#!/usr/bin/perl
# Purpose: configure evtmon.ini after installed
# Requires: evtmon and opsware agent
# Author: matt_gravlin@intuit.com
# Updated: 10/21/2011
#########################################

# modules
use File::Copy;

#----- Backup existing evtmon.ini file -----
# get the time for backing up existing evtmon.ini file
my ($sec,$min,$hour,$day,$month,$yr19,@rest) = localtime(time);
$datetime = int($month+1).$day.($yr19+1900)."-".$hour.$min.$sec;
# define path to snmpd.conf
$file = "c:/evtmon/evtmon.ini";
# see if evtmon.ini exists, if yes backup, if no exit
if (-e $file) {
	print "evtmon.ini exists, backing up...\n";
	}
 else {
 	print "evtmon.ini does not exist!.\n";
 	print "evtmon is probably not installed. Exiting...\n";
 	exit 1
 	}
# make a backup of existing file
move($file, $file."-".$datetime.".txt") or die "File cannot be moved.";

# make new default evtmon.ini. This will overwrite existing config
open FILE, ">$file" or die "unable to open $file $!";
# write the entire evtmon.ini file
print FILE <<EVTMONCONF;
###################################################################
#
# Sample Configuration file for evtmon.exe
#
# Blank lines and lines beginning with # are ignored.
# Valid entries are:
#   scan_interval_sec = seconds to scan ALL the log files. If 2 logs, will scan each every 2 sec.
#   syslog_host1 = IP addr of primary syslog server
#   syslog_host2 = IP addr of secondary syslog server
#   trap_host1 = IP of primary SNMP Trap server
#   trap_host2 = IP of secondary SNMP Trap server
#   scan_interval_sec = xxx (number of seconds between event log scans)
#   log_supress = intervals to suppress duplicates for this output.
#   trap_supress = intervals to suppress duplicates for this output.
#   cmd_supress = intervals to suppress duplicates for this output.
#   syslog_supress = intervals to suppress duplicates for this output.
# 
# Values are case-insensitive.
#
# If you make a change to this file, you will need to restart the application
#
###################################################################
scan_interval_sec = 10
log_supress = 5
syslog_supress = 5
trap_supress = 5
cmd_supress = 5
EVTMONCONF

close FILE;
open FILE, "+>>$file" or die "unable to open $file $!";

#----- Append snmp trap destination and syslog destinations -----
#--- write environment specific info from opsware facility custom attributes----
my $agentToolsPath= 'C:/Progra~1/Opsware/agent_tools/';
my $customAttributeScript = 'get_cust_attr.bat';

if ( ! -e "$agentToolsPath$customAttributeScript") {
 print "File: get_cust_attr.bat does not exist!\n";
 exit 1;
}

my $SNMPserver1 = 'TRAP_HOST1';
my $SNMPserver2 = 'TRAP_HOST2';
my $Logserver1 = 'SYSLOG_HOST1';
my $Logserver2 = 'SYSLOG_HOST2';

my $getHost1 = `$agentToolsPath$customAttributeScript $SNMPserver1`;
my $getHost2 = `$agentToolsPath$customAttributeScript $SNMPserver2`;
my $getLogHost1 = `$agentToolsPath$customAttributeScript $Logserver1`;
my $getLogHost2 = `$agentToolsPath$customAttributeScript $Logserver2`;

if ( $getHost1 !~ /Could not find custom attribute/ ) {
 if ( length($getHost1 > 4)) {
  print "trap_host1=$getHost1";
  print FILE "trap_host1 = $getHost1";}
}
 else {
  $getHost1 = "";
  print "trap_host1 is not defined in Opsware\n";
  exit 1;
}

if ( $getHost2 !~ /Could not find custom attribute/ ) {
 if ( length($getHost2 > 4)) {
  print "trap_host2=$getHost2";
  print FILE "trap_host2 = $getHost2";}
}
 else {
  $getHost2 = "";
  print "trap_host2 is not defined in Opsware\n";
 }

if ( $getLogHost1 !~ /Could not find custom attribute/ ) {
 if ( length($getLogHost1 > 4)) {
  print "syslog_host1=$getLogHost1";
  print FILE "syslog_host1 = $getLogHost1";}
}
 else {
  $getLogHost1 = "";
  print "syslog_host1 is not defined in Opsware\n";
  exit 1;
 }

if ( $getLogHost2 !~ /Could not find custom attribute/ ) {
 if ( length($getLogHost2 > 4)) {
  print "syslog_host2=$getLogHost2";
  print FILE "syslog_host2 = $getLogHost2";}
}
 else {
  $getLogHost2 = "";
  print "syslog_host2 is not defined in Opsware\n";
 }
close FILE;

#---- restart evtmon -----
print "restarting evtmon windows service\n";
`net stop evtmon`;
sleep(5);
`net start evtmon`;
print "restart complete\n";
