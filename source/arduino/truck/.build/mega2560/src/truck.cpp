#include <Arduino.h>
void setup();
void logger(String t);
void doSomething(String s);
void loop();
void serialEvent();
#line 1 "src/truck.ino"

#include <Servo.h>
#include <AFMotor.h>

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
     Serial.println("arduino ready");
     Serial1.println("arduino ready");
     
     //start the timer
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
     String log = "receive: " + s + " - ";
     if(s == "BVF")
     {
          logger(log + "begin vehicle forward");
          motor1.run(FORWARD);
     }
     else if(s == "EVF")
     {
          logger(log + "end vehicle forward");
          motor1.run(RELEASE);
     }
     else if (s=="BVB")
     {
          logger(log + "begin vehicle backward");          
          motor1.run(BACKWARD);
     }
     else if (s=="EVB")
     {
          logger(log + "end vehicle backward");
          motor1.run(RELEASE);
     }
     else if (s=="BVL")
     {
          logger(log + "begin vehicle left");
          motor3.run(FORWARD);
     }
     else if (s=="EVL")
     {
          logger(log + "end vehicle left");
          motor3.run(RELEASE);
     }
     else if (s=="BVR")
     {
          logger(log + "begin vehicle right");
          motor3.run(BACKWARD);
     }
     else if (s=="EVR")
     {
          logger(log + "end vehicle right");
          motor3.run(RELEASE);
     }
     else if (s=="BTL")
     {
          logger(log + "begin turret left");
          if (howfarlr <=95)
          {
               howfarlr = howfarlr + 5;
               servo10.write(howfarlr);
          }
     }
     else if (s=="ETL")
     {
          logger(log + "end turret left");
     }
     else if (s=="BTR")
     {
          logger(log + "begin turret right");
          if (howfarlr >=5)
          {
               howfarlr = howfarlr - 5;
               servo10.write(howfarlr);
          }
     }
     else if (s=="ETR")
     {
          logger(log + "end turret right");
     }
     else if (s=="BTU")
     {
          logger(log + "begin turret up");
          if (howfarud >=5)
          {
               howfarud = howfarud - 5;
               servo9.write(howfarud);
          }        
     }
     else if (s=="ETU")
     {
          logger(log + "end turret up");
     }
     else if (s=="BTD")
     {
          logger(log + "begin turret down");
          if (howfarud <=170)
          {
               howfarud = howfarud + 5;
               servo9.write(howfarud); 
          }
     }
     else if (s=="ETD")
     {
          logger(log + "end turret down");
     }
     else if (s=="SF")
     {
          logger(log + "start firing");
          motor2.run(FORWARD);
     }
     else if (s=="EF")
     {
          logger(log + "end firing");
          motor2.run(RELEASE);
     }
     else if (s=="ping")
     {
          Serial.println("pong");
          Serial.println(millis());
     }
}

/*
 * main loop
 */
void loop()
{
     if (stringComplete)
     {
          Serial.println(inputString);
          Serial1.println(inputString);
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

