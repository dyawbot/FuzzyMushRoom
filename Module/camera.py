import cv2
import numpy as np
import base64
# import flask

# app = flask.Flask(__name__)

# def generate_frames():
#     cap = cv2.VideoCapture(0)
#     while True:
#         success, frame = cap.read()
#         if not success:
#             print(success)
#             break
#         else:
#             ret, buffer = cv2.imencode('.jpg', frame)
#             if not ret:
#                 continue
#             # print("SAdfsdfsdfdsgsgs")
#             yield (b'--frame\r\n' 
#                     b'Content-Type: image/jpeg\r\n\r\n' + buffer.tobytes() + b'\r\n')
            

def generate_frames():
    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 1920)  # Set the width to 640 pixels
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
    try:
        while True:
            success, frame = cap.read()
            if not success:
                break
            ret, buffer = cv2.imencode('.jpg', frame)
            if not ret:
                continue
            yield (b'--frame\r\n' 
                   b'Content-Type: image/jpeg\r\n\r\n' + buffer.tobytes() + b'\r\n')
    finally:    
        cap.release()
            
# sa = generate_frames()
# for ja in sa:
#     print("hello")
            

    

# @app.route('/')
# def index():
#     return flask.render_template('index.html')

# @app.route('/video')
# def video():
#     return flask.Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

# if __name__ == "__main__":
#     app.run(host='0.0.0.0', port=5000, debug=True)



# while True:
#     ret, frame = cap.read()
#     if ret:
#         cv2.imshow('frame', frame)
#         if cv2.waitKey(1) & 0xFF == ord('q'):
#             break
#     else:
#         break

# cap.release()
# cv2.destroyAllWindows()