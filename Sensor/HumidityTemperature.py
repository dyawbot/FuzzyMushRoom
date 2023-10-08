
import Adafruit_DHT as humidTemp
import time


dht_pin = 17

dht_sensor = humidTemp.DHT22
#dsfsdfsd
print("HELLO")


try:
	while True:
		print("HELLO")
		humidity, temperature = humidTemp.read_retry(dht_sensor, dht_pin)
		print(humidity)
		if humidity is not None and temperature is not None:
			print(f"Temperature: {temperature: .2f}C")
			print(f"Temperature: {humidity: .2f}%")
			time.sleep(1)
		else:
			print("Failed to load data")




except KeyboardInterrupt:
	print("Terminated")

except Exception as e:
	print("THIS IS AN ERROR {e}")
	print(e)




