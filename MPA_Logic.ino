#include <CapacitiveSensor.h>

CapacitiveSensor  cs_4_2 = CapacitiveSensor(4,2);
CapacitiveSensor  cs_8_6 = CapacitiveSensor(8,6);        
CapacitiveSensor  cs_12_10 = CapacitiveSensor(12,10);       

int   pv[2]       = {22, 28};
int   pulseWidth  = 15;
byte  lick        = 0; // start with no lick at all; see matlab's decoding file (bmaRead.m)
long  th          = 500;

void setup() 
{
Serial.begin(115200);

pinMode(pv[0],OUTPUT);
digitalWrite(pv[0], LOW);

pinMode(pv[1],OUTPUT);
digitalWrite(pv[1], LOW);

}
void loop() 
{
  int v[3]   = {(cs_8_6.capacitiveSensor(30) > th), (cs_4_2.capacitiveSensor(30)>th)};
  lick  = (v[0] + v[1]) + v[1];
//  Serial.println(lick);
//  int lick[3]  = {(cs_8_6.capacitiveSensor(30) > th), (cs_4_2.capacitiveSensor(30)>th), cs_12_10.capacitiveSensor(30) > th};
//  long tStart      = cs_12_10.capacitiveSensor(30) > th;

     
  if (Serial.available() > 0) {
    int cmd = Serial.read();
    
    switch (cmd) {
      
      case 'w':  
        Serial.write(lick);      
//        Serial.write(tStart);                                        
        break; 
                       
      case 1:           // Reward to left port
        digitalWrite(pv[0], HIGH);
        delay(pulseWidth);
        digitalWrite(pv[0], LOW);
        break;       

      case 2:           // Reward to right port      
        digitalWrite(pv[1], HIGH);
        delay(pulseWidth);
        digitalWrite(pv[1], LOW);          
        break;

      case 3:        // Reward to both port
        digitalWrite(pv[0], HIGH);               
        digitalWrite(pv[1], HIGH);
        delay(pulseWidth);
        digitalWrite(pv[0], LOW);                  
        digitalWrite(pv[1], LOW);          
        break;

      default:
        pulseWidth = cmd;
        break;
       
    }
  }




}


