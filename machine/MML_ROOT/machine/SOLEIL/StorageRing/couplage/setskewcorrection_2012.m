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
CorrectionFlag = 1 ; % Si Ã  zÃ©ro pas de correction
PostMeasurementFlag = 1 % Mesure aprÃ¨s correction du couplage
Params = [1e3 32 100] ; % ParamÃ¨tres par dÃ©faut de la correction
% Params(1) : poids Dz
% Params(2) : nb de valeurs propres de lamatrice efficacite QT
% Params(3) : pourcentage de correction appliquÃ©

for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignore structures
        handles.caller = varargin{i}.figure1;
        M = getappdata(handles.caller,'M'); % paramÃ¨tres mesure
        S = getappdata(handles.caller,'S'); % paramÃ¨tres correction
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
    PostMeasurementFlag = 0
    %waittime = 2.8;  % 5 secondes car pb alim correcteurs % 2.8 s 24 octobre 08
end



%% RÃ©sultats fit LOCO redÃ©marrage juillet 2011
% if strcmpi(ModeFlag,'Online') % juste pour la visualisation immédiate de la dispersion
%     %load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2009-03-06a/160quad.mat') % LOCO/2009-03-06a
%     load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-09-01/160quad.mat')
%     iter = 3;
%     HBPMgain = BPMData(iter).HBPMGain;
%     VBPMgain = BPMData(iter).VBPMGain;
%     HBPMcoupling = BPMData(iter).HBPMCoupling;
%     VBPMcoupling = BPMData(iter).VBPMCoupling;
%     HCMkick = CMData(iter).HCMKicks;
%     meanHCMkick = mean(HCMkick);
%     
%     C = zeros(120,2,2);
%     for ik =1:120,
%         C(ik,:,:)= [ HBPMgain(ik)       HBPMcoupling(ik)
%             VBPMcoupling(ik)   VBPMgain(ik)      ];
%         Cinv(ik,:,:) = inv(squeeze(C(ik,:,:)));
%     end
% end
%%

if MeasurementFlag
    %Indexskewquad = family2atindex('QT');% Index of skew quadrupoles
    %Meffskewquad_CTO = zeros(120,120,32); % premiÃ¨re matrice : efficacitÃ© vis Ã  vis des orbites fermÃ©es croisÃ©es
    %Etalonnage = zeros(2,120,32);
    DeviceNumber_HCOR = 0;
    
    % graphe
    lim = 0.10* DeltaI_HCOR / 0.6; % en mm, valeur max estimÃ©e des CTCO pour graphe
    
    
%    if ArchiveFlag  % enregistrement de la matrice reponse dispersion
%         if isempty(FileName)
%             FileName = appendtimestamp('SkewMeasurement');
%             DirectoryName = getfamilydata('Directory', 'SkewResponse');
%             if isempty(DirectoryName)
%                 %             DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
%             else
%                 % Make sure default directory exists
%                 DirStart = pwd;
%                 [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
%                 cd(DirStart);
%             end
%             [FileName, DirectoryName] = uiputfile('*.mat', 'Select a Skew File ("Save" starts measurement)', [DirectoryName FileName]);
%             if FileName == 0
%                 ArchiveFlag = 0;
%                 disp('   Skew efficiency measurement canceled.');
%                 return
%             end
%             FileName = [DirectoryName, FileName];
%         elseif FileName == -1
%             FileName = appendtimestamp(getfamilydata('Default', 'SkewArchiveFile'));
%             DirectoryName = getfamilydata('Directory', 'SkewResponse');
%             FileName = [DirectoryName, FileName];
%         end
%    end
    
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
    if strcmpi(ModeFlag,'Online')  % MODIFIER LE REPERTOIRE D ENREGISTREMENT
        FileName_DISP = appendtimestamp('Dispersion_V')
        FileName_DISP = ['/home/production/matlab/matlabML/machine/SOLEIL/StorageRing/fonction_test/couplage/'   FileName_DISP];
        measdisp('Archive',FileName_DISP,'NoDisplay'); % on sauvegarde les mesures brutes cette fois
        Dx_Meas = getdisp('BPMx',FileName_DISP,'Physics');
        Dy_Meas = getdisp('BPMz',FileName_DISP,'Physics');
        
        % visualisation
        figure(304);plot(Dy_Meas,'bo-'),title('Mesures brutes')
        load('/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO/2011-09-01_pseudo_nano/160quad.mat'); % à actualiser
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
        Dy_plot = Dx_Meas.*Cinv(:,2,1) + Dy_Meas.*Cinv(:,2,2);
        figure(305);plot(Dy_plot,'ro-'),title('Mesures corrigées')
        sleep(waittime*2)
    else
        DirectoryName = getfamilydata('Directory', 'DispData');
        FileName = appendtimestamp('Disp');%[];
        [FileName, DirectoryName] = uiputfile('*.mat', 'Save a Dispersion File', [DirectoryName FileName]);
        FileName_DISP = fullfile(DirectoryName,FileName);
        [Dx_Meas Dy_Meas] = modeldisp('BPMx','Archive',FileName_DISP);
        disp('Dispersion Registration ended')
        figure(689);plot(Dy_Meas,'o-');ylabel('Dispersion V (m)')
        figure(690);plot(Dx_Meas,'o-');ylabel('Dispersion H (m)')
    end
    %     if strcmpi(ModeFlag,'Online')
    %         Dy_Meas = Dy_Meas - Dx_Meas.*CT';
    %     end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CrossTalk closed orbit measurement
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmpi(ModeFlag,'Online')
        measbpmresp('Archive',Mode);
    else
        DirectoryName = getfamilydata('Directory', 'BPMResponse');
        FileName = appendtimestamp('BPMRespMat');%[];
        [FileName, DirectoryName] = uiputfile('*.mat', 'Save a BPM Response File', [DirectoryName FileName]);
        FileName_Resp = fullfile(DirectoryName,FileName);
        measbpmresp('Archive',FileName_Resp,ModeFlag);
        disp('Response Matrix Registration ended')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coupling correction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if CorrectionFlag
    if ~MeasurementFlag  % si on  n'a pas préalablement mesuré de matrice réponse
        
        %% chargement d'une matrice réponse BPM déjà enregistrée
        FileName = [];
        DirectoryName = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO'; % ??? modifier par un getfamilydata('Directory', '????');
        %DirectoryName = getfamilydata('Directory', 'BPMResponse');
        if isempty(DirectoryName)
            %             DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
        else
            % Make sure default directory exists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        FileName = [];
        [FileName, DirectoryName] = uigetfile('*.mat', 'Select a BPM Response File', [DirectoryName FileName]);
        if FileName == 0
            %ArchiveFlag = 0;
            disp('   User selected CANCEL ');
            return
        else
            disp(['User selected  ',fullfile(DirectoryName,FileName)])
            % enregistrer le repertoire LOCO choisi
            LOCODirectory = DirectoryName;
        end
        FileName_BPMresp = [DirectoryName, FileName];
        
        load(FileName_BPMresp);
        % la matrice se présente sous cette forme :
        % R(BPM Plane, Corrector Plane) - 2x2 struct array
        %     R(1,1).Data=xx;  % Kick x, look x
        %     R(2,1).Data=yx;  % Kick x, look y
        %     R(1,2).Data=xy;  % Kick y, look x
        %     R(2,2).Data=yy;  % Kick y, look y
        % on s'interesse aux mesure kick x.
        
        if ~isequal(size((Rmat(2,1).Data),2),length(family2dev('HCOR')))
            disp('WARNING : vous n''avez pas sélectionné un matrice réponse de correcteurs lents')
            return
        end
        
        %% chargement d'une dispersion déjà enregistrée
        FileName = [];
        DirectoryName = LOCODirectory ; % '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO'; % ??? modifier par un getfamilydata('Directory', '????');
        %DirectoryName = getfamilydata('Directory','DispData');
        [FileName, DirectoryName] = uigetfile('*.mat', 'Select a dispersion file', [DirectoryName FileName]);
        if FileName == 0
            %ArchiveFlag = 0;
            disp('   User selected CANCEL ');
            return
        else
            disp(['User selected  ',fullfile(DirectoryName,FileName)])
            
        end  
        FileName_disp = [DirectoryName, FileName];
            %load(FileName_disp);
        
        Dx = getdisp('BPMx',FileName_disp,'Physics');
        Dy = getdisp('BPMz',FileName_disp,'Physics');
        
        %% construction de la matrice réponse complète pour la correction de couplage
        
        if strcmpi(ModeFlag,'Model')
            CTCO_Meas = Rmat(2,1).Data;
            Dy_Meas = Dy;
            disp('?')
            
        else % online
            
            %% chargement des gains et couplage des BPM (LOCO) déjà enregistrés  attention à choisir une mesure LOCO avec 122 BPM
            
            FileName = [];
            DirectoryName = LOCODirectory ; % '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/LOCO'; % ??? modifier par un getfamilydata('Directory', '????');
            [FileName, DirectoryName] = uigetfile('*.mat', 'Select BPM gains from a 160quad LOCO file', [DirectoryName FileName]);
            if FileName == 0
                %ArchiveFlag = 0;
                disp('   User selected CANCEL ');
                return
            else
                disp(['User selected  ',fullfile(DirectoryName,FileName)])
            end
            FileName_LOCO = [DirectoryName, FileName];
            
            load(FileName_LOCO);
            
            iter = length(BPMData); % on choisit la dernière itération de LOCO (OK ???)
           
            HBPMgain = BPMData(iter).HBPMGain;
            if ~isequal(length(HBPMgain),length(dev2elem('BPMx')))
                disp('!!! la matrice 160quad de LOCO selectionnée n''a pas le nombre correct de BPM')
                return
            end
            VBPMgain = BPMData(iter).VBPMGain;
            HBPMcoupling = BPMData(iter).HBPMCoupling;
            VBPMcoupling = BPMData(iter).VBPMCoupling;
            HCMkick = CMData(iter).HCMKicks;
            meanHCMkick = mean(HCMkick);
            
            C = zeros(length(dev2elem('BPMx')),2,2);
            for ik =1:length(dev2elem('BPMx')),
                C(ik,:,:)= [ HBPMgain(ik)       HBPMcoupling(ik)
                    VBPMcoupling(ik)   VBPMgain(ik)      ];
                Cinv(ik,:,:) = inv(squeeze(C(ik,:,:)));
            end
            
            Oz = Rmat(2,1).Data ; % orbite z
            Ox = Rmat(1,1).Data ;  % orbite x
            CTCO_Meas = 0*ones(length(dev2elem('BPMx')), length(dev2elem('HCOR')));
            for k=1:length(dev2elem('HCOR'))
                CTCO_Meas(:,k) = Oz(:,k).*Cinv(:,2,2) + Ox(:,k).*Cinv(:,2,1);
                Dy_Meas = Dx.*Cinv(:,2,1) + Dy.*Cinv(:,2,2);
            end
            
            figure(304);plot(Dy,'bo-')
            figure(304);hold on;plot(Dy_Meas,'ro-');
            set(gca,'Fontsize',14)
            xlabel('s (m)');ylabel('dispersion (m)');
            legend('Mesures brutes','Mesures corrigées de la diaphonie')
            title('Vérification de la dispersion et des gains BPM selectionnés')
            
        end

    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Efficiency Matrix loading
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% chargement des matrices d'efficacité des quadrupoles tournés QT
    
    FileName = [];
    DirectoryName = getfamilydata('Directory', 'SkewResponse');
    [FileName, DirectoryName] = uigetfile('*.mat', 'Select a skew efficiency matrix SKEWRESPMAT CTCO', [DirectoryName FileName]);
    if FileName == 0
        %ArchiveFlag = 0;
        disp('   User selected CANCEL ');
        return
    else
        disp(['User selected  ',fullfile(DirectoryName,FileName)])       
    end    
    FileName_CTCO = [DirectoryName, FileName];
    S_CTCO = load(FileName_CTCO);
    Meffskewquad_CTCO = S_CTCO.Meffskewquad_CTCO;
    
    FileName = [];
    DirectoryName = getfamilydata('Directory', 'SkewResponse');
    [FileName, DirectoryName] = uigetfile('*.mat', 'Select a skew efficiency matrix SKEWRESPMAT DISP', [DirectoryName FileName]);
    if FileName == 0
        %ArchiveFlag = 0;
        disp('   User selected CANCEL ');
        return
    else
        disp(['User selected  ',fullfile(DirectoryName,FileName)])      
    end    
    FileName_disp = [DirectoryName, FileName];
    S_D = load(FileName_disp);
    Meffskewquad_D = S_D.Meffskewquad_D;
    if ~isequal(size(Meffskewquad_D,1),length(dev2elem('BPMx')))
        disp('!!! la matrice DISP selectionnée n''a pas le nombre correct de BPM')
        return
    end
    if ~isequal(size(Meffskewquad_CTCO,1),length(dev2elem('BPMx')))
        disp('!!! la matrice CTCO selectionnée n''a pas le nombre correct de BPM')
        return
    end
   
   %%% matrice en cours en décembre 2011
   % S_D = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-10-11_17-51-37_lat_nano_17_25_disp')
   
   %%% matrice en cours en décembre 2011
   %S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-10-11_18-08-11_lat_nano_17_25_CTCO')
    
    
    %     S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-09-22_13-58-13_lat_nano_17_25_CTCO_bis_CTCO')
    %S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2011-06-13_11-06-05_betax5m_32QT_CTCO')
    %S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2010-06-17_12-13-58_CTCO_lat_nano_20_64.mat')
    % run 27 octobre 08
    %S_CTCO = load('-mat','/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/SkewRespMat_2008-10-24_09-19-19_CTCO_nux_0-27_nuz_0-32.mat')
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Coupling Matrix construction (depending on Relative Dispersion correction weigth)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %PoidsDz = Params(1)*ones(1,120);  % 1e3*ones(1,120); %  Relative Dispersion correction weigth
    if isequal(size(Meffskewquad_CTCO,3),length(family2dev('SQ')))&isequal(size(Meffskewquad_D,2),length(family2dev('SQ')))
        VirtualQT = 1 ;
    elseif isequal(size(Meffskewquad_CTCO,3),length(family2dev('QT')))&isequal(size(Meffskewquad_D,2),length(family2dev('QT')))
        VirtualQT = 0 ;       
    else
        disp('!! Il y a une incohérence de dimension entre vos 2 matrices d''efficacité')
        return
    end
    
    if VirtualQT
        DeviceList_QT = family2dev('SQ');
    else
        DeviceList_QT = family2dev('QT');
    end
    DeviceList_HCOR = family2dev('HCOR');
    DeviceList_BPMz = family2dev('BPMz');
    
    nb = length(DeviceList_BPMz);
    PoidsDz = PoidsDz*ones(1,nb);  % 1e3*ones(1,120); %  Relative Dispersion correction weigth
    
    for l = 1:length(DeviceList_QT)
        for k = 1:length(DeviceList_QT)
            A_Dz(l,k) = sum(PoidsDz'.*Meffskewquad_D(:,l).*Meffskewquad_D(:,k)); % VÃ©rifier dimension de PoidsDz
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
        B_Dz(l) = sum(PoidsDz'.*Meffskewquad_D(:,l).*Dy_Meas(:)); % VÃ©rifier dimension de PoidsDz
    end
    for l = 1:length(DeviceList_QT)
        
        for j = 1:length(DeviceList_HCOR)
            T(j) = sum(Meffskewquad_CTCO(:,j,l).*CTCO_Meas(:,j));
        end
        B_CTCO(l) = sum(T(:));
        
    end
    coeff_Dz = -1; coeff_CTCO = -1 ;   % coeff_Dz / coeff_CTCO = -1 -> annulation du couplage dispersion / orbites croisÃ©es (betatron)
    SecondMember =   + coeff_Dz * B_Dz + coeff_CTCO *  B_CTCO;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Correction ( also depending on Relative Dispersion correction weigth !!)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    couleur = 'k-o'; % changer la couleur pour chaque valeur de nbvp (sauf blue)
    [U,S,V] = svd(MeffSkewQuad);
    figure(4) ; semilogy(diag(S));title('MeffSkewQuad  -  PoidsDz = 0');xlabel('No EigenValue');
    DiagS = diag(S);
    %nbvp = Params(2) ; % 32  %  length(DiagS);  % NOMBRE DE VALEURS PROPRES
    Rmod1 = MeffSkewQuad * V(:,1:nbvp);
    B1 = Rmod1\ (SecondMember' ); % SeconMember en ?
    Deltaskewquad = V(:,1:nbvp) * B1;
    %figure(20) ; hold on ; plot(Deltaskewquad,couleur) ; title('Valeur des QT en A')
    figure(21) ; hold on ; bar(Deltaskewquad) ; title('Valeur des QT en A')
    
    if isequal(VirtualQT,-1) % 32 QT
        figure(20) ; hold on ; plot(Deltaskewquad,'Color',nxtcolor) ; title('Valeur des QT en A')
        consigne = getam('QT',ModeFlag); % getsp('QT',ModeFlag); % decembre 2011 getsp ni getam ne fonctionnent en mode online sur metis
        %consigne = [consigne(1:23)' consigne(25:32)']'
        
        %pourcentage = Params(3) % 100;  % POURCENTAGE DE LA CORRECTION
        val_max = 7 ; val_min = -7 ;
        if all((consigne + Deltaskewquad* pourcentage*0.01)<val_max)*all((consigne +Deltaskewquad* pourcentage*0.01)>val_min);
            %Deltaskewquad = [Deltaskewquad(1:23)' 0 Deltaskewquad(24:31)']'
            %%
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%% application de la correction
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
                    
                    %DeltaI_HCOR = 0.6*1.; % 0.6 Amp : choix d'une orbite infÃ©rieure Ã  1 mm
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
                        end; % CTCO aprÃ¨s correction
                        hold on ; plot(getspos('BPMz'),-CTCO_Meas(:,1)*2*DeltaI_HCOR,'bo-') % rÃ©ference avant correction
                        title('HCOR [1 1]') ; legend('CTCO aprÃ¨s correction','CTCO avant correction')
                    elseif k2 == 2
                        figure(22) ; hold on ; plot(getspos('BPMz'),DeltaZof,couleur) ;
                        if exist('lim') ylim([-lim lim])
                        end ; % CTCO aprÃ¨s correction
                        hold on ; plot(getspos('BPMz'),-CTCO_Meas(:,2)*2*DeltaI_HCOR,'bo-') % rÃ©ference avant correction
                        title('HCOR [1 4]') ; legend('CTCO aprÃ¨s correction','CTCO avant correction')
                    elseif k2 == 3
                        figure(23) ; hold on ; plot(getspos('BPMz'),DeltaZof,couleur) ;
                        if exist('lim') ylim([-lim lim])
                        end ; % CTCO aprÃ¨s correction
                        hold on ; plot(getspos('BPMz'),-CTCO_Meas(:,3)*2*DeltaI_HCOR,'bo-') % rÃ©ference avant correction
                        title('HCOR [1 7]') ; legend('CTCO aprÃ¨s correction','CTCO avant correction')
                    end
                end
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%% mesure des émittances après correction du couplage
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
            %%% Ã  faire Ã  la main sur demande : setsp('QT',consigne,'Model') % go back to initial value for QT
        else
            consigne=Deltaskewquad
            errordlg('un QT  au moins dépasse les valeurs admises !','Attention');
            return
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% tracé des résultats
    if VirtualQT
        X = getspos('SQ');    
    else
        X = getspos('QT');  
    end
    Y(:,1) = Deltaskewquad;
    %Y(:,2) = Deltaskewquad;
    
    for k=1:3
        nfig = 100+k;
        if k==1  % plot en courant
            titre = 'Distribution des défauts de couplage';
            xlab = 'position s (m)';
            if VirtualQT
                ylab = 'I_Q_T_ _v_i_r_t_u_e_l_s (A)';
            else
                ylab = 'I_Q_T (A)';
            end
            Yplot = -Y ;
            
        elseif k==2  % plot en gradient tourné integré en Tesla
            titre = 'Coupling Error distribution';
            coeff = 93.83/1e4 ; % Tesla/A
            Yplot = -Y*coeff; % 
            ylab = 'Integrated Skew Gradient (T)';
            xlab = 'longitudinal position (m)';
            
        else  % plot en delta z sur les sextupôles
            % trouver les positions dse SQ
            F = 1e3;
            posSQ = (1/F)*floor(getspos('SQ')*F);
            % trouver les positions des sextupôles
            global THERING;
            localspos = findspos(THERING,1:length(THERING)+1);
            ATi= atindex;
            posS = 0*ones(11,8);
            coeff = 93.83/1e4 ; % Tesla/A étalonnage en gradient tourné intégré
            Y1 = -Y*coeff; 
            for iS = 1:11
                Name = ['S' num2str(iS)];
                A = getam((Name));
                IS(iS) = A(1);     % courant du sextupôle        
                posS = (1/F)*floor(localspos(ATi.(Name)(:))*F); % position du sextupôle
                [C,IA,IB] = INTERSECT(posS,posSQ');
                ISQ(IB) = IS(iS);
                Yplot(IB) = 1e3*Y1(IB,1)./(2*hw2physics('S1','Setpoint',IS(iS))*1e-8) % deplacement vertical équivalent du sextupole en mm
            end
            ylab = 'Vertical sextupole displacement (mm) ';
            xlab = 'longitudinal position (m)';
        end
        
        figure(nfig);
        h1 = subplot(4,1,1:3);bar(X,Yplot,1.5);
        set(gca,'FontSize',14)
        ylabel(ylab); title(titre)
        % echelle
        M = max(abs(Yplot(:,1)));
        M = M*1.1;
        L = 354.09;
        ylim([-M M]);xlim([0 L]);
        
        h2 = subplot(4,1,4);drawlattice;ylim([-3 3]);
        xlabel(xlab,'FontSize',14);
        linkaxes([h1 h2],'x')
        set(gca,'FontSize',14)
        
        %         % idem en gradient tourné integré (Tesla)
        %         figure(104);
        %         coeff = 93.83/1e4 ; % Tesla/A
        %         Y = Y*coeff;
        %         h1 = subplot(4,1,1:3);bar(X,-Y,1.5);
        %         set(gca,'FontSize',14)
        %         ylabel('Integrated Skew Gradient (T)'); title('Coupling Error distribution')
        %
        %         % legende
        %         %legend('Location','SouthEast')
        %         %legend('boxoff');legend('Location','SouthWest')
        %
        %         % echelle
        %         M = max(abs(Y(:,1)*coeff));
        %         M = M*(1+.01);
        %         L = 354.09;
        %         ylim([-M M]);xlim([0 L]);
        %
        %         h2 = subplot(4,1,4);drawlattice;ylim([-3 3]);
        %         xlabel('longitudinal position (m)','FontSize',14);
        %         linkaxes([h1 h2],'x')
        %         set(gca,'FontSize',14)
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% sauvegarde des résultats à la demande
    choice = questdlg('Please choose if you want to save the skew quad solution :','Save solution','Yes','No','Yes')
    switch choice
        case 'Yes'
            DirStart = pwd;
            DirectoryName = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/Response/Skew/solution_QT'; % A MODIFIER ??
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            FileName = [];
            [FileName, DirectoryName] = uiputfile('*.mat', 'Choose a filename for saving skew quad list', [DirectoryName FileName]);
            if FileName == 0
                disp('   User selected CANCEL ');
                return
            else
                save(FileName,'Deltaskewquad')
            end
            cd(DirStart);
        case 'No'
            disp('Pas de sauvegarde')
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end