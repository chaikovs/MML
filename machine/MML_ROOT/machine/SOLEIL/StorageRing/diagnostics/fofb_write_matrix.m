function fofb_write_matrix(groupe,X_value,Z_value,onX,onZ)
coeffx=256*4;
coeffz=512*4;
fai_cfg_reg=2048*4;
ack_rise=int32([fai_cfg_reg 4 1 9]);
ack_fall=int32([fai_cfg_reg 4 1 8]);
N=256;

X_array=X_value*ones(1,N)
Z_array=Z_value*ones(1,N)

if onX==1
    X_array(256)=1;
else
  	X_array(256)=0; 
end;
if onZ==1
    Z_array(256)=1;
else
  	Z_array(256)=0; 
end;
 

conf_array_X=int32([coeffx 4 N X_array]);
conf_array_Z=int32([coeffz 4 N Z_array]);



tango_group_command_inout2(groupe,'WriteFAData',1,conf_array_X)
tango_group_command_inout2(groupe,'WriteFAData',1,conf_array_Z)
tango_group_command_inout2(groupe,'WriteFAData',1,ack_rise)
tango_group_command_inout2(groupe,'WriteFAData',1,ack_fall)

    

% tango_command_inout2(bpm,'WriteFAData',conf_array_X)
% tango_command_inout2(bpm,'WriteFAData',conf_array_Z)
% 
% tango_command_inout2(bpm,'WriteFAData',ack_rise)
% tango_command_inout2(bpm,'WriteFAData',ack_fall)
