#!/usr/bin/perl

use IO::Socket;
use Device::SerialPort;
use Net::Address::IP::Local;

#make stdout unbuffered
$| = 1; 

#my $ip = Net::Address::IP::Local->public_ipv4;
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
	LocalPort	=>	$port,
	Proto		=>	'tcp',
	Listen		=>	1,
	Reuse		=>	1, 
);
die "could not create socket: $!\n" unless $socket;

# Set up the serial port
# 19200, 81N on the USB ftdi driver

@whichdevice = qw(/dev/ttyUSB0 /dev/ttyUSB1 /dev/ttyACM0 /dev/ttyACM1);
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
	#die "cannot connect to the serial port!\n";
}

$v_fb = 1;
$v_lr = 3;
$t_ud = 9;
$t_lr = 10;
$fire = 2;

print "ip address:\t",$host,"\n";
print "port number:\t",$port,"\n";

print "\nwaiting for a connection....\n";

sub sendcommand
{
	#print "ord: ",ord(255),"\n";
	#print "chr: ",chr(255),"\n";
	#print 255;
	
	#put back next line
	#$serialport->write(chr(255));
	foreach (@_)
	{
		#put back next line
		#$serialport->write(chr($_));
		#print "\nserial $_,:\n";
		print "$_,";
	}
	#print "\n";
}

#my $newsocket = $socket->accept();
#$input = "";
#while (<$newsocket>)
while($newsocket = $socket->accept())
{
	print "connection from ",$newsocket->peerhost(),"\n";
	
	while (<$newsocket>)
	{
		$_ =~ s/[\r\n]+//;
		print "received:$_";
		if ($_ eq "BVF")
		{
			print "$v_fb:1";
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
			#print "$v_fb:2";
			sendcommand($v_fb,2);
		}
		if ($_ eq "BVL")
		{
			#print "$v_lr:1\n";
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

