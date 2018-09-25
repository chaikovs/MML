
dir = '/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2014-11-06/11-41-38/'
load([dir 'BPMData_2014-11-06_11-43-39.mat'])  

%%

load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/applications/loco/Hardware.mat')
%%
figure
plot(BPMxData.Data)
ylabel('x (mm)'); xlabel('BPM')

%%
clear
sigma = 10e-3;
dir = '/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2014-11-06/11-41-38/'
load([dir 'BPMData_2014-11-06_11-43-39.mat'])
BPMxData.Data = BPMxData.Data + sigma*randn(size(BPMxData.Data));
BPMyData.Data = BPMyData.Data + sigma*randn(size(BPMyData.Data));

 % Low frequency drifting increases the STD.  For many purposes, like LOCO,
    % this is not desireable.  Using difference orbits mitigates the drift problem.
    Mx = BPMxData.Data;
    for i = 1:size(Mx,2)-1
        Mx(:,i) = Mx(:,i+1) - Mx(:,i);
    end
    Mx(:,end) = [];
    
    My = BPMyData.Data;
    for i = 1:size(My,2)-1
        My(:,i) = My(:,i+1) - My(:,i);
    end
    My(:,end) = [];
    
    BPMxData.Sigma = std(Mx,0,2) / sqrt(2);   % sqrt(2) comes from substracting 2 random variables
    BPMyData.Sigma = std(My,0,2) / sqrt(2);

%%

figure
plot(BPMxData.Data)
ylabel('x (mm)'); xlabel('BPM')


%%
save([dir 'BPMData_2014-11-06_11-43-39_1.mat'])   

%%
dir = '/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2014-11-06/11-41-38/'
load([dir 'Disp_2014-11-06_11-41-46.mat'])
%%
figure(123)
plot(getspos('BPMx'),BPMxDisp.Data,'o-')
xlabel('spos (m)'); ylabel('Dx (mm/MHz)')
hold on

%%
%load Disp_2012-06-27_12-01-55.mat        
clear
sigma = 10e-3;%0.01;
dir = '/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2014-11-06/11-41-38/'
load([dir 'Disp_2014-11-06_11-41-46.mat'])
BPMxDisp.Data =  BPMxDisp.Data+sigma*BPMxDisp.ActuatorDelta*randn(size(BPMxDisp.Data));
BPMyDisp.Data =  BPMyDisp.Data+sigma*BPMyDisp.ActuatorDelta*randn(size(BPMyDisp.Data));

plot(getspos('BPMx'),BPMxDisp.Data,'ro-')
hold off

%%
save([dir 'Disp_2014-11-06_11-41-46_1.mat'])
 
 
 
%% ORM

load([dir 'BPMRespMat_2014-11-06_11-41-48.mat'])
%%
figure
surf(Rmat(1,1).Data)
%view(2)

%%
clear
sigma = 10e-3;
dir = '/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/LOCO/2014-11-06/11-41-38/'
load([dir 'BPMRespMat_2014-11-06_11-41-48.mat'])
Rmat(1,1).Data = Rmat(1,1).Data + sigma*randn(size(Rmat(1,1).Data))*Rmat(1,1).ActuatorDelta(1);
Rmat(1,2).Data = Rmat(1,2).Data + sigma*randn(size(Rmat(1,2).Data))*Rmat(1,2).ActuatorDelta(1);
Rmat(2,1).Data = Rmat(2,1).Data + sigma*randn(size(Rmat(2,1).Data))*Rmat(2,1).ActuatorDelta(1);
Rmat(2,2).Data = Rmat(2,2).Data + sigma*randn(size(Rmat(2,2).Data))*Rmat(2,2).ActuatorDelta(1);
%%
 save([dir 'BPMRespMat_2014-11-06_11-41-48_1.mat'])
 