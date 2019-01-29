function ir=ddc_sim_SOLEIL(f,o)
% f fill as fraction of 1
% o offset as fractoin of 1

c1=ones(1,193);
c2=ones(1,129);
c3=ones(1,96);

cf=[zeros(1,129) conv(conv(c1,c2),c3) zeros(1,258)];
cf=cf/sum(cf);

t=zeros(5,length(cf));
for n=0:5
    for m=(5-n):5
    t(n+1,round((129*(m+o-f/2)+1):(129*(m+o+f/2)+1)))=1;
    end
end

sr=cf*t';
sr=sr/max(sr);

ir=diff(sr);

% subplot(2,3,3)
% plot(sr,'-o');
% xlabel('turns')
% ylabel('magnitude')
% title('step response')
% hold all;
% 
% subplot(2,3,2)
% plot(ir,'-o');
% axis([1 5 0 1])
% xlabel('turns')
% ylabel('magnitude')
% title('impulse response')
% hold all;
% 
% subplot(2,3,4)
% h=(abs(freqz(ir,1,10000)));
% plot(linspace(0,.5,10000),h)
% ylim([0 1])
% xlabel('normalised frequency')
% ylabel('magnitude')
% title('frequency response')
% h(2256*2);
% h(3630*2);
% xlim([0 .5])
% hold all;
% 
% subplot(2,3,1)
% plot(1:length(cf),t(5,:),1:length(cf),cf/max(cf),'k')
% ylim([0 1.1])
% %legend('fill','filter')
% xlabel('ADC samples')
% ylabel('magnitude')
% title('fill and offset')
% hold all;
% 
% subplot(2,3,5)
% tt0=[zeros(1,10) sin((0:9)*2*pi*.2256)];
% plot(2:21,tt0,'ko',1:22,conv(tt0,ir(2:4))/h(2256*2),'x-');xlim([1 20]);xlabel('turn');ylabel('X position')
% ylim([-1.01 1.01])
% title('kick response 1')
% hold all;
% 
% subplot(2,3,6)
% tt1=[zeros(1,10) sin((0:9)*2*pi*.2256+pi/8)];
% plot(2:21,tt1,'ko',1:22,conv(tt1,ir(2:4))/h(2256*2),'x-');xlim([1 20]);xlabel('turn');ylabel('X position')
% title('kick response 2')
% ylim([-1.01 1.01])
% hold all;




