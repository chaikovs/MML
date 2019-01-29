function loco_build_BPMmat

%% Load golden file
FileName      = getfamilydata('OpsData', 'BPMGainAndCouplingFile');
DirectoryName = getfamilydata('Directory', 'OpsData');
FileName       = fullfile(DirectoryName, FileName);

%% Resultats fit LOCO redémarrage run 2 2009
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-05-29_SOFB/160quad.mat')

%% Resultats fit LOCO Nanoscopium run 4 2010
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-10-10_Nano/163quad.mat')

%% Resultats fit LOCO Nanoscopium run 5 2011
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-11-04/160quad.mat')

iter = 3;
HBPMgain = BPMData(iter).HBPMGain;
VBPMgain = BPMData(iter).VBPMGain;
HBPMcoupling = BPMData(iter).HBPMCoupling;
VBPMcoupling = BPMData(iter).VBPMCoupling;
HCMkick = CMData(iter).HCMKicks;
meanHCMkick = mean(HCMkick);

C = zeros(120,2,2);
for ik =1:120,
    C(ik,:,:)= [ HBPMgain(ik)       HBPMcoupling(ik) 
                 VBPMcoupling(ik)   VBPMgain(ik)      ];
    Cinv(ik,:,:) = inv(squeeze(C(ik,:,:)));
end
%%

% load loco data
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2010-10-29/LOCO160quad.mat')
%Ref = load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-05-29_SOFB/160quad.mat');
%Ref = load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-10-10_Nano/163quad.mat')
% Comparison
iter = 3;
figure
h1 = subplot(2,2,1)
plot(BPMData(iter).HBPMGain); hold all
plot(Ref.BPMData(iter).HBPMGain,'r')
ylabel('HBPM gains')
h2 = subplot(2,2,2)
plot(BPMData(iter).VBPMGain); hold all
plot(Ref.BPMData(iter).VBPMGain,'r')
ylabel('VBPM gains')
h3 = subplot(2,2,3)
plot(BPMData(iter).HBPMCoupling); hold all
plot(Ref.BPMData(iter).HBPMCoupling,'r')
ylabel('HBPM coupling')
h4 = subplot(2,2,4)
plot(BPMData(iter).VBPMCoupling); hold all
plot(Ref.BPMData(iter).VBPMCoupling,'r')
legend(['LOCO data', 'Diag. data'])
ylabel('VBPM coupling')
linkaxes([h1 h2 h3 h4], 'x');
xaxis([0 121])

% Load coupling data measurement by diagnostics group in April 2007
load(fullfile(getfamilydata('Directory', 'LOCOData'), 'coupling_diag_avril07.mat'));

%%
iter = 3;

% Remove nanoscopium BPM
id = dev2elem('BPMx',[13 8; 13 9]);
idx = [1:id(1)-1 id(2)+1:122];

figure
h1 = subplot(2,2,1)
plot(BPMData(iter).HBPMGain(idx))
ylabel('HBPM gains')
h2 = subplot(2,2,2)
plot(BPMData(iter).VBPMGain(idx))
ylabel('VBPM gains')
h3 = subplot(2,2,3)
plot(BPMData(iter).HBPMCoupling(idx))
ylabel('HBPM coupling')
h4 = subplot(2,2,4)
plot(BPMData(iter).VBPMCoupling(idx)); hold on
plot(CT_DIAG,'k')
legend('LOCO data', 'Diag. data')
ylabel('VBPM coupling')
linkaxes([h1 h2 h3 h4], 'x');
xaxis([0 121])
%%

fullfile(getfamilydata('Directory', 'DispData'), filesep, '2008', filesep, 'Disp_2008-04-11_11-33-08.mat');

FileName = fullfile(getfamilydata('Directory', 'DispData'), filesep, '2008', filesep, 'Disp_2008-04-11_11-33-08.mat');
etax = getdisp('BPMx', FileName, 'Physics');
etaz = getdisp('BPMz', FileName, 'Physics');

FileName = fullfile(getfamilydata('Directory', 'LOCOData'), filesep, '2009-03-06c', filesep, 'Disp_2009-03-06_18-08-44.mat');

etax = getdisp('BPMx', FileName, 'Physics');
etaz = getdisp('BPMz', FileName, 'Physics');
%%
C = zeros(120,2,2);
for ik =1:120,
    C(ik,:,:)= [ BPMData(iter).HBPMGain(ik)     BPMData(iter).HBPMCoupling(ik) 
                 BPMData(iter).VBPMCoupling(ik) BPMData(iter).VBPMGain(ik)      ];
    Cinv(ik,:,:) = inv(squeeze(C(ik,:,:)));
end
%%  
% etax_new= etax.*BPMData(iter).HBPMGain + etaz.*BPMData(iter).HBPMCoupling;
% etaz_new= etax.*BPMData(iter).VBPMCoupling + etaz.*BPMData(iter).VBPMGain;
 
eta_new = zeros(120, 2);
for ik =1:120,
    eta_new(ik,:)= squeeze(Cinv(ik,:,:))*[etax(ik); etaz(ik)];
end

%%

figure;
subplot(2,1,1)
spos = getspos('BPMx');
plot(spos, etax); hold on
plot(spos, eta_new(:,1), 'k');
subplot(2,1,2)
plot(spos, etaz); hold on
plot(spos, eta_new(:,2), 'k');

%% Store data BPM in a file
% to be put in a dedicated script

%% Resultats fit LOCO redémarrage run 2 2009
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-05-29_SOFB/160quad.mat')
%% Resultats fit LOCO Nanoscopium run 4 2010
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-10-10_Nano/163quad.mat')
%% Resultats fit LOCO Nanoscopium run 5 2011
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-11-04/160quad.mat')
%% Resultats fit LOCO Nanoscopium run 4 2012
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2012/2012-05-25_redemarrage2/163quad.mat')
%% Resultats fit LOCO Nanoscopium run 5 2012
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2012/2012-09-01_redemarrage_4/163quad.mat')
%% Resultats fit LOCO Nanoscopium run 6 2012
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2012/2012-11-01_redemarrage_1/163quad.mat')
%% Resultats fit LOCO Nanoscopium run 2 2013
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2013/2013-03-08_redemarrage_slowcorr_WSV50closed/163quad.mat')

%% Resultats fit LOCO Nanoscopium run 5 2013 nouvelle maille
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2013/2013-10-27_RUN5_LOCO1/163quad.mat')

%% Resultats fit LOCO Nanoscopium run 4 2014 
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2014/2014-07-29_RUN4_SOFB_WSV50_iter2/163quad.mat')

%% Resultats fit LOCO Nanoscopium RUN5 2014 6 more correctors for local
%% correction in SDL13
load(fullfile(getfamilydata('Directory', 'LOCOData'), filesep, '2014', filesep, '2014-10-25_Ajout_6_correcteurs_SDL13', filesep, '163quad.mat'));

iter = 3;
HBPMgain = BPMData(iter).HBPMGain;
VBPMgain = BPMData(iter).VBPMGain;
HBPMcoupling = BPMData(iter).HBPMCoupling;
VBPMcoupling = BPMData(iter).VBPMCoupling;
HCMkick = CMData(iter).HCMKicks;
meanHCMkick = mean(HCMkick);

C = zeros(122,2,2);
for ik =1:122,
    C(ik,:,:)= [ HBPMgain(ik)       HBPMcoupling(ik) 
                 VBPMcoupling(ik)   VBPMgain(ik)      ];
    Cinv(ik,:,:) = inv(squeeze(C(ik,:,:)));
end

clear AM;
AM.DeviceList = family2dev('BPMx');
AM.Locodata = 'LOCO_2013-03-08'; % date to be updated 
% added created by mfilename
for ik=1: size(AM.DeviceList,1),
    AM.Cinv{ik,1} = squeeze(Cinv(ik,:,:));
end
AM.Description='Matrix for get true value from each BPM [invHGain invHCoupling; invVCoupling invVGain]';
save('BPM_gain_coupling_LOCO_2014-07-29', 'AM');