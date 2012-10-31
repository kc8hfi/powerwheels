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
 * to control multiple servos frwsom a PC using a USB cable.
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
#include <AFMotor.h>w

AF_DCMotor motor1(3,MOTOR12_64KHZ);    //this is one of the wheels
AF_DCMotor motor2(4,MOTOR12_64KHZ);    //this is the other wheel


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

void setup() 
{ 

  // Open the serial connection, 9600 baud
  Serial.begin(9600);
  motor1.setSpeed(255);
  motor2.setSpeed(255); 

}//end setup 

void loop() 
{ 
  // Wait for serial input (min 3 bytes in buffer)
  if (Serial.available() > 2) 
  {
    // Read the first byte
    startbyte = Serial.read();
    // If it's really the startbyte (255) ...
    if (startbyte == 255) 
    {
      // ... then get the next two bytes
      for (i=0;i<2;i++) {
        userInput[i] = Serial.read();
      }
      // First byte = servo to move?
      servo = userInput[0];
      // Second byte = which position?
      pos = userInput[1];
      // Packet error checking and recovery
      if (pos == 255) { 
        servo = 255; 
      }
      // Assign new position to appropriate servo
      switch (servo)
      {
      case 1:
        //Serial.print("which way1: ");
        if (pos == 0)
        {
          Serial.println("stop forward");           
          motor1.run(RELEASE);
          motor2.run(RELEASE);
        }
        if (pos == 1)
        {
          Serial.println("start forward");
          motor1.run(FORWARD);
          motor2.run(FORWARD);
        }
        if (pos == 2)
        {
          Serial.println("start backward");
          motor1.run(BACKWARD);
          motor2.run(BACKWARD);
        }
        break;
      case 3:
          if (pos == 1)
          {
            Serial.println("start left");
            motor1.run(FORWARD);
            //motor2.run(BACKWARD);
          }
          if(pos == 2)
          {
            Serial.println("start right");
            //motor1.run(BACKWARD);
            motor2.run(FORWARD);
          }
          if(pos == 0)
          {
            Serial.println("stop turning");
            motor1.run(RELEASE);
            motor2.run(RELEASE);
          }
      }//end switch
    }//end if startbyte
  }//end we got enough characters to start a command 
}//end loop

