#!/bin/bash

if [[ -d $HOME/.snmp ]] ; then
   echo "ERR: $HOME/.snmp already exists!"
   rsync -anvv snmp/ $HOME/.snmp
else
   cp -av snmp $HOME/.snmp
fi
