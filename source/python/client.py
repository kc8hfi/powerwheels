import socket
import pygame
import pygame
from pygame.locals import (QUIT, KEYDOWN,KEYUP,JOYBUTTONDOWN,JOYBUTTONUP,JOYAXISMOTION,
K_ESCAPE,K_SPACE,K_w,K_s,K_a,K_d,K_i,K_j,K_k,K_l)

#declare constants whose values gets passed to the server
START_VEHICLE_FORWARD	= 	"BVF";
STOP_VEHICLE_FORWARD 	= 	"EVF";
START_VEHICLE_REVERSE	= 	"BVB";
STOP_VEHICLE_REVERSE	=	"EVB";
START_VEHICLE_LEFT		=	"BVL";
STOP_VEHICLE_LEFT		= 	"EVL";
START_VEHICLE_RIGHT		= 	"BVR";
STOP_VEHICLE_RIGHT		= 	"EVR";

START_TURRET_LEFT		=	"BTL";
STOP_TURRET_LEFT		= 	"ETL";
START_TURRET_RIGHT		=	"BTR";
STOP_TURRET_RIGHT		=	"ETR";
START_TURRET_UP		= 	"BTU";
STOP_TURRET_UP			= 	"ETU";
START_TURRET_DOWN		=	"BTD";
STOP_TURRET_DOWN		= 	"ETD";

START_FIRE	= "SF";
STOP_FIRE		= "EF";

done = False

def start_forward():
	#print "start vehicle forward"
	socket.send(START_VEHICLE_FORWARD)
	socket.send("\n")
	
def stop_forward():
	#print "stop vehicle forward"
	socket.send(STOP_VEHICLE_FORWARD)
	socket.send("\n")

def start_reverse():
	#print "start vehicle reverse"
	socket.send(START_VEHICLE_REVERSE)
	socket.send("\n")
	
def stop_reverse():
	#print "stop vehicle reverse"
	socket.send(STOP_VEHICLE_REVERSE)
	socket.send("\n")

def start_right():
	#print "start vehicle right"
	socket.send(START_VEHICLE_RIGHT)
	socket.send("\n")

def stop_right():
	#print "stop vehicle right"
	socket.send(STOP_VEHICLE_RIGHT)
	socket.send("\n")
	
def start_left():
	#print "start vehicle left"
	socket.send(START_VEHICLE_LEFT)
	socket.send("\n")
	
def stop_left():
	#print "stop vehicle left"
	socket.send(STOP_VEHICLE_LEFT)
	socket.send("\n")	
	
def start_turret_up():
	#print "start turret up"
	socket.send(START_TURRET_UP)
	socket.send("\n")	

def stop_turret_up():
	#print "stop turret up"
	socket.send(STOP_TURRET_UP)
	socket.send("\n")	
	
def start_turret_down():
	#print "start turret down"
	socket.send(START_TURRET_DOWN)
	socket.send("\n")	

def stop_turret_down():
	#print "stop turret down"
	socket.send(STOP_TURRET_DOWN)
	socket.send("\n")

def start_turret_left():
	#print "start turret left"
	socket.send(START_TURRET_LEFT)
	socket.send("\n")

def stop_turret_left():
	#print "stop turret left"
	socket.send(STOP_TURRET_LEFT)
	socket.send("\n")

def start_turret_right():
	#print "start turret right"
	socket.send(START_TURRET_RIGHT)
	socket.send("\n")

def stop_turret_right():
	#print "stop turret right"
	socket.send(STOP_TURRET_RIGHT)
	socket.send("\n")

def start_fire():
	#print "start fire"
	socket.send(START_FIRE)
	socket.send("\n")

def stop_fire():
	#print "stop fire"
	socket.send(STOP_FIRE)
	socket.send("\n")

#make a connection to the server
#HOST = raw_input("Input Server IP Address: ")
#PORT = raw_input("input port number: ")

HOST = '192.168.1.3'
PORT = 4201

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
PORT = int(PORT)
socket.connect((HOST, PORT))

pygame.init()
screen = pygame.display.set_mode((200,200))
pygame.mouse.set_visible(1)

# allow multiple joysticks
joy = []

# look for joysticks
totaljoy = pygame.joystick.get_count()
print totaljoy,"joysticks total -",

if totaljoy == 1:
  ddrmat = pygame.joystick.Joystick(totaljoy-1)
  ddrmat.init()
  print "last one is",ddrmat.get_numaxes(),"axes and",ddrmat.get_numbuttons(),"buttons"
else:
    print "No joystick plugged int"

while not done:
	for event in pygame.event.get():
		#print event
		#*********************************************************************
		#		Close the program by pressing the escape key
		#*********************************************************************
		if event.type == KEYDOWN:
			if event.key == K_ESCAPE:
				done = True
			elif event.key == K_w:
				start_forward()
			elif event.key == K_s:
				start_reverse()
			elif event.key == K_a:
				start_left()
			elif event.key == K_d:
				start_right()
				
			elif event.key == K_i:
				start_turret_up()
			elif event.key == K_k:
				start_turret_down()
			elif event.key == K_j:
				start_turret_left()
			elif event.key == K_l:
				start_turret_right()
			elif event.key == K_SPACE:
				start_fire()
		elif event.type == KEYUP:
			if event.key == K_ESCAPE:
				done = True
			elif (event.key == K_w):
				stop_forward()
			elif event.key == K_s:
				stop_reverse()
			elif event.key == K_a:
				stop_left()
			elif event.key == K_d:
				stop_right()
	
			elif event.key == K_i:
				stop_turret_up()
			elif event.key == K_k:
				stop_turret_down()
			elif event.key == K_j:
				stop_turret_left()
			elif event.key == K_l:
				stop_turret_right()
			elif event.key == K_SPACE:
				stop_fire()
		elif event.type == JOYBUTTONDOWN:
			if event.button == 0:
				start_fire()
			elif event.button == 2:
				start_turret_up()
			elif event.button == 3:
				start_turret_down()
			elif event.button == 4:
				start_turret_left()
			elif event.button == 5:
				start_turret_right()
		elif event.type == JOYBUTTONUP:
			if event.button == 0:
				stop_fire()
			elif event.button == 2:
				stop_turret_up()
			elif event.button == 3:
				stop_turret_down()
			elif event.button == 4:
				stop_turret_left()
			elif event.button == 5:
				stop_turret_right()
		elif event.type == JOYAXISMOTION:
			#print event.axis
			#print event.value
			if (event.axis == 0):
				if (event.value <0.0):
					start_left()
				elif (event.value >0.0):
					start_right()
				elif (event.value == 0.0):
					stop_left()
					stop_right()
			elif (event.axis == 1):
				if (event.value>0.0):
					start_reverse()
				elif (event.value <0.0):
					start_forward()
				elif (event.value == 0.0):
					stop_forward()
					stop_reverse()

