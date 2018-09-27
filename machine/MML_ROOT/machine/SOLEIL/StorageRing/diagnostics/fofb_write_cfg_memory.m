function fofb_write_cfg_memory(bpm,RAM_X,RAM_Z)
dev=bpm;
RAM_X_start=256*4;
RAM_Z_start=512*4;
fai_cfg_reg=2048*4;
ack_rise=int16([fai_cfg_reg 4 1 9 0]);
ack_fall=int16([fai_cfg_reg 4 1 8 0]);

for i=2:2:512
    RAM_X(i)=0;
    RAM_Z(i)=0;
end

RAM_X_array=int16([RAM_X_start 4 256 RAM_X]);
RAM_Z_array=int16([RAM_Z_start 4 256 RAM_Z]);
tango_command_inout2(dev,'WriteFAData',RAM_X_array)     
tango_command_inout2(dev,'WriteFAData',RAM_Z_array)     
tango_command_inout2(dev,'WriteFAData',ack_rise)
tango_command_inout2(dev,'WriteFAData',ack_fall)
