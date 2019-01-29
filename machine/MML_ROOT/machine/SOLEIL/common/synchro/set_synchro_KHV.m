function set_synchro_KHV(step)

% read
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigStepDelay');bpm=temp.value(1); %not used
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay');kv0=temp.value(1);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay');kh0=temp.value(1);


% setp les clk
tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay',(kv0+step) );
%tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay',(kh0+step) );


% read again
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay');kv1=temp.value(1);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay');kh1=temp.value(1);

fprintf('************ step %d ********** \n',step);
fprintf('StepDelay avant  KH= %d   KV=%d \n',kh0,kv0);
fprintf('StepDelay après  KH= %d   KV=%d \n',kh1,kv1);

