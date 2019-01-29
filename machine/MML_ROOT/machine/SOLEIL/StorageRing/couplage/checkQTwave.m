
%% Put parameters identical as those in couplingFB script

fac_threshold = 0.25; % put the same fac threshold than in the couplingFB script
I_threshold = 0.20 ;  % put the same low current threshold than in the couplingFB script

%% check mode number in setoperationalmode, and optics

ModeNumber = getfamilydata('ModeNumber') ;
temp = tango_read_attribute2('ANS/FC/PUB-SLICING','isSlicing')
isSlicing = temp.value(1) ;
temp = tango_read_attribute2('ANS/FC/PUB-SLICING','isPuma')
isPuma = temp.value(1) ;


%% Find if QT values diverge from their theoretical values and plot

Mode = 'Online';
Iqt = getam('QT',Mode);

% load QT setting for minimum coupling "Deltaskewquad"
if ModeNumber==36|ModeNumber==41|ModeNumber==32        % low-alpha mode
    load(fullfile(getfamilydata('Directory','Coupling'), filesep, 'Alphaby10', filesep, 'QT_min_lowalphaby25_12mars2012.mat'));
else                                    % nanoscopium mode
    %     % machine AVEC WSV50
    %     load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QT_Kminimum_Golden_WSV50_ferme_redemarrage_RUN2_2015.mat'));
    if ~isSlicing&~isPuma
        %load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QTmin_RUN1_2016_wWSV50_3iter_LOCO_iter1.mat'));
        %load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QTmin_RUN4_LOCOiter2_machine_Golden_WSV50.mat'));
        load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QTmin_RUN4_LOCOiter2_machine_Golden_WSV50.mat'));

    elseif isSlicing
        %load(fullfile(getmmlconfigroot, filesep, 'machine', filesep,'SOLEIL', filesep, 'StorageRingOpsData', filesep,'Nanoscopium_bx11m_SDL01_09_6Corr', filesep,'QTmin_LOCO_RUN1_2016_wW164_wWSV50_gap_slicing.mat')); % RUN1 2016
        %load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QTmin_RUN4_SLICING_W164_16p7mm_WSV50.mat')); % RUN4 2016
        load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QTmin_RUN4_SLICING_W164_16p7mm_WSV50_VRAI.mat')); % RUN4 2016
    
    elseif isPuma
        load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QTmin_RUN1_2017_PUMA_W164_14p7mm_WSV50.mat')); % RUN4 2016

    else 
        disp('Problemo with optics ???!!!')
        break
    end
    %     % machine SANS WSV50
    %    load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09_6Corr', filesep, 'QT_Kminimum_Golden_sans_WSV50_redemarrage_RUN5_2015.mat'));
end

Iqtmin = Deltaskewquad;
IqtDz = Iqt - Iqtmin;


% load QT setting for Dispersion wave "Deltaskewquad"
if ModeNumber==36|ModeNumber==41|ModeNumber==32        % low-alpha mode
    load(fullfile(getfamilydata('Directory','Coupling'), filesep, 'Alphaby10', filesep, 'QT_maximum_Dz_alphaby10_maher_opt.mat'));
else                                    % nanoscopium mode
    load(fullfile(getmmlconfigroot, filesep, 'machine', filesep, 'SOLEIL', filesep, 'StorageRingOpsData', filesep, 'Nanoscopium_bx11m_SDL01_09', filesep, 'QT_Golden_Nano24oct13_partieDz.mat'));
end

IqtDzTH  = Deltaskewquad ;
fac = IqtDz./IqtDzTH;

% si on trouve une anomalie, regarder si par hasard la valeur absolue du
% courant du QT concerné n'est pas très faible

figure;
spos = getspos('QT');
h(1) = subplot(5,1,1:2);
plot(spos,IqtDzTH,'bo-');hold on ; plot(spos,IqtDz,'ro-');legend('GOLDEN','applied');
ylabel('I_Q_T for the vert. disp. wave (A)')
title('SKEW QUADRUPOLES TEST')
h(2) = subplot(5,1,3:4);
plot(spos,fac,'ro');xlabel('numero QT');ylabel('applied QT_D_z / theoretical QT_D_z');
hold on ;
xplot = [0 getcircumference];
yplot = fac_threshold * ones(1,2);
plot(xplot,yplot,'b-.')
%%ylim([0.1 1.1]);
h(3) = subplot(5,1,5);
drawlattice(0.01);
linkaxes(h,'x');

%% Exclude QT with low Dz current value and replot

[i j] = find(abs(IqtDzTH)<I_threshold); % put the same low current threshold than in the couplingFB script
Bx = spos;Bx(i) = [];
Bz = fac;Bz(i) = [];
%figure(1) ;
hold on ;
h(2) = subplot(5,1,3:4);
plot(spos,fac,'ro');xlabel('numero QT');ylabel('applied QT_D_z / theoretical QT_D_z');
hold on ;
plot(Bx,Bz,'ro','MarkerFacecolor','k');xlabel('numero QT');ylabel('applied QT_D_z / theoretical QT_D_z');

%% Do statistics on QT with sufficient high current value

fprintf('  Rms value for QT Dz factor = %4.2f  around mean value %4.2f  \n ',std(Bz),mean(Bz));

%% Save current QT values in dedicated directory

%Dir = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/SavedData';
Dir = fullfile(getfamilydata('Directory', 'DataRoot'), filesep, 'SkewQuad', filesep,  'SavedData');
DirStart = pwd;
cd(Dir)
FileName = appendtimestamp('PresentSQvalues');
save(FileName,'Iqt','IqtDz')
cd(DirStart);
fprintf('Data save in filename %s \n', [Dir '/' FileName]);

%% Archive
%DirName = getfamilydata('Directory','OpsData');
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Ske
%wQuad/solution_QT/Nanoscopium/QT_couplage_min_nanoscopium_redemarrage_5mai2013.mat')
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Alphaby10/QT_min_lowalphaby25_12mars2012.mat')
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/PhysData/RUN_HU36_10juin2013/QTmin_machine_sym_sans_WSV50.mat')
%File = fullfile(DirName,'QT_Kminimum_LOCO_16sept13');
%load('/home/production/matlab/matlabML/machine/SOLEIL/StorageRingOpsData/Nanoscopium_bx11m_SDL01_09/QT_Kminimum_Golden_WSV50_ferme');
%load('/home/production/matlab/matlabML/machine/SOLEIL/StorageRingOpsData/Nanoscopium_bx11m_SDL01_09_6Corr/QT_Kmin_26octobre2014_w_WSV50.mat') % update 26 oct 2014
% pour clement : decommenter la ligne ci-dessous :
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/PhysData/2014-09-08_feedforward_statique_HU640/QTmin32values.mat')
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/PhysData/2014-04-15_feedforward_statique_HU640/QTmin_Golden_wWSV50_2014_RUN2.mat')

%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Nanoscopium/QT_Dipersion_verticale_pure_Nanoscopium.mat')
%load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Alphaby10/QT_maximum_Dz_alphaby10_maher_opt.mat')
%%%IqtDzTH = Deltaskewquad;
%File = fullfile(DirName,'QT_Golden_Nano24oct13_partieDz.mat');
%load('/home/production/matlab/matlabML/machine/SOLEIL/StorageRingOpsData/Nanoscopium_bx11m_SDL01_09/QT_Golden_Nano24oct13_partieDz.mat');
