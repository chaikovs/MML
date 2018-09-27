function result=test(ChannelNumber, Values, toto)
    result=-1;
%     readattribute([idDevServ 'bx2/current']);
    SAO_DevServ='ans-c15/ei/sao.1';
    SAI_DevServ='ans-c15/ei/sai.2';
    CPT_DevServ='ans-c15/ei/cpt.1';
    
%     OutChan0Ref=[SAO_DevServ '/channel0'];
%     OutChan0=readattribute([SAO_DevServ '/channel0'])
    Argin.dvalue=Values;
    Argin.svalue{1,1}=num2str(ChannelNumber);
%     tango_command_inout2(SAO_DevServ, 'SetAOScaledData', '[-5, -4, -3, 0, -5, -4, -3, 0, -5, -4] ['0']] )
Numpnts=size(Values)
if (Numpnts(1)~=1)
   fprintf('Values must be 1xN vector\n')
   return
end

if (toto==1)
    tango_command_inout2(SAO_DevServ, 'Stop')
    tango_put_property(SAO_DevServ, 'BufferDepth', {num2str(Numpnts(2))})
end
% tango_command_inout2(SAI_DevServ, 'Stop')
% tango_command_inout2(SAI_DevServ, 'Init')

% tango_command_inout2(SAO_DevServ, 'Init')
tango_command_inout2(SAO_DevServ, 'SetAOScaledData', Argin);
tango_command_inout2(SAO_DevServ, 'Start');
tango_command_inout2(SAI_DevServ, 'Start');
% tango_get_property(SAO_DevServ, 'BufferDepth')
tango_command_inout2(CPT_DevServ, 'Start');
%      writeattribute(OutCha0Ref, 5);

end
%     CurrentBX2=readattribute([idDevServ 'bx2/current']);
%     StateBZP=tango_command_inout2([idDevServ 'bzp'], 'State');
%     StateBX1=tango_command_inout2([idDevServ 'bx1'], 'State');