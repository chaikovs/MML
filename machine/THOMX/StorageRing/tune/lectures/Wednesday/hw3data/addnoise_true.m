sigma = 0.002;

load BPMData_2012-06-27_12-03-16.mat     
BPMxData.Data = BPMxData.Data + sigma*randn(size(BPMxData.Data));
BPMyData.Data = BPMyData.Data + sigma*randn(size(BPMyData.Data));
% save  BPMData_2012-06-27_12-03-16.mat     

%load Disp_2012-06-27_12-01-55.mat        
clear
sigma = 0.002;
load Disp_2012-06-27_12-15-15.mat
BPMxDisp.Data =  BPMxDisp.Data+sigma*BPMxDisp.ActuatorDelta*randn(size(BPMxDisp.Data));
BPMyDisp.Data =  BPMyDisp.Data+sigma*BPMyDisp.ActuatorDelta*randn(size(BPMyDisp.Data));
% save Disp_2012-06-27_12-15-15.mat


clear
sigma = 0.002;

load BPMRespMat_2012-06-27_12-02-00.mat 
Rmat(1,1).Data = Rmat(1,1).Data + sigma*randn(size(Rmat(1,1).Data))*Rmat(1,1).ActuatorDelta(1);
Rmat(1,2).Data = Rmat(1,2).Data + sigma*randn(size(Rmat(1,2).Data))*Rmat(1,2).ActuatorDelta(1);
Rmat(2,1).Data = Rmat(2,1).Data + sigma*randn(size(Rmat(2,1).Data))*Rmat(2,1).ActuatorDelta(1);
Rmat(2,2).Data = Rmat(2,2).Data + sigma*randn(size(Rmat(2,2).Data))*Rmat(2,2).ActuatorDelta(1);
% save BPMRespMat_2012-06-27_12-02-00.mat 

%%


surf(Rmat(1,1).Data)