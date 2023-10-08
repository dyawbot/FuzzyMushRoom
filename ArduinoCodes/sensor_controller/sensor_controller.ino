

#define waterLevelPin A0

//THIS IS RELAYS
int pumpRelayPin = 12;
int exhaustFanRelayPin = 11;
int ledLightRelayPin = 10;
int humidifierRelayPin = 9;
int humidifier = 8;
char incomingByte;



void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(pumpRelayPin,OUTPUT);
  pinMode(exhaustFanRelayPin,OUTPUT);
  pinMode(ledLightRelayPin,OUTPUT);
  pinMode(humidifierRelayPin,OUTPUT);
  pinMode(humidifier, OUTPUT);
  Serial.println("Main Code Here");
//  digitalWrite(humidifierRelayPin, HIGH);
  

}

void loop() {
  // put your main code here, to run repeatedly:
  int waterLevelValue = waterLevelSensor();
  Serial.println("DSFDSFS");
//  Serial.println(waterLevelValue);

  if(Serial.available()){
    incomingByte = Serial.read();
//    Serial.println(incomingByte);
  


    if( waterLevelValue < 450){
      Serial.println("Water level is too low");
      digitalWrite(pumpRelayPin, HIGH);
    }
  
    if(waterLevelValue>650){
      Serial.println("Water level is full");
      digitalWrite(pumpRelayPin, LOW);
    }
  }
  

}


int waterLevelSensor(){
  int sensorValue = analogRead(waterLevelPin);
  return sensorValue;
  
  
}
