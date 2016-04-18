#!/bin/bash

script_name=${0##*/}                               # Basename, or drop /path/to/file
script=${script_name%%.*}                          # Drop .ext.a.b
script_path=${0%/*}                                # Dirname, or only /path/to
script_path=$( [[ -d ${script_path} ]] && cd ${script_path} ; pwd)             # Absolute path
script_path_name="${script_path}/${script_name}"   # Full path and full filename to $0
script_basedir=${script_path%/*}                   # basedir, if script_path is .../bin/

# No log handling enabled - turning on stderr logging
# /root/.snmp/snmpwalk.conf: line 1: Warning: Unknown token: mibs.

tstamp=$( date +"%Y-%m-%d-%H-%M-%S")
snmpwalk -c public -m "${script_path}/snmp/mips/powernet414.mib" -v 1 apc8B090E enterprises.318 > ${script_path}/data/${tstamp}.snmp-dump
#snmpwalk -c public -m "${script_path}/snmp/mips/powernet414.mib" -v 1 apc8B090E                 > ${script_path}/data/${tstamp}.snmp-dump
exit

cat << X

https://tobinsramblings.wordpress.com/2011/05/03/snmp-tutorial-apc-pdus/

https://github.com/jirutka/apcupsd-snmp


snmpwalk -Os -c public -v 1 apc8B090E system
snmpwalk -Os -c public -v 1 apc8B090E 

snmpwalk -c public -m "./snmp/mips/powernet414.mib" -v 1 apc8B090E enterprises.318
snmpwalk -c public -m "./snmp/mips/powernet414.mib" -v 1 apc8B090E

snmpwalk -c public -m "${script_path}/snmp/mips/powernet414.mib" -v 1 apc8B090E enterprises.318 > ${script_path}/data/$( date +"%Y-%m-%d-%H-%M-%S").snmp-dump
X
