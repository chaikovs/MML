function scan_synchro_KHV

fprintf('************ scan KHV ********** \n');

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay');kv0=temp.value(1);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay');kh0=temp.value(1);

delay=[];
xx=[];
for i=0:16:208  % scan sur un tour
    % setp les clk
    tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay',(kh0+i) );
    %tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay',(kv0+i) );
    delay=[delay (i)];
    pause(1)
    
    % read again
    temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay');kh1=temp.value(1);
    %temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay');kv1=temp.value(1);
    
    % déclenche les kickers
    tango_command_inout2('ANS/SY/CENTRAL','FireSoftEvent');
    pause(2)
    
    % get DD sur BPM02
    temp=tango_read_attribute2('ANS-C01/DG/BPM.2','XPosDD');
    X=temp.value;
    X=X(1:50);
    X=X-mean(X);
    Xmin=min(X);
    Xmax=max(X);
    Xrms=std(X);
    dx=(Xmax-Xmin)/2;
    xx=[xx dx];
    
    figure(5)
    subplot(2,1,1)
    plot(X,'-ob');xlabel('Tour');ylabel('Amp  (mm)');grid on
    subplot(2,1,2)
    plot(delay,xx,'-ob');xlabel('Step Delay');ylabel('Amp max (mm)');grid on
   
    
    fprintf('StepDelay  KH= %d   Amplitude BPM02=%d \n',kh1,dx);
   
end



tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay',(kh0) );