function [CC_version,CC_status,lp1,lp2,lp3,lp4,status_RX1,status_RX2,status_RX3,status_RX4,status_TX1,status_TX2,status_TX3,status_TX4,time_frame_count,hard_error_cnt_1,hard_error_cnt_2,hard_error_cnt_3,hard_error_cnt_4,soft_error_cnt_1,soft_error_cnt_2,soft_error_cnt_3,soft_error_cnt_4,frame_error_cnt_1,frame_error_cnt_2,frame_error_cnt_3,frame_error_cnt_4,rx_pck_cnt_1,rx_pck_cnt_2,rx_pck_cnt_3,rx_pck_cnt_4,tx_pck_cnt_1,tx_pck_cnt_2,tx_pck_cnt_3,tx_pck_cnt_4]=configure_fofb(bpm)
dev=bpm;
CC_cfg=0;
matrix_x=256*4;
matrix_z=512*4;
CC_status=768*4;
fai_cfg_reg=2048*4;
ack_rise=int32([fai_cfg_reg 4 1 9]);
ack_fall=int32([fai_cfg_reg 4 1 8]);
Disable_Itech_fai=int32([(fai_cfg_reg+4) 4 1 0]);
Soft_stop=int32([(fai_cfg_reg+8) 4 1 0]);
Reset_user_fai=int32([(fai_cfg_reg) 4 1 0]);
Enable_user_fai=int32([(fai_cfg_reg) 4 1 10]);
Enable_Itech_fai=int32([(fai_cfg_reg+4) 4 1 1]);

switch mode
    case 'read_RAM'
        RAM_X_array=int32([matrix_x,4,256])
        result=uint32(tango_command_inout2(dev,'ReadFAData',RAM_X_array))
        for i=1:1:256
            RAM_X(i)=result(i);
        end
        RAM_X
        
    case 'read'
        CC_status_array=int32([CC_status,4,32])
        result=uint32(tango_command_inout2(dev,'ReadFAData',CC_status_array))
        addr=1;
        CC_version= dec2hex(result(addr));
        addr=addr+1;
        CC_status=result(addr);
        addr=addr+1;
        lp1=result(addr);
        addr=addr+1;
        lp2=result(addr)
        addr=addr+1;
        lp3=result(addr);
        addr=addr+1;
        lp4=result(addr);
        addr=addr+1;
        link_up_down_status=dec2bin(result(addr),8)
        status_RX1=link_up_down_status(8)
        status_RX2=link_up_down_status(7)
        status_RX3=link_up_down_status(6)
        status_RX4=link_up_down_status(5)
        status_TX1=link_up_down_status(4)
        status_TX2=link_up_down_status(3)
        status_TX3=link_up_down_status(2)
        status_TX4=link_up_down_status(1)
        addr=addr+1;
        time_frame_count=result(addr);
        addr=addr+1;
        hard_error_cnt_1=result(addr);
        addr=addr+1;
        hard_error_cnt_2=result(addr);
        addr=addr+1;
        hard_error_cnt_3=result(addr);
        addr=addr+1;
        hard_error_cnt_4=result(addr);
        addr=addr+1;
        soft_error_cnt_1=result(addr);
        addr=addr+1;
        soft_error_cnt_2=result(addr);
        addr=addr+1;
        soft_error_cnt_3=result(addr);
        addr=addr+1;
        soft_error_cnt_4=result(addr);
        addr=addr+1;
        frame_error_cnt_1=result(addr);
        addr=addr+1;
        frame_error_cnt_2=result(addr);
        addr=addr+1;
        frame_error_cnt_3=result(addr);
        addr=addr+1;
        frame_error_cnt_4=result(addr);
        addr=addr+1;
        rx_pck_cnt_1=result(addr);
        addr=addr+1;
        rx_pck_cnt_2=result(addr);
        addr=addr+1;
        rx_pck_cnt_3=result(addr);
        addr=addr+1;
        rx_pck_cnt_4=result(addr);
        addr=addr+1;
        tx_pck_cnt_1=result(addr);
        addr=addr+1;
        tx_pck_cnt_2=result(addr);
        addr=addr+1;
        tx_pck_cnt_3=result(addr);
        addr=addr+1;
        tx_pck_cnt_4=result(addr);
        
        RAM_XZ_array=int32([matrix_x,4,512])
        result_ram=uint32(tango_command_inout2(dev,'ReadFAData',RAM_XZ_array))
        for i=1:1:256
            RAM_X(i)=result_ram(i);

        end
        for i=1:1:256
            RAM_Z(i)=result_ram((i+256));
        end
        RAM_X
        RAM_Z
             
    case 'write'
        switch commande
             case 'init_CC'
              conf_array=int16([CC_cfg 4 5 id 0 time_frame_lenght 0 MGT_powerdown 0 MGT_loopback 0 buf_clr_dly 0]);
              tango_command_inout2(dev,'WriteFAData',conf_array)
              tango_command_inout2(dev,'WriteFAData',ack_rise)
              tango_command_inout2(dev,'WriteFAData',ack_fall)
            case 'stop_CC'
               tango_command_inout2(dev,'WriteFAData',Disable_Itech_fai) 
               tango_command_inout2(dev,'WriteFAData',Soft_stop) 
               tango_command_inout2(dev,'WriteFAData',Reset_user_fai) 
            case 'arm_CC'
                tango_command_inout2(dev,'WriteFAData',Enable_user_fai) 
               tango_command_inout2(dev,'WriteFAData',Enable_Itech_fai) 
            otherwise
                display('command name is not valid')
        end;
    otherwise
        display('mode is not valid') 
end;
      