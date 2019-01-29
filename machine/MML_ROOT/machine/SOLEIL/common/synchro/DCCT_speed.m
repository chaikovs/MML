function DCCT_speed
% Mesure vitesse de lecture DCCT

temp=tango_read_attribute2('ANS-C03/DG/DCCT','current');anscur0=temp.value;
pause(0.2)

dt=0.05 ;  % en seconde
tt=1:60;
anscur=[];
%tango_command_inout2('ANS/SY/CENTRAL','FireBurstEvent');
tic
for t=tt
    pause(dt)
    temp=tango_read_attribute2('ANS-C03/DG/DCCT','current');
    anscur=[anscur temp.value];
    anscur1=anscur - anscur0; 
end
toc
plot(tt*dt,anscur1,'-ob');grid on
xlabel('Time (s)');ylabel('Current (A)')
    
     
    