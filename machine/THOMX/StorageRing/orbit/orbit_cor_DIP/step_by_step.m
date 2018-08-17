%%

AO = getao;

%%
% Find responce bpm matrix
R1 = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList ,'Model','Archive');

%%

copybpmrespfile('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2014-09-12_10-42-19.mat')

%%   Put in a vertical orbit distortion 
 
% Create an Orbit Error
vcm = .00005 * randn(12,1);  % 
setsp('VCOR', vcm);
%save vcm

%%   Put in a horizontal orbit distortion 
 
% Create an Orbit Error
hcm = .00005 * randn(12,1);  % 
setsp('HCOR', hcm);
%save hcm
%%
getsp('HCOR')
getsp('VCOR')


%%

getfamilydata('VCOR')
%%

getfamilydata('VCOR','Monitor','Units')

%%

getfamilydata('HCOR','Status')
%%

%% Simmulation of the quad gradient errors

%%
[BetaX, BetaY, BPMs] = modeltwiss('Beta');
figure;
a1 = subplot(2,1,1);
set(gca,'FontSize',16)
plot(BPMs, BetaX);
hold on
xlabel('s (m)'); ylabel('\beta_x [meters]')
a2 = subplot(2,1,2);
set(gca,'FontSize',16)
plot(BPMs, BetaY);
xlabel('s (m)'); ylabel('\beta_y [meters]')
linkaxes([a1,a2],'x')
hold on

%%
% qp11=getpv('QP1',[1 1]);  % QD
% qp12=getpv('QP1',[1 12]); % QD
% qp13=getpv('QP1',[2 1]);  % QD
% qp14=getpv('QP1',[2 12]); % QD
% 
% qp21=getpv('QP2',[1 2]);     % QF
% qp22=getpv('QP2',[1 11]);    % QF
% qp23=getpv('QP2',[2 2]);     % QF
% qp24=getpv('QP2',[2 11]);    % QF
% 
% qp31=getpv('QP3',[1 6]);  % QD
% qp32=getpv('QP3',[1 7]);  % QD
% qp33=getpv('QP3',[2 6]);  % QD
% qp34=getpv('QP3',[2 7]);  % QD
% 
% qp41=getpv('QP4',[1 5]);    % QF
% qp42=getpv('QP4',[1 8]);    % QF
% qp43=getpv('QP4',[2 5]);    % QF
% qp44=getpv('QP4',[2 8]);    % QF
% 
% qp311=getpv('QP31',[1 3]);   % QD
% qp312=getpv('QP31',[1 10]);  % QD
% qp313=getpv('QP31',[2 3]);   % QD
% qp314=getpv('QP31',[2 10]);  % QD
% 
% qp411=getpv('QP41',[1 4]);     % QF
% qp412=getpv('QP41',[1 9]);     % QF
% qp413=getpv('QP41',[2 4]);     % QF
% qp414=getpv('QP41',[2 9]);     % QF
%%

getpv('QP1') % QD
getpv('QP2') % QF
getpv('QP3') % QD
getpv('QP4') % QF
getpv('QP31') % QD
getpv('QP41') % QF

%%

% qf=getpv('QP2',[1 11]);
% qd=getpv('QP3',[1 6]);
% qdd=getpv('QP4',[1 8]);
% qdd1=getpv('QP1',[1 12]);
% 
% setpv('QP2',1.15*qf,[1 11]);
% setpv('QP3',1.05*qd,[1 6]);
% setpv('QP4',0.95*qdd,[1 8]);
% setpv('QP1',0.95*qdd1,[1 12]);


qd11=getpv('QP1',[1 1]);
qd12=getpv('QP1',[1 12]);
qd13=getpv('QP1',[2 1]);
qd14=getpv('QP1',[2 12]);

setpv('QP1',1.1*qd11,[1 1]);
setpv('QP1',1.05*qd12,[1 12]);
setpv('QP1',0.93*qd13,[2 1]);
setpv('QP1',0.9*qd14,[2 12]);

% qd31=getpv('QP3',[1 6]);
% qd32=getpv('QP3',[1 7]);
% setpv('QP3',1.05*qd31,[1 6]);
% setpv('QP3',1.05*qd32,[1 7]);

%%
[BetaX, BetaY, BPMs] = modeltwiss('Beta');
a1 = subplot(2,1,1);
set(gca,'FontSize',16)
plot(BPMs, BetaX, 'r.-');
hold off
xlabel('s (m)'); ylabel('\beta_x [meters]')
a2 = subplot(2,1,2);
set(gca,'FontSize',16)
plot(BPMs, BetaY, 'r.-');
xlabel('s (m)'); ylabel('\beta_y [meters]')
linkaxes([a1,a2],'x')
hold off

%%
getsp('QP1')
getsp('QP2')
getsp('QP3')
getsp('QP4')
getsp('QP31')
getsp('QP41')

%% Set the wrong BPMs and correctors gain

setfamilydata([1.05;  0.98; 0.95],'BPMx','Gain', [1,1; 1,5; 1,10]);
setfamilydata([0.97;  1.02; 0.99],'BPMz','Gain', [1,3; 1,6; 1,12]);

setfamilydata([1.01;  0.95; 0.91],'HCOR','Gain', [1,2; 2,3; 1,6]);
setfamilydata([1.04;  0.99; 1.05],'VCOR','Gain', [1,5; 2,3; 2,6]);

%% Quad missalignment

%CDR_017_072_r56_02_sx_Dff_corrSX_BPMIP

 getlist('QP3')

 QP1INDEX = findcells(THERING,'FamName','QP1')
 QP2INDEX = findcells(THERING,'FamName','QP2')
 QP4INDEX = findcells(THERING,'FamName','QP4')
 
 %%
 
quadalign(10e-6,20e-6);plotorbit

%%
%setshift(QP1INDEX(3), 20e-6, 10e-6)
setshift(85, 5e-6, 10e-6)
%setshift(QP2INDEX(1), 50e-6, 10e-6)
setshift(7, 20e-6, 25e-6)
%setshift(QP4INDEX(1), 10e-6, 20e-6)
setshift(52, 10e-6, 15e-6)

% addxrot
% addyrot
% addsrot


%%

R2 = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList,'Archive');

%%

copybpmrespfile('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2014-11-06/11-41-38/BPMRespMat_2014-11-06_11-41-48_1.mat')

%%

%AO = getao;
R1 = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList ,'Model','Archive','Physics');
R2 = getbpmresp('Physics');

%% Corrector magnet response
Rxx = 1:12;
Ryy = 13:24;
range = Ryy;

figure(101)
set(gca,'FontSize',16)
for i = range
plot( R1(:,i), 'o-')
hold all
xlabel('CM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Model BPM Response')
end
hold off

figure(111)
set(gca,'FontSize',16)
for i = range
plot(R2(:,i), 'o-')
hold all
xlabel('CM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Default BPM Response')
end
hold off

figure(121)
set(gca,'FontSize',16)
for i = range
plot(R2(:,i) - R1(:,i), 'o-')
hold all
xlabel('CM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Default - Model BPM Response')
end
hold off

%%
Rmeas  = getbpmresp('Physics');
%Rmodel = measbpmresp('Model');
Rmodel = R1;
%%
figure(131)
subplot(2,1,1);
surf(Rmeas);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
subplot(2,1,2);
surf(Rmodel);  title('Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');


figure(141)
subplot(2,1,1);
surf(Rmeas);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
subplot(2,1,2);
surf(Rmeas-Rmodel);  title('Default - Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
     
%%

