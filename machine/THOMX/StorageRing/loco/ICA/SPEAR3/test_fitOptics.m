
% addpath C:\xiahuang\work2014\NSLS2\ICA

clear all
selcase = 'case2';

[x,y] = icaloaddata(['spear_' selcase]); 
[data,dout]=geticaxymodes(x,y,512);
load dev_bpm.mat devbpm
data.bpmindex = family2atindex('BPMx',devbpm);

dire = 'C:\xiahuang\work2015\ICA_optics\fitSPEAR3_sim\sim_data';
load([dire filesep '\data_track_' selcase '.mat'],  'Dx', 'Dy');
data.Dx = Dx;
data.Dy = Dy;


% %load  meas_Disp Dx Dy dpp rf 
% load locoin LocoMeasData;
% a0 = getmcf;
% dpp = -LocoMeasData.DeltaRF/LocoMeasData.RF/a0;
% Dx = LocoMeasData.Eta(1:180)/dpp;
% Dy = LocoMeasData.Eta(181:360)/dpp;
% data.Dx = Dx/1000;
% data.Dy = Dy/1000;

%% 
if 1
sp3v82_lelt;
gx = ones(length(data.bpmindex),1);
gy = gx;
br = gx*0;
[FitParam] = buildfitparameters(THERING); 
% THERING = setparamgroup(THERING, FitParam.Params{end}, 0.0002);

else
    dire = 'C:\xiahuang\work2015\ICA_optics\fitSPEAR3_sim\sim_data';
 load([dire filesep '\data_track_' selcase '.mat'],  'THERING', 'gx','gy','br','FitParamRef');
global GLOBVAL
GLOBVAL.E0 = 3e9;
[FitParam] = FitParamRef; %buildfitparameters(THERING);
end



%test Xdiff
p0 = [zeros(size(FitParam.Values)); gx(:); gy(:); br(:)];
df0 = Xdiff(THERING,data,FitParam, p0,1);

fprintf('chi2 = %f\n', df0'*df0/length(df0));
%  return

%%
global g_costindex g_costweight
% g_costindex = 1:length(FitParam.Values);
g_costindex = 1:length(p0);
g_costweight = ones(size(g_costindex))*0.01;

load res_fit_case2_noPsiX2Y1 FitParamOut
FitParam = FitParamOut;

[FitParamOut,Xgain,Ygain,Broll] = fitRing(THERING,data,FitParam);

p = [zeros(size(FitParamOut.Values)); Xgain(:); Ygain(:); Broll(:)];
df = Xdiff(THERING,data,FitParamOut, p,1);

RINGFIT = THERING;
for ii=1:length(FitParamOut.Params)
    RINGFIT = setparamgroup(RINGFIT, FitParamOut.Params{ii}, FitParamOut.Values(ii)); %+FitParameters.Deltas(ii)
end
        

%% compare results

% load C:\xiahuang\work2014\NSLS2\TBT_data\icaoptics\sim_data\data_track_case1.mat  gx gy br FitParamRef
load(['sim_data' filesep 'data_track_' selcase '.mat'],  'FitParamRef', 'gx','gy','br');
RINGREF = THERING;
for ii=1:length(FitParamRef.Params)
    RINGREF = setparamgroup(RINGREF, FitParamRef.Params{ii}, FitParamRef.Values(ii)); %+FitParameters.Deltas(ii)
end
    
sp3v82_lelt;
[FitParam] = buildfitparameters(THERING); 

figure
subplot(3,1,1)
plot(1:57,gx,1:57, Xgain);
ylabel('BPM x');
subplot(3,1,2)
plot(1:57,gy,1:57, Ygain);
ylabel('BPM y');
subplot(3,1,3)
plot(1:57,br,1:57, Broll);
ylabel('BPM roll');
legend('target','fitted')

figure;
h = plot(1:72, FitParamOut.Values(1:72)./FitParam.Values(1:72)-1, 1:72, FitParamRef.Values(1:72)./FitParam.Values(1:72)-1); grid on
legend(h, 'fitted','target',0);
xlabel('Fit Param');
ylabel('\Delta K/K');

figure;
h = plot(1:13, FitParamOut.Values(73:end), 1:13, FitParamRef.Values(73:end)); grid on
legend(h, 'fitted','target',0);
xlabel('Skew Quad');
ylabel('Delta K');

%% 
sp3v82_lelt;
RING0 = THERING;
latcomp(RINGREF, RING0, 0,1);

latcomp(RINGREF, RINGFIT, 0,1);
