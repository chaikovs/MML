
%cd /Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata//BPM/
cd /Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2015-06-02/19-33-01/

%%

load BPMData_2015-06-02_19-34-55.mat     

sigma = 0.2;

BPMxData.Data = BPMxData.Data + sigma*randn(size(BPMxData.Data));
BPMyData.Data = BPMyData.Data + sigma*randn(size(BPMyData.Data));
save('BPMData_2015-06-02_19-34-55_noise.mat','BPMxData','BPMyData');     

%%        
cd /Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Dispersion/

%%
load Disp_2015-06-02_19-33-06_simu.mat

sigma = 0.2/BPMxDisp.ActuatorDelta;

BPMxDisp.Data =  BPMxDisp.Data+sigma*BPMxDisp.ActuatorDelta*randn(size(BPMxDisp.Data));
BPMyDisp.Data =  BPMyDisp.Data+sigma*BPMyDisp.ActuatorDelta*randn(size(BPMyDisp.Data));
save('Disp_2015-06-02_19-33-06_simu_noise.mat', 'BPMxDisp', 'BPMyDisp');

%%
cd /Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/

%%
load BPMRespMat_2015-06-02_19-33-07_simu.mat

sigma = 0.2/Rmat(1,1).ActuatorDelta(1);

Rmat(1,1).Data = Rmat(1,1).Data + sigma*randn(size(Rmat(1,1).Data))*Rmat(1,1).ActuatorDelta(1);
Rmat(1,2).Data = Rmat(1,2).Data + sigma*randn(size(Rmat(1,2).Data))*Rmat(1,2).ActuatorDelta(1);
Rmat(2,1).Data = Rmat(2,1).Data + sigma*randn(size(Rmat(2,1).Data))*Rmat(2,1).ActuatorDelta(1);
Rmat(2,2).Data = Rmat(2,2).Data + sigma*randn(size(Rmat(2,2).Data))*Rmat(2,2).ActuatorDelta(1);
save('BPMRespMat_2015-06-02_19-33-07_simu_noise.mat', 'Rmat', 'MachineConfig');
