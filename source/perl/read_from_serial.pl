#!/usr/bin/perl

use Device::SerialPort;

#list of all the ports that I've seen the arduino controllers show up on
@whichdevice = qw(/dev/ttyUSB0 /dev/ttyUSB1 /dev/ttyACM0 /dev/ttyACM1);
$serialport= "";
foreach $s(@whichdevice)
{
     #print "device is: ", $s,"\n";
     print "checking $s:\t";
     $serialport = Device::SerialPort->new($s);
     #print "$! is the error\n";
     if ($serialport)
     {
          print "we got a serial port!\n";
          $serialport->databits(8);
          $serialport->baudrate(115200);
          $serialport->parity("none");
          $serialport->stopbits(1);
          last;
     }
     else
     {
          print "$!\n";
     }
}
if (!$serialport)
{
     die "cannot connect to the serial port!\n";
}


while (1)
{
     $val = $serialport->input;
     if ($val ne "")
     {
          print "incoming: $val";
     }
}
# # now catch gremlins at start
# my $tEnd = time()+2; # 2 seconds in future
# while (time()< $tEnd)
# { # end latest after 2 seconds
#      my $c = $serialport->lookfor(); # char or nothing
#      next if $c eq ""; # restart if noting
#      # print $c; # uncomment if you want to see the gremlin
#      last;
# }
# while (1)
# { # and all the rest of the gremlins as they come in one piece
#      my $c = $serialport->lookfor(); # get the next one
#      last if $c eq ""; # or we're done
#      # print $c; # uncomment if you want to see the gremlin
# }


exit;