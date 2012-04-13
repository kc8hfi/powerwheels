/*
 * controllercode
 *
 * MultipleSerialServoControl
 * --------------
 *
 * Uses the Arduino Serial library
 *  (http://arduino.cc/en/Reference/Serial)
 * and the Arduino Servo library
 *  (http://arduino.cc/en/Reference/Servo)
 * to control multiple servos from a PC using a USB cable.
 *
 * Designed for use with the Python servo.py module
 *  (http://principialabs.com/arduino-python-4-axis-servo-control/)
 *
 * REQUIRED: Arduino 0017 or higher
 *   Control up to 48 servos with Arduino Mega!
 *   See the "TO ADD SERVOS:" comments below.
 *
 * Created 23 December 2009
 * copyleft 2009 Brian D. Wendt
 * http://principialabs.com/
 *
 */

// Import the Arduino Servo library
#include <Servo.h> 
#include <AFMotor.h>

// Create a Servo object for each servo
//Servo servo1;
//Servo servo2;
//Servo servo3;
//Servo servo4;
//Servo servo5;

Servo servo9;
Servo servo10;

AF_DCMotor motor1(1,MOTOR12_64KHZ);
AF_DCMotor motor2(2,MOTOR12_64KHZ);
AF_DCMotor motor3(3,MOTOR12_64KHZ);
AF_DCMotor motor4(4,MOTOR12_64KHZ);

// TO ADD SERVOS:
//   Servo servo5;
//   etc...

// Common servo setup values
//int minPulse = 600;   // minimum servo position, us (microseconds)
//int maxPulse = 2400;  // maximum servo position, us

//changed the min and max pulse to match the servos we have
int minPulse = 900;
int maxPulse = 2400;

// User input for servo and position
int userInput[3];    // raw input from serial buffer, 3 bytes
int startbyte;       // start byte, begin reading input
int servo;           // which servo to pulse?
int pos;             // which direction
int i;               // iterator

int howfarud = 90;
int howfarlr = 40;


void setup() 
{ 
  // Attach each Servo object to a digital pin
//  servo1.attach(2, minPulse, maxPulse);
//  servo1.attach(1, 900,2100);
//  servo2.attach(2, 900,2100);
//  servo3.attach(3, minPulse, maxPulse);
//  servo4.attach(4, minPulse, maxPulse);
//  servo5.attach(5, 900,2100);
  
  servo9.attach(9,minPulse,maxPulse);
  servo10.attach(10,minPulse,maxPulse);
  
  // TO ADD SERVOS:
  //   servo5.attach(YOUR_PIN, minPulse, maxPulse);
  //   etc...

  // Open the serial connection, 9600 baud
  Serial.begin(9600);
  motor1.setSpeed(255);
  motor4.setSpeed(255); 
  motor3.setSpeed(255);  
  motor2.setSpeed(255); 
  
  servo9.write(howfarud);
  servo10.write(howfarlr);
} 

void loop() 
{ 
  // Wait for serial input (min 3 bytes in buffer)
  if (Serial.available() > 2) {
    // Read the first byte
    startbyte = Serial.read();
    // If it's really the startbyte (255) ...
    if (startbyte == 255) {
      // ... then get the next two bytes
      for (i=0;i<2;i++) {
        userInput[i] = Serial.read();
      }
      // First byte = servo to move?
      servo = userInput[0];
      // Second byte = which position?
      pos = userInput[1];
      // Packet error checking and recovery
      if (pos == 255) { servo = 255; }
/*     Serial.write("servo: ");
     Serial.write(servo);
     Serial.write(" pos: ");
     Serial.write(pos);
     Serial.write("\n");
*/
      // Assign new position to appropriate servo
      switch (servo) {
        case 1:
          //Serial.print("which way1: ");
          if (pos == 0)
          {
            Serial.println("stop forward");           
            motor1.run(RELEASE);
          }
          if (pos == 1)
          {
            Serial.println("start forward");
            motor1.run(FORWARD);
          }
          if (pos == 2)
          {
            Serial.println("start backward");
            motor1.run(BACKWARD);
          }
          
          //Serial.println(pos);
          break;
         case 2:
          //Serial.print("Backwards: ");
          if (pos == 1)
          {
            Serial.println("start fire");
            motor2.run(FORWARD);
            //delay(300);
            //motor2.run(RELEASE);
          }
          if (pos == 0) 
          {
            Serial.println("stop fire");
            motor2.run(RELEASE);  
          }
          break;
        case 3:
          if (pos == 1)
          {
            Serial.print("Left: ");
            Serial.println(pos);
            motor3.run(FORWARD);
          }
          if (pos == 2)
          {
            motor3.run(BACKWARD);
          }
          if (pos == 0)
          {
            motor3.run(RELEASE);
          }
          break; 
//        case 4:
//          Serial.print("Right: ");
//          Serial.println(pos);
//          motor3.run(BACKWARD);
//          delay(50);
//          motor3.run(RELEASE);
//          break;  
//        case 5:
//          Serial.println("fire!");
//          motor2.run(FORWARD);
//          delay(200);
//          motor2.run(RELEASE);
//          break;
        case 9:
//          Serial.println("move 9 down");
//          Serial.print("servo:");
//          Serial.println(servo);
//          Serial.print("pos:");
//          Serial.println(pos);
//          Serial.println(howfarud);
          Serial.print("updown: ");
          Serial.println(howfarud);          
          if (pos == 2 && howfarud <=170)
          {
            Serial.println("move turret down");
            howfarud = howfarud + 5;
            servo9.write(howfarud); 
          }
          if (pos == 1 && howfarud >=5)
          {
            Serial.println("move turret up");
            howfarud = howfarud - 5;
            servo9.write(howfarud);
          }        
          break;
        case 10:
//          Serial.println("move 10");
          Serial.print("leftright: ");
          Serial.println(howfarlr);
          if (pos == 2 && howfarlr >=5)
          {
            Serial.println("move turret right");
            howfarlr = howfarlr - 5;
            servo10.write(howfarlr);
          }
          if (pos == 1 && howfarlr <=95)
          {
            Serial.println("move turret left");
            howfarlr = howfarlr + 5;
            servo10.write(howfarlr);
          }
          break;  
   // TO ADD SERVOS:
   //     case 5:
   //       servo5.write(pos);
   //       break;
   // etc...
      }
    }
  }


}
