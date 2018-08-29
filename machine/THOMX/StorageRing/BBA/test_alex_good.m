% investigate large angle in quad vs bba accuracy
% Set shift
global THERING
%CDR_017_072_r56_02_sx_NoDipFF_corrSX_BPMIP;
ifam='QP3';
ATI = atindex(THERING);
quad=[ATI.(ifam)] ;
target=quad(1);  
% target=list(1);  % QP3.1
bpm=[ATI.BPMz];
vcor=[ATI.VCOR];
%setpv('VCOR',[0]);
K0=THERING{target}.K;
%K0=-18.0545;
L0=0.15;
KL0=sqrt(-K0)*L0;
C0C=cos(KL0/2);
S0C=sin(KL0/2);
C0 =cos(KL0);
S0 =sin(KL0);
dksk=1.05;
offset0=1e-4;
setshift(target,0,offset0); % 1 mm
%Z0=getz;

% Scan orbit from corv
vcor1=vcor(1);
Zq1=[];
Zq2=[];
Zq3=[];
Zi=[];
bba=[];
teta=[-2:1:2]*1e-3;
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
   Zq3=[Zq3 (C0C*(Z1(3)-offset0)+S0C/sqrt(-K0)*Z1(4))+offset0];  % centre
   Zi=[Zi   (S0*(Z1(3)-offset0)+(1-C0)*Z1(4)/sqrt(-K0))/KL0+offset0]; % int

   THERING{target}.K=K0*dksk;
   THERING{target}.PolynomB(2) =K0*dksk;
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
tetaf=[-2:0.1:2]*1e-3;
f = polyval(p,tetaf);
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
plot(teta*1e3,bba,'ob'); hold on
plot(tetaf*1e3,f,'-k'); hold off