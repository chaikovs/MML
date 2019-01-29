function setlocodata(CommandInput, FileName)
%SETLOCODATA - Applies the LOCO calibration data to both the middle layer & the accelerator
%  setlocodata(CommandInput, FileName)
%
%  INPUTS
%  1. CommandInput
%     'Nominal'    - Sets nominal gains (1) / rolls (0) to the model (BPM/correctors).
%     'SetGains'   - Set gains/coupling from a LOCO file.
%     'Symmetrize' - Symmetry correction of the lattice based on a LOCO file.
%     'CorrectCoupling' - Coupling correction of the lattice based on a LOCO file.
%     'SetModel'   - Set the model from a LOCO file.  But it only changes
%                    the part of the model that does not get corrected
%                    in 'Symmetrize' (also does a SetGains).
%     'LOCO2Model' - Set the model from a LOCO file (also does a 'SetGains').
%                    This sets all lattice machines fit in the LOCO run to the model.
%  2. FileName - LOCO file name {Default: getfamilydata('OpsData', 'LOCOFile')}
%                '' to browse for a file
%
%  NOTES
%  The set of data used will be the last iteration present in the LOCO file
%  How one uses this function depends on how LOCO was setup.
%  1. Use setlocodata('Nominal') if no model calibration information is known.
%  2. The most typical situation is to apply:
%         setlocodata('Symmetrize') to the accelerator
%         setlocodata('SetModel')   to the middle layer (usually done in setoperationalmode)
%  3. If a LOCO run was done on the present lattice with no changes made to lattice
%     after LOCO run, then setting all the LOCO fits to the model makes sense.
%         setlocodata('LOCO2Model')
%  4. This function obviously has machine dependent parts.
%
% See Also plotlocodata, gcr2loco, getgain, getroll, getcrunch


%
%  Written by Greg Portmann


global THERING

if nargin < 1
    %CommandInput = 'Default';
    ModeCell = {'Nominal - Set Gain=1 & Rolls=0 in the model', 'SetGains - Set gains/rolls from a LOCO file','Symmetrize - Symmetry correction of the lattice', 'CorrectCoupling - Coupling correction of the lattice', 'SetModel - Set the model from a LOCO file','LOCO2Model - Set the model from a LOCO file (also does a SetGains)', 'see "help setlocodata" for more details'};
    [ModeNumber, OKFlag] = listdlg('Name','Soleil','PromptString', ...
        'Select the proper set LOCO data command:', ...
        'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [500 200]);
    if OKFlag ~= 1
        fprintf('   setlocodata cancelled\n');
        return
    end
    if ModeNumber == 1
        CommandInput = 'Nominal';
    elseif ModeNumber == 2
        CommandInput = 'SetGains';
    elseif ModeNumber == 3
        CommandInput = 'Symmetrize';
    elseif ModeNumber == 4
        CommandInput = 'CorrectCoupling';
    elseif ModeNumber == 5
        CommandInput = 'SetModel';
    elseif ModeNumber == 6
        CommandInput = 'LOCO2Model';
    elseif ModeNumber == 7
        help setlocodata;
        return
    end
end


if nargin < 2
    % Default (Golden) LOCO file
    % If empty, the user will be prompted if needed.
    FileName = getfamilydata('OpsData','LOCOFile');
end


% Device list
BPMxFamily = 'BPMx';

BPMxDeviceList = family2dev(BPMxFamily);
BPMxDeviceListTotal = family2dev(BPMxFamily,0);

BPMzFamily = 'BPMz';
BPMzDeviceList = family2dev(BPMzFamily);
BPMzDeviceListTotal = family2dev(BPMzFamily,0);

HCMFamily = 'HCOR';
HCMDeviceList = family2dev(HCMFamily);
HCMDeviceListTotal = family2dev(HCMFamily,0);

VCMFamily = 'VCOR';
VCMDeviceList = family2dev(VCMFamily);
VCMDeviceListTotal = family2dev(VCMFamily,0);


if any(strcmpi(CommandInput, 'Nominal'))
    fprintf('   Using nominal BPM and corrector Gain=1 and Roll=0\n');

    % To speed things up, put Gains/Rolls/etc in the AO
    AO = getao;

    % Zero or one the gains and rolls
    AO.(BPMxFamily).Gain   = ones(size(BPMxDeviceListTotal,1),1);
    AO.(BPMzFamily).Gain   = ones(size(BPMzDeviceListTotal,1),1);
    AO.(BPMxFamily).Roll   = zeros(size(BPMxDeviceListTotal,1),1);
    AO.(BPMzFamily).Roll   = zeros(size(BPMzDeviceListTotal,1),1);
    AO.(BPMxFamily).Crunch = zeros(size(BPMxDeviceListTotal,1),1);
    AO.(BPMzFamily).Crunch = zeros(size(BPMzDeviceListTotal,1),1);

    AO.(VCMFamily).Gain = ones(size(HCMDeviceListTotal,1),1);
    AO.(HCMFamily).Gain = ones(size(VCMDeviceListTotal,1),1);
    AO.(VCMFamily).Roll = zeros(size(HCMDeviceListTotal,1),1);
    AO.(HCMFamily).Roll = zeros(size(VCMDeviceListTotal,1),1);


    % Set the roll, crunch to the AT model to be used by getpvmodel, setpvmodel, etc
    setatfield(BPMxFamily, 'GCR', [AO.(BPMxFamily).Gain AO.(BPMzFamily).Gain ...
              AO.(BPMxFamily).Crunch AO.(BPMxFamily).Roll], BPMxDeviceListTotal);

    % Set the gains to the AT model to be used by getpvmodel, setpvmodel, etc
    % Make sure the Roll field is 1x2 even for single plane correctors

    % First set the cross planes to zero
    setatfield(HCMFamily, 'Roll', 0*AO.(HCMFamily).Roll, HCMDeviceListTotal, 1, 2);
    setatfield(VCMFamily, 'Roll', 0*AO.(VCMFamily).Roll, VCMDeviceListTotal, 1, 1);

    % Then set the roll field
    setatfield(HCMFamily, 'Roll', AO.(HCMFamily).Roll, HCMDeviceListTotal, 1, 1);
    setatfield(VCMFamily, 'Roll', AO.(VCMFamily).Roll, VCMDeviceListTotal, 1, 2);

    setao(AO);


elseif any(strcmpi(CommandInput, 'SetGains'))

    if isempty(FileName) || strcmp(FileName, '.')
        if isempty(FileName)
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?', [getfamilydata('Directory','DataRoot'), 'LOCO', filesep]);
        else
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?');
        end
        drawnow;
        if isequal(FileName,0) || isequal(DirectoryName,0)
            fprintf('   setlocodata canceled\n');
            return
        end
        FileName = [DirectoryName FileName];
    end

    % Set the model gains
    setlocodata('Nominal');

    AO = getao;

    % Load the LOCO data
    fprintf('   Setting BPM and corrector gains and rolls based on %s.\n', FileName);
    load(FileName);


    % Get the device list from the LOCO file
    try
        BPMxDeviceList = LocoMeasData.HBPM.DeviceList;
        BPMzDeviceList = LocoMeasData.VBPM.DeviceList;
        HCMDeviceList  = LocoMeasData.HCM.DeviceList;
        VCMDeviceList  = LocoMeasData.VCM.DeviceList;
    catch errRecord
        % Legacy
        BPMxDeviceList = LocoMeasData.HBPM.DeviceList;
        BPMzDeviceList = LocoMeasData.VBPM.DeviceList;
        HCMDeviceList  = LocoMeasData.HCM.DeviceList;
        VCMDeviceList  = LocoMeasData.VCM.DeviceList;
    end


    % Change to Gain, Roll, Crunch system (Need to add a logic for single view BPMs???)
    i = findrowindex(BPMxDeviceList, BPMxDeviceListTotal);
    for j = 1:length(BPMData(end).HBPMGain)
        MLOCO = [BPMData(end).HBPMGain(j)     BPMData(end).HBPMCoupling(j)
                 BPMData(end).VBPMCoupling(j) BPMData(end).VBPMGain(j) ];
        [AO.(BPMxFamily).Gain(i(j),:), AO.(BPMzFamily).Gain(i(j),:), AO.(BPMxFamily).Crunch(i(j),:), AO.(BPMxFamily).Roll(i(j),:)] = loco2gcr(MLOCO);
    end
    AO.(BPMzFamily).Roll   = AO.(BPMxFamily).Roll;
    AO.(BPMzFamily).Crunch = AO.(BPMxFamily).Crunch;

    if ~isreal(AO.(BPMxFamily).Gain)
        error('Horizontal BPM gain is complex.');
    end
    if ~isreal(AO.(BPMzFamily).Gain)
        error('Vertical BPM gain is complex.');
    end
    if ~isreal(AO.(BPMxFamily).Crunch)
        error('BPM Crunch is complex.');
    end
    if ~isreal(AO.(BPMxFamily).Roll)
        error('BPM roll is complex.');
    end



    %%%%%%%%%%%%%%
    % Correctors %
    %%%%%%%%%%%%%%

    % Kick strength (LOCO is in milliradian)
    % LOCO is run with the original gain in hw2physics (stored in LocoMeasData.VCMGain/LocoMeasData.HCMGain).
    % The new gain must combine the new CM gain and the one used in buildlocoinput.
    % hw2physics:  Rad = G * amps   (original)
    % LOCO gain:   Gloco = KickNew/KickStart
    % New hw2physics gain: Gloco * G

    % HCM
    i = findrowindex(HCMDeviceList, HCMDeviceListTotal);

    HCMGainOldLOCO  = LocoMeasData.HCMGain .* cos(LocoMeasData.HCMRoll);
    HCMGainLOCO     = HCMGainOldLOCO .* CMData(end).HCMKicks ./ CMData(1).HCMKicks;
    HCMCouplingLOCO = HCMGainLOCO .* CMData(end).HCMCoupling;

    %AO.(HCMFamily).Roll(i) = atan2(-HCMCouplingLOCO, HCMGainLOCO);
    AO.(HCMFamily).Roll(i) = atan(HCMCouplingLOCO ./ abs(HCMGainLOCO));
    AO.(HCMFamily).Gain(i) = sign(HCMGainLOCO) .* sqrt(HCMCouplingLOCO.^2 + HCMGainLOCO.^2);


    % VCM
    i = findrowindex(VCMDeviceList, VCMDeviceListTotal);

    VCMGainOldLOCO  = LocoMeasData.VCMGain .* cos(LocoMeasData.VCMRoll);
    VCMGainLOCO     = VCMGainOldLOCO .* CMData(end).VCMKicks ./ CMData(1).VCMKicks;
    VCMCouplingLOCO = VCMGainLOCO .* CMData(end).VCMCoupling;

    %AO.(VCMFamily).Roll(i) = atan2(-VCMCouplingLOCO, VCMGainLOCO);
    AO.(VCMFamily).Roll(i) = atan(-VCMCouplingLOCO ./ abs(VCMGainLOCO));
    AO.(VCMFamily).Gain(i) = sign(VCMGainLOCO) .* sqrt(VCMCouplingLOCO.^2 + VCMGainLOCO.^2);


    % Set the roll, crunch to the AT model to be used by getpvmodel, setpvmodel, etc
    setatfield(BPMxFamily, 'GCR', [AO.(BPMxFamily).Gain AO.(BPMzFamily).Gain AO.(BPMxFamily).Crunch AO.(BPMxFamily).Roll], BPMxDeviceListTotal);

    % Set the gains to the AT model to be used by getpvmodel, setpvmodel, etc
    % Make sure the Roll field is 1x2 even for single plane correctors

    % First set the cross planes to zero
    setatfield(HCMFamily, 'Roll', 0*AO.(HCMFamily).Roll, HCMDeviceListTotal, 1, 2);
    setatfield(VCMFamily, 'Roll', 0*AO.(VCMFamily).Roll, VCMDeviceListTotal, 1, 1);

    % Then set the roll field
    setatfield(HCMFamily, 'Roll', AO.(HCMFamily).Roll, HCMDeviceListTotal, 1, 1);
    setatfield(VCMFamily, 'Roll', AO.(VCMFamily).Roll, VCMDeviceListTotal, 1, 2);


    % If other magnet fits were done (like roll), it should be add to the AT model as well

    setao(AO);


elseif any(strcmpi(CommandInput, 'SetModel'))

    % Some LOCO errors are applied to the accelerator 'SetMachine' and some
    % go to the model.  If errors detected by LOCO are not applied to the accelerator,
    % then include them in the AT and Middle Layer model.

    % The assumption is that setlocodata('SetMachine') has already been run.
    % So QF, QD, QFA, QDA, SQSF, SQSD have changed in the accelerator to match
    % the LOCO run.

    if isempty(FileName) || strcmp(FileName, '.')
        if isempty(FileName)
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?', [getfamilydata('Directory','DataRoot'), 'LOCO', filesep]);
        else
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?');
        end
        drawnow;
        if isequal(FileName,0) || isequal(DirectoryName,0)
            fprintf('   setlocodata canceled\n');
            return
        end
        FileName = [DirectoryName FileName];
    end


    % Load the LOCO data
    load(FileName);


    % Set the model gains
    setlocodata('SetGains', FileName);


elseif any(strcmpi(CommandInput, 'SetMachine'))

    if isempty(FileName) || strcmp(FileName, '.')
        if isempty(FileName)
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?', [getfamilydata('Directory','DataRoot'), 'LOCO', filesep]);
        else
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?');
        end
        drawnow;
        if isequal(FileName,0) || isequal(DirectoryName,0)
            fprintf('   setlocodata canceled\n');
            return
        end
        FileName = [DirectoryName FileName];
    end

    % Load the LOCO data
    load(FileName);
    
    le = length(FitParameters);
    fprintf('  The last iteration present in LOCO file is used\n');

    QFamilies = findmemberof('QUAD');

    ioffset = 0;
    for k=1:length(QFamilies),
        ifam = QFamilies{k};
        if family2status(ifam)
            nquad = length(family2dev(ifam));
            iparam = (1:length(family2dev(ifam)))+ioffset;
            ioffset = iparam(end);
            Qscale = FitParameters(le).Values(iparam)./FitParameters(1).Values(iparam);
            setsp(ifam, getsp(ifam).*Qscale);
        end
    end

elseif any(strcmpi(CommandInput, 'CorrectCoupling'))

    if isempty(FileName) || strcmp(FileName, '.')
        if isempty(FileName)
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?', [getfamilydata('Directory','DataRoot'), 'LOCO', filesep]);
        else
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?');
        end
        drawnow;
        if isequal(FileName,0) || isequal(DirectoryName,0)
            fprintf('   setlocodata canceled\n');
            return
        end
        FileName = [DirectoryName FileName];
    end

    
    % Load the LOCO data
    load(FileName);

    NQT = size(family2dev('QT'),1); 
    fprintf('   Correcting the coupling based on LOCO file %s.\n', FileName);
    fprintf('   It is assumed that the QT are in FitParameters.Values(end-%d:end)\n', NQT-1);

    QT = FitParameters(end).Values(end-(NQT-1):end);

    % Starting point for the skew quadrupoles when LOCO data was measured
    MachineConfig = LocoMeasData.MachineConfig;
    setpv(MachineConfig.QT.Setpoint);

    QThw = physics2hw('QT', 'Setpoint', -QT);

    % Maximum setpoint check
    if any(abs(MachineConfig.QT.Setpoint.Data+QThw)>maxsp('QT'))
        error('At least one of the QT would go beyond it''s limit ... aborting coupling correction');
    end

    % Make the setpoint change
    stepsp('QT', QThw);

    % Keep the change?
    CorrectFlag = questdlg('Keep the new skew quadrupole setpoints or return to the old values?','SETLOCOGAINS(''CorrectCoupling'')','Keep this lattice','Restore Old Lattice','Keep this lattice');
    if strcmpi(CorrectFlag, 'Restore Old Lattice') || isempty(CorrectFlag)
        fprintf('   Changing the skew quadrupole magnets back to the original setpoints.\n');
        stepsp('QT', QThw);
    end


elseif any(strcmpi(CommandInput, 'LOCO2Model'))

    % LOCO is usually used to correct the model.  If the LOCO fit parameters are
    % not applied to the accelerator, then the entire model needs to be updated.
    % Ie, the machine lattice file is the same as it was when the LOCO data was
    % taken, then put the LOCO output settings in the model.

    if isempty(FileName) || strcmp(FileName, '.')
        if isempty(FileName)
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?', [getfamilydata('Directory','DataRoot'), 'LOCO', filesep]);
        else
            [FileName, DirectoryName] = uigetfile('*.mat', 'LOCO Output File Name?');
        end
        drawnow;
        if isequal(FileName,0) || isequal(DirectoryName,0)
            fprintf('   setlocodata canceled\n');
            return
        end
        FileName = [DirectoryName FileName];
    end


    % Load the LOCO data
    load(FileName);


    % Use loco file for the lattice and the fit parameter
    % Using everything in the loco lattice may not be what you want!
    global THERING
    RINGData.Lattice = THERING;
    for i = 1:length(FitParameters(end).Params)
        RINGData = locosetlatticeparam(RINGData, FitParameters(end).Params{i}, FitParameters(end).Values(i));
    end
    THERING = RINGData.Lattice;


    % Since the lattice may have changed
    %updateatindex;

    % Set the model gains (this added GCR, Roll field to lattice)
    setlocodata('SetGains', FileName);

else
    warning('Unkown option');
    help mfilename
end