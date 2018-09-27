function soft_trig_bpm

%tmp_adress=int32(18);
tmp_adress=int32(16);


%%% Store old bpm soft event adress %%%%%
local='ANS-C01/SY/LOCAL.DG.2';
old_adress=tango_read_attribute2(local,'bpm.trigEvent')


%%%% Change bpm soft event adress %%%%%%
local='ANS-C01/SY/LOCAL.DG.2';
tango_write_attribute2(local,'bpm.trigEvent',tmp_adress);
tango_read_attribute2(local,'bpm.trigEvent')
for i=2:1:9
    local=['ANS-C0',num2str(i),'/SY/LOCAL.DG.1'];
    tango_write_attribute2(local,'bpm.trigEvent',tmp_adress);
    tango_read_attribute2(local,'bpm.trigEvent')
end
for i=10:1:16
    local=['ANS-C',num2str(i),'/SY/LOCAL.DG.1'];
    tango_write_attribute2(local,'bpm.trigEvent',tmp_adress);
    tango_read_attribute2(local,'bpm.trigEvent')
end

%%%% Change Central soft event adress %%%%%%
central='ANS/SY/CENTRAL';
 old_adress_central=tango_read_attribute2(central,'softEventAdress');
 tango_write_attribute2(central,'softEventAdress',tmp_adress);
 pause(1)
 tango_command_inout2(central,'FireSoftEvent');
 pause(1)
 tango_write_attribute2(central,'softEventAdress',old_adress_central.value(1));
%tango_command_inout2(central,'FirePostMortemEvent');

%%%%% Apply old bpm soft adress %%%%%%
local='ANS-C01/SY/LOCAL.DG.2';
tango_write_attribute2(local,'bpm.trigEvent',old_adress.value(1));
tango_read_attribute2(local,'bpm.trigEvent')
for i=2:1:9
    local=['ANS-C0',num2str(i),'/SY/LOCAL.DG.1'];
    tango_write_attribute2(local,'bpm.trigEvent',old_adress.value(1));
    tango_read_attribute2(local,'bpm.trigEvent')
end
for i=10:1:16
    local=['ANS-C',num2str(i),'/SY/LOCAL.DG.1'];
    tango_write_attribute2(local,'bpm.trigEvent',old_adress.value(1));
    tango_read_attribute2(local,'bpm.trigEvent')
end

