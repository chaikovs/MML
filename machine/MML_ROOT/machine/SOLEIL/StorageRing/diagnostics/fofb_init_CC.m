function fofb_init_CC(bpm,id,time_frame_lenght,MGT_powerdown,MGT_loopback,buf_clr_dly,Golden_X,Golden_Z)
CC_cfg=0;
fai_cfg_reg=2048*4;
ack_rise=int32([fai_cfg_reg 4 1 9]);
ack_fall=int32([fai_cfg_reg 4 1 8]);


conf_array=int32([CC_cfg 4 7 id time_frame_lenght MGT_powerdown MGT_loopback buf_clr_dly,Golden_X,Golden_Z]);
tango_command_inout2(bpm,'WriteFAData',conf_array)
tango_command_inout2(bpm,'WriteFAData',ack_rise)
tango_command_inout2(bpm,'WriteFAData',ack_fall)
      