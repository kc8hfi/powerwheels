#include <Servo.h>
#include <AFMotor.h>

/*
 * http://arduino.cc/en/Reference/Servo
 * http://learn.adafruit.com/adafruit-motor-shield/overview
 */

// Create a Servo object for each servo
Servo servo9;
Servo servo10;

// set up the motor controllers
AF_DCMotor motor1(1,MOTOR12_64KHZ);
AF_DCMotor motor2(2,MOTOR12_64KHZ);
AF_DCMotor motor3(3,MOTOR12_64KHZ);
AF_DCMotor motor4(4,MOTOR12_64KHZ);

//changed the min and max pulse to match the servos we have
int minPulse = 900;      //minimum servo position, us (microseconds)
int maxPulse = 2400;     //maximum servo position, us

//angle on how far to move the turret up and down, left and right
int howfarud = 90;
int howfarlr = 40;

//string to hold the incoming command
String inputString = "";
boolean stringComplete = false;

unsigned long time = 0;
int noResponse = 0;

void setup()
{
     // Open the serial connection,
     Serial.begin(115200);
     Serial1.begin(115200);

     //attach the servos 
     servo9.attach(9,minPulse,maxPulse);
     servo10.attach(10,minPulse,maxPulse);

     //set the speed of the motor controllers
     motor1.setSpeed(255);
     motor2.setSpeed(255); 
     motor3.setSpeed(255);  
     //motor4.setSpeed(255); 
     
     //move the turret to about the middle
     servo9.write(howfarud);
     servo10.write(howfarlr);
     
     //log ready message
     logger("arduino ready");
}

void logger(String t)
{
     Serial.println(t);
     Serial1.println(t);
}

/*
BVF - begin vehicle forward
EVF - end vehicle forward
BVB - begin vehicle backward
EVB - end vehicle backward
BVL - begin vehicle left
BVR - begin vehicle right
EVL - end vehicle left
EVR - end vehicle right
BTL - begin turret left
ETL - end turret left
BTR - begin turret right
ETR - end turret right
BTU - begin turret up
ETU - end turret up
BTD - begin turret down
ETD - end turret down
SF - start firing
EF - end firing
*/

void doSomething(String s)
{
     time = millis();
     String log = "receive: " + s;
     if(s == "BVF" || s == "bvf")
     {
          logger(log);
          motor1.run(FORWARD);
     }
     else if(s == "EVF" || s == "evf")
     {
          logger(log);
          motor1.run(RELEASE);
     }
     else if (s=="BVB" || s == "bvb")
     {
          logger(log);
          motor1.run(BACKWARD);
     }
     else if (s=="EVB" || s == "evb")
     {
          logger(log);
          motor1.run(RELEASE);
     }
     else if (s=="BVL" || s == "bvl")
     {
          logger(log);
          motor3.run(FORWARD);
     }
     else if (s=="EVL" || s == "evl")
     {
          logger(log);
          motor3.run(RELEASE);
     }
     else if (s=="BVR" || s == "bvr")
     {
          logger(log);
          motor3.run(BACKWARD);
     }
     else if (s=="EVR" || s == "evr")
     {
          logger(log);
          motor3.run(RELEASE);
     }
     else if (s=="BTL" || s == "btl")
     {
          logger(log);
          if (howfarlr <=95)
          {
               howfarlr = howfarlr + 5;
               servo10.write(howfarlr);
          }
     }
     else if (s=="ETL" || s == "etl")
     {
          logger(log);
     }
     else if (s=="BTR" || s == "btr")
     {
          logger(log);
          if (howfarlr >=5)
          {
               howfarlr = howfarlr - 5;
               servo10.write(howfarlr);
          }
     }
     else if (s=="ETR" || s == "etr")
     {
          logger(log);
     }
     else if (s=="BTU" || s == "btu")
     {
          logger(log);
          if (howfarud >=5)
          
          {
               howfarud = howfarud - 5;
               servo9.write(howfarud);
          }        
     }
     else if (s=="ETU" || s =="etu")
     {
          logger(log);
     }
     else if (s=="BTD" || s == "btd")
     {
          logger(log);
          if (howfarud <=170)
          {
               howfarud = howfarud + 5;
               servo9.write(howfarud); 
          }
     }
     else if (s=="ETD" || s == "etd")
     {
          logger(log);
     }
     else if (s=="SF" || s == "sf")
     {
          logger(log);
          motor2.run(FORWARD);
     }
     else if (s=="EF" || s == "ef")
     {
          logger(log);
          motor2.run(RELEASE);
     }
//      else if (s=="ping")
//      {
//           logger("pong");
//      }
}

/*
 * main loop
 */
void loop()
{
     if (stringComplete)
     {
          //Serial.println(inputString);
          //Serial1.println(inputString);
          doSomething(inputString);
          inputString = "";
          stringComplete = false;
     }
     if ( (millis() - time) > 6000)
     {
          //Serial.println("stop everything!");
          //delay(1000);
          motor1.run(RELEASE);
          motor2.run(RELEASE);
          motor3.run(RELEASE);
     }
}

/*
 * after a loop(), if there is serial data in the buffer
 */
void serialEvent()
{
     while(Serial.available())
     {
          char inChar = (char)Serial.read();
          if(inChar == '\n')
               stringComplete = true;
          else
               inputString += inChar;     
     }
}

