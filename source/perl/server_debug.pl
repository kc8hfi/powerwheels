#!/usr/bin/perl

# this is a debugging program.  It is the same as the server.pl
# script, but you do not need the arduino plugged into the computer.

use strict;
use warnings;

use Net::Address::IP::Local;
use IO::Async::Listener;
use IO::Async::Loop;
use IO::Async::Timer::Periodic;

#make stdout unbuffered
$| = 1; 

my $host = "127.0.0.1";
my $port = "4201";
eval 
{
     $host = Net::Address::IP::Local->public;
};

sub log_time
{
     my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
     my $nice_timestamp = sprintf ( "%04d-%02d-%02d %02d:%02d:%02d",
                                   $year+1900,$mon+1,$mday,$hour,$min,$sec);
     return $nice_timestamp;
}

my $logfile = "server.log";

sub write_log
{
     my ($want_timestamp,$string) = @_;
     open LOGFILE, ">>$logfile" or die "cannot create log file! $! \n";
     if ($want_timestamp == 1)
     {
          print log_time(),"\t",$string,"\n";
          print LOGFILE log_time(),"\t",$string,"\n";
     }
     else
     {
          print $string,"\n";
          print LOGFILE $string,"\n";
     }
     close LOGFILE;
}

my $loop = IO::Async::Loop->new;
my $timer = IO::Async::Timer::Periodic->new(
    interval => 3,

    on_tick => sub {
       #print "3 seconds\n";
    },
 );
$timer->start;
$loop->add( $timer );

my $listener = IO::Async::Listener->new
(
     on_stream => sub
     {
          my $self = shift;
          my ( $stream ) = @_;
          
          my $socket = $stream->read_handle;
          my $peeraddr = $socket->peerhost . ":" . $socket->peerport;
          
          write_log(1,"connection from $peeraddr");
          $stream->configure
          (
               on_read => sub
               {
                    my ($self,$buffref,$eof) = @_;
                    # s/^(.*\n)// 
                    # this means any number of characters and any number of \n's 
                    # at the beginning of the string
                    #basically, gets the first line of stuff
                    while( $$buffref =~ s/^(.*\n)// )
                    {
                         #eat a line from the stream input
                         $self->write($1);   #$1 is the captured part of that regex in the loop
                         my $cmd = $1;
                         $cmd =~ s/[\r\n]+//;
                         write_log(1,"cmd: $cmd");
                    }
                    return 0;
               },
               on_closed => sub
               {
                    write_log(1,"connection from $peeraddr closed");
               },
          );
          $loop->add($stream);
     },
);

$loop->add($listener);

$listener->listen
(
     addr => 
     { 
          ip        =>   $host,
          port      =>   $port,
          family    =>   "inet",
          socktype  =>   "stream",
     },
     on_listen =>   sub
     {    
          write_log(0,"Server Ready");
          write_log(0,"ip:\t$host");
          write_log(0,"port:\t$port");
          
     },
     on_resolve_error => sub { die "Cannot resolve - $_[0]\n"; },
     on_listen_error  => sub { die "Cannot listen\n"; }, 
);



$loop->run;

exit;
