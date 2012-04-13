#!/usr/bin/perl

use IO::Socket;
use Device::SerialPort;

use GPS::NMEA;

#make stdout unbuffered
$| = 1; 

# @whichdevice = qw(/dev/ttyUSB0 /dev/ttyUSB1);
# $serialport= "";
# foreach $s(@whichdevice)
# {
# 	print "device is: ", $s,"\n";
# 	$serialport = Device::SerialPort->new($s);
# 	print "$! is the error\n";
# 	if ($serialport)
# 	{
# 		print "we got a serial port! $s\n";
# 		$serialport->databits(8);
# 		$serialport->baudrate(57600);
# 		$serialport->parity("none");
# 		$serialport->stopbits(1);
# 		$serialport->read_const_time(1);
# 		last;
# 	}
# 	else
# 	{
# 		print "whats the deal\n";
# 	}
# }
# if (!$serialport)
# {
# 	die "cannot connect to the serial port!\n";
# }
# else
# {
# 	print "do a bunch of work now!\n";
# 	my $readChars = 0; my $readBytes = ""; my $readBuffer = "";
# 	while (true)
# 	{
# 		($readChars,$readBytes) = $serialport->read(1);
# 		print $readBytes,"\n";
# 		print $readChars,"\n";
# 	}
# 	print "after read\n";
# 	
# 	
# }

my $gps = GPS::NMEA->new(Port => '/dev/ttyUSB0', # or COM5: or /dev/ttyS0
                             Baud => 57600);
while(1) 
{
	#my($ns,$lat,$ew,$lon) = $gps->get_position;
	#print "($ns,$lat,$ew,$lon)\n";

	
	
	$gps->parse;
	# Dump internal NMEA data:
	$gps->nmea_data_dump;
	
	print "\n\n\n";

	# Alternative to look at the internal NMEA data:
	#require Data::Dumper;
	#print Data::Dumper->new([$gps->{NMEADATA}],[])->Indent(1)->Useqq(1)->Dump;

	
}

exit;
