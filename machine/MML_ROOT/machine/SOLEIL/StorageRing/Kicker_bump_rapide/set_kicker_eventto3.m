% set adress kicker and bpm12 to 5 (soft)
event=int32(3);

arg.svalue={'k1.trig','k2.trig','k3.trig','k4.trig'};
arg.lvalue=[event event event event];
tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.1','SetEventsNumbers',arg);% chagement groupÃ© address sans update
tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.1', 'Update');pause(1);

tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigEvent',event);
tango_write_attribute2('ANS/SY/CENTRAL', 'softEventAdress',int32(101));


pause(1);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent');k1=temp.value(1);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigEvent');k2=temp.value(1);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigEvent');k3=temp.value(1);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigEvent');k4=temp.value(1);
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'softEventAdress');central=temp.value(1);

fprintf('trig event kicker and central \n k1=%d k2=%d k3=%d k4=%d central=%d \n',k1,k2,k3,k4, central)

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigEvent');bpm=temp.value(1);

fprintf('trig event BPM12 = %d  \n',bpm)
