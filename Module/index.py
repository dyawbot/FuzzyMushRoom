# import serial
# from Sensor import arduino_water_level1 as WaterLevel
import flask
import secrets
from flask import Flask, request, jsonify
from Module.db.connector import SavingDataUsers
from Module import camera
import cv2

user_keys = {}
class Index:
    # ser =   serial.Serial('/dev/ttyUSB0', 9600)

    # def serial_water_level():
    #     print("Serial")

    # def humid_temp():
    #     print("humidity and temperature")

    def __init__(self):
        self.app = Flask(__name__)
        self.app.config['JSON_SORT_KEYS'] = False 

        self.app.add_url_rule("/", "index", self.index)
        self.app.add_url_rule(
            "/api/video", "video", self.video
        )
        self.app.add_url_rule("/api/login", "api_key_login", self.api_key_login, methods=["POST"])
        self.app.add_url_rule("/api/temp_humid_waterlever", "home_dashboard", self.home_dashboard,)


    def index(self):
        return flask.render_template("index.html")
    
    # def video(self):


    #     frame = cv2.VideoCapture(0).read()[1]

    # # Encode the frame as a JPEG image.
    #     encoded_frame = cv2.imencode('.jpg', frame)[1]

    # # Return the JPEG image to the client.
    #     return flask.Response(encoded_frame.tostring(), mimetype='image/jpeg')
        # a = 1
        # if a==1:
        #     live_camera = flask.Response(camera.generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')
        #     print(live_camera)
        
        # return live_camera
    def home_dashboard(self):
        data = request.form.to_dict()
        token = data["token"]

        if token is not None:
            print("proceed")
            #get the value of the temperature and humidity and water level sensor:
            #return it as jsonify

        
    



    def video(self):
        a = 1
        if a==1:
            live_camera = flask.Response(camera.generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')
            print(live_camera)
        
        return live_camera

    def api_key_login(self):
    
        data = request.form.to_dict()
      
        username = data['username']
        password = data['password']

        csv_data = SavingDataUsers()
        users_data = csv_data.getData()

        if users_data[0]['username'] == username and users_data[0]['password'] == password:
    

            api_key = secrets.token_hex(32)
            api_key = "sk-"+api_key+"-data"
            users_data[0]["token"] = api_key
            csv_data.write_csv("data.csv", users_data)
            return jsonify({"username": username, "password": password, "token" :api_key})
        else:
            return jsonify({"message":"Invalid credentials"})


    def run(self, host="0.0.0.0", port=5000):
        self.app.run(host=host, port=port)
