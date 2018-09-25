
setpathspear3

qf=getpv('QF',[7 1]);
qd=getpv('QD',[4 2]);
setpv('QF',1.05*qf,[7 1]);
setpv('QD',1.05*qd,[4 2]);

setfamilydata([1.05;  0.98; 0.95],'BPMx','Gain', [8,1; 12,4; 17,1]);
setfamilydata([0.97;  1.02; 0.99],'BPMy','Gain', [6,1; 11,6; 14,1]);


%% take LOCO data (in simulator mode)
measlocodata

%on the real machine, use 
%monbpm

cd /Users/ichaikov/Documents/MATLAB/LOCO/Release/lectures/Wednesday/locodata
load BPMData_2007-04-04_04-46-03.mat

BPMxData.Data=0.001*randn(size(BPMxData.Data));
BPMyData.Data=0.001*randn(size(BPMyData.Data));
save BPMData_sim

%% 
buildlocoinput


%%
locogui
 
%%  export fitting results and plot

figure
who
FitParameters
figure
plot(FitParameters(2).Values-FitParameters(1).Values)
figure
plot(FitParameters(5).Values-FitParameters(1).Values)
