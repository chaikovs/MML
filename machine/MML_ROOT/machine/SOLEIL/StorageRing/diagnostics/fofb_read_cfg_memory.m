function [CC_conf_reg,CC_Status_reg,RAM_X,RAM_Z]=fofb_read_cfg_memory(bpm)
dev=bpm;
CC_cfg=0;
matrix_x=256;
matrix_z=512;
CC_status=768;
fai_cfg_reg=2048;
ack_rise=int32([fai_cfg_reg 4 1 9]);
ack_fall=int32([fai_cfg_reg 4 1 8]);
Disable_Itech_fai=int32([(fai_cfg_reg+4) 4 1 0]);
Soft_stop=int32([(fai_cfg_reg+8) 4 1 0]);
Reset_user_fai=int32([(fai_cfg_reg) 4 1 0]);
Enable_user_fai=int32([(fai_cfg_reg) 4 1 10]);
Enable_Itech_fai=int32([(fai_cfg_reg+4) 4 1 1]);


        read_array=int32([0,4,1024]);
        CC_status_array=int32([0,4,1024]);
        result=int32(tango_command_inout2(dev,'ReadFAData',read_array));
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% read configuration register%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        addr=1;
        CC_conf_reg.bpm_id=result(addr);
        addr=addr+1;
        CC_conf_reg.time_frame_length=result(addr);
        addr=addr+1;
        CC_conf_reg.MGT_powerdown=result(addr);
        addr=addr+1;
        CC_conf_reg.MGT_loopback=result(addr);
        addr=addr+1;
        CC_conf_reg.buf_clr_dly=result(addr);
        addr=addr+1;
        CC_conf_reg.Golden_X=result(addr);
        addr=addr+1;
        CC_conf_reg.Golden_Z=result(addr);
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% read CC status%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
       
        
        addr=768+1;
        CC_Status_reg.CC_version= dec2hex(result(addr));
        addr=addr+1;
        CC_Status_reg.CC_status=result(addr);
        addr=addr+1;
        CC_Status_reg.lp1=result(addr);
        addr=addr+1;
        CC_Status_reg.lp2=result(addr);
        addr=addr+1;
        CC_Status_reg.lp3=result(addr);
        addr=addr+1;
        CC_Status_reg.lp4=result(addr);
        addr=addr+1;
        CC_Status_reg.link_up_down_status=dec2bin(result(addr),8);
        CC_Status_reg.status_RX1=CC_Status_reg.link_up_down_status(8);
        CC_Status_reg.status_RX2=CC_Status_reg.link_up_down_status(7);
        CC_Status_reg.status_RX3=CC_Status_reg.link_up_down_status(6);
        CC_Status_reg.status_RX4=CC_Status_reg.link_up_down_status(5);
        CC_Status_reg.status_TX1=CC_Status_reg.link_up_down_status(4);
        CC_Status_reg.status_TX2=CC_Status_reg.link_up_down_status(3);
        CC_Status_reg.status_TX3=CC_Status_reg.link_up_down_status(2);
        CC_Status_reg.status_TX4=CC_Status_reg.link_up_down_status(1);
        addr=addr+1;
        CC_Status_reg.time_frame_count=result(addr);
        addr=addr+1;
        CC_Status_reg.hard_error_cnt_1=result(addr);
        addr=addr+1;
        CC_Status_reg.hard_error_cnt_2=result(addr);
        addr=addr+1;
        CC_Status_reg.hard_error_cnt_3=result(addr);
        addr=addr+1;
        CC_Status_reg.hard_error_cnt_4=result(addr);
        addr=addr+1;
        CC_Status_reg.soft_error_cnt_1=result(addr);
        addr=addr+1;
        CC_Status_reg.soft_error_cnt_2=result(addr);
        addr=addr+1;
        CC_Status_reg.soft_error_cnt_3=result(addr);
        addr=addr+1;
        CC_Status_reg.soft_error_cnt_4=result(addr);
        addr=addr+1;
        CC_Status_reg.frame_error_cnt_1=result(addr);
        addr=addr+1;
        CC_Status_reg.frame_error_cnt_2=result(addr);
        addr=addr+1;
        CC_Status_reg.frame_error_cnt_3=result(addr);
        addr=addr+1;
        CC_Status_reg.frame_error_cnt_4=result(addr);
        addr=addr+1;
        CC_Status_reg.rx_pck_cnt_1=result(addr);
        addr=addr+1;
        CC_Status_reg.rx_pck_cnt_2=result(addr);
        addr=addr+1;
        CC_Status_reg.rx_pck_cnt_3=result(addr);
        addr=addr+1;
        CC_Status_reg.rx_pck_cnt_4=result(addr);
        addr=addr+1;
        CC_Status_reg.tx_pck_cnt_1=result(addr);
        addr=addr+1;
        CC_Status_reg.tx_pck_cnt_2=result(addr);
        addr=addr+1;
        CC_Status_reg.tx_pck_cnt_3=result(addr);
        addr=addr+1;
        CC_Status_reg.tx_pck_cnt_4=result(addr);
        addr=addr+1;
        CC_Status_reg.process_time=result(addr);
        addr=addr+1;
        CC_Status_reg.bpm_involved=result(addr);

          
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% read coeff RAM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    
        for i=1:1:256
            RAM_X(i)=result((i+256));

        end
        for i=1:1:256
            RAM_Z(i)=result((i+512));
        end
        RAM_X;
        RAM_Z;
             
    