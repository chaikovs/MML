function [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocoinput_soleil(OutputFileName)
%BUILDLOCOINPUT - Matlab Middlelayer (MML) method for building a LOCO input file.
%                 Combines response matrix, BPM standard deviation, and 
%                 dispersion files (or measurements) into a LOCO input file.
%                 The fit parameters are added if a buildlocofitparameters file is on the path.
%
%  [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocoinput(OutputFileName)
%
%  Written by Greg Portmann


% % In order to iterate loco uses arrays of structures all the fields in the structure must be present
% LocoFlags = struct('SVmethod',[], 'Dispersion',[], 'Coupling',[], 'Normalize',[], 'Linear',[], 'SVDDataFileName',[]);
% LocoModel = struct('M',[], 'OutlierIndex',[], 'Eta',[], 'EtaOutlierIndex',[], 'SValues',[], 'SValuesIndex',[], 'ChiSquare',[]);
% BPMData = struct('FamName',[], 'BPMIndex',[], 'HBPMIndex',[], 'VBPMIndex',[], 'HBPMGoodDataIndex',[], 'VBPMGoodDataIndex',[], 'HBPMGain',[], 'VBPMGain',[], 'HBPMCoupling',[], 'VBPMCoupling',[], 'HBPMGainSTD',[], 'VBPMGainSTD',[],'HBPMCouplingSTD',[],'VBPMCouplingSTD',[],'FitGains',[],'FitCoupling',[]);
% CMData = struct('FamName',[], 'HCMIndex',[], 'VCMIndex',[], 'HCMGoodDataIndex',[], 'VCMGoodDataIndex',[], 'HCMKicks',[], 'VCMKicks',[], 'HCMCoupling',[], 'VCMCoupling',[], 'HCMKicksSTD',[], 'VCMKicksSTD',[],'HCMCouplingSTD',[],'VCMCouplingSTD',[],'FitKicks',[],'FitCoupling',[]);
% FitParameters = struct('Params',[], 'Values',[], 'ValuesSTD',[], 'Deltas',[], 'DeltaRF',[], 'FitRFFrequency',[], 'DeltaRFSTD',[]);

FitParameters = [];


% Family Setup
BPMxFamily = gethbpmfamily;
BPMyFamily = getvbpmfamily;

HCMFamily = 'HCOR'; 
VCMFamily = 'VCOR'; 


% Should probably get these from the response matrix???
if isempty(BPMxFamily)
    BPMxFamily = 'BPMx';   
end
if isempty(BPMyFamily)
    BPMyFamily = 'BPMz';   
end
if isempty(HCMFamily)
    HCMFamily = 'HCOR';   
end
if isempty(VCMFamily)
    VCMFamily = 'VCOR';   
end


% BPMs to remove 
RemoveBPMDeviceList = [];
RemoveHCMDeviceList = [];
RemoveVCMDeviceList = [];


if nargin == 0
    [OutputFileName, DirectoryName] = uiputfile('*.mat', 'New LOCO Input File Name?');
    if OutputFileName == 0
        return
    end
    OutputFileName = [DirectoryName OutputFileName];
end

DirStart = [getfamilydata('Directory', 'DataRoot'), 'LOCO', filesep];


% To start with nominal gains (1) and coupling (0)
%ButtonName = questdlg('Gains and Coupling?','LOCO STARTING POINT','Use Present Setting','Nominal Gain=1, Coupling=0','Use Present Setting');
%switch ButtonName,
%    case 'Nominal Gain=1, Coupling=0'
        setlocodata('Nominal');
        fprintf('   May need to run setoperationmode (or aoinit) to restore the proper gains & rolls.\n');
%end

%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Build the AT MODEL %
%%%%%%%%%%%%%%%%%%%%%%%%%
LocoModel = [];

% Save THERING and restore on exit so that this function does not change the model
global THERING
THERINGsave = THERING;

AO_ATModel = getfamilydata('ATModel');
[DirectoryName, ATModel, Ext] = fileparts(which(AO_ATModel));
[ATModel, DirectoryName] = uigetfile('*.*', 'AT Model (Cancel to use the present model)?', [DirectoryName, filesep, ATModel, Ext]);
if ATModel == 0
    if isempty(THERING)
        fprintf('   No AT model found.  Buildlocoinput canceled.\n');
        return;
    end
else
    run([DirectoryName, ATModel]);
    %updateatindex; % Purpose ?
end

% Cavity and radiation should be off for response and dispersion generation
setcavity off;
setradiation off;

% Set the model energy
setenergymodel(getfamilydata('Energy'));

RINGData.Lattice = THERING;
RINGData.CavityFrequency  = getrf('Model', 'Physics');
RINGData.CavityHarmNumber = getharmonicnumber; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. MEASURED DATA STRUCTURE                %
% LocoMeasData.M          [mm]              %
% LocoMeasData.BPMSTD     [mm]              %
% LocoMeasData.DeltaAmps  [Amps] (Optional) %
% LocoMeasData.Eta        [mm]              %
% LocoMeasData.RF         [Hz]              %
% LocoMeasData.DeltaRF    [Hz]              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%
% BPM Response Matrix %
%%%%%%%%%%%%%%%%%%%%%%%
% Rmat(BPM,COR)
% Rmat(1,1).Data=xx;  %Kick x, look x
% Rmat(2,1).Data=yx;  %Kick x, look y
% Rmat(1,2).Data=xy;  %Kick y, look x
% Rmat(2,2).Data=yy;  %Kick y, look y

ButtonName = questdlg('LOCO response matrix?','RESPONSE MATRIX','Use Default','Measure','Get From File','Get From File');
drawnow;
%IDBPM = getidbpmlist;

switch ButtonName,
    case 'Get From File'
        [BPMRespFile, BPMRespDirectory] = uigetfile('*.mat','Select a BPM Response Matrix File', DirStart);
        if BPMRespFile == 0
            fprintf('   buildlocoinput canceled.\n');
            return
        end
        DirStart = BPMRespDirectory;

        % Variable MachineConfig is the lattice at the time when the response matrix was generated
        try
            load([BPMRespDirectory BPMRespFile], 'MachineConfig');
        catch
            fprintf('   Lattice configuration not found in the response matrix file.  You don''t need it but it''s nice to have.\n');
        end
        
        Rmat(1,1) = getrespmat(BPMxFamily, [], HCMFamily, [], [BPMRespDirectory BPMRespFile], 'Struct', 'Hardware', 'NoEnergyScaling');
        Rmat(1,2) = getrespmat(BPMxFamily, [], VCMFamily, [], [BPMRespDirectory BPMRespFile], 'Struct', 'Hardware', 'NoEnergyScaling');
        Rmat(2,1) = getrespmat(BPMyFamily, [], HCMFamily, [], [BPMRespDirectory BPMRespFile], 'Struct', 'Hardware', 'NoEnergyScaling');
        Rmat(2,2) = getrespmat(BPMyFamily, [], VCMFamily, [], [BPMRespDirectory BPMRespFile], 'Struct', 'Hardware', 'NoEnergyScaling');
        
    case 'Use Default'
        Rmat(1,1) = getrespmat(BPMxFamily, [], HCMFamily, [], 'Struct', 'Hardware', 'NoEnergyScaling');
        Rmat(1,2) = getrespmat(BPMxFamily, [], VCMFamily, [], 'Struct', 'Hardware', 'NoEnergyScaling');
        Rmat(2,1) = getrespmat(BPMyFamily, [], HCMFamily, [], 'Struct', 'Hardware', 'NoEnergyScaling');
        [Rmat(2,2), FileName] = getrespmat(BPMyFamily, [], VCMFamily, [], 'Struct', 'Hardware', 'NoEnergyScaling');
        
        % Variable MachineConfig is the lattice at the time when the response matrix was generated
        load(FileName,'MachineConfig');
        
    case 'Measure'
        Rmat = measbpmresp('Struct', 'Hardware');

        % Variable MachineConfig is the lattice at the time when the response matrix was generated
        MachineConfig = getmachineconfig;
        
    otherwise
        fprintf('   LOCO build canceled.\n');
        return
end

if exist('MachineConfig','var')
    LocoMeasData.MachineConfig = MachineConfig;  % Extra (not needed by LOCO but it's often nice to have it)
end


% BPM remove list  
i = findrowindex(RemoveBPMDeviceList, Rmat(1,1).Monitor.DeviceList);
Rmat(1,1).Data(i,:) = [];
Rmat(1,1).Monitor1(i,:) = [];
Rmat(1,1).Monitor2(i,:) = [];
Rmat(1,1).Monitor.DeviceList(i,:) = [];
Rmat(1,1).Monitor.Data(i,:) = [];
Rmat(1,1).Monitor.Status(i,:) = [];

i = findrowindex(RemoveBPMDeviceList, Rmat(1,2).Monitor.DeviceList);
Rmat(1,2).Data(i,:) = [];
Rmat(1,2).Monitor1(i,:) = [];
Rmat(1,2).Monitor2(i,:) = [];
Rmat(1,2).Monitor.DeviceList(i,:) = [];
Rmat(1,2).Monitor.Data(i,:) = [];
Rmat(1,2).Monitor.Status(i,:) = [];

i = findrowindex(RemoveBPMDeviceList, Rmat(2,1).Monitor.DeviceList);
Rmat(2,1).Data(i,:) = [];
Rmat(2,1).Monitor1(i,:) = [];
Rmat(2,1).Monitor2(i,:) = [];
Rmat(2,1).Monitor.DeviceList(i,:) = [];
Rmat(2,1).Monitor.Data(i,:) = [];
Rmat(2,1).Monitor.Status(i,:) = [];

i = findrowindex(RemoveBPMDeviceList, Rmat(2,2).Monitor.DeviceList);
Rmat(2,2).Data(i,:) = [];
Rmat(2,2).Monitor1(i,:) = [];
Rmat(2,2).Monitor2(i,:) = [];
Rmat(2,2).Monitor.DeviceList(i,:) = [];
Rmat(2,2).Monitor.Data(i,:) = [];
Rmat(2,2).Monitor.Status(i,:) = [];


% CM remove list  
i = findrowindex(RemoveHCMDeviceList, Rmat(1,1).Actuator.DeviceList);
Rmat(1,1).Data(:,i) = [];
Rmat(1,1).ActuatorDelta(i,:) = [];
Rmat(1,1).Actuator.DeviceList(i,:) = [];
Rmat(1,1).Actuator.Data(i,:) = [];
Rmat(1,1).Actuator.Status(i,:) = [];

i = findrowindex(RemoveVCMDeviceList, Rmat(1,2).Actuator.DeviceList);
Rmat(1,2).Data(:,i) = [];
Rmat(1,2).ActuatorDelta(i,:) = [];
Rmat(1,2).Actuator.DeviceList(i,:) = [];
Rmat(1,2).Actuator.Data(i,:) = [];
Rmat(1,2).Actuator.Status(i,:) = [];

i = findrowindex(RemoveHCMDeviceList, Rmat(2,1).Actuator.DeviceList);
Rmat(2,1).Data(:,i) = [];
Rmat(2,1).ActuatorDelta(i,:) = [];
Rmat(2,1).Actuator.DeviceList(i,:) = [];
Rmat(2,1).Actuator.Data(i,:) = [];
Rmat(2,1).Actuator.Status(i,:) = [];

i = findrowindex(RemoveVCMDeviceList, Rmat(2,2).Actuator.DeviceList);
Rmat(2,2).Data(:,i) = [];
Rmat(2,2).ActuatorDelta(i,:) = [];
Rmat(2,2).Actuator.DeviceList(i,:) = [];
Rmat(2,2).Actuator.Data(i,:) = [];
Rmat(2,2).Actuator.Status(i,:) = [];


% LOCO uses mm, not mm/amp
R11 = (ones(size(Rmat(1,1).Data,1),1) * Rmat(1,1).ActuatorDelta(:)') .* Rmat(1,1).Data;
R12 = (ones(size(Rmat(1,2).Data,1),1) * Rmat(1,2).ActuatorDelta(:)') .* Rmat(1,2).Data;
R21 = (ones(size(Rmat(2,1).Data,1),1) * Rmat(2,1).ActuatorDelta(:)') .* Rmat(2,1).Data;
R22 = (ones(size(Rmat(2,2).Data,1),1) * Rmat(2,2).ActuatorDelta(:)') .* Rmat(2,2).Data;


% Add energy to the RINGData (not needed for LOCO)
RINGData.Energy = Rmat(1,1).GeV;

% Build non-structure response matrix
LocoMeasData.M = [R11 R12; R21 R22];   % [mm]
LocoMeasData.DeltaAmps = [Rmat(1,1).ActuatorDelta(:); Rmat(2,2).ActuatorDelta(:)];

% Extra variables to add to the measured structure
LocoMeasData.HBPM = Rmat(1,1).Monitor;
LocoMeasData.VBPM = Rmat(2,2).Monitor;
LocoMeasData.HCM  = Rmat(1,1).Actuator;
LocoMeasData.VCM  = Rmat(2,2).Actuator;

% Needed for computing the new gain
LocoMeasData.HCMGain = getgain(HCMFamily, Rmat(1,1).Actuator.DeviceList);
LocoMeasData.VCMGain = getgain(VCMFamily, Rmat(2,2).Actuator.DeviceList);
LocoMeasData.HCMRoll = getroll(HCMFamily, Rmat(1,1).Actuator.DeviceList);
LocoMeasData.VCMRoll = getroll(VCMFamily, Rmat(2,2).Actuator.DeviceList);


if ~exist('RINGData','var')
    % Kick strength in milliradian
    HCMKicks = 1000 * hw2physics(HCMFamily, 'Setpoint', Rmat(1,1).ActuatorDelta, Rmat(1,1).Actuator.DeviceList);  
    VCMKicks = 1000 * hw2physics(VCMFamily, 'Setpoint', Rmat(2,2).ActuatorDelta, Rmat(2,2).Actuator.DeviceList);
    fprintf('   Note: Without an AT model BPMData and CMData variables cannot be determined.\n');
    fprintf('         Variables HCMKicks and VCMKicks will be saved to the data file.\n');
    save(OutputFileName, 'LocoMeasData', 'LocoModel', 'HCMKicks', 'VCMKicks');
    return
end



%%%%%%%%%%%%%%%%%%%%%%%
% GET DISPERSION INFO %
%%%%%%%%%%%%%%%%%%%%%%%
ButtonName = questdlg({'LOCO Dispersion & RF Frequency?','(Close dialog box to not include dispersion)'},'DISPERSION','Use Default','Measure','Get From File','Get From File');
drawnow;
switch ButtonName
    case 'Use Default'
        DISPx = getdisp(BPMxFamily, Rmat(1,1).Monitor.DeviceList, 'Struct', 'Hardware');
        DISPy = getdisp(BPMyFamily, Rmat(2,2).Monitor.DeviceList, 'Struct', 'Hardware');
        RF = DISPx.Actuator.Data;
        DeltaRF = DISPx.ActuatorDelta;
        DISPx = DeltaRF * DISPx.Data;
        DISPy = DeltaRF * DISPy.Data;

    case 'Get From File'
        [DISPFile, DISPDirectory] = uigetfile('*.mat','Select a Dispersion File', DirStart);
        if DISPFile == 0
            fprintf('   buildlocoinput canceled.\n');
            return
        end
        DirStart = DISPDirectory;

        DISPx = getrespmat(BPMxFamily, Rmat(1,1).Monitor.DeviceList, 'RF', [], [DISPDirectory DISPFile], 'Struct', 'Hardware', 'NoEnergyScaling');
        RF = DISPx.Actuator.Data;
        DeltaRF = DISPx.ActuatorDelta;
        DISPx = DeltaRF * DISPx.Data;
        DISPy = DeltaRF * getrespmat(BPMyFamily, Rmat(2,2).Monitor.DeviceList, 'RF', [], [DISPDirectory DISPFile], 'Hardware', 'NoEnergyScaling');
        
    case 'Measure'
        [Dx, Dy] = measdisp(BPMxFamily, Rmat(1,1).Monitor.DeviceList, BPMyFamily, Rmat(2,2).Monitor.DeviceList, 'Struct', 'Archive', 'Hardware');
        RF = Dx.Actuator.Data;
        DeltaRF = Dx.ActuatorDelta;
        DISPx = DeltaRF * Dx.Data;
        DISPy = DeltaRF * Dy.Data;
    case ''
        fprintf('   Dispersion will not be included in the LOCO file.\n');
end

if isempty(ButtonName)
    LocoMeasData.RF      = [];
    LocoMeasData.DeltaRF = [];
    LocoMeasData.Eta = [];
else
    %LocoMeasData.RF      = 1e6 * RF;             % [Hz]
    %LocoMeasData.DeltaRF = 1e6 * DeltaRF;        % [Hz]
    LocoMeasData.RF      = hw2physics('RF', 'Setpoint', RF);        % [Hz]
    LocoMeasData.DeltaRF = hw2physics('RF', 'Setpoint', DeltaRF);   % [Hz]
    LocoMeasData.DeltaRF = LocoMeasData.DeltaRF(1);
    LocoMeasData.Eta = [DISPx(:); DISPy(:)];      % [mm]
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% GET BPM STANDARD DEVIATION INFO %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ButtonName = questdlg('LOCO BPM Sigma?','BPM SIGMA','Use Default','Measure','Get From File','Get From File');
drawnow;
switch ButtonName,
    case 'Get From File'
        [BPMSigmaFile, BPMSigmaDirectory] = uigetfile('*.mat','Select a BPM Sigma File', DirStart);
        drawnow;
        if BPMSigmaFile == 0
            fprintf('   buildlocoinput canceled.\n');
            return
        end
        DirStart = BPMSigmaDirectory;

        %BPMxSTD = getdata(BPMxFamily, Rmat(1,1).Monitor.DeviceList, [BPMSigmaDirectory BPMSigmaFile], 'Hardware');
        %BPMySTD = getdata(BPMyFamily, Rmat(2,2).Monitor.DeviceList, [BPMSigmaDirectory BPMSigmaFile], 'Hardware');
        BPMxSTD = getsigma(BPMxFamily, Rmat(1,1).Monitor.DeviceList, [], [BPMSigmaDirectory BPMSigmaFile], 'Hardware');
        BPMySTD = getsigma(BPMyFamily, Rmat(2,2).Monitor.DeviceList, [], [BPMSigmaDirectory BPMSigmaFile], 'Hardware');
        
    case 'Use Default'
        BPMxSTD = getsigma(BPMxFamily, Rmat(1,1).Monitor.DeviceList, 'Hardware');
        BPMySTD = getsigma(BPMyFamily, Rmat(2,2).Monitor.DeviceList, 'Hardware');

    case 'Measure'
        [BPMx, BPMy, tout, DCCT, BPMxSTD, BPMySTD] = monbpm(0:.5:60*3, BPMxFamily, Rmat(1,1).Monitor.DeviceList, BPMyFamily, Rmat(2,2).Monitor.DeviceList, 'Archive', 'Hardware');
end

% sqrt(2) is needed because LOCO standard deviation is for difference orbits
LocoMeasData.BPMSTD = sqrt(2) * [BPMxSTD(:); BPMySTD(:)];    % [mm]


% % Check for a zero standard deviation (this is done in lococheckfile)
% i = find(BPMxSTD==0);
% if ~isempty(i)
%     for k = 1:length(i)
%         fprintf('   %s(%d,%d) or %s(%d) has a zero standard deviation\n', BPMxFamily, Rmat(1,1).Monitor.DeviceList(i(k),:), BPMxFamily, i(k));
%     end
% end
% 
% % Check for a zero standard deviation
% j = find(BPMySTD==0);
% if ~isempty(j)
%     for k = 1:length(j)
%         fprintf('   %s(%d,%d) or %s(%d) has a zero standard deviation\n', BPMyFamily, Rmat(2,2).Monitor.DeviceList(j(k),:), BPMyFamily, j(k));
%     end
% end
% if ~isempty(i) || ~isempty(j)
%     fprintf('   WARNING:  LOCO can''t handle zero standard deviations.\n');
% end



% 3. BPM AND CORRECTOR MAGNET STRUCTURES
% FamName and BPMIndex tells the findorbitrespm function which BPMs are needed in the response matrix
% HBPMIndex/VBPMIndex is the sub-index of BPMIndex which correspond to the measured response matrix
% BPMData.HBPMGain = starting value for the horizontal BPM gains (default: ones)
% BPMData.VBPMGain = starting value for the vertical   BPM gains (default: ones)
% BPMData.HBPMCoupling = starting value for the horizontal BPM coupling (default: zeros)
% BPMData.VBPMCoupling = starting value for the vertical   BPM coupling (default: zeros)
% BPMData.FitGains    = 'Yes'/'No' to fitting the BPM gain     (set in locogui)
% BPMData.FitCoupling = 'Yes'/'No' to fitting the BPM coupling (set in locogui)
% Note that gains and coupling are used all the time (fit or not!)

BPMData.FamName = 'BPMx';
BPMData.FitGains    = 'Yes';
BPMData.FitCoupling = 'Yes';

if 1
    % Get the AT indexes from the AT model
    % The model should have the same number of devices as the total device list in the AO.
    % Then index based on the DeviceList saved with the response matrix
    BPMData.BPMIndex = findcells(THERING, 'FamName', BPMData.FamName)';
    tempindex = BPMData.BPMIndex;
    
    BPMxListTotal0 = family2dev(Rmat(1,1).Monitor.FamilyName,0);
    %BPMxListTotal = getlist(Rmat(1,1).Monitor.FamilyName);
    BPMxListTotal = Rmat(1,1).Monitor.DeviceList;
    subindex = findrowindex([BPMxListTotal; zeros(length(BPMxListTotal0)-length(BPMxListTotal),2)],BPMxListTotal0); 
        
    BPMData.BPMIndex = BPMData.BPMIndex(subindex);    
    if length(BPMData.BPMIndex) == size(BPMxListTotal,1)
        %BPMData.HBPMIndex = 1:length(BPMData.BPMIndex); 
        
        % Only include the good BPMs (Status = 1)
        BPMData.HBPMIndex = findrowindex(Rmat(1,1).Monitor.DeviceList, BPMxListTotal); 
    else
        error('BPM family in the AT model has more BPMs then the actual accelerator (horizontally)');
    end     
    
    BPMyListTotal = Rmat(2,2).Monitor.DeviceList;
    
    if length(BPMData.BPMIndex) == size(BPMyListTotal,1)
        % Only include the good BPMs (Status = 1)
        BPMData.VBPMIndex = findrowindex(Rmat(2,2).Monitor.DeviceList, BPMyListTotal); 
    else
        error('BPM family in the AT model has more BPMs then the actual accelerator (vertically)');
    end     
    
else
    % Get the AT indexes from the AO
    BPM1Index = family2atindex(Rmat(1,1).Monitor.FamilyName, Rmat(1,1).Monitor.DeviceList);    % Must match the response matrix
    BPM2Index = family2atindex(Rmat(2,2).Monitor.FamilyName, Rmat(2,2).Monitor.DeviceList);    % Must match the response matrix
    BPMData.FamName = THERING{BPM1Index(1)};
    
    BPMData.BPMIndex = unique([BPM1Index(:); BPM2Index(:)]);
    BPMData.HBPMIndex = findrowindex(BPM1Index, BPMData.BPMIndex);          % Must match the response matrix
    BPMData.VBPMIndex = findrowindex(BPM2Index, BPMData.BPMIndex);          % Must match the response matrix
end

if 1
    % Starting with the present GCR
    for i = 1:length(Rmat(1,1).Monitor.DeviceList)
        m = gcr2loco(getgain(BPMxFamily, Rmat(1,1).Monitor.DeviceList(i,:)), getgain(BPMyFamily, Rmat(1,1).Monitor.DeviceList(i,:)), getcrunch(BPMxFamily, Rmat(1,1).Monitor.DeviceList(i,:)), getroll(BPMxFamily, Rmat(1,1).Monitor.DeviceList(i,:)));
        BPMData.HBPMGain(i,1) = m(1,1);
        BPMData.HBPMCoupling(i,1) = m(1,2);
    end

    for i = 1:length(Rmat(2,2).Monitor.DeviceList)
        m = gcr2loco(getgain(BPMxFamily, Rmat(2,2).Monitor.DeviceList(i,:)), getgain(BPMyFamily, Rmat(2,2).Monitor.DeviceList(i,:)), getcrunch(BPMyFamily, Rmat(2,2).Monitor.DeviceList(i,:)), getroll(BPMyFamily, Rmat(2,2).Monitor.DeviceList(i,:)));
        BPMData.VBPMGain(i,1) = m(2,2);
        BPMData.VBPMCoupling(i,1) = m(2,1);
    end
else
    % Starting with nominal gains
    BPMData.HBPMGain = ones(length(BPMData.HBPMIndex), 1);
    BPMData.VBPMGain = ones(length(BPMData.VBPMIndex), 1);
end



% FamName and HCMIndex/VCMIndex tells the findorbitrespm function which corrector magnets are in the response matrix
% CMData.FitKicks = 'Yes'/'No' to fitting the corrector magnet gain (set in locogui)
% CMData.FitCoupling = 'Yes'/'No' to fitting the corrector magnet coupling (set in locogui)
% CMData.HCMKicks = starting value for the horizontal kicks in milliradian
% CMData.VCMKicks = starting value for the vertical   kicks in milliradian
% CMData.HCMCoupling = starting value for the horizontal coupling (default: zeros)
% CMData.VCMCoupling = starting value for the vertical   coupling (default: zeros)
% Note:  The kick strength should match the measured response matrix as best as possible
% Note:  The kicks and Coupling are used all the time (fit or not!)

% Get the AT indexes from the AT model
CMData.FitKicks    = 'Yes';
CMData.FitCoupling = 'Yes';
CMData.FitHCMEnergyShift = 'No';
CMData.FitVCMEnergyShift = 'No';

% Get the AT indexes from the AO
CMData.HCMIndex = family2atindex(Rmat(1,1).Actuator.FamilyName, Rmat(1,1).Actuator.DeviceList);    % Must match the response matrix
CMData.VCMIndex = family2atindex(Rmat(2,2).Actuator.FamilyName, Rmat(2,2).Actuator.DeviceList);    % Must match the response matrix
CMData.FamName = THERING{CMData.HCMIndex(1)}.FamName;

% Kick strength in milliradian
CMData.HCMKicks = 1000 * hw2physics(HCMFamily, 'Setpoint', Rmat(1,1).ActuatorDelta, Rmat(1,1).Actuator.DeviceList);  
CMData.VCMKicks = 1000 * hw2physics(VCMFamily, 'Setpoint', Rmat(2,2).ActuatorDelta, Rmat(2,2).Actuator.DeviceList);

% The kicks need to be adjusted for roll (model coordinates)
CMData.HCMKicks = CMData.HCMKicks .* cos(getroll(HCMFamily,Rmat(1,1).Actuator.DeviceList));
CMData.VCMKicks = CMData.VCMKicks .* cos(getroll(VCMFamily,Rmat(2,2).Actuator.DeviceList));

% Coupling term: Cloco/Gloco  = gain(ML)*sin(Roll)/(gain(ML)*cos(Roll)) = tan(Roll)
%CMData.HCMCoupling =  getgain(HCMFamily, Rmat(1,1).Actuator.DeviceList) .* sin(getroll(HCMFamily,Rmat(1,1).Actuator.DeviceList));
%CMData.VCMCoupling = -getgain(VCMFamily, Rmat(2,2).Actuator.DeviceList) .* sin(getroll(VCMFamily,Rmat(2,2).Actuator.DeviceList));
CMData.HCMCoupling =  tan(getroll(HCMFamily,Rmat(1,1).Actuator.DeviceList));
CMData.VCMCoupling = -tan(getroll(VCMFamily,Rmat(2,2).Actuator.DeviceList));



%%%%%%%%%%%%%
% LocoFlags %
%%%%%%%%%%%%%
% LocoFlags can be created or just take the defaults with locogui (or locofilecheck) 
% LocoFlags = [];   
LocoFlags.Threshold = 1e-006;
LocoFlags.OutlierFactor = 10;
LocoFlags.SVmethod = 1e-005;
LocoFlags.HorizontalDispersionWeight = 12.5;
LocoFlags.VerticalDispersionWeight = 12.5;
LocoFlags.AutoCorrectDelta = 'Yes';
LocoFlags.Coupling = 'Yes';
LocoFlags.Normalize = 'Yes';
LocoFlags.Dispersion = 'Yes';
LocoFlags.ResponseMatrixCalculatorFlag1 = 'Linear';
LocoFlags.ResponseMatrixCalculatorFlag2 = 'FixedPathLength';



%%%%%%%%%%%%%
% Save file %
%%%%%%%%%%%%%

% File check
[BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData] = locofilecheck({BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData});


% Save
save(OutputFileName, 'LocoModel', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags');


% Restore the old AT model
THERING = THERINGsave;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add the machine dependent stuff %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if exist('buildlocofitparameters', 'file')
    buildlocofitparameters(OutputFileName);
else
    fprintf('   buildlocofitparameters.m was not found so the FitParameters variable still needs to be created.\n');
end


