function [CC_conf_reg,CC_Status_reg,RAM_X,RAM_Z]=fofb_read_cfg_memory(groupe)
CC_cfg=0;
matrix_x=256*4;
matrix_z=512*4;
CC_status=768*4;
fai_cfg_reg=2048*4;
ack_rise=int16([fai_cfg_reg 4 1 9 0]);
ack_fall=int16([fai_cfg_reg 4 1 8 0]);
Disable_Itech_fai=int16([(fai_cfg_reg+4) 4 1 0 0]);
Soft_stop=int16([(fai_cfg_reg+8) 4 1 0 0]);
Reset_user_fai=int16([(fai_cfg_reg) 4 1 0 0]);
Enable_user_fai=int16([(fai_cfg_reg) 4 1 10 0]);
Enable_Itech_fai=int16([(fai_cfg_reg+4) 4 1 1 0]);


        read_array=int16([0,4,1024])
        CC_status_array=int16([0,4,1024])
        result=uint16(tango_group_command_inout2(dev,'ReadFAData',read_array))
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% read configuration register%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        addr=1;
        CC_conf_reg.bpm_id=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_conf_reg.time_frame_length=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_conf_reg.MGT_powerdown=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_conf_reg.MGT_loopback=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_conf_reg.buf_clr_dly=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_conf_reg.Golden_X=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_conf_reg.Golden_Z=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% read CC status%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
       
        
        addr=4*768+1;
        CC_Status_reg.CC_version= dec2hex(result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3))
        addr=addr+4;
        CC_Status_reg.CC_status=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.lp1=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.lp2=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.lp3=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.lp4=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.link_up_down_status=dec2bin(result(addr),8)
        CC_Status_reg.status_RX1=CC_Status_reg.link_up_down_status(8)
        CC_Status_reg.status_RX2=CC_Status_reg.link_up_down_status(7)
        CC_Status_reg.status_RX3=CC_Status_reg.link_up_down_status(6)
        CC_Status_reg.status_RX4=CC_Status_reg.link_up_down_status(5)
        CC_Status_reg.status_TX1=CC_Status_reg.link_up_down_status(4)
        CC_Status_reg.status_TX2=CC_Status_reg.link_up_down_status(3)
        CC_Status_reg.status_TX3=CC_Status_reg.link_up_down_status(2)
        CC_Status_reg.status_TX4=CC_Status_reg.link_up_down_status(1)
        addr=addr+4;
        CC_Status_reg.time_frame_count=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.hard_error_cnt_1=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.hard_error_cnt_2=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.hard_error_cnt_3=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.hard_error_cnt_4=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.soft_error_cnt_1=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.soft_error_cnt_2=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.soft_error_cnt_3=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.soft_error_cnt_4=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.frame_error_cnt_1=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.frame_error_cnt_2=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.frame_error_cnt_3=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.frame_error_cnt_4=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.rx_pck_cnt_1=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.rx_pck_cnt_2=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.rx_pck_cnt_3=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.rx_pck_cnt_4=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.tx_pck_cnt_1=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.tx_pck_cnt_2=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.tx_pck_cnt_3=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)
        addr=addr+4;
        CC_Status_reg.tx_pck_cnt_4=result(addr)+2^8*result(addr+1)+2^16*result(addr+2)+2^24*result(addr+3)

          
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% read coeff RAM %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    
        for i=0:1:255
            RAM_X(i+1)=result(4*(i+256)+1)+2^8*result(4*(i+256)+2)+2^16*result(4*(i+256)+3)+2^24*result(4*(i+256)+4);

        end
        for i=0:1:255
            RAM_Z(i+1)=result(4*(i+512)+1)+2^8*result(4*(i+512)+2)+2^16*result(4*(i+512)+3)+2^24*result(4*(i+512)+4);
        end
        RAM_X
        RAM_Z
             
    