% Simulation of the real machine errors

%%

[BetaX, BetaY, BPMs] = modeltwiss('Beta');

figure
h1 = subplot(5,1,[1 2]);
plot(BPMs,BetaX,'.-b', 'Markersize',10);
hold on
xlim([0 BPMs(end)]);
ylabel('\beta_x [m]');
title('\beta-functions');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(BPMs,BetaY,'.-r', 'Markersize',10);
hold on
xlabel('s - position [m]');
ylabel('\beta_z [m]');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');



% figure;
% a1 = subplot(2,1,1);
% set(gca,'FontSize',16)
% plot(BPMs, BetaX);
% hold on
% xlabel('s (m)'); ylabel('\beta_x [meters]')
% a2 = subplot(2,1,2);
% set(gca,'FontSize',16)
% plot(BPMs, BetaY);
% xlabel('s (m)'); ylabel('\beta_y [meters]')
% linkaxes([a1,a2],'x')
% hold on

%% Difference to the real field ~ 1% (power supply resolution 14 bits ~1/2^14)

deltaK = 0.01 * randn(24,1);

save('errorssimuvals', 'deltaK'); 
fprintf('The differences to the real field ~1 percent are saved to errorssimuvals.mat \n');


qp11=getpv('QP1',[1 1]);
qp12=getpv('QP1',[1 12]);
qp13=getpv('QP1',[2 1]);
qp14=getpv('QP1',[2 12]);

qp21=getpv('QP2',[1 2]);
qp22=getpv('QP2',[1 11]);
qp23=getpv('QP2',[2 2]);
qp24=getpv('QP2',[2 11]);

qp31=getpv('QP3',[1 6]);
qp32=getpv('QP3',[1 7]);
qp33=getpv('QP3',[2 6]);
qp34=getpv('QP3',[2 7]);

qp41=getpv('QP4',[1 5]);
qp42=getpv('QP4',[1 8]);
qp43=getpv('QP4',[2 5]);
qp44=getpv('QP4',[2 8]);

qp311=getpv('QP31',[1 3]);
qp312=getpv('QP31',[1 10]);
qp313=getpv('QP31',[2 3]);
qp314=getpv('QP31',[2 10]);

qp411=getpv('QP41',[1 4]);
qp412=getpv('QP41',[1 9]);
qp413=getpv('QP41',[2 4]);
qp414=getpv('QP41',[2 9]);


setpv('QP1',deltaK(1)*qp11 + qp11,[1 1]);
setpv('QP1',deltaK(2)*qp12 + qp12,[1 12]);
setpv('QP1',deltaK(3)*qp13 + qp13,[2 1]);
setpv('QP1',deltaK(4)*qp14 + qp14,[2 12]);

setpv('QP2',deltaK(5)*qp21 + qp21,[1 2]);
setpv('QP2',deltaK(6)*qp22 + qp22,[1 11]);
setpv('QP2',deltaK(7)*qp23 + qp23,[2 2]);
setpv('QP2',deltaK(8)*qp24 + qp24,[2 11]);

setpv('QP3',deltaK(9)*qp31 + qp31,[1 6]);
setpv('QP3',deltaK(10)*qp32 + qp32,[1 7]);
setpv('QP3',deltaK(11)*qp33 + qp33,[2 6]);
setpv('QP3',deltaK(12)*qp34 + qp34,[2 7]);

setpv('QP4',deltaK(13)*qp41 + qp41,[1 5]);
setpv('QP4',deltaK(14)*qp42 + qp42,[1 8]);
setpv('QP4',deltaK(15)*qp43 + qp43,[2 5]);
setpv('QP4',deltaK(16)*qp44 + qp44,[2 8]);

setpv('QP31',deltaK(17)*qp311 + qp311,[1 3]);
setpv('QP31',deltaK(18)*qp312 + qp312,[1 10]);
setpv('QP31',deltaK(19)*qp313 + qp313,[2 3]);
setpv('QP31',deltaK(20)*qp314 + qp314,[2 10]);

setpv('QP41',deltaK(21)*qp411 + qp411,[1 4]);
setpv('QP41',deltaK(22)*qp412 + qp412,[1 9]);
setpv('QP41',deltaK(23)*qp413 + qp413,[2 4]);
setpv('QP41',deltaK(24)*qp414 + qp414,[2 9]);

%% QUAD gradient errors

deltaKerror = 0.02 * randn(24,1);

save('errorssimuvals', 'deltaKerror','-append'); 
fprintf('The QUAD gradient errors are saved to errorssimuvals.mat \n');

setpv('QP2',deltaKerror(5)*qp21 + qp21,[1 2]);
setpv('QP2',deltaKerror(6)*qp22 + qp22,[1 11]);
setpv('QP2',deltaKerror(7)*qp23 + qp23,[2 2]);
setpv('QP2',deltaKerror(8)*qp24 + qp24,[2 11]);
%%

[BetaX, BetaY, BPMs] = modeltwiss('Beta');

h1  = subplot(5,1,[1 2]);
set(gca,'FontSize',16)
plot(BPMs, BetaX, 'k.-');
hold off
xlabel('s (m)'); ylabel('\beta_x [meters]')
h2 = subplot(5,1,[4 5]);
set(gca,'FontSize',16)
plot(BPMs, BetaY, 'k.-');
xlabel('s (m)'); ylabel('\beta_y [meters]')
%linkaxes([a1,a2],'x')
hold off


%%  Vertical orbit distortion 
 
% Create an Orbit Error
getfamilydata('VCOR','Monitor','Units');
vcm = 0.0001 * randn(12,1);  % 
setsp('VCOR', vcm);

save('errorssimuvals', 'vcm','-append'); 
fprintf('The vertical corrctor errors are saved to errorssimuvals.mat \n');
%% Horizontal orbit distortion 
 
% Create an Orbit Error
getfamilydata('HCOR','Monitor','Units');
hcm = 0.0001 * randn(12,1);  % 
setsp('HCOR', hcm);

save('errorssimuvals', 'hcm','-append'); 
fprintf('The horizonal corrctor errors are saved to errorssimuvals.mat \n');



%% Quad missalignment (10e-6, 20e-6 um shift)

%CDR_017_072_r56_02_sx_Dff_corrSX_BPMIP

%  getlist('QP3')
% 
%  QP1INDEX = findcells(THERING,'FamName','QP1')
%  QP2INDEX = findcells(THERING,'FamName','QP2')
%  QP4INDEX = findcells(THERING,'FamName','QP4')
 
quadalign(10e-6, 20e-6);

fprintf('The QUAD missalignment errors are set \n');
% QuadList = findmemberof('QUAD');
% 
% quadindx=AO.('QP1').AT.ATIndex;
% setshift(quadindx, 10e-6 * randn(length(quadindx),1),20e-6 * randn(length(quadindx),1) );

%% Dipole missalignment (0.1 rad rotation and 10e-6, 20e-6 um shift)

% BendList = findmemberof('BEND');
% 
% bendindx=AO.('BEND').AT.ATIndex;
% 
% setshift(bendindx, 10e-6 * randn(length(bendindx),1),20e-6 * randn(length(bendindx),1) );
% %plotorbit
% fprintf('The Dipole missalignment errors are set \n');
% 
% bendrot = 0.1 * randn(length(bendindx),1);
% settilt(bendindx,bendrot)
% fprintf('The Dipole rotation errors are set \n');
% %plotorbit
% 
% % addxrot
% % addyrot
% % addsrot

%% Set the wrong BPMs and correctors gains (calibration errors)

bpmxgain = 1 + 0.05 * randn(12,1);
bpmzgain = 1 + 0.05 * randn(12,1);
hcorgain = 1 + 0.05 * randn(12,1);
vcorgain = 1 + 0.05 * randn(12,1);

setfamilydata(bpmxgain,'BPMx','Gain');
setfamilydata(bpmzgain,'BPMz','Gain');
setfamilydata(hcorgain,'HCOR','Gain');
setfamilydata(vcorgain,'VCOR','Gain');

% setfamilydata([1.05;  0.98; 0.95],'BPMx','Gain', [1,1; 1,5; 1,10]);
% setfamilydata([0.97;  1.02; 0.99],'BPMz','Gain', [1,3; 1,6; 1,12]);
% 
% setfamilydata([1.01;  0.95; 0.91],'HCOR','Gain', [1,2; 2,3; 1,6]);
% setfamilydata([1.04;  0.99; 1.05],'VCOR','Gain', [1,5; 2,3; 2,6]);

save('errorssimuvals', 'bpmxgain', 'bpmzgain', 'hcorgain', 'vcorgain','-append'); 
fprintf('The BMPs and Corrctors calibration errors (GAINS) are saved to errorssimuvals.mat \n');

%%



