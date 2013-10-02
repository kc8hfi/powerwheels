#!/usr/bin/perl

use IO::Socket;

$default = "192.168.0.5";
print "ip address of the server: [$default]:";

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

$default = "4201";
print "port number: [$default]:";
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
     PeerAddr  =>   $ip_address,
     PeerPort  =>   $port_number,
     Proto          => 'tcp',
);
die "could not create socket: $!\n" unless $socket;


#read input from the user
$string = "";
$last = "";
do
{
     print "command list, case sensitive!!\n";
     print "
BVF - begin vehicle forward
EVF - end vehicle forward
BVB - begin vehicle backward
EVB - end vehicle backward
BVL - begin vehicle left
BVR - begin vehicle right
EVL - end vehicle left
EVR - end vehicle right
BTL - begin turret left
ETL - end turret left
BTR - begin turret right
ETR - end turret right
BTU - begin turret up
ETU - end turret up
BTD - begin turret down
ETD - end turret down
SF - start firing
EF - end firing
quit - exit program
\n";
     print "command (quit will exit): [$last]:";
     $f = <STDIN>;
     $f =~ s/[\n\r]+//;
     if ($f eq "")
     {
          $string = $last;
     }
     else
     {
          $string = $f;
     }
     print $socket $string,"\n";
     $last = $string;
}while ($string ne "quit");

exit;