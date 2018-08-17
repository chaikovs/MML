% investigate large angle in quad vs bba accuracy
% Set shift
global THERING
%CDR_017_072_r56_02_sx_NoDipFF_corrSX_BPMIP;
ifam='QP3';
ATI = atindex(THERING);
quad=[ATI.(ifam)] ;
target=quad(1);  % QP3.1
bpm=[ATI.BPMz];
vcor=[ATI.VCOR];
%setpv('VCOR',[0]);
%K0=THERING{target}.K;
K0=-18.0545;
L0=0.15;
KL0=sqrt(K0)*L0;
C0=cos(KL0);
S0=sin(KL0);
dksk=0.002;
offset0=1e-4;
setshift(target,0,offset0); % 1 mm
%Z0=getz;

% Scan orbit from corv
vcor1=vcor(8);
Zq1=[];
Zq2=[];
Zq3=[];
Zi=[];
bba=[];
teta=[-2:0.5:2]*1e-3;
for dev=teta
   %setpv('VCOR',dev,[1 1]);
   THERING{vcor1}.KickAngle=[0,dev];

   THERING{target}.K=K0;
   THERING{target}.PolynomB(2) = K0;
   CO=findorbit4(THERING,0,bpm);
   Z0=CO(3,:);
   Z1=findorbit4(THERING,0,target);
   Z2=findorbit4(THERING,0,target+1);
   Zq1=[Zq1 Z1];    % entrance
   Zq2=[Zq2 Z2];    % exit
   Zq3=[Zq3 (C0*Z1(3)+S0/sqrt(K0)*Z1(4))];  % centre
   Zi=[Zi (S0*Z1(3)+(1-C0)*Z1(4)/sqrt(K0))/KL0]; % int

   THERING{target}.K=K0*dksk;
   THERING{target}.PolynomB(2) = K0*dksk;
   CO=findorbit4(THERING,0,bpm);
   Zk=CO(3,:);

   dZ=((Zk-Z0)*1e3).^2;
   bba=[bba sum(dZ)];
end
THERING{vcor1}.KickAngle=[0,0];

[bbam, im]=min(bba); % im : basic good offset index
offset1=Zq1(3,im);
offset2=Zq2(3,im);
offset3=Zq3(im);
offseti=Zi(im);

p = polyfit(teta,bba,2); % Find root for value
r =roots(p);t0=mean(r);
f = polyval(p,teta);
t1=interp1(teta,Zq1(3,:),t0);
t2=interp1(teta,Zq2(3,:),t0);
t3=interp1(teta,Zq3,t0);
ti=interp1(teta,Zi,t0);

fprintf('************\n')
fprintf(' quad offset   : %8.3E \n',offset0)
fprintf(' quad entrance : %8.3E    %8.3E\n',offset1, t1)
fprintf(' quad exit     : %8.3E    %8.3E \n',offset2,t2)
fprintf(' quad centre   : %8.3E    %8.3E \n',(offset3), t3)
fprintf(' quad mean     : %8.3E    %8.3E \n',(offset1+offset2)/2, (t1+t2)/2)
fprintf(' quad int      : %8.3E    %8.3E \n',(offseti), ti)
fprintf('\n')

figure(100)
plot(teta*1e3,bba,'-b'); hold on
plot(teta*1e3,f,'-k'); hold off
xlabel('Cor dev (mrad)')
ylabel('diff orbit vs quad')
grid on

figure(101)
plot(teta*1e3,Zq1(3,:),'-b');hold on
plot(teta*1e3,Zq3,'-m')
plot(teta*1e3,Zi,'-k')
plot(teta*1e3,Zq2(3,:),'-r');hold off
xlabel('Cor dev (mrad)')
ylabel('orbit quad entrance exit')
grid on

figure(102)
plot(teta*1e3,Zq1(4,:),'-b');hold on
plot(teta*1e3,Zq2(4,:),'-r');hold off
xlabel('Cor dev (mrad)')
ylabel('slope quad entrance exit')
grid on


% % scan quad strength
% THERING{target}.K=K0*1.01;
% THERING{target}.PolynomB(2) = K0*1.01;
%
% %
%get_orbit