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

#a file to write the data\
$file = "coordinates.txt";
# open FILE,">$file" or die "cannot open $file for writing! $!\n";
# $| = 1;
while(1) 
{
     open FILE,">>$file" or die "cannot open $file for writing! $!\n";
#      $| = 1;

     my($ns,$lat,$ew,$lon) = $gps->get_position;
     print "($ns,$lat,$ew,$lon)\n";
     print FILE "($ns,$lat,$ew,$lon)\n";
     
     #this will dump the entire string of stuff
#      print $gps->parse;
     
     # Dump internal NMEA data:
#      $gps->nmea_data_dump;
     
#      print FILE $gps->nmea_data_dump;

#      print $gps->{NMEADATA};
     foreach $key (sort keys %{$gps->{NMEADATA}})
     {
#           print "$key=> ",$gps->{NMEADATA}{$key},"\n";
          print FILE "$key=> ",$gps->{NMEADATA}{$key},"\n";
     }
     #dumps data received
#      print "\n\n";
     print FILE "\n\n";
     
     close FILE;
     #wait 3 seconds and then read again
     sleep(3);

     #don't know how the get_altitude works, because this doesn't do anything
#      while ( ($key,$value) = each $gps->get_altitude)
#      {
#           print "$key=>$value\n";
#      }
     
	# Alternative to look at the internal NMEA data:
	#require Data::Dumper;
	#print Data::Dumper->new([$gps->{NMEADATA}],[])->Indent(1)->Useqq(1)->Dump;


}
exit;
