#include <Arduino.h>
void setup();
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
     motor4.setSpeed(255); 
     
     //move the turret to about the middle
     servo9.write(howfarud);
     servo10.write(howfarlr);
     
}

void doSomething(String s)
{
     if(s == "BVF")
     {
          Serial.println("begin vehicle forward");
     }
}

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

