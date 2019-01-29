function trig_geophones

deviceName = 'ANS/DG/SURVIB.1';

% create Tango Device Proxy
tango_ping(deviceName);

%argin.svalue={'dstp://survib/declenchementtango'};
argin.svalue={'dstp://172.17.23.160/declenchementtango'};
argin.lvalue=int32(1);

tango_command_inout2(deviceName, 'WriteBool', argin);

