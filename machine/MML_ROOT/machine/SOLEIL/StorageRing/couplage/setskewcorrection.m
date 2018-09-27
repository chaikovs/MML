function setskewcorrection(varargin)
% setskewcorrection - coupling correction with CTCO and dispersion measurement method
%  setskewcorrection('Online')

%  INPUT
%  Optional
%  'Archive', 'Display'
%  Optional override of the mode:
%     'Online'    - Set/Get data online
%     'Model'     - Get the model chromaticity directly from AT (uses modelchro, DeltaRF is ignored)
%     'Simulator' - Set/Get data on the simulated accelerator using AT (ie, same commands as 'Online')
%
%  OUPUTS
%
%
%  ALGORITHM

%
%  See Also

%
%  Written by M-A. Tordeux

DisplayFlag = 1;
ArchiveFlag = 1;
FileName = '';
ModeFlag = 'Model';  % model, online, manual, 'Model' for default mode
waittime = 0.5; %seconds taken into account for simulator and Online
OutputFlag = 1;

MeasurementFlag = 0 ; % s
CorrectionFlag = 1 ; % Si à zéro pas de correction
PostMeasurementFlag = 1 % Mesure après correction du couplage
Params = [1e3 32 100] ; % Paramètres par défaut de la correction
% Params(1) : poids Dz
% Params(2) : nb de valeurs propres de lamatrice efficacite QT
% Params(3) : pourcentage de correction appliqué

for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignore structures
        handles.caller = varargin{i}.figure1;
        M = getappdata(handles.caller,'M'); % paramètres mesure
        S = getappdata(handles.caller,'S'); % paramètres correction
        Diaphonie = getappdata(handles.caller,'Diaphonie'); %
        DeltaI_HCOR = M.Param1 ;
        waittime = M.Param2 ;
        PoidsDz = S.Param1 ;
        nbvp = S.Param2 ;
        pourcentage = S.Param3 ;             
    elseif iscell(varargin{i})
        % Ignore cells
        % store handle from caller
        handles.caller = varargin{i}.figure1;
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = O;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoArchive')
        ArchiveFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Archive')
        ArchiveFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Simulator') || strcmpi(varargin{i},'Model') ...
            || strcmpi(varargin{i},'Online') || strcmpi(varargin{i},'Manual')
        ModeFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Measurement')
        MeasurementFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoMeasurement')
        MeasurementFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Correction')
        CorrectionFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoCorrection')
        CorrectionFlag = 0;
        varargin(i) = [];    
%     elseif isnumeric(varargin{i})
%         Params = varargin{i};
%         varargin(i) = []; 
    end
end



if strcmpi(ModeFlag,'Model')
    waittime = -1;
    OutputFlag = 0;
elseif strcmpi(ModeFlag,'Online')
    %waittime = 2.8;  % 5 secondes car pb alim correcteurs % 2.8 s 24 octobre 08
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% en attente de mettre dans un fichier
CT_DIAG = 0.01* [    -0.7000   -3.1700   -2.6800   -3.0200   -0.1500   -3.2000   -4.0300    2.7100   -3.3500   -0.6200   -2.4000    1.0000   -2.4000   -1.1600   -2.4100    0.8100   -1.4600   -2.8500   -4.2300...
    0.9200   -0.9600   -3.4100    0.3100    1.4600   -4.9700   -3.1100   -1.5700   -3.3600   -5.6000   -4.7800    3.2300   -4.9300   -4.2700   -3.5100   -6.6700   -2.3700   -3.2000   -0.3800   -3.5000...
   -3.8600   -4.0300    0.0800   -2.9000   -5.0300   -3.0300    1.5300   -6.5200   -4.3900   -1.7500    1.0700   -5.1400   -3.1300   -4.5200   -1.4500   -1.9800    3.4100    0.9100   -2.3100   -0.0800...
   -0.5400    1.2200   -3.3600   -2.9100   -3.5900   -3.6500   -4.5700   -2.5200    2.2800   -2.4200   -1.1400   -4.4900    2.2900   -5.9800   -4.2700   -3.1300   -0.1500   -4.5700   -4.8700   -2.9700...
    1.1400    0.9100   -2.2000   -0.3800   -2.9600   -1.2900   -0.3800   -0.2300   -0.3800   -0.4900   -3.5700   -0.3500   -1.4700   -1.4800   -1.6800   -3.5300   -0.6300   -4.1500    1.5400   -2.3200...
   -1.7300   -2.0200    3.1500   -0.6100   -3.9200   -3.8300    1.9500   -1.8900    2.5400   -2.3900    1.0500   -0.3500   -1.6100   -3.3000    1.7100    0.6200    0.1500   -2.2500   -0.080    -0.080  -3.1900];
% crosstalk mesuré par groupe diag avril 2007
% attention premier BPM mml = [1 2] d'ou  la permutation du premier crosstalk (-3.19%)

CT_LOCO =  [ ...
   -0.0088   -0.0268   -0.0133   -0.0200   -0.0190   -0.0218   -0.0527   -0.0073   -0.0127   -0.0153   -0.0272    0.0026   -0.0284 ...
   -0.0157   -0.0215    0.0055   -0.0463   -0.0139   -0.0532   -0.0046   -0.0466   -0.0357   -0.0174    0.0165   -0.0249   -0.0296 ...
   -0.0364   -0.0327   -0.0387   -0.0445    0.0209   -0.0416   -0.0342   -0.0286   -0.0317   -0.0417   -0.0284   -0.0219   -0.0455 ...
   -0.0267   -0.0280   -0.0051   -0.0402   -0.0641   -0.0442   -0.0018   -0.0523   -0.0252   -0.0314    0.0074   -0.0301   -0.0320 ...
   -0.0298    0.0068   -0.0126   -0.0137   -0.0180   -0.0174   -0.0157    0.0011   -0.0015   -0.0292   -0.0256   -0.0393   -0.0419 ...
   -0.0405   -0.0453    0.0055   -0.0254   -0.0120   -0.0349    0.0092   -0.0165   -0.0133   -0.0368   -0.0108   -0.0199   -0.0276 ...
   -0.0259    0.0076   -0.0147   -0.0408   -0.0077   -0.0158   -0.0049   -0.0190   -0.0135   -0.0082   -0.0212   -0.0499    0.0004 ...
   -0.0194   -0.0123   -0.0155   -0.0115   -0.0200   -0.0487    0.0081   -0.0325   -0.0099   -0.0343    0.0147   -0.0063   -0.0149 ...
   -0.0323    0.0099   -0.0183   -0.0058   -0.0205    0.0131   -0.0121   -0.0042   -0.0342    0.0116   -0.0189   -0.0176   -0.0033 ...
   -0.0186   -0.0287   -0.0273...
   ];  % !!!!! fausses valeurs !!
CT_LOCO_bis_H = [ ...
 -0.0132   -0.0003   -0.0043   -0.0171   -0.0233    0.0112   -0.0297   -0.0180    0.0071   -0.0046 ...
 -0.0217   -0.0112   -0.0054    0.0040   -0.0264   -0.0127   -0.0262   -0.0096   -0.0279   -0.0195 ...
 -0.0338   -0.0141   -0.0124   -0.0080   -0.0157   -0.0093   -0.0132    0.0022   -0.0168   -0.0246 ...
 -0.0029   -0.0151   -0.0166   -0.0304   -0.0181   -0.0067   -0.0060   -0.0136   -0.0156   -0.0233 ...
 -0.0168   -0.0102   -0.0234   -0.0313   -0.0225   -0.0107   -0.0158   -0.0205   -0.0201   -0.0049 ...
 -0.0150   -0.0086   -0.0151   -0.0014    0.0028    0.0041   -0.0164   -0.0002   -0.0021   -0.0018 ...
 -0.0060   -0.0176   -0.0171   -0.0244   -0.0175   -0.0093   -0.0234   -0.0114   -0.0024   -0.0041 ...
 -0.0224    0.0073   -0.0086   -0.0041   -0.0197   -0.0115    0.0148   -0.0245   -0.0254    0.0009 ...
  0.0021   -0.0159   -0.0096   -0.0171   -0.0195   -0.0284   -0.0160   -0.0085   -0.0152   -0.0242 ...
 -0.0115   -0.0138   -0.0090   -0.0212   -0.0091   -0.0147   -0.0310   -0.0124   -0.0122   -0.0028 ...
 -0.0250   -0.0100   -0.0186   -0.0078   -0.0109   -0.0068    0.0045   -0.0062   -0.0239   -0.0009 ...
  -0.0036   -0.0083   -0.0196   -0.0074   -0.0207   -0.0096    0.0086    0.0095   -0.0165   -0.0090 ...
   ]; % 14 décembre 2009
CT_LOCO_bis_V = [...
   -0.0015   -0.0240   -0.0121   -0.0192   -0.0196   -0.0173   -0.0528   -0.0049   -0.0123   -0.0176 ...
 -0.0323    0.0035   -0.0300   -0.0137   -0.0177    0.0040   -0.0423   -0.0166   -0.0563   -0.0058 ...
 -0.0485   -0.0287   -0.0082    0.0141   -0.0255   -0.0333   -0.0386   -0.0217   -0.0382   -0.0430 ...
  0.0161   -0.0375   -0.0347   -0.0291   -0.0293   -0.0398   -0.0239   -0.0178   -0.0371   -0.0317 ...
 -0.0309   -0.0072   -0.0466   -0.0580   -0.0340   -0.0038   -0.0454   -0.0289   -0.0248    0.0088 ...
 -0.0359   -0.0300   -0.0252    0.0101   -0.0089   -0.0151   -0.0220   -0.0217   -0.0173    0.0005 ...
  -0.0004   -0.0215   -0.0283   -0.0419   -0.0468   -0.0388   -0.0440    0.0032   -0.0216   -0.0130 ...
 -0.0368    0.0121   -0.0191   -0.0125   -0.0332   -0.0076   -0.0178   -0.0315   -0.0302    0.0115 ...
  -0.0163   -0.0332   -0.0033   -0.0170   -0.0053   -0.0230   -0.0130   -0.0104   -0.0203   -0.0505 ...
 -0.0011   -0.0198   -0.0124   -0.0142   -0.0120   -0.0195   -0.0467    0.0060   -0.0325   -0.0165 ...
 -0.0412    0.0144   -0.0213   -0.0182   -0.0314    0.0084   -0.0164   -0.0097   -0.0208    0.0189 ...
  -0.0102   -0.0004   -0.0286    0.0142   -0.0236   -0.0203   -0.0064   -0.0192   -0.0323   -0.0344 ...
 ];

if isequal(Diaphonie,'LOCO')
    %CT = CT_LOCO;
    disp('Diaphonie calculée par LOCO')
else
    %CT = CT_DIAG;
    disp('Diaphonie mesurée en labo')
end

%% Résultats fit LOCO redémarrage run 2 2009
if strcmpi(ModeFlag,'Online')
    %load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2009-03-06a/160quad.mat') % LOCO/2009-03-06a
    load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2009-11-22/160quad.mat')
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
end
%%

if MeasurementFlag
    %Indexskewquad = family2atindex('QT');% Index of skew quadrupoles
    %Meffskewquad_CTO = zeros(120,120,32); % première matrice : efficacité vis à vis des orbites fermées croisées
    %Etalonnage = zeros(2,120,32);
    DeviceNumber_HCOR = 0;
    
    % graphe
    lim = 0.10* DeltaI_HCOR / 0.6; % en mm, valeur max estimée des CTCO pour graphe


    if ArchiveFlag  % enregistrement de la matrice reponse dispersion
        if isempty(FileName)
            FileName = appendtimestamp('SkewMeasurement');
            DirectoryName = getfamilydata('Directory', 'SkewResponse');
            if isempty(DirectoryName)
                %             DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
            else
                % Make sure default directory exists
                DirStart = pwd;
                [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
                cd(DirStart);
            end
            [FileName, DirectoryName] = uiputfile('*.mat', 'Select a Skew File ("Save" starts measurement)', [DirectoryName FileName]);
            if FileName == 0
                ArchiveFlag = 0;
                disp('   Skew efficiency measurement canceled.');
                return
            end
            FileName = [DirectoryName, FileName];
        elseif FileName == -1
            FileName = appendtimestamp(getfamilydata('Default', 'SkewArchiveFile'));
            DirectoryName = getfamilydata('Directory', 'SkewResponse');
            FileName = [DirectoryName, FileName];
        end
    end

    % Starting time
    t0 = clock;

    %for k1 = 1:length(QuadFam),

    if ~isfamily('QT')
        error('%s is not a valid Family \n', 'QT');
        return;
    end

    DeviceList_QT = family2dev('QT');
    DeviceList_HCOR = family2dev('HCOR');

   if strcmpi(ModeFlag,'Online') 
    %%%%
    temp=tango_read_attribute2('ANS-C02/DG/PHC-EMIT','EmittanceH'); pinhole.emitH= temp.value;
    temp=tango_read_attribute2('ANS-C02/DG/PHC-EMIT','EmittanceV'); pinhole.emitV= temp.value;
    temp=tango_read_attribute2('ANS-C02/DG/PHC-EMIT','Coupling'); pinhole.coupling= temp.value;
    temp=tango_read_attribute2('ANS-C02/DG/PHC-IMAGEANALYZER','XProjFitSigma'); pinhole.XProjFitSigma=temp.value;
    temp=tango_read_attribute2('ANS-C02/DG/PHC-IMAGEANALYZER','YProjFitSigma'); pinhole.YProjFitSigma= temp.value;
    temp=tango_read_attribute2('ANS-C02/DG/PHC-IMAGEANALYZER','GaussianFitCovarianceXY'); pinhole.GaussianFitCovarianceXY=temp.value;
    temp=tango_read_attribute2('ANS-C03/DG/DCCT','current');   pinhole.cur=temp.value;
    %%%%%%
   end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % dispersion measurement
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmpi(ModeFlag,'Online')
    FileName_DISP = appendtimestamp('Dispersion_V')
    FileName_DISP = ['/home/production/matlab/matlabML/machine/SOLEIL/StorageRing/fonction_test/couplage/'   FileName_DISP];
    measdisp('Archive',FileName_DISP,'NoDisplay'); % on sauvegarde les mesures brutes cette fois
    Dx_Meas = getdisp('BPMx',FileName_DISP,'Physics');
    Dy_Meas = getdisp('BPMz',FileName_DISP,'Physics');
        
    figure(304);plot(Dy_Meas,'bo-'),title('Mesures brutes')
    Dy_plot = Dx_Meas.*Cinv(:,2,1) + Dy_Meas.*Cinv(:,2,2);
    figure(305);plot(Dy_plot,'ro-'),title('Mesures corrigées')
    sleep(waittime*2)
else
    [Dx_Meas Dy_Meas] = modeldisp('BPMx');
    figure(689);plot(Dy_Meas,'o-');ylabel('Dispersion V (m)')
    figure(690);plot(Dx_Meas,'o-');ylabel('Dispersion H (m)')
end
%     if strcmpi(ModeFlag,'Online')
%         Dy_Meas = Dy_Meas - Dx_Meas.*CT';
%     end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CrossTalk closed orbit measurement
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    for k2 = 1:length(DeviceList_HCOR),

        Xof0 = getx(ModeFlag); % Horizontal reference orbit
        Zof0 = getz(ModeFlag); % Vertical reference orbit
        if strcmpi(ModeFlag,'Online')
            Zof0 = Zof0 - Xof0.*CT_DIAG';
        end

        DeviceNumber_HCOR = DeviceNumber_HCOR + 1;
        Ic_HCOR = getam('HCOR', DeviceList_HCOR(k2,:), ModeFlag);
        if OutputFlag
                    fprintf('Measuring %s [%d %d] actual current %f A : ... \n', ...
                        'HCOR', DeviceList_HCOR(k2,:),Ic_HCOR)  % pour suivi
        end

        %DeltaI_HCOR = 0.6*1.; % 0.6 Amp : choix d'une orbite inférieure à 1 mm
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        stepsp('HCOR', DeltaI_HCOR, DeviceList_HCOR(k2,:), ModeFlag); % Step value
        sleep(waittime) % wait for HCOR reaching new setpoint value

        Xof1 = getx(ModeFlag) ; orbiteX1(:,DeviceNumber_HCOR) = Xof1;
        Zof1 = getz(ModeFlag) ; orbiteZ1(:,DeviceNumber_HCOR) = Zof1;
        if strcmpi(ModeFlag,'Online')
            Zof1 = Zof1 - Xof1.*CT_DIAG';
        end
        DevMaxX = max(Xof0-Xof1);
        fprintf('-     Déviation maximale induite : %4.3f mm  \n',DevMaxX) % pour tester la validité de DeltaI

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        stepsp('HCOR', -2*DeltaI_HCOR, DeviceList_HCOR(k2,:), ModeFlag); % Step value
        sleep(waittime) % wait for HCOR reaching new setpoint value

        Xof2 = getx(ModeFlag) ;  orbiteX2(:,DeviceNumber_HCOR) = Xof2;
        Zof2 = getz(ModeFlag) ;  orbiteZ2(:,DeviceNumber_HCOR) = Zof2;
        if strcmpi(ModeFlag,'Online')
            Zof2 = Zof2 - Xof2.*CT_DIAG';
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        stepsp('HCOR', DeltaI_HCOR, DeviceList_HCOR(k2,:), ModeFlag); % Initial value
        sleep(waittime) % wait for HCOR reaching new setpoint value

        
        %% computation part

        DeltaZof = Zof2-Zof1 ; % HCOR induced Orbit shift 
        figure(13) ; plot(getspos('BPMz'),DeltaZof) ; grid on ;
        title('orbite verticale induite par le kick horizontal');
        ylabel('différence d''orbite V en mm');
        xlabel('abscisse machine (m)')
        ylim([-0.05 0.05])
        DevMaxZ = max(DeltaZof);
        
        CTCO_Meas(:,DeviceNumber_HCOR) = DeltaZof/(-2*DeltaI_HCOR) ; % mm/A
        CTCO_Etalonnage(1,DeviceNumber_HCOR) = DevMaxX;
        CTCO_Etalonnage(2,DeviceNumber_HCOR) = DevMaxZ ; % Amplitude test

    end

    

    %     if DisplayFlag
    %
    %     end

    if ArchiveFlag
        directory_actuelle = pwd;
        cd(DirectoryName)
       if strcmpi(ModeFlag,'Online')
        save(FileName,'CTCO_Meas','CTCO_Etalonnage','Dx_Meas','Dy_Meas',...
            'orbiteX1','orbiteX2','orbiteZ1','orbiteZ2','DeltaI_HCOR','pinhole','-mat');
       else
           save(FileName,'CTCO_Meas','CTCO_Etalonnage','Dx_Meas','Dy_Meas',...
            'orbiteX1','orbiteX2','orbiteZ1','orbiteZ2','DeltaI_HCOR','-mat');
        end
        %save(FileName,'CTCO_Meas','CTCO_Etalonnage','-mat'); % cas ou DCCT pb communication
        cd(directory_actuelle);
    end

    disp('Registration ended')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coupling correction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if CorrectionFlag
    if ~MeasurementFlag
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Measurement loading
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%% model
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewRespMat_2007-06-05_19-33-04.mat')
        %         S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-06-07_15-22-51.mat') % défauts = QT=[1 -1 1 -1,etc..
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-06-08_11-27-15_tirage_defauts.mat') % tirage défauts
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-06-18_15-40-27_graine_n9.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-10_15-32-57_graine_DIPOLE+-5mrad.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-11_10-29-00_graine_dipole+-5mrad.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-11_10-54-56_graine_dipoles_++5mrad.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-11_11-21-19_graine_n18.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-13_14-32-22_graine_+1-1AcorrV.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-13_17-45-18_graine18.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-16_18-34-14_orbite_non_moyennee.mat');
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-16_20-42-47_orbite_non_moyennee_iter2.mat');
        %S = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-07-18_17-23-38_graine_n9bis.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/Ringdata/Response/Skew/SkewMeasurement_2007-09-02_14-28-06_HU640_-600A_nux-2600_avant_corr.mat')
        %S = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/Ringdata/Response/Skew/SkewMeasurement_2007-09-10_11-50-11_HU640_p600A_nux_-26.mat')

        DirectoryName = getfamilydata('Directory', 'SkewResponse');
        if isempty(DirectoryName)
            %             DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
        else
            % Make sure default directory exists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [FileName, DirectoryName] = uigetfile('*.mat', 'Select a Skew File ("Save" starts measurement)', [DirectoryName FileName]);
        if FileName == 0
            ArchiveFlag = 0;
            disp('   Skew efficiency measurement canceled.');
            return
        end
        FileName = [DirectoryName, FileName];

        S = load(FileName);
        %         Dy_Meas = S.Dy_Meas;
        %         CTCO_Meas = S.CTCO_Meas;
        
        if strcmpi(ModeFlag,'Model')
            Dy_Meas = S.Dy_Meas;
            DeviceList_HCOR = family2dev('HCOR');
            CTCO_Meas = S.CTCO_Meas;
            disp('?')

        else

            if strcmp(Diaphonie,'DIAG')   % Diaphonie mesurée en labo
                if isfield(S,'DeltaI_HCOR') % alors on a enregistré les mesures brutes
                    Dy_Meas = S.Dy_Meas - S.Dx_Meas.*CT_DIAG';
                else % anciennes mesures : on avait corrigé les mesures brutes avant de les enregistrer
                    Dy_Meas = S.Dy_Meas;
                end

                CTCO_Meas = S.CTCO_Meas;
            else    % Diaphonie calculée par LOCO

                DeviceList_HCOR = family2dev('HCOR');
                if isfield(S,'orbiteX1')

                    for k = 1:length(DeviceList_HCOR)
                        %Zof1(:,k) = S.orbiteZ1(:,k) - S.orbiteX1(:,k).*CT';
                        Zof1(:,k) = S.orbiteX1(:,k).*Cinv(:,2,1) +S.orbiteZ1(:,k).*Cinv(:,2,2);
                    end


                    for k = 1:length(DeviceList_HCOR)
                        %Zof2(:,k) = S.orbiteZ2(:,k) - S.orbiteX2(:,k).*CT';
                        Zof2(:,k) = S.orbiteX2(:,k).*Cinv(:,2,1) +S.orbiteZ2(:,k).*Cinv(:,2,2);

                    end

                    DeltaZof = Zof2-Zof1 ;

                    if isfield(S,'DeltaI_HCOR')
                        CTCO_Meas = DeltaZof/(-2*S.DeltaI_HCOR) ;
                    else
                        DeltaI_HCOR = 0.2 ; % A VERIFIER !!!!!
                        CTCO_Meas = DeltaZof/(-2*DeltaI_HCOR) ;
                    end
                    % s.CTCO_Meas./DeltaZof % verification

                    if isfield(S,'DeltaI_HCOR')
                        Dy_Meas = S.Dx_Meas.*Cinv(:,2,1) + S.Dy_Meas.*Cinv(:,2,2); % Dy mesur� est brut puisqu'on a enregistr� DeltaI_HCOR
                        figure(302); plot(Dy_Meas,'ro-');title(' CHECK !! reconstitution de la dispersion verticale')
                    else
                        Dy_Measbrut = S.Dy_Meas + S.Dx_Meas.*CT_DIAG'; % retour au Dz originel car oubli dans  script enregistrement
                        %%Dy_Meas = S.Dy_Measbrut - S.Dx_Meas.*CT'; %
                        Dy_Meas = S.Dx_Meas.*Cinv(:,2,1) + Dy_Measbrut.*Cinv(:,2,2);
                    end
                else
                    disp('l''enregistrement ne contiens pas les valeurs orbiteX1, etc..')
                    return
                end

            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%% online
        %         S1 = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-06-11_12-53-30.mat') % mesure sur machine du lundi 11 juin
        %         Dy_Meas = S1.Dy_Meas;
        %         S2 = load('-mat','/home/production/matlab/matlabML/measdata/Ringdata/Response/Skew/SkewMeasurement_2007-06-11_12-25-27.mat') % mesure sur machine du lundi 11 juin
        %         CTCO_Meas = S2.CTCO_Meas;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Efficiency Matrix loading
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %pourcentage = 100 ; % 100% de la correction proposée sera appliquée
    %S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2007-03-09_16-46-16_deuxieme_test.mat')
    %S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2010-06-17_13-41-00_DISP_nano_20_64.mat')
    %%% S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-10_13-47-38_alphaby10_maher_opt_32QT_DISP')
%     S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-14_10-36-42_alphaby10_maher_opt_DISP_BIS')
%S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-21_19-02-21_32QT_optique_nanoscopiumLIKE_DISP')
%S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-09-23_11-18-19_lat_nanoscopiumLIKE_122BPM_DISP')
%S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-10-06_09-23-22_lat_nano_17_25_chicane_0_disp')
     
     S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-10-11_17-51-37_lat_nano_17_25_disp')
%     S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-09-22_15-46-11_lat_nano_17_25_bis_DISP')
    %S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-13_13-27-54_betax5m_32QT_DISP')
    % run 27 octobre 08
    %S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2008-10-24_15-03-20_DISP_nux_0-27_nuz_0-32.mat')
    Meffskewquad_D = S_D.Meffskewquad_D;
    %Meffskewquad_D = [Meffskewquad_D(:,1:23) Meffskewquad_D(:,25:32)] % exclure le Skew monté en Quad
    % S_CTCO =
    % load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2007-06-03_23-13-56_CTCO_theorique.mat') nominal
    %%%% S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-10_11-52-51_alphaby10_maher_opt_32QT_CTCO')
%     S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-13_14-30-15_alphaby10_maher_opt_32QT_CTCO_DeltaH0_2A')
% S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-21_18-03-17_32QT_optique_NanoscopiumLIKE_CTCO')
%S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-09-23_09-18-24_lat_nanoscopiumLIKE_122BPM_CTCO')
%S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-10-05_18-30-43_lat_nano_17_25_chicane_0_CTCO')
    S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-10-11_18-08-11_lat_nano_17_25_CTCO')
    
    
%     S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-09-22_13-58-13_lat_nano_17_25_CTCO_bis_CTCO')
    %S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-13_11-06-05_betax5m_32QT_CTCO')
    %S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2010-06-17_12-13-58_CTCO_lat_nano_20_64.mat')
    % run 27 octobre 08
    %S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2008-10-24_09-19-19_CTCO_nux_0-27_nuz_0-32.mat')
    Meffskewquad_CTCO = S_CTCO.Meffskewquad_CTCO;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Coupling Matrix construction (depending on Relative Dispersion correction weigth)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %PoidsDz = Params(1)*ones(1,120);  % 1e3*ones(1,120); %  Relative Dispersion correction weigth
    

    DeviceList_QT = family2dev('QT');
    DeviceList_HCOR = family2dev('HCOR');
    DeviceList_BPMz = family2dev('BPMz');
    
    nb = length(DeviceList_BPMz);
    PoidsDz = PoidsDz*ones(1,nb);  % 1e3*ones(1,120); %  Relative Dispersion correction weigth

    for l = 1:length(DeviceList_QT)
        for k = 1:length(DeviceList_QT)
            A_Dz(l,k) = sum(PoidsDz'.*Meffskewquad_D(:,l).*Meffskewquad_D(:,k)); % Vérifier dimension de PoidsDz
        end
    end
    for l = 1:length(DeviceList_QT)
        for k = 1:length(DeviceList_QT)
            for j = 1:length(DeviceList_HCOR)
                T(j) = sum(Meffskewquad_CTCO(:,j,l).*Meffskewquad_CTCO(:,j,k));
            end
            A_CTCO(l,k) = sum(T(:));
        end
    end
    MeffSkewQuad =   A_Dz +   A_CTCO;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Second member vector evaluation ( also depending on Relative Dispersion correction weigth !!)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for l = 1:length(DeviceList_QT)
        B_Dz(l) = sum(PoidsDz'.*Meffskewquad_D(:,l).*Dy_Meas(:)); % Vérifier dimension de PoidsDz
    end
    for l = 1:length(DeviceList_QT)

        for j = 1:length(DeviceList_HCOR)
            T(j) = sum(Meffskewquad_CTCO(:,j,l).*CTCO_Meas(:,j));
        end
        B_CTCO(l) = sum(T(:));

    end
    coeff_Dz = -1; coeff_CTCO = 0 ;   % coeff_Dz / coeff_CTCO = -1 -> annulation du couplage dispersion / orbites croisées (betatron)
    SecondMember =   + coeff_Dz * B_Dz + coeff_CTCO *  B_CTCO;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Correction ( also depending on Relative Dispersion correction weigth !!)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    couleur = 'k-o' % changer la couleur pour chaque valeur de nbvp (sauf blue)
    [U,S,V] = svd(MeffSkewQuad);
    figure(4) ; semilogy(diag(S));title('MeffSkewQuad  -  PoidsDz = 0');xlabel('No EigenValue');
    DiagS = diag(S);
    %nbvp = Params(2) ; % 32  %  length(DiagS);  % NOMBRE DE VALEURS PROPRES
    Rmod1 = MeffSkewQuad * V(:,1:nbvp);
    B1 = Rmod1\ (SecondMember' ); % SeconMember en ?
    Deltaskewquad = V(:,1:nbvp) * B1
    %figure(20) ; hold on ; plot(Deltaskewquad,couleur) ; title('Valeur des QT en A')
    figure(20) ; hold on ; plot(Deltaskewquad,'Color',nxtcolor) ; title('Valeur des QT en A')
    consigne = getsp('QT',ModeFlag);
    %consigne = [consigne(1:23)' consigne(25:32)']'

    %pourcentage = Params(3) % 100;  % POURCENTAGE DE LA CORRECTION
    val_max = 7 ; val_min = -7 ;
    if all((consigne + Deltaskewquad* pourcentage*0.01)<val_max)*all((consigne +Deltaskewquad* pourcentage*0.01)>val_min);
        %Deltaskewquad = [Deltaskewquad(1:23)' 0 Deltaskewquad(24:31)']'
%%
      
        stepsp('QT',Deltaskewquad* pourcentage*0.01,ModeFlag); %
        correction = getam('QT',ModeFlag)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%% mesure sur la machine après correction
        if PostMeasurementFlag
            [Dxapres,Dyapres] = measdisp('Physics',ModeFlag)
            if strcmpi(ModeFlag,'Online')
                Dyapres = Dxapres.*Cinv(:,2,1) + Dyapres.*Cinv(:,2,2); % 
            end
            sleep(waittime)
            figure(25) ; hold on ; plot(getspos('BPMz'),Dy_Meas,'bo-') ;
            hold on ; plot(getspos('BPMz'),Dyapres,couleur );legend('Dispersion V avant correction','apres correction')

            DeviceNumber_HCOR = 0;
            for k2 =1:3
                DeviceNumber_HCOR = DeviceNumber_HCOR + 1;
                Ic_HCOR = getam('HCOR', DeviceList_HCOR(k2,:), ModeFlag);
                if OutputFlag
                    fprintf('Measuring %s [%d %d] actual current %f A : ... \n', ...
                        'HCOR', DeviceList_HCOR(k2,:),Ic_HCOR)  % pour suivi
                end

                %DeltaI_HCOR = 0.6*1.; % 0.6 Amp : choix d'une orbite inférieure à 1 mm
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                stepsp('HCOR', DeltaI_HCOR, DeviceList_HCOR(k2,:), ModeFlag); % Step value
                sleep(waittime) % wait for HCOR reaching new setpoint value

                Xof1 = getx(ModeFlag) ;
                Zof1 = getz(ModeFlag) ;
                if strcmpi(ModeFlag,'Online')
                    Zof1(:,k) = Xof1(:,k).*Cinv(:,2,1) +Zof1(:,k).*Cinv(:,2,2);    
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                stepsp('HCOR', -2*DeltaI_HCOR, DeviceList_HCOR(k2,:), ModeFlag); % Step value
                sleep(waittime) % wait for HCOR reaching new setpoint value

                Xof2 = getx(ModeFlag) ;
                Zof2 = getz(ModeFlag) ;
                if strcmpi(ModeFlag,'Online')
                    Zof2(:,k) = Xof2(:,k).*Cinv(:,2,1) +Zof2(:,k).*Cinv(:,2,2); 
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                stepsp('HCOR', DeltaI_HCOR, DeviceList_HCOR(k2,:), ModeFlag); % Initial value
                sleep(waittime) % wait for HCOR reaching new setpoint value

                %% computation part

                DeltaZof = Zof2-Zof1 ; % HCOR induced Orbit shift

                if k2 == 1
                    figure(21) ; hold on ; plot(getspos('BPMz'),DeltaZof,couleur) ; 
                    if exist('lim') ylim([-lim lim])
                    end; % CTCO après correction
                    hold on ; plot(getspos('BPMz'),-CTCO_Meas(:,1)*2*DeltaI_HCOR,'bo-') % réference avant correction
                    title('HCOR [1 1]') ; legend('CTCO après correction','CTCO avant correction')
                elseif k2 == 2
                    figure(22) ; hold on ; plot(getspos('BPMz'),DeltaZof,couleur) ;
                    if exist('lim') ylim([-lim lim])
                    end ; % CTCO après correction
                    hold on ; plot(getspos('BPMz'),-CTCO_Meas(:,2)*2*DeltaI_HCOR,'bo-') % réference avant correction
                    title('HCOR [1 4]') ; legend('CTCO après correction','CTCO avant correction')
                elseif k2 == 3
                    figure(23) ; hold on ; plot(getspos('BPMz'),DeltaZof,couleur) ;
                    if exist('lim') ylim([-lim lim])
                    end ; % CTCO après correction
                    hold on ; plot(getspos('BPMz'),-CTCO_Meas(:,3)*2*DeltaI_HCOR,'bo-') % réference avant correction
                    title('HCOR [1 7]') ; legend('CTCO après correction','CTCO avant correction')
                end
            end
        end


        if ~strcmpi(ModeFlag,'Online')
            E = modelemit;
            fprintf('EmittanceX =  %4.2f nm , EmittanceZ = %4.2f pm \n',E(1),E(2)*1e3 )
            fprintf('Couplage =  %4.2f % \n',100*E(2)/E(1) )
            disp('contente ?!')
            %setsp('QT',consigne,ModeFlag);
        else
            % prendre mesure pinhole
            emit = tango_read_attributes('ANS-C02/DG/PHC-EMIT',{'EmittanceH','EmittanceV'});
            fprintf('EmittanceX =  %4.2f nm , EmittanceZ = %4.2f pm \n',emit(1).value,emit(2).value )
        end
        %%

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        disp('eh oui')
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% à faire à la main sur demande : setsp('QT',consigne,'Model') % go back to initial value for QT
    else
        consigne-Deltaskewquad
        errordlg('un QT  au moins dépasse les valeurs admises !','Attention');
        return
    end
end