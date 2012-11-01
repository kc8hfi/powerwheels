#!/usr/bin/perl

use IO::Socket;
use Device::SerialPort;
use Net::Address::IP::Local;

#make stdout unbuffered
$| = 1; 

$ip = "127.0.0.1";
eval 
{
	$ip = Net::Address::IP::Local->public;
};
#warn "no ip address, $@ \n";
warn "no ip address, using $ip instead\n";

$host = $ip;
$port = '4201';

my $socket = new IO::Socket::INET (
	LocalHost 	=>	$host,
	LocalPort		=>	$port,
	Proto		=>	'tcp',
	Listen		=>	1,
	ReuseAddr	=>	1, 
);
if ($socket)
{
	print "socket isn't created\n";
}
die "could not create socket: $!\n" unless $socket;

# Set up the serial port
# 19200, 81N on the USB ftdi driver

#typed in the list of possible devices.  I just started typing 
#them in as my linux box picked them up. 

#The ones with usb are for the controllers that use the ftdi usb chips
#The acm ones are for the controllers that use the atmega16u2 or the atmega8u2
#programmed as a usb to serial converter

@whichdevice = qw(/dev/ttyUSB0 /dev/ttyUSB1 /dev/ttyUSB2 /dev/ttyACM0 /dev/ttyACM1);
$serialport= "";
foreach $s(@whichdevice)
{
	print "device is: ", $s,"\n";
	$serialport = Device::SerialPort->new($s);
	print "$! is the error\n";
	if ($serialport)
	{
		print "we got a serial port! $s\n";
		$serialport->databits(8);
		$serialport->baudrate(9600);
		$serialport->parity("none");
		$serialport->stopbits(1);
		last;
	}
	else
	{
		print "whats the deal\n";
	}
}
if (!$serialport)
{
	die "cannot connect to the serial port!\n";
}

$v_fb = 1;
$v_lr = 3;
$t_ud = 9;
$t_lr = 10;
$fire = 2;

print "ip address:\t",$host,"\n";
print "port number:\t",$port,"\n";

print "\nwaiting for a connection....\n";

#this function sends data out the serial port
#it turns each character in the string into a char and
#send them out the serial port
sub sendcommand
{
	#print "ord: ",ord(255),"\n";
	#print "chr: ",chr(255),"\n";
	#print 255;
	$serialport->write(chr(255));
	foreach (@_)
	{
		$serialport->write(chr($_));
		#print "\nserial $_,:\n";
		print "$_,";
	}
	#print "\n";
}

#my $newsocket = $socket->accept();
#$input = "";
#while (<$newsocket>)

#BVF - begin vehicle forward
#EVF - end vehicle forward
#BVB - begin vehicle backward
#EVB - end vehicle backward
#BVL - begin vehicle left
#BVR - begin vehicle right
#EVL - end vehicle left
#EVR - end vehicle right
#BTL - begin turret left
#ETL - end turret left
#BTR - begin turret right
#ETR - end turret right
#BTU - begin turret up
#ETU - end turret up
#BTD - begin turret down
#ETD - end turret down
#SF - start firing
#EF - end firing

while($newsocket = $socket->accept())
{
	print "connection from ",$newsocket->peerhost(),"\n";
	
	#wait for a command to come in, then decide what command to 
	#send to the serial port based on the incoming string
	while (<$newsocket>)
	{
		$_ =~ s/[\r\n]+//;
		print "received:$_";
		if ($_ eq "BVF")
		{
			#print "$v_fb:1";
			#this works
			sendcommand($v_fb,1);
			
			#sendcommand("B","V");
			#sendcommand("BVF");
		}
		if (($_ eq "EVF") || ($_ eq "EVB")) 
		{
			#print "$v_fb:0";
			sendcommand($v_fb,0);
		}
		if ($_ eq "BVB")
		{
			sendcommand($v_fb,2);
		}
		if ($_ eq "BVL")
		{
			sendcommand($v_lr,1);
		}
		if ($_ eq "BVR")
		{
			sendcommand($v_lr,2);
		}
		if (($_ eq "EVL") || ($_ eq "EVR"))
		{
			sendcommand($v_lr,0);
		}
		if (($_ eq "ETL") || ($_ eq "ETR"))
		{
			sendcommand($t_lr, 0);
		}
		if ($_ eq "BTL")
		{
			sendcommand($t_lr,1);
		}
		if ($_ eq "BTR")
		{
			sendcommand($t_lr,2);
		}
		if ($_ eq "BTU")
		{
			sendcommand($t_ud,1);
		}
		if ($_ eq "BTD")
		{
			sendcommand($t_ud,2);
		}
		if (($_ eq "ETU")||($_ eq "ETD"))
		{
			sendcommand($t_ud,0);
		}
		if ($_ eq "SF")
		{
			sendcommand($fire,1);
		}
		if ($_ eq "EF")
		{
			sendcommand($fire,0);
		}

		print "\n";
	}
} 
#close ($socket);

