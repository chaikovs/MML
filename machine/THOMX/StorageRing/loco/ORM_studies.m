
clear all; close all; clc
%%

AO = getao;

%%
% Find responce bpm matrix
%R1 = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList ,'Model','Archive');
%copybpmrespfile('/Users/ichaikov/Documents/MATLAB/MML_v1/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2019-01-28_12-31-43.mat')

%%

R1 = getbpmresp('Filename' ,'/Users/ichaikov/Documents/MATLAB/MML_v1/machine/THOMX/StorageRingOpsData/D1Thomx_017_064_r56_02_chro11/GoldenBPMRespD1Thomx_017_064_r56_02_chro11.mat');
R2 = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList);

%%

%Rmeas = getbpmresp('Filename' ,'/Users/ichaikov/Documents/MATLAB/MML_v1/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2019-01-28_12-35-05.mat');

%%

Rmodel= R1;
Rmeas = R2;

%%

figure(131)
subplot(2,1,1);
surf(Rmeas);  title('Measured BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
subplot(2,1,2);
surf(Rmodel);  title('Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');


figure(141)
subplot(2,1,1);
surf(Rmeas);  title('Measured BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
subplot(2,1,2);
surf(Rmeas-Rmodel);  title('Measured - Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');

%% Corrector magnet response
Rxx = 1:12;
Ryy = 13:24;
range = Rxx;

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
title('Measured BPM Response')
end
hold off

figure(121)
set(gca,'FontSize',16)
for i = range
plot(R2(:,i) - R1(:,i), 'o-')
hold all
xlabel('CM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Measured - Model BPM Response')
end
hold off
