function fofb_stop_CC(groupe)
fai_cfg_reg=2048*4;
Disable_Itech_fai=int32([(fai_cfg_reg+4) 4 1 0]);
Soft_stop=int32([(fai_cfg_reg+8) 4 1 0]);
Reset_user_fai=int32([(fai_cfg_reg) 4 1 0]);

tango_group_command_inout2(groupe,'WriteFAData',1,Disable_Itech_fai) 

tango_group_command_inout2(groupe,'WriteFAData',1,Soft_stop) 

tango_group_command_inout2(groupe,'WriteFAData',1,Reset_user_fai) 
      