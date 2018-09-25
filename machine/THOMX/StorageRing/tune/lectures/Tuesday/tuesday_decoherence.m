%% demonstrate the decoherence effect in turn-by-turn BPM measurements
Np = 40;
x0= 0.005;
sig_dp = 0.001;
Nturn = 500;

dpl = randn(1,Np)*sig_dp;
X0=zeros(6,Np);
X0(5,:) = dpl;
X0(6,:) = randn(1,Np)*0.0049;
X0(1,:) = x0;

global THERING
sp3v82
modelchro

setcavity on;
setradiation on;
R0=findorbit6(THERING,1);
rfindx = findcells(THERING,'Frequency');
THERING = setcellstruct(THERING, 'TimeLag',1,-R0(6));

    
X = ringpass(THERING,X0,Nturn);
x = reshape(X(1,:),Np,Nturn);
xp = reshape(X(2,:),Np,Nturn);
dp = reshape(X(5,:),Np,Nturn);

xv = mean(x);

figure(81)
plot(1:Nturn, xv)
xlabel('turn');ylabel('BPMx')

figure(82)
plot(1:Nturn, dp)
xlabel('turn');ylabel('\Delta p/p')

figure(83)
subplot(2,2,1);i1=4;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
xlabel('x (m)'); ylabel('xp (rad)')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])
subplot(2,2,2);i1=25;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])
subplot(2,2,3);i1=59;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])
subplot(2,2,4);i1=120;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])

%% change the chromoticity
setsp('SF',0);
setsp('SD',0);
setsp('SFM',0);
setsp('SDM',0);

X = ringpass(THERING,X0,Nturn);
x = reshape(X(1,:),Np,Nturn);
xp = reshape(X(2,:),Np,Nturn);
dp = reshape(X(5,:),Np,Nturn);

xv = mean(x);


figure(91)
plot(1:Nturn, xv)
xlabel('turn');ylabel('BPMx')

figure(92)
plot(1:Nturn, dp)
xlabel('turn');ylabel('\Delta p/p')

figure(93)
subplot(2,2,1);i1=4;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
xlabel('x (m)'); ylabel('xp (rad)')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])
subplot(2,2,2);i1=25;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])
subplot(2,2,3);i1=59;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])
subplot(2,2,4);i1=120;
plot(x(:,i1), xp(:,i1),'.',0,0,'o')
set(gca,'xlim',[-8,8]*.001, 'ylim',[-1.5,1.5]*.001)
title(['turn ' num2str(i1)])





