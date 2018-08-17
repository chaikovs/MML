setpaththomx

TDR_good_017_064_r56_02_sx_Dff_SKEWquad 

%% Check kick value for ORM calculation


for icorv = 1:6
for ih = 50:50%10:100
    setsp('VCOR', 1e-6*ih, [2 icorv]);
    get_orbit
    setsp('VCOR', 0*ih, [2 icorv]);
end
end

%%


for icorv = 1:6
for ih = 50:50%10:100
    setsp('HCOR', 1e-6*ih, [1 icorv]);
    get_orbit
    setsp('HCOR', 0*ih, [1 icorv]);
end
end

%% RF freq for dispersion measurements

cspeed = 2.99792458e8;
harm = 30;
rf0 = getrf

rf = harm*cspeed/findspos(THERING,1+length(THERING))/1e6


for irf = 1:10
    steprf(0.005*irf, 'MHz'); 
    get_orbit
    steprf(-0.005*irf, 'MHz'); 
end

%%

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

%% one QUAD gradient error

qp11=getpv('QP1',[1 1]);
qp22=getpv('QP2',[1 2]);
qp33=getpv('QP3',[2 6]);
qp44=getpv('QP4',[2 8]);
qp314=getpv('QP31',[2 10]);
qp411=getpv('QP41',[1 4]);

setpv('QP1',0.97*qp11,[1 1]);
setpv('QP2',1.02*qp22,[1 2]);


%% Difference to the real field ~ 1% (power supply resolution 14/16 bits ~1/2^14) + 2% QUAD gradient errors


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

deltaK = 0.03 * randn(24,1);

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

save('errorssimuvals', 'deltaK'); 
fprintf('The differences to the real field ~1 percent are saved to errorssimuvals.mat \n');


%% QUAD gradient errors

qp21=getpv('QP2',[1 2]);
qp22=getpv('QP2',[1 11]);
qp23=getpv('QP2',[2 2]);
qp24=getpv('QP2',[2 11]);

deltaKerror2 = 0.01 * randn(24,1);

save('errorssimuvals', 'deltaKerror2','-append'); 
fprintf('QP2 field error  ~1 percent are saved to errorssimuvals.mat \n');

setpv('QP2',deltaKerror2(5)*qp21 + qp21,[1 2]);
setpv('QP2',deltaKerror2(6)*qp22 + qp22,[1 11]);
setpv('QP2',deltaKerror2(7)*qp23 + qp23,[2 2]);
setpv('QP2  ',deltaKerror2(8)*qp24 + qp24,[2 11]);


%% Tilt the QUAD

AO = getao;
quadindx=AO.('Qall').AT.ATIndex;

quadrot = 1e-3 * randn(length(quadindx),1);
settilt(quadindx,quadrot)
%addsrot(quadindx,quadrot)
fprintf('The QUAD rotation errors are set \n');
%plotorbit

%%

settilt(93,2e-3)

%%
sextindx=AO.('SX2').AT.ATIndex;
setshift(26, 20e-6, 30e-6)


%%

% deltaKerror4 = 0.03 * randn(24,1);
% 
% save('errorssimuvals', 'deltaKerror4','-append'); 
% fprintf('QP4 field error  ~3 percent are saved to errorssimuvals.mat \n');
% 
% setpv('QP4',deltaKerror4(13)*qp41 + qp41,[1 5]);
% setpv('QP4',deltaKerror4(14)*qp42 + qp42,[1 8]);
% setpv('QP4',deltaKerror4(15)*qp43 + qp43,[2 5]);
% setpv('QP4',deltaKerror4(16)*qp44 + qp44,[2 8]);
% 
deltaKerror3 = 0.03 * randn(24,1);

save('errorssimuvals', 'deltaKerror3','-append'); 
fprintf('QP3 field error  ~3 percent are saved to errorssimuvals.mat \n');

setpv('QP3',deltaKerror3(9)*qp31 + qp31,[1 6]);
setpv('QP3',deltaKerror3(10)*qp32 + qp32,[1 7]);
setpv('QP3',deltaKerror3(11)*qp33 + qp33,[2 6]);
setpv('QP3',deltaKerror3(12)*qp34 + qp34,[2 7]);

%% Quad missalignment (10e-6, 20e-6 um shift)

quadalign(50e-6, 50e-6);
fprintf('The QUAD missalignment errors are set \n');

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

%%
figure(1)
    set(gcf, 'color', 'w');
    export_fig('Abeta_1percentQUADerror_SKEWQUAD.pdf')



%% Save the lattice befor LOCO corrections

save('lat_before_corr_2', 'THERING')



%%  Vertical orbit distortion 
 

% Create an Orbit Error
getfamilydata('VCOR','Monitor','Units');
vcm = 0.000001 * randn(12,1);  % 
setsp('VCOR', vcm);

save('errorssimuvals', 'vcm','-append'); 
fprintf('The vertical corrctor errors are saved to errorssimuvals.mat \n');
%% Horizontal orbit distortion 

% Create an Orbit Error
getfamilydata('HCOR','Monitor','Units');
hcm = 0.000001 * randn(12,1);  % 
setsp('HCOR', hcm);

save('errorssimuvals', 'hcm','-append'); 
fprintf('The horizonal corrctor errors are saved to errorssimuvals.mat \n');
%%

%% DIpole field errors

dBB = 1e-4;
bendindx = findcells(THERING,'FamName','BEND');

THERING{bendindx(1)}.ByError = dBB;
THERING{bendindx(5)}.ByError = dBB;


%%


measlocodata

%%

buildlocoinput_thomx

%%


RINGData.Lattice = THERING;

%%

save('loco_02_in_simu_noise.mat', 'LocoModel', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags');


%% Examination of the measured files

%load('/Users/seagull/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/BPM/BPMData_2015-04-16_00-36-40.mat')

%load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-04-16/16-27-41/BPMData_2015-04-16_16-29-34.mat')

load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-06-02/19-33-01/BPMData_2015-06-02_19-34-55.mat')
%load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/applications/loco/Hardware.mat')

BPMxData

%%

figure
plot(BPMxData.Data)

figure
plot(BPMyData.Data)
%%

figure
plot(BPMxData.Data(:,5))
ylabel('x (mm)'); xlabel('BPM')

figure
subplot(2,2,1)
[xn,xx] = hist(BPMxData.Data(1,:),10);
bar(xx, xn)
title('BPM 1')
xlabel('x (mm)'); ylabel('count')

subplot(2,2,2)
i1 = 5;
[xn,xx] = hist(BPMxData.Data(i1,:),10);
bar(xx, xn)
title(['BPM ' num2str(i1)])
xlabel('x (mm)'); ylabel('count')

subplot(2,2,3)
i1 = 10;
[xn,xx] = hist(BPMyData.Data(i1,:),10);
bar(xx, xn)
title(['BPM ' num2str(i1)])
xlabel('y (mm)'); ylabel('count')

subplot(2,2,4)
i1 = 12;
[xn,xx] = hist(BPMyData.Data(i1,:),10);
bar(xx, xn)
title(['BPM ' num2str(i1)])
xlabel('y (mm)'); ylabel('count')

%%

figure
subplot(2,1,1)
plot(std(BPMxData.Data'))
xlabel('BPM'); ylabel('\sigma_x (mm)');

subplot(2,1,2)
plot(std(BPMyData.Data'))
xlabel('BPM'); ylabel('\sigma_y (mm)');


%% examine the response file

%load('/Users/seagull/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-04-16_00-34-19.mat')

load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-06-02/19-33-01/BPMRespMat_2015-06-02_19-33-07.mat')
%load /Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-04-23_19-05-08.mat

Rmat.Units

%%


figure
subplot(2,1,1)
surf(Rmat(1,1).Data)
%view(2)

subplot(2,1,2)
surf(Rmat(1,1).Data)
view(2)


figure
subplot(2,1,1)
surf(Rmat(2,2).Data)
%view(2)

subplot(2,1,2)
surf(Rmat(2,2).Data)
view(2)

figure
subplot(2,2,1)
surf(Rmat(1,1).Data)

subplot(2,2,2)
surf(Rmat(1,2).Data)

subplot(2,2,3)
surf(Rmat(2,1).Data)

subplot(2,2,4)
surf(Rmat(2,2).Data)

%% Put BPM and CORR gains (wrong BPM and CORR calibrations)

%load('/Users/seagull/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-04-15_21-55-38.mat')
%load('/Users/seagull/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-04-15/23-54-18/BPMRespMat_2015-04-15_23-54-35.mat')


%BPMs: each line of the ORM is multiplied by random factor from the interval [0.9; 1.2].
a = 0.95;
b = 1.05;
wrong_bpm_gain = (b-a).*rand(24,1) + a;

for irow = 1:12
    
Rmat(1,1).Data(irow,:) = Rmat(1,1).Data(irow,:)*wrong_bpm_gain(irow);
Rmat(1,2).Data(irow,:) = Rmat(1,2).Data(irow,:)*wrong_bpm_gain(irow);
Rmat(2,1).Data(irow,:) = Rmat(2,1).Data(irow,:)*wrong_bpm_gain(irow+12);
Rmat(2,2).Data(irow,:) = Rmat(2,2).Data(irow,:)*wrong_bpm_gain(irow+12);

end

%CORRs: each column of the ORM is multiplied by random factor from the interval [0.9; 1.2].
a = 0.95;
b = 1.05;
wrong_corr_gain = (b-a).*rand(24,1) + a;

for icol = 1:12
    
Rmat(1,1).Data(:,icol) = Rmat(1,1).Data(:,icol)*wrong_corr_gain(icol);
Rmat(1,2).Data(:,icol) = Rmat(1,2).Data(:,icol)*wrong_corr_gain(icol);
Rmat(2,1).Data(:,icol) = Rmat(2,1).Data(:,icol)*wrong_corr_gain(icol+12);
Rmat(2,2).Data(:,icol) = Rmat(2,2).Data(:,icol)*wrong_corr_gain(icol+12);

end

save('errorssimuvals', 'wrong_bpm_gain','wrong_corr_gain', '-append'); 
fprintf('Wrong BPM and CORR gains are saved to errorssimuvals.mat \n');

% setfamilydata([1.05; 1.01; 0.99;  0.98; 1.04; 0.95],'BPMx','Gain', [1,1; 1,2; 1,5; 1,6; 1,8; 1,10]);
% setfamilydata([0.97; 1.01; 0.99; 1.02; 0.99; 1.07],'BPMz','Gain', [1,2; 1,3; 1,4; 1,6; 1,10; 1,12]);
% 
% setfamilydata([1.01; 1.05; 0.93;  0.95; 0.91],'HCOR','Gain', [1,2; 1,5; 1,6; 2,2; 2,3]);
% setfamilydata([1.04; 0.94; 0.97;  0.99; 1.05],'VCOR','Gain', [1,1; 1,3; 1,5; 2,3; 2,6]);

%save('/Users/seagull/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-04-16_00-34-19_simu.mat', 'Rmat', 'MachineConfig');
%save('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-04-16/16-27-41/BPMRespMat_2015-04-16_16-27-47_simu.mat', 'Rmat', 'MachineConfig');
save('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-06-02/19-33-01/BPMRespMat_2015-06-02_19-33-07_simu.mat', 'Rmat', 'MachineConfig');

%% examine the dispersion file
%clear

%load('/Users/seagull/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Dispersion/Disp_2015-04-16_00-36-36.mat')

load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-06-02/19-33-01/Disp_2015-06-02_19-33-06.mat')
%load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Dispersion/Disp_2015-04-24_14-21-56.mat')

%load /Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Dispersion/Disp_2015-04-23_17-59-48.mat

% 
% BPMxDisp
% BPMyDisp

%%
figure
plot(getspos('BPMz'),BPMyDisp.Data,'dr-')
xlabel('spos (m)'); ylabel('Dx/Dy (mm/MHz)')
hold on
plot(getspos('BPMx'),BPMxDisp.Data,'o-')
hold off

figure
plot(getspos('BPMz'),BPMyDisp.Data*BPMyDisp.ActuatorDelta,'dr-')
xlabel('spos (m)'); ylabel('Dx/Dy (mm/MHz)')
hold on
plot(getspos('BPMx'),BPMxDisp.Data*BPMxDisp.ActuatorDelta,'o-')
hold off


%%

BPMxDisp.Data =  BPMxDisp.Data.*wrong_bpm_gain(1:12);
BPMyDisp.Data =  BPMyDisp.Data.*wrong_bpm_gain(13:24);

figure
plot(getspos('BPMx'),BPMxDisp.Data,'o-')
xlabel('spos (m)'); ylabel('Dx/Dy (mm/MHz)')
hold on
plot(getspos('BPMz'),BPMyDisp.Data,'dr-')
hold off

%save('/Users/seagull/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Dispersion/Disp_2015-04-16_00-36-36_simu.mat', 'BPMxDisp', 'BPMyDisp');
% save('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-04-16/16-27-41/Disp_2015-04-16_16-27-46_simu.mat', 'BPMxDisp', 'BPMyDisp');
save('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-06-02/19-33-01/Disp_2015-06-02_19-33-06_simu.mat', 'BPMxDisp', 'BPMyDisp');

%% Save the lattice befor LOCO corrections

save('lat_before_corr_27_skew', 'THERING')

%% now build the loco input file

buildlocoinput_thomx

%% build the loco fit parameters

buildlocofitparameters_thomx

%%

locogui


%% Plot QUAD scale-factors


%***********************
%load loco27_QUAD_SKEWQUAD_scaled_Levenberg.mat
load loco_02_in_simu_noise.mat
%load loco27A_QUAD_SKEWQUAD_scaled_Levenberg.mat

quadscales = FitParameters(1).Values(1:24)./FitParameters(end).Values(1:24);
figure
plot(quadscales,'bo-')
hold on
plot(1+deltaK,'ro-')
hold off
title('Quadrupole scaling factors for correction')
grid on

%% Apply corrections

load loco_ipac2015_QUAD.mat  

quadscales = FitParameters(end).Values(1:24)./FitParameters(1).Values(1:24);
figure
set(gca,'FontSize',16)
plot(quadscales, 'o-')
title('Quadrupole scaling factors for correction')
%%
QP1scale(1:4) = quadscales(1:4);
QP2scale(1:4) = quadscales(5:8);
QP3scale(1:4) = quadscales(9:12);
QP4scale(1:4) = quadscales(13:16);
QP31scale(1:4) = quadscales(17:20);
QP41scale(1:4) = quadscales(21:24);

QP1old = getsp('QP1');
QP2old = getsp('QP2');
QP3old = getsp('QP3');
QP4old = getsp('QP4');
QP31old = getsp('QP31');
QP41old = getsp('QP41');


QP1new = QP1scale'.*getsp('QP1');
QP2new = QP2scale'.*getsp('QP2');
QP3new = QP3scale'.*getsp('QP3');
QP4new = QP4scale'.*getsp('QP4');
QP31new = QP31scale'.*getsp('QP31');
QP41new = QP41scale'.*getsp('QP41');

%%
vpa(QP1new./QP1old)
vpa((QP1new - QP1old) ./QP1old)


%%
figure(1)
    set(gcf, 'color', 'w');
    export_fig('Adisp_1mrad_ALLquad_tilt_1percent_quad_error.pdf')

%%
figure(2)
    set(gcf, 'color', 'w');
    export_fig('AQUAD_scaling_factors_1percentQUADerror_SKEWQUAD.pdf')


%%
figure(2)
    set(gcf, 'color', 'w');
    export_fig('ARespMat_error_1percentQUADerror_SKEWQUAD_before_cor.pdf')
    
    %%
figure(1)
    set(gcf, 'color', 'w');
    export_fig('Abeta_1percentQUADerror_SKEWQUAD_after_corr.pdf')



%%
tune0=gettune;

[BetaX, BetaY, BPMs] = modeltwiss('Beta');

figure
h1 = subplot(5,1,[1 2]);
plot(BPMs,BetaX,'.-b', 'Markersize',10);
hold on
xlim([0 BPMs(end)]);
ylabel('\beta_x [m]');
%title('\beta-functions');

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


%% Adjust quadrupole strengths


setsp('QP1',QP1new,[],0);
setsp('QP2',QP2new,[],0);
setsp('QP3',QP3new,[],0);
setsp('QP4',QP4new,[],0);
setsp('QP31',QP31new,[],0);
setsp('QP41',QP41new,[],0);


%% Save the lattice after LOCO corrections

save('lat_after_corr_27_QUAD_1it', 'THERING')

%%


[BetaX, BetaY, BPMs] = modeltwiss('Beta');

h1  = subplot(5,1,[1 2]);
set(gca,'FontSize',16)
plot(BPMs, BetaX, 'k.-');
hold off
xlabel('s (m)'); ylabel('\beta_x [meters]')
u = legend('Before correction','After correction');
set(u,'Location','NorthEast')

h2 = subplot(5,1,[4 5]);
set(gca,'FontSize',16)
plot(BPMs, BetaY, 'k.-');
xlabel('s (m)'); ylabel('\beta_z [meters]')
u = legend('Before correction','After correction');
set(u,'Location','NorthWest')

%linkaxes([a1,a2],'x')
hold off

%%

set(gcf, 'color', 'w');
export_fig('/Users/ichaikov/Work/Schools_Confs/IPAC2015/paper/beta_fit.pdf')
%%
tunef=gettune

%% Apply fraction of the corrections


ifraction = 10;
for loop=1:ifraction
    setsp('QP1',QP1old+loop*(QP1new-QP1old)/ifraction,[],0);
    setsp('QP2',QP2old+loop*(QP2new-QP2old)/ifraction,[],0);
    setsp('QP3',QP3old+loop*(QP3new-QP3old)/ifraction,[],0);
    setsp('QP4',QP4old+loop*(QP4new-QP4old)/ifraction,[],0);
    setsp('QP31',QP31old+loop*(QP31new-QP31old)/ifraction,[],0);
    setsp('QP41',QP41old+loop*(QP41new-QP41old)/ifraction,[],0);
  
    pause(1);
end








%% Plotting

locoplotrms('loco_in14.mat', 2, 1)
locoplotrms('loco_test.mat', 2, 2)
locoplotrms('loco_test.mat', 2, 3)
locoplotrms('loco_test.mat', 2, 4)

%% To extract data from a LOCO file

[Data1, Data2, Data3 ]= locodata('loco_test.mat', 2, 'ResponseMatrixXX','Meas', 'EtaX', 'Meas', 'Tune', 'Meas')

%%




%% Questions

% Kick strength in milliradian
1000 * hw2physics('HCOR', 'Setpoint', Rmat(1,1).ActuatorDelta, Rmat(1,1).Actuator.DeviceList)  % 0.1 mrad
getfamilydata('HCOR','Setpoint','DeltaRespMat')


%%

[Dx, Dy, Sx, Sy] = modeldisp('BPMx',[],'BPMz',[],'Hardware')

plot(Sx, Dx*BPMxDisp.ActuatorDelta)
%%


cd /Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-04-24/19-32-12/

%%

eta1 = BPMxDisp.Data*BPMxDisp.ActuatorDelta
eta2 = BPMyDisp.Data*BPMyDisp.ActuatorDelta
di = [eta1; eta2]
LocoMeasData.Eta = di
%%

% LOCO uses mm, not mm/amp
R11 = (ones(size(Rmat(1,1).Data,1),1) * Rmat(1,1).ActuatorDelta(:)') .* Rmat(1,1).Data;
R12 = (ones(size(Rmat(1,2).Data,1),1) * Rmat(1,2).ActuatorDelta(:)') .* Rmat(1,2).Data;
R21 = (ones(size(Rmat(2,1).Data,1),1) * Rmat(2,1).ActuatorDelta(:)') .* Rmat(2,1).Data;
R22 = (ones(size(Rmat(2,2).Data,1),1) * Rmat(2,2).ActuatorDelta(:)') .* Rmat(2,2).Data;


% Build non-structure response matrix
LocoMeasData.M = [R11 R12; R21 R22];   % [mm]

%%


RINGData.Lattice = THERING;

%%

save('loco_02_aaa.mat', 'LocoModel', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags');

%%
AO = getao;
sizeQT = size(find(AO.QT.Status),1);
IndexQT = (1:sizeQT);% + LastIndex;
k =-1;
QT0 = 0;
Mode = 'Model';

DK = LOCOstruct.DK;

setsp('QT', k* DK(IndexQT) + QT0, Mode, 'Physics');

%%
figure(1)
    set(gcf, 'color', 'w');
    export_fig('skewQUAD_setpoint.pdf')


%% Correct coupling

SkewK_LOCO = -FitParameters(end).Values(1:end);

% According the Jacky's fit (Q:\Groups\Accel\Controls\matlab\spear3data\Loco\2004-01-07\Jacky) 
% K/I = 0.00245246 1/(m^2*A)
%current = SkewK_LOCO/0.00245246;

figure
plot(SkewK_LOCO,'bo--')
title('Skew quadrupole setpoint changes')

pause 

SQList = [     
     1     1
     1     2
     1     3
     1     4
     2     1
     2     2
     2     3
     2     4];
%     3     3 ;...  % 2008-03-10 removed skew quadrupole under kicker bump
%     from the list.
stepsp('SkewQuad',SkewK_LOCO,SQList)
