#!/usr/bin/perl

use SDL;
use SDL::Joystick;
use SDL::Event;
use SDL::Events;
use SDLx::App;
use IO::Socket;

SDL::init_sub_system(SDL_INIT_JOYSTICK);

#die('no joystick found') unless(SDL::Joystick::num_joysticks());

#make stdout unbuffered
$| = 1;

#constants
use constant START_VEHICLE_FORWARD 	=> 	"BVF";
use constant STOP_VEHICLE_FORWARD 		=> 	"EVF";
use constant START_VEHICLE_REVERSE		=> 	"BVB";
use constant STOP_VEHICLE_REVERSE		=>	"EVB";
use constant START_VEHICLE_LEFT		=>	"BVL";
use constant STOP_VEHICLE_LEFT		=> 	"EVL";
use constant START_VEHICLE_RIGHT		=> 	"BVR";
use constant STOP_VEHICLE_RIGHT		=> 	"EVR";

use constant START_TURRET_LEFT		=>	"BTL";
use constant STOP_TURRET_LEFT			=> 	"ETL";
use constant START_TURRET_RIGHT		=>	"BTR";
use constant STOP_TURRET_RIGHT		=>	"ETR";
use constant START_TURRET_UP			=> 	"BTU";
use constant STOP_TURRET_UP			=> 	"ETU";
use constant START_TURRET_DOWN		=>	"BTD";
use constant STOP_TURRET_DOWN			=> 	"ETD";

use constant START_FIRE		=>	"SF";
use constant STOP_FIRE		=>	"EF";

print 'Ip address of the server: [192.168.1.3]:';
$default = "192.168.1.3";
$f = <STDIN>;
$f =~ s/[\n\r]+//;
$ip_address = "";
if ($f eq "")
{
	$ip_address = $default;
}
else
{
	$ip_address = $f;
}

print 'port number: [4201]:';
$default = "4201";
$f = <STDIN>;
$f =~ s/[\n\r]+//;
$port_number = "";
if ($f eq "")
{
	$port_number = $default;
}
else
{
	$port_number = $f;
}




my $socket = new IO::Socket::INET (
	PeerAddr	=>	$ip_address,
	PeerPort	=>	$port_number,
	Proto		=> 'tcp',
);
die "could not create socket: $!\n" unless $socket;


my $joystick = SDL::Joystick->new(0);


if($joystick)
{
	printf("Opened Joystick 0\n");
	printf("Name: %s\n",              SDL::Joystick::name(0));
	printf("Number of Axes: %d\n",    SDL::Joystick::num_axes($joystick));
	printf("Number of Buttons: %d\n", SDL::Joystick::num_buttons($joystick));
	printf("Number of Balls: %d\n",   SDL::Joystick::num_balls($joystick));
}
else
{
	printf("No joystick attached!\n");
}


### Create A new Application window 
my $app = new SDLx::App(
	title	=>	'Remote control power wheels',
	width	=>	400,
	height	=>	400,
	depth	=>	32
);


my $event = SDL::Event->new();
while(1)
{
	#SDL::Events::pump_events();
	while (SDL::Events::poll_event($event))
	{
		$type = $event->type();
		#print "mask: ",$event->mask(),"\n";
		exit() if ($type == SDL_QUIT);
		joystick_axis() if ($type == SDL_JOYAXISMOTION);
		joystick_button_down() if ($type == SDL_JOYBUTTONDOWN);
		joystick_button_up () if ($type == SDL_JOYBUTTONUP);
		key_down() if ($type == SDL_KEYDOWN);
		key_up() if ($type == SDL_KEYUP);
		
		#print $event->type(),"\n";
	}#end loop that gets events
}#end endless loop


sub joystick_axis
{
	my $axis = $event->jaxis_axis;
	my $value = $event->jaxis_value;
	if ($axis == 1)	#y, up and down
	{
		#print $event->jaxis_value,"\n"; 
		start_forward()	if ($value == -32768);
		stop_forward()		if ($value == 0);
		
		start_backward()	if ($value == 32767);
		stop_backward()	if ($value == 0);
		#up value, -32768
		#down value, 32767
	}
	if ($axis == 0)	#x,  left and right
	{
		start_left()	if ($value == -32768);
		stop_left()	if ($value == 0);
		
		start_right()	if ($value == 32767);
		stop_right()	if ($value == 0);
		#print $event->jaxis_value,"\n";
		#left value, -32768
		#right value, 32767
	}
	#print "axis: $axis\n";
	#print $type,"\n";
}#end joystick_axis

sub joystick_button_down
{
	#print $event->jbutton_button,"\n";
	my $button = $event->jbutton_button;
	start_fire() 		if ($button == 0);
	start_turret_up() 	if ($button == 2);
	start_turret_down()	if ($button == 3);
	start_turret_left()	if ($button == 4);
	start_turret_right()if ($button == 5);
}#end joystick_button_down

sub joystick_button_up
{
	#print $event->jbutton_button,"\n";
	my $button = $event->jbutton_button;
	stop_fire()		if ($button == 0);
	stop_turret_up()	if ($button == 2);
	stop_turret_down()	if ($button == 3);
	stop_turret_left()	if ($button == 4);
	stop_turret_right()	if ($button == 5);
	
}#end joystick_button_up

sub key_down
{
	my $keysym = $event->key_sym();
	my $key = SDL::Events::get_key_name($keysym);
	#print "name: ",$key,"\n";
	
	exit()			if ($key eq 'escape');
 	start_fire() 		if ($key eq 'space');
	start_turret_up() 	if ($key eq 'k');
	start_turret_down()	if ($key eq 'i');
	start_turret_left()	if ($key eq 'j');
	start_turret_right()if ($key eq 'l');
	
	start_forward() 	if ($key eq 'w');
	start_backward() 	if ($key eq 's');
	start_left()		if ($key eq 'a');
	start_right()		if ($key eq 'd');
}#end key_down

sub key_up
{
	my $keysym = $event->key_sym();
	my $key = SDL::Events::get_key_name($keysym);
	#print "name: ",$key,"\n";
	
	exit()			if ($key eq 'escape');
	stop_fire() 		if ($key eq 'space');
	stop_turret_up() 	if ($key eq 'k');
	stop_turret_down()	if ($key eq 'i');
	stop_turret_left()	if ($key eq 'j');
	stop_turret_right()	if ($key eq 'l');
	
	stop_forward() 	if ($key eq 'w');
	stop_backward() 	if ($key eq 's');
	stop_left()		if ($key eq 'a');
	stop_right()		if ($key eq 'd');	
}#end key_up

sub start_forward
{
	print $socket START_VEHICLE_FORWARD,"\n";
	#print $socket START_VEHICLE_FORWARD;
}

sub stop_forward
{
	print $socket STOP_VEHICLE_FORWARD,"\n";
}

sub start_backward
{
	print $socket START_VEHICLE_REVERSE,"\n";
}

sub stop_backward
{
	print $socket STOP_VEHICLE_REVERSE,"\n";
}
sub start_left
{
	print $socket START_VEHICLE_LEFT,"\n";
}

sub stop_left
{
	print $socket STOP_VEHICLE_LEFT,"\n";
}
sub start_right
{
	print $socket START_VEHICLE_RIGHT,"\n";
}

sub stop_right
{
	print $socket STOP_VEHICLE_RIGHT,"\n";
}

sub start_turret_left
{
	print $socket START_TURRET_LEFT,"\n";
}

sub stop_turret_left
{
	print $socket STOP_TURRET_LEFT,"\n";
}

sub start_turret_right
{
	print $socket START_TURRET_RIGHT,"\n";
}

sub stop_turret_right
{
	print $socket STOP_TURRET_RIGHT,"\n";
}

sub start_turret_up
{
	print $socket START_TURRET_UP,"\n";
}

sub stop_turret_up
{
	print $socket STOP_TURRET_UP,"\n";
}
sub start_turret_down
{
	print $socket START_TURRET_DOWN,"\n";
}

sub stop_turret_down
{
	print $socket STOP_TURRET_DOWN,"\n";
}

sub start_fire
{
	print $socket START_FIRE,"\n";
}
sub stop_fire
{
	print $socket STOP_FIRE,"\n";
}

