
clear all; close all; clc;


%% Initial lattices



% load lattice
ring_woErr = ThomX_017_064_r56_02_chro11();
ring = ThomX_017_064_r56_02_chro11_multip();
load ThomX_017_064_r56_02_chro11_errorMAX.mat
rerr = thomx_lattice_error;


indHCor=find(atgetcells(ring,'FamName','HCOR'));
indVCor=find(atgetcells(ring,'FamName','VCOR'));
indQCor=find(atgetcells(ring,'FamName','Quadrupole'));
indm=find(atgetcells(ring,'FamName','BPMx'));

ring_woErr=atsetfieldvalues(ring_woErr,indHCor,'PassMethod','StrMPoleSymplectic4Pass');
ring_woErr=atsetfieldvalues(ring_woErr,indVCor,'PassMethod','StrMPoleSymplectic4Pass');

ring=atsetfieldvalues(ring,indHCor,'PassMethod','StrMPoleSymplectic4Pass');
ring=atsetfieldvalues(ring,indVCor,'PassMethod','StrMPoleSymplectic4Pass');



r0=ring;

thomx_ring = ring;

%%

% global THERING
% thomx_ring=THERING;

%thomx_ring = atcavityon(thomx_ring);
%thomx_ring=atsetcavity(thomx_ring,300e3,0,30); % beta =1 ;
%thomx_ring = atradon(thomx_ring);
%thomx_ring{80}.Frequency = thomx_ring{80}.Frequency - 10e3 ;

Z0=[0.005 0.0 0.0001 0 0 0]';
Z1=[0.000 0 0.0000 0 0 0]';

Nturns = 10;
[X1,lost_thomx]=ringpass(thomx_ring,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, X1, BPMindex);
BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
BPMy = reshape(X2(3,:), Nturns, length(BPMindex));

% BPMindex = family2atindex('BPMx');
 spos = getspos('BPMx');
 
 %%
 
%  % Example: define apertures.
% Xapert=0.04*ones(size(thomx_ring));
% Yapert=0.028*ones(size(thomx_ring));
% thomx_ring=SetPhysicalAperture(thomx_ring,Xapert/2,Yapert/2);
% 
% atplot(thomx_ring,@plotAperture);

 
 %%

figure

plot(spos,BPMx)
hold on
plot(spos,mean(BPMx,1),'r--','Linewidth',3)
hold off
xlabel('s-position');
ylabel('x-orbit');

BPMxAll = reshape(BPMx', 1,Nturns*length(BPMindex));

figure
plot(BPMx(:,1))
xlabel('Turn number');
ylabel('x-orbit');

figure
plot(BPMxAll)
xlabel('Turn number');
ylabel('x-orbit');
 
 %%
 
 
indBPM=1:length(thomx_ring);   %find(atgetcells(ring,'FamName','BPMx'))';
s=findspos(thomx_ring,indBPM);

thomx_ring=atsetcavity(thomx_ring,300e3,0,30); % beta =1 ;

o=findorbit6(thomx_ring,indBPM);

f0 = thomx_ring{80}.Frequency;

rerrRF=atsetcavity_TESTBETANOT1(thomx_ring,300e3,0,30); 

o1=findorbit6(rerrRF,indBPM);
f1 = rerrRF{80}.Frequency;

figure;
set(gca,'FontSize',18)
plot(s,o(1,:));
hold on;
plot(s,o1(1,:));
legend(['beta=1, f_{RF}=' num2str(f0) ' Hz'],['beta thomx, f_{RF}=' num2str(f1) ' Hz'])
ylabel('x-orbit [m] findorbit6');
xlabel('s [m]');
title(['RF frequency difference ' num2str((f0-f1)/1e3) ' kHz'])
%print('freqRF_diff.png', '-dpng', '-r300');


%%

figure('units','normalized','position',[0.1 0.4 0.45 0.35])
atplot(rerr,'comment',[],@pltmisalignments);


figure('units','normalized','position',[0.3 0.3 0.45 0.35])
atplot(rerr,'comment',[],@plClosedOrbit)

figure('units','normalized','position',[0.1 0.4 0.65 0.35])
atplot(rerr,'comment',[],@plPolynomBComp);



%%

%compute response matrix if it doesn't already exist

if ~exist('ModelRM')
ModelRM...
        =getresponsematrices(...
        ring,...
        indm,...
        indHCor,...
        indVCor,...
        [],...
        indQCor,...
        []',...
        [0 0 0 0 0 0]',...
        [1 2 3]);
end

%%

%now orbit correction
[rcor,inCOD,hs,vs]=atcorrectorbit(rerr,...
    indm,...
    indHCor',...
    indVCor',...
    [0 0 0 0 0 0]',...
    [10 10],...
    [false true],...
    1.0,...
    ModelRM,...
    zeros(2,length(indm)),...
    [],...
    true);

%%


o=findorbit6Err(rerr,indm,inCOD);
oxe=o(1,:);
oye=o(3,:);

o=findorbit6(rerr,indm,inCOD);
ox=o(1,:);
oy=o(3,:);

sBPM=findspos(rcor,indm);
figure;subplot(2,1,1);
plot(sBPM,oxe,'.-');hold on; plot(sBPM,ox,'.-');
legend('findorbit6Err','findorbit6');
xlabel('s [m]');
ylabel('hor. COD');
subplot(2,1,2);
plot(sBPM,oye,'.-');hold on; plot(sBPM,oy,'.-');
legend('findorbit6Err','findorbit6');
xlabel('s [m]');
ylabel('ver. COD');


%%

%find new closed orbit

o=findorbit6Err(rerr,indm,inCOD);
oxe=o(1,:);
oye=o(3,:);

o=findorbit6Err(rcor,indm,inCOD);
oxc=o(1,:);
oyc=o(3,:);

sBPM=findspos(rcor,indm);
figure;subplot(2,1,1);
plot(sBPM,oxe,'.-');hold on; plot(sBPM,oxc,'.-');
legend('before','after');
xlabel('s [m]');
ylabel('hor. COD');
subplot(2,1,2);
plot(sBPM,oye,'.-');hold on; plot(sBPM,oyc,'.-');
legend('before','after');
xlabel('s [m]');
ylabel('ver. COD');

%%

Lh=atgetfieldvalues(rcor,indHCor,'Length');
Lv=atgetfieldvalues(rcor,indVCor,'Length');

figure(14);
histogram(hs.*Lh(1)*1e3,10)
set(gcf,'color','w')
set(gca,'fontsize',16');
grid on
set(gcf,'color','w')
set(gca,'fontsize',16');
xlabel(' horizontal kick [mrad]');
ylabel('Entries');
addlabel(1, 0, datestr(clock,0))


figure(15);
histogram(vs.*Lh(1)*1e3,10)
set(gcf,'color','w')
set(gca,'fontsize',16');
grid on
set(gcf,'color','w')
set(gca,'fontsize',16');
xlabel(' vertical kick [mrad]');
ylabel('Entries');
addlabel(1, 0, datestr(clock,0))


%%

Z0=[0.001 0.0 0.0001 0 0 0]';

Nturns = 1000;

[X1_woErr,lost_thomx_woErr]=ringpass(ring_woErr,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2_woErr = linepass(ring_woErr, X1_woErr, BPMindex);

[X1,lost_thomx]=ringpass(rerr,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(rerr, X1, BPMindex);

BPMx_woErr = reshape(X2_woErr(1,:), Nturns, length(BPMindex));
BPMy_woErr = reshape(X2_woErr(3,:), Nturns, length(BPMindex));

BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
BPMy = reshape(X2(3,:), Nturns, length(BPMindex));

% BPMindex = family2atindex('BPMx');
 spos = getspos('BPMx');

%%

figure
plot(spos,BPMx)
hold on
plot(spos,mean(BPMx,1),'r--','Linewidth',4)
hold off
xlabel('s-position');
ylabel('x-orbit');

BPMxAll = reshape(BPMx', 1,Nturns*length(BPMindex));
BPMxAll_woErr = reshape(BPMx_woErr', 1,Nturns*length(BPMindex));

figure
plot(BPMx(:,5),'r.-')
hold on
plot(BPMx_woErr(:,5))
hold off
xlabel('Turn number');
ylabel('x-orbit');

figure
plot(BPMxAll,'r.-')
hold on
plot(BPMxAll_woErr)
hold off
xlabel('Turn number');
ylabel('x-orbit');








