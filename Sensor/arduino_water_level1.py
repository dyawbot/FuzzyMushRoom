import serial
# class WaterLevel:
#     def value():
ser =   serial.Serial('/dev/ttyUSB0', 9600)
try:
    
    
    data = ser.readline().decode('utf-8').strip()
    if data is not None:
        print(data)
    else:
        print("null")

    ser.write("Hello arduino".encode('ascii'))
    # return data

except KeyboardInterrupt:
    print("Terminated getting the data")
except Exception as e:
    print("An Error Occured")
    print(e)

finally:
    ser.close()