%%

AO = getao;
%%

Rmeas = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList,'Archive');

%%

copybpmrespfile('/Users/mbp_ichaikov/Documents/MATLAB/thomx-mml/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2017-02-20_14-05-22.mat')

%%

RmodelPH = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList ,'Model','Archive','Physics');
RmeasPH = getbpmresp('Physics');

%%

Rmodel = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList ,'Model','Archive','Hardware');
RmeasGET = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList,'Archive'); %getbpmresp('Hardware');

RmeasFile = load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-04-13_16-40-55.mat')

%% Comparizon different kicks

R1 = getbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList,'/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-04-13_16-40-55.mat');
R2 = getbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList,'/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2014-11-07_13-59-31.mat');



%% Corrector magnet response
Rxx = 1:12;
Ryy = 13:24;
range = Ryy;

figure(101)
set(gca,'FontSize',16)
for i = range
plot( Rmodel(i,:), 'o-')
hold all
xlabel('BPM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Model BPM Response')
end
hold off

figure(111)
set(gca,'FontSize',16)
for i = range
plot(RmeasGET(i,:), 'o-')
hold all
xlabel('BPM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Default BPM Response')
end
hold off

figure(121)
set(gca,'FontSize',16)
for i = range
plot(RmeasGET(i,:) - Rmodel(i,:), 'o-')
hold all
xlabel('BPM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Default - Model BPM Response')
end
hold off


%% Hardware units
figure(131)
subplot(2,1,1);
surf(RmeasGET);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
subplot(2,1,2);
surf(Rmodel);  title('Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');

% LOCO uses mm, not mm/amp
% R11 = RmeasFile.Rmat(1,1).Data;
% R12 = RmeasFile.Rmat(1,2).Data;
% R21 = RmeasFile.Rmat(2,1).Data;
% R22 = RmeasFile.Rmat(2,2).Data;



R11 = (ones(size(RmeasFile.Rmat(1,1).Data,1),1) * RmeasFile.Rmat(1,1).ActuatorDelta(:)') .* RmeasFile.Rmat(1,1).Data;
R12 = (ones(size(RmeasFile.Rmat(1,2).Data,1),1) * RmeasFile.Rmat(1,2).ActuatorDelta(:)') .* RmeasFile.Rmat(1,2).Data;
R21 = (ones(size(RmeasFile.Rmat(2,1).Data,1),1) * RmeasFile.Rmat(2,1).ActuatorDelta(:)') .* RmeasFile.Rmat(2,1).Data;
R22 = (ones(size(RmeasFile.Rmat(2,2).Data,1),1) * RmeasFile.Rmat(2,2).ActuatorDelta(:)') .* RmeasFile.Rmat(2,2).Data;

figure(151)
subplot(2,2,1);
surf(R11);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm]');
subplot(2,2,2);
surf(R12);  title('Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm]');
subplot(2,2,3);
surf(R21);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm]');
subplot(2,2,4);
surf(R22);  title('Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm]');


figure(141)
subplot(2,1,1);
surf(RmeasGET);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
subplot(2,1,2);
surf(RmeasGET-Rmodel);  title('Default - Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[mm/amp]');
     


%% Physics units
figure(131)
subplot(2,1,1);
surf(RmeasPH);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[m/rad]');
subplot(2,1,2);
surf(RmodelPH);  title('Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[m/rad]');


figure(141)
subplot(2,1,1);
surf(RmeasPH);  title('Default BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[m/rad]');
subplot(2,1,2);
surf(RmeasPH-RmodelPH);  title('Default - Model BPM Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[m/rad]');


%% Comparizon different kicks

figure(55)
subplot(3,1,1);
surf(R1);  title( ' Response x10'); xlabel('BPM #'); ylabel('CM #'); zlabel('[m/rad]');
subplot(3,1,2);
surf(R3);  title(' Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[m/rad]');
subplot(3,1,3);
surf(R1-R2);  title('Response x10 -  Response'); xlabel('BPM #'); ylabel('CM #'); zlabel('[m/rad]');

%%


