% mesure bump sur les deux bpm 1.2 et 1.3
% faire set_kicker_eventto5 avant
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');clk=temp.value(1);
xx=[];zz=[];
n=0;
fprintf('*************************\n')
for i=1:104:416
    bunch=i;
    [dtour,dpaquet]=bucketnumber(bunch);
    clk_soft=int32(clk+dtour);
    tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay',clk_soft);

    pause(1)
    tango_command_inout('ANS/SY/CENTRAL','FireSoftEvent');
    pause(1)

    temp=tango_read_attribute2('ANS-C01/DG/BPM.2','XPosDD');
    X=temp.value;
    X=X(1:50);
    X=X-mean(X);
    Xmin=min(X);
    Xmax=max(X);
    Xrms=std(X);
    xx=[xx (Xmax-Xmin)/2];
    temp=tango_read_attribute2('ANS-C01/DG/BPM.2','ZPosDD');
    Z=temp.value;
    Z=Z(1:50);
    Z=Z-mean(Z);
    Zmin=min(Z);
    Zmax=max(Z);
    Zrms=std(Z);
    zz=[zz (Zmax-Zmin)/2];
 

    temp=tango_read_attribute2('ANS-C01/DG/BPM.3','XPosDD');
    X1=temp.value;
    X1=X1(1:50);
    X1=X1-mean(X1);
    X1min=min(X1);
    X1max=max(X1);
    X1rms=std(X1);
    xx1=[xx (X1max-X1min)/2];

    n=n+1;
    figure(101)
    subplot(4,1,n)
    plot(X,'-ob'); hold on
    plot(X1,'-or'); hold off
    txt=strcat('Visé =',num2str(bunch) ,'    Xrms=',num2str(Xrms));
    legend(txt)
    grid on
    ylim([-1.5  +1.5])
    
    figure(102)
    subplot(4,1,n)
    plot(Z,'-ob');
    txt=strcat('Visé =',num2str(bunch) ,'    Zrms=',num2str(Zrms));
    legend(txt)
    grid on
    ylim([-0.2  +0.2])
   
    
    
    
    fprintf('Visé = %d    Ecart max = %g  µm\n',bunch,(Xmax-Xmin)*1000);
    

end


tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay',int32(clk));
