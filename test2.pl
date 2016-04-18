#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
#use local::lib "$FindBin::Bin/perl5lib/lib";
#use lib "$FindBin::Bin/../lib/perl5";
use lib "$FindBin::Bin/local/lib/perl5";

use Data::Dumper;
use POSIX;
use Sys::Hostname;

#use SNMP; # Net::SNMP
use SNMP::Info;

my $apc_host = 'apc';
my $mibfile = "$FindBin::Bin/snmp/mips/powernet414.mib";
stat($mibfile);
unless ( (-e $mibfile) && (-f $mibfile) && (-s $mibfile) && (-r $mibfile)  ) {
   print "ERROR: Unable to read APC Mib file '$mibfile': $!\n";
   exit 1;
}
print "Using APC Mibfile '$mibfile'\n";

&SNMP::addMibFiles($mibfile);
&SNMP::initMib();

# Let SNMP::Info determine the correct subclass for you. 
my $apc = new SNMP::Info(
                          AutoSpecify => 1,
                          Debug       => 2,
                          DestHost    => $apc_host,
                          Community   => 'public',
                          Version     => 2
                        ) 
    or die "Can't connect to DestHost $apc_host.\n";
print "\nSNMP Connected!!\n\n";

my $name  = $apc->name();
my $clas = $apc->class();
print "SNMP::Info name->$name is using this device class : $clas\n";

my $class      = $apc->class();

print "SNMP::Info determined this device to fall under subclass : $class\n";

print Dumper($apc);


print "os: ", $apc->os(), "\n";
print "os_bin: ", $apc->os_bin(), "\n";
print "os_ver: ", $apc->os_ver(), "\n";
print "serial: ", $apc->serial(), "\n";
print "vendor: ", $apc->vendor(), "\n";
print "model: ", $apc->model(), "\n";
print "ps1_type: ", $apc->ps1_type(), "\n";
print "ps1_status: ", $apc->ps1_status(), "\n";
print "ps2_type: ", $apc->ps2_type(), "\n";
print "ps2_status: ", $apc->ps2_status(), "\n";
