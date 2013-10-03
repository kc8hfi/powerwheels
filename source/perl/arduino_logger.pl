#!/usr/bin/perl

use warnings;
use strict;
use POE;
use POE::Wheel::ReadWrite;
use POE::Wheel::ReadLine;
use Symbol qw(gensym);
use Device::SerialPort;
use POE::Filter::Line;
POE::Session->create
(
     inline_states => 
     {
          _start      => \&setup_device,
          got_port    => \&display_port_data,
          got_console => \&transmit_console_data,
          got_error   => \&handle_errors,
     },
);
POE::Kernel->run();
exit 0;

sub log_time
{
     my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
     my $nice_timestamp = sprintf ( "%04d-%02d-%02d %02d:%02d:%02d",
                                   $year+1900,$mon+1,$mday,$hour,$min,$sec);
     return $nice_timestamp;
}

sub setup_device 
{
     my ($kernel, $heap) = @_[KERNEL, HEAP];

     # Open a serial port, and tie it to a file handle for POE.
     my $handle = gensym();
  
     my $serialport = "";
     my $sp = "";
     #list of all the ports that I've seen the arduino controllers show up on
     my @whichdevice = qw(/dev/ttyUSB0 /dev/ttyUSB1 /dev/ttyACM0 /dev/ttyACM1);
     foreach my $s(@whichdevice)
     {
          $sp = Device::SerialPort->new($s);
          if ($sp)
          {
               $serialport = $s;
               last;
          }
     }
     if (!$sp)
     {
          die "cannot connect to the serial port!\n";
     }
     #close it 
     $sp->close;
  
     my $port = tie(*$handle, "Device::SerialPort", $serialport);
     die "can't open port: $!" unless $port;
     $port->datatype('raw');
     $port->baudrate(115200);
     $port->databits(8);
     $port->parity("none");
     $port->stopbits(1);
     $port->handshake("rts");
     $port->write_settings();

     # Start interacting now
     $heap->{port}       = $port;
     $heap->{port_wheel} = POE::Wheel::ReadWrite->new
     (
          Handle => $handle,
          Filter => POE::Filter::Line->new
          (
               InputLiteral  => "\x0D\x0A",    # Received line endings.
               #InputLiteral  => "\n",    # my line endings???
               OutputLiteral => "\x0D",        # Sent line endings.
          ),
          InputEvent => "got_port",
          ErrorEvent => "got_error",
     );

     # Start a wheel to interact with the console, and prompt the user.
     $heap->{console} = POE::Wheel::ReadLine->new(InputEvent => "got_console",);
     $heap->{console}->put("Press ^D to stop.");
     $heap->{console}->get("Ready: ");
     
     #need a file for logging
     open (LOG, ">>arduino_log.txt");
     LOG->autoflush(1);
}

# Port data (lines, separated by CRLF) are displayed on the console.
sub display_port_data 
{
     my ($heap, $data) = @_[HEAP, ARG0];
     #$heap->{console}->put("write to file here?");
     
     $heap->{console}->put($data);
     print LOG log_time(),"\t",$data,"\n";
}

# Console input is sent to the device.
sub transmit_console_data 
{
     my ($heap, $input) = @_[HEAP, ARG0];
     if (defined $input) {
     $heap->{console}->addhistory($input);
     $heap->{port_wheel}->put($input);
     $heap->{console}->get("Ready: ");
     

     # Clearing $! after $serial_port_wheel->put() seems to work around
     # an issue in Device::SerialPort 1.000_002.
     $! = 0;
     return;
     }
     $heap->{console}->put("Bye!");
     delete $heap->{port_wheel};
     delete $heap->{console};
}

# Error on the serial port.  Shut down.
sub handle_errors 
{
     my $heap = $_[HEAP];
     $heap->{console}->put("$_[ARG0] error $_[ARG1]: $_[ARG2]");
     $heap->{console}->put("bye!");
     delete $heap->{console};
     delete $heap->{port_wheel};
}