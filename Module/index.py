import serial
from Sensor import arduino_water_level1 as WaterLevel

class Index:
    ser =   serial.Serial('/dev/ttyUSB0', 9600)
     
    def serial_water_level():
        print("Serial")
        
    def humid_temp():
        print("humidity and temperature")