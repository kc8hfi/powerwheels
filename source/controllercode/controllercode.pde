/*
 * controllercode.pde
 *
 * This makes the truck remote control.
 * it reads in a command from the serial port, then 
 * does whatever the command said to do.
 *
 */

// Import the Servo library
// and the motor shield library
#include <Servo.h> 
#include <AFMotor.h>

// Create a Servo object for each servo
Servo servo9;
Servo servo10;

AF_DCMotor motor1(1,MOTOR12_64KHZ);
AF_DCMotor motor2(2,MOTOR12_64KHZ);
AF_DCMotor motor3(3,MOTOR12_64KHZ);
AF_DCMotor motor4(4,MOTOR12_64KHZ);

// Common servo setup values
//int minPulse = 600;   // minimum servo position, us (microseconds)
//int maxPulse = 2400;  // maximum servo position, us

//changed the min and max pulse to match the servos we have
int minPulse = 900;
int maxPulse = 2400;

// User input for servo and position
int userInput[3];    // raw input from serial buffer, 3 bytes
int startbyte;       // start byte, begin reading input
int movewhat;           // which 
int pos;             // which direction
int i;               // iterator

//the platform that it sits on  has limits on how far we can move 
//the turret up, down, left and right
//set them to this inital angle at initialization time
int howfarud = 90;   //how far we can move the turret up and down
int howfarlr = 40;   //how far we can move the turret left and right


void setup() 
{ 
  //attach the servos to a digital pin
  //servo?.attach(YOUR_PIN, minPulse, maxPulse);
  servo9.attach(9,minPulse,maxPulse);
  servo10.attach(10,minPulse,maxPulse);

  // Open the serial connection, 115200 baud
  Serial.begin(115200);

  //set the max speed of the motor,  0-255, 255 max speed
  //we set them at max speed because the controller only trips the relay to
  //start the truck in motion
  motor1.setSpeed(255);
  motor2.setSpeed(255); 
  motor3.setSpeed(255);  
  motor4.setSpeed(255); 

  //move the servos to the initial position
  servo9.write(howfarud);
  servo10.write(howfarlr);
} 

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
      for (i=0;i<2;i++) 
      {
        userInput[i] = Serial.read();
      }
      // First byte = servo to move?
      movewhat = userInput[0];
      // Second byte = which position?
      pos = userInput[1];
      // Packet error checking and recovery
      if (pos == 255)
      {
        movewhat = 255; 
      }
      //check movewhat to find out which item needs some action
      //
      switch (movewhat) 
      {
        //this is to go forward and backward
        case 1:
          //Serial.print("which way1: ");
          if (pos == 0)
          {
            Serial.println("stop forward/backward");           
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
        //this is for the gun to start/stop firing
        case 2:
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
        //to turn left and right
        case 3:
        if (pos == 1)
        {
          Serial.println("start left");
//          Serial.println(pos);
          motor3.run(FORWARD);
        }
        if (pos == 2)
        {
          Serial.println("start right");
          motor3.run(BACKWARD);
        }
        if (pos == 0)
        {
          Serial.println("stop turning");
          motor3.run(RELEASE);
        }
        break; 
      case 9:
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
      }//end switch
    }//end startbyte
  }//end serial available
}//end loop


