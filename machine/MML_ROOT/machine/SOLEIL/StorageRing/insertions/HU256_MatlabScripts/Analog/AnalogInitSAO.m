function Result=AnalogInitSAO(BufferDepth, TimeOfStep, UseSAI, TimeToWait)
    % BufferDepth (number of points), TimeOfStep in ms
    Result=-1;
    global ANALOG_SAO_DevServ
    global ANALOG_SAI_DevServ
    global ANALOG_CPT_DevServ
    global ANALOG_TimeToWait

    
    ANALOG_SAO_DevServ='ans-c15/ei/sao.1';
    ANALOG_SAI_DevServ='ans-c15/ei/sai.2';
    ANALOG_CPT_DevServ='ans-c15/ei/cpt.1';
    ANALOG_TimeToWait=TimeToWait;
    
    % SAO Caracteristics
%     TimeOfStep=400;   % [ms]
    SAO_Frequency=1./TimeOfStep %.*1000
    SAI_Frequency=1./(1./SAO_Frequency-TimeToWait)
    State=tango_command_inout2(ANALOG_SAO_DevServ, 'State');
    if (strcmp(State, 'RUNNING')==1)
        Res0=tango_command_inout2(ANALOG_SAO_DevServ, 'Stop');
%         tango_command_inout2(ANALOG_SAO_DevServ, 'State')
        if (Res0~=0)
            return
        end
    end
    
    tango_put_property(ANALOG_SAO_DevServ, 'BufferDepth', {num2str(BufferDepth)})
    tango_put_property(ANALOG_SAO_DevServ, 'Frequency', {num2str(SAO_Frequency)})
    
    Res1 = tango_command_inout2(ANALOG_SAO_DevServ, 'Init');
    pause(2);
    Res2 = tango_command_inout2(ANALOG_SAO_DevServ, 'Start');
    
    if (UseSAI==1)
        tango_write_attribute(ANALOG_SAI_DevServ, 'bufferDepth', 10);
%         tango_write_attirbute2(ANALOG_SAI_DevServ, 'frequency', BufferDepth);
%         Res3=tango_command_inout2(ANALOG_SAI_DevServ, 'Init');
        Res4=tango_command_inout2(ANALOG_SAI_DevServ, 'Start');
    else
        Res3=0;
        Res4=0;
    end
            
    if (Res1==0&&Res2==0&&Res4==0)
        Result=1;
    end