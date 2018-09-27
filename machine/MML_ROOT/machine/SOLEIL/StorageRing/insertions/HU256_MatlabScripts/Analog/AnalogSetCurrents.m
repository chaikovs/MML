function result=AnalogSetCurrents(ChannelNumber, FLValues, Debug)
% FLValues is a 2x1 vector containing First and Last Values of current
    result=-1;
    global ANALOG_SAO_DevServ;
    global ANALOG_SAI_DevServ;
    global ANALOG_CPT_DevServ;

%     Debug=1;
    
    if (isempty(ANALOG_SAO_DevServ)==1)
        fprintf('AnalogSetCurrents : You should initialise the SAO card with AnalogInitSAO function\n')
        return
    end
    
    if (Debug)
        fprintf('*******Begin of AnalogSetCurrents*******\n')
    end
    BufferStruct=tango_get_property(ANALOG_SAO_DevServ, 'BufferDepth');
    NumberPoints=str2num(BufferStruct.value{1});
    if (Debug)
        fprintf('AnalogSetCurrents Debug : the SAO BufferDepth value is %1.0f\n', NumberPoints)
        fprintf('AnalogSetCurrents Debug : the FLValues size is %1.0f\n', size(FLValues, 2))
    end
    if (size(FLValues, 1)==2)
        Points=interp1([1 NumberPoints], FLValues, 1:NumberPoints);
    else
        Points=FLValues;
    end
    if (Debug)
        fprintf('AnalogSetCurrents Debug : Points=\n')
        disp(Points)
        fprintf('AnalogSetCurrents Debug : ChannelNumber=%1.0f\n', ChannelNumber)
    end
    Argin.dvalue=Points;
    Argin.svalue{1,1}=num2str(ChannelNumber);
    tango_command_inout2(ANALOG_SAO_DevServ, 'SetAOScaledData', Argin);
%     tango_command_inout2(ANALOG_SAO_DevServ, 'Start');
    result=1;
    if (Debug)
        fprintf('*******End of AnalogSetCurrents*******\n')
    end

% tango_command_inout2(SAO_DevServ, 'SetAOScaledData', '[-5, -4, -3, 0, -5, -4, -3, 0, -5, -4] ['0']] )
% tango_command_inout2(SAO_DevServ, 'Stop')
% tango_command_inout2(SAI_DevServ, 'Stop')
% tango_command_inout2(SAI_DevServ, 'Init')
% tango_put_property(SAO_DevServ, 'BufferDepth', {num2str(Numpnts(2))})
% tango_command_inout2(SAO_DevServ, 'Init')

% tango_command_inout2(ANALOG_SAO_DevServ, 'Start');
% tango_command_inout2(ANALOG_SAI_DevServ, 'Start');4

% Commenté le 17/06/08 pour tests (ça ne marchait pas sinon!)
% tango_command_inout2(ANALOG_CPT_DevServ, 'Start');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%      writeattribute(OutCha0Ref, 5);

end
%     CurrentBX2=readattribute([idDevServ 'bx2/current']);
%     StateBZP=tango_command_inout2([idDevServ 'bzp'], 'State');
%     StateBX1=tango_command_inout2([idDevServ 'bx1'], 'State');