#!/usr/bin/perl

# http://cuddletech.com/articles/snmp/node17.html

$SNMP_GET_CMD = "snmpget -v1 -c public -Ovq -m './snmp/mips/powernet414.mib'";
$SNMP_TARGET = 'apc8B090E';

chomp($model = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsBasicIdentModel.0 ) );
chomp($serial = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsAdvIdentSerialNumber.0 ) );
chomp($cap = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsAdvBatteryCapacity.0 ) );
chomp($temp = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsAdvBatteryTemperature.0 ) );
chomp($out_load = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsAdvOutputLoad.0 ) );
chomp($out_v = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsAdvOutputVoltage.0 ) );
chomp($out_f = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsAdvOutputFrequency.0 ) );
chomp($out_status = qx( ${SNMP_GET_CMD} ${SNMP_TARGET} PowerNet-MIB::upsBasicOutputStatus.0 ) );

$model =~ s/\"//g;      # Ditch the quotes.
$serial =~ s/\"//g;

print <<END;
APC UPS                         ${SNMP_TARGET}
Model: ${model}         Serial No: ${serial}

Battery Capacity: ${cap}
Battery Temp(F): ${temp}

Output Status: ${out_status}
Output Load: ${out_load}
Output: ${out_v}VAC @ ${out_f}Hz
END
