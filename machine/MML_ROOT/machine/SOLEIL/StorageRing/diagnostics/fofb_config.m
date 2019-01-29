function fofb_config(groupe,X_conf,Z_conf)
% coeffx=512*4-4;
% coeffz=768*4-4;
coeffx=512*4-4;
coeffz=768*4-4;
fai_cfg_reg=2048*4;
ack_rise=int32([fai_cfg_reg 4 1 9]);
ack_fall=int32([fai_cfg_reg 4 1 8]);
N=1;


conf_array_X=int32([coeffx 4 N X_conf]);
conf_array_Z=int32([coeffz 4 N Z_conf]);



tango_group_command_inout2(groupe,'WriteFAData',1,conf_array_X)
tango_group_command_inout2(groupe,'WriteFAData',1,conf_array_Z)
tango_group_command_inout2(groupe,'WriteFAData',1,ack_rise)
tango_group_command_inout2(groupe,'WriteFAData',1,ack_fall)

    

% tango_command_inout2(bpm,'WriteFAData',conf_array_X)
% tango_command_inout2(bpm,'WriteFAData',conf_array_Z)
% 
% tango_command_inout2(bpm,'WriteFAData',ack_rise)
% tango_command_inout2(bpm,'WriteFAData',ack_fall)
