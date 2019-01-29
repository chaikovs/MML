function fofb_arm_CC(groupe,time_frame_cnt_limit_value,data_selection)


fai_cfg_reg=2048*4;
if data_selection==1
    reg=time_frame_cnt_limit_value*2^4+10;
else
    reg=time_frame_cnt_limit_value*2^4+8;
end    
Enable_user_fai=int32([(fai_cfg_reg) 4 1 reg]);
Enable_Itech_fai=int32([(fai_cfg_reg+4) 4 1 1]);

tango_group_command_inout2(groupe,'WriteFAData',1,Enable_user_fai) 

tango_group_command_inout2(groupe,'WriteFAData',1,Enable_Itech_fai) 
   