function setoperationalmode(ModeNumber)
%SETOPERATIONALMODE - Switches between the various operational modes, and 
%  set the AD(Accelerator Data) storage path.
%
% setoperationalmode(ModeNumber)
%
%  Modified for ThomX by Jianfeng Zhang @ LAL, 22/06/2013
%
%  INPUTS
%  ModeNumber 1 = 
%               TDR_017_064_r56_02_Dff412_chro00
%  ModeNumber 2 = 
%               TDR_017_064_r56_02_Dff412_chro00
%  ModeNumber 3 = 
%               TDR_017_064_r56_02_Dff412
%
% 
%  ModeNumber 4 = 
%               TDR_017_064_r56_02_sx_Dff412_DipMagnL_SEPT_KICK
%                but with the definitions of septums and inj.&extr. kickers
%
%
%
%  See also aoinit, updateatindex, thomxinit, setmmldirectories, lattice_prep

%  NOTES
% use local_set_config_mode for defining status of S11 et S12;

%
% Written by Laurent S. Nadolski
% FOR CVS
% $Header$
global THERING

% Check if the AO exists
checkforao;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accelerator Dependent Modes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 1
    ModeNumber = [];
end
if isempty(ModeNumber)
    ModeCell = {...
        ' 1/ 50 MeV, 3.17 1.64, r56=0.2', ...
        ' 2/ 50 MeV, 3.17 1.64, r56=0.3', ...
        ' 3/ 50 MeV, 3.17 1.64, r56=0.4', ...
        ' 4/ 50 MeV, 3.17 1.64, r56=0.4 SEPT KICK', ...
        };
    [ModeNumber, OKFlag] = listdlg('Name','THOMX','PromptString','Select the Operational Mode:', ...
        'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [450 200], 'InitialValue', 1);
    if OKFlag ~= 1
        fprintf('   Operational mode not changed\n');
        return
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accelerator Data Structure %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AD = getad;
AD.Machine = 'THOMX';            % Will already be defined if setpathmml was used
AD.MachineType = 'StorageRing';   % Will already be defined if setpathmml was used %'Transport';
AD.SubMachine  = 'StorageRing';   % Will already be defined if setpathmml was used
AD.OperationalMode = '';          % Gets filled in later
AD.HarmonicNumber = 30;

% Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
% minimum orbit change 14 micro meter.
AD.DeltaRFDisp = 100e-6*1e2; % machine unit [MHz], 10000 Hz; called by measdisp.m
% the mcf of ThomX ring is 1.37e-2, so must have a relative large deltaRF,
% otherwise the change of energy offset is too small, and BPMs can't
% detect such a small orbit (BPM resolution is about 5 micro meters in ThomX ring).


AD.DeltaRFChro = 1*[ -100 -50 0 50 100 ] * 1e-6*1e2; % machine unit, [MHz]; -50*1e2 Hz


% Tune processor delay: delay required to wait
% to have a fresh tune measurement after changing
% a variable like the RF frequency.  Setpv will wait
% 2.2 * TuneDelay to be guaranteed a fresh data point.
%AD.BPMDelay  = 0.25; % use [N, BPMDelay]=getbpmaverages (AD.BPMDelay will disappear)
AD.TuneDelay = 1;

% The offset and golden orbits are stored at the end of this file
% TODO
%BuildOffsetAndGoldenOrbits;  % Local function


% SP-AM Error level
% AD.ErrorWarningLevel = 0 -> SP-AM errors are Matlab errors {Default}
%                       -1 -> SP-AM errors are Matlab warnings
%                       -2 -> SP-AM errors prompt a dialog box
%                       -3 -> SP-AM errors are ignored (ErrorFlag=-1 is returned)
AD.ErrorWarningLevel = 0;

%%%%%%%%%%%%%%%%%%%%%
% Operational Modes %
%%%%%%%%%%%%%%%%%%%%%

% Mode setup variables (mostly path and file names)
% AD.OperationalMode - String used in titles
% ModeName - String used for mode directory name off DataRoot/MachineName
% OpsFileExtension - string add to default file names

%% ModeNumber == 1, nu_x,y = 3.175/1.72
if ModeNumber == 1
    AD.OperationalMode = '50e-3 GeV, 3.169 1.639';
    AD.Energy = 50e-3; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'TDR_017_064_r56_02_Dff412_chro00';
    OpsFileExtension = 'TDR_017_064_r56_02_Dff412_chro00';

    
    % AT lattice
    AD.ATModel = 'test_lat';%'TDR_017_064_r56_02_Dff412_chro00';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    %3.169 1.639
    AO = getao;

AO.TUNE.Monitor.Golden = [
        0.1699
        0.6401
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [0.0; 0.0];
    
    % Status factory
    % don't need for ThomX ?????
    %local_set_config_mode('normalconfig120'); 
    AO = getao;
    local_setmagnetcoefficient( @magnetcoefficients);
    setao(AO);

elseif ModeNumber == 2
    AD.OperationalMode = '50e-3 GeV, 3.175 1.72';
    AD.Energy = 50e-3; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'TDR_017_064_r56_02_Dff412_chro11';
    OpsFileExtension = 'TDR_017_064_r56_02_Dff412_chro11';

    % AT lattice
    AD.ATModel = 'TDR_017_064_r56_02_Dff412_chro11';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
 
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.169
        0.639
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.0; 1.0];
    
    elseif ModeNumber == 3
    AD.OperationalMode = '50e-3 GeV, 3.175 1.72';
    AD.Energy = 50e-3; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'TDR_017_064_r56_02_Dff412';
    OpsFileExtension = 'TDR_017_064_r56_02_Dff412';

    % AT lattice
    AD.ATModel = 'TDR_017_064_r56_02_Dff412';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
 
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.169
        0.639
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [0.0; 0.0];
               
    elseif ModeNumber == 4
    AD.OperationalMode = '50e-3 GeV, 3.175 1.72';
    AD.Energy = 50e-3; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'TDR_017_064_r56_02_sx_Dff412_DipMagnL_SEPT_KICK';
    OpsFileExtension = '_TDR_017_064_r56_02_sx_Dff412_DipMagnL_SEPT_KICK';

    % AT lattice
    AD.ATModel = 'TDR_017_064_r56_02_sx_Dff412_DipMagnL_SEPT_KICK';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
 
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.169
        0.639
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [0.0; 0.0];
               
               
 else
    error('Operational mode unknown');
end

% Force units to hardware
switch2hw;


% Set the AD directory path
setad(AD);
MMLROOT = setmmldirectories(AD.Machine, AD.SubMachine, ModeName, OpsFileExtension);
AD = getad;


% Top Level Directories

MMLDATAROOT = getmmldataroot;
AD.Directory.DataRoot       = fullfile(MMLDATAROOT, 'measdata', 'THOMX', 'StorageRingdata', filesep);
AD.Directory.Lattice        = fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'Lattices', filesep);
AD.Directory.Orbit          = fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing',  'orbit', filesep);

% Data Archive Directories DO NOT REMOVE LINES
AD.Directory.BeamUser       = fullfile(AD.Directory.DataRoot, 'BPM', 'BeamUser', filesep); %store saved orbit for operation (every new beam)
AD.Directory.BPMData        = fullfile(AD.Directory.DataRoot, 'BPM', filesep);
AD.Directory.TuneData       = fullfile(AD.Directory.DataRoot, 'Tune', filesep);
AD.Directory.ChroData       = fullfile(AD.Directory.DataRoot, 'Chromaticity', filesep);
AD.Directory.DispData       = fullfile(AD.Directory.DataRoot, 'Dispersion', filesep);
AD.Directory.ConfigData     = fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'MachineConfig', filesep);
AD.Directory.BumpData       = fullfile(AD.Directory.DataRoot, 'Bumps', filesep);
AD.Directory.Archiving      = fullfile(AD.Directory.DataRoot, 'ArchivingData', filesep);
AD.Directory.QUAD           = fullfile(AD.Directory.DataRoot, 'QUAD', filesep);
AD.Directory.BBA            = fullfile(AD.Directory.DataRoot, 'BBA', filesep);
AD.Directory.BBAcurrent     = fullfile(AD.Directory.BBA, 'dafault' ,filesep);
AD.Directory.Synchro        = fullfile(MMLROOT, 'machine', 'THOMX', 'common', 'synchro', filesep);
AD.Directory.LOCOData       = fullfile(AD.Directory.DataRoot, 'LOCO', filesep);


% STANDALONE matlab applications
AD.Directory.Standalone     = fullfile(MMLROOT, 'machine', 'THOMX', 'standalone_applications', filesep);


% For coupling correction. Used by coupling.m
%AD.Directory.Coupling     = fullfile(AD.Directory.DataRoot, 'SkewQuad', 'solution_QT');

% AD.Directory.InterlockData  = fullfile(AD.Directory.DataRoot, 'Interlock/'];

%Response Matrix Directories
AD.Directory.BPMResponse    = fullfile(AD.Directory.DataRoot, 'Response', 'BPM', filesep);
AD.Directory.TuneResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Tune', filesep);
AD.Directory.ChroResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Chrom', filesep);
AD.Directory.DispResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Disp', filesep);
AD.Directory.SkewResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Skew', filesep);

% used by energytunette
AD.Directory.BPMTransport   = fullfile(AD.Directory.DataRoot, 'Transport', 'BPM', filesep);
% used by MAT's Steerette application
AD.Directory.Steerette     = fullfile(AD.Directory.DataRoot, 'Transport', 'Steerette', filesep);


%Default Data File Prefix
AD.Default.BPMArchiveFile      = 'BPM';                %file in AD.Directory.BPM               orbit data
AD.Default.TuneArchiveFile     = 'Tune';               %file in AD.Directory.Tune              tune data
AD.Default.ChroArchiveFile     = 'Chro';               %file in AD.Directory.Chromaticity       chromaticity data
AD.Default.DispArchiveFile     = 'Disp';               %file in AD.Directory.Dispersion       dispersion data
AD.Default.CNFArchiveFile      = 'CNF';                %file in AD.Directory.CNF               configuration data
AD.Default.QUADArchiveFile     = 'QuadBeta';           %file in AD.Directory.QUAD             betafunction for quadrupoles
%AD.Default.SkewArchiveFile     = 'SkewQuad';           %file in AD.Directory.SkewQuad             SkewQuad data
AD.Default.BBAArchiveFile      = 'BBA_DKmode';         %file in AD.Directory.BBA             BBA DK mode data

%Default Response Matrix File Prefix
AD.Default.BPMRespFile      = 'BPMRespMat';         %file in AD.Directory.BPMResponse       BPM response matrices
AD.Default.TuneRespFile     = 'TuneRespMat';        %file in AD.Directory.TuneResponse      tune response matrices
AD.Default.ChroRespFile     = 'ChroRespMat';        %file in AD.Directory.ChroResponse      chromaticity response matrices
AD.Default.DispRespFile     = 'DispRespMat';        %file in AD.Directory.DispResponse      dispersion response matrices
%AD.Default.SkewRespFile     = 'SkewRespMat';        %file in AD.Directory.SkewResponse      skew quadrupole response matrices

%Orbit Control and Feedback Files
AD.Restore.GlobalFeedback   = 'Restore.m';

% Circumference
AD.Circumference = findspos(THERING,length(THERING)+1);
setad(AD);

% Updates the AT indices in the MiddleLayer with the present AT lattice
updateatindex;

% Set the model energy
setenergymodel(AD.Energy);


% Momentum compaction factor
MCF = getmcf('Model');
if isnan(MCF)
    AD.MCF = 1.39e-02;%1.24e-02;
    fprintf('   Model alpha calculation failed, middlelayer alpha set to  %f\n', AD.MCF);
else
    AD.MCF = MCF;
    fprintf('   Middlelayer alpha set to %f (AT model).\n', AD.MCF);
end
setad(AD);


% Add Gain & Offsets for magnet family
fprintf('   Setting magnet monitor gains based on the production lattice.\n');
%setgainsandoffsets;

%% Config texttalker (right location ?), what's it?
%AD.TANGO.TEXTTALKERS={'ans/ca/texttalker.1', 'ans/ca/texttalker.2'};

% set LOCO gain and roll to zero
%setlocodata('Nominal');

%%%%%%%%%%%%%%%%%%%%%%
% Final mode changes %
%%%%%%%%%%%%%%%%%%%%%%
if any(ModeNumber == [99])
    % User mode - 0.05 GeV, Nominal lattice

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Add LOCO Parameters to AO and AT-Model %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     'Nominal'    - Sets nominal gains (1) / rolls (0) to the model.
    %     'SetGains'   - Set gains/coupling from a LOCO file.
    %     'SetModel'   - Set the model from a LOCO file.  But it only changes
    %                    the part of the model that does not get corrected
    %                    in 'Symmetrize' (also does a SetGains).
    %     'LOCO2Model' - Set the model from a LOCO file (also does a SetGains).
    %                    This sets all lattice machines fit in the LOCO run to the model.
    %
    % Basically, use 'SetGains' or 'SetModel' if the LOCO run was applied to the accelerator
    %            use 'LOCO2Model' if the LOCO run was made after the final setup

    % Store the LOCO file in the opsdata directory

    % MCF depends on optics !!!

    AD.OpsData.LOCOFile = [getfamilydata('Directory','OpsData'),'LOCO_163Quads_122BPMs']; % =>>>>>>> see the file for thomx
    
    try % TO BE DONE LATER IN 2012
        setlocodata('LOCO2Model', AD.OpsData.LOCOFile);
    catch
        fprintf('\n%s\n\n', lasterr);
        fprintf('   WARNING: there was a problem calibrating the model based on LOCO file %s.\n', AD.OpsData.LOCOFile);
    end

else
    setlocodata_example('Nominal');  % <<<======= setlocodata was changed to setlocodata_example
end

fprintf('   lattice files have changed or if the AT lattice has changed.\n');
fprintf('   Middlelayer setup for operational mode: %s\n', AD.OperationalMode);

setad(orderfields(AD));

end

%% There were two functions local_set_config_mode(configmode) and local_setmagnetcoefficient(magnetcoeff_function)

function local_setmagnetcoefficient(magnetcoeff_function)
% quadrupole magnet coefficients
% number of status 1 quadrupole families

AO = getao;
    
quadFamList = {'QP1', 'QP2','QP3','QP4','QP31','QP41'};
        
    
for k = 1:length(quadFamList),
        ifam = quadFamList{k};

        HW2PhysicsParams = feval(magnetcoeff_function, AO.(ifam).FamilyName);
        Physics2HWParams = HW2PhysicsParams;

        nb = size(AO.(ifam).DeviceName,1);

        for ii=1:nb,
            val = 1.0;
            AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)                 = HW2PhysicsParams;
            AO.(ifam).Monitor.HW2PhysicsParams{2}(ii,:)                 = val;
            AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)                 = Physics2HWParams;
            AO.(ifam).Monitor.Physics2HWParams{2}(ii,:)                 = val;
            AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)                = HW2PhysicsParams;
            AO.(ifam).Setpoint.HW2PhysicsParams{2}(ii,:)                = val;
            AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)                = Physics2HWParams;
            AO.(ifam).Setpoint.Physics2HWParams{2}(ii,:)                = val;
        end
end

% sextupole magnet coefficients
% number of status 1 sextupole families
% sextuFamList = {'SX1', 'SX2', 'SX3'}
%    
% 
% for k = 1:length(sextuFamList),
%         ifam = sextuFamList{k};
%         
%         HW2PhysicsParams = feval(magnetcoeff_function, AO.(ifam).FamilyName);
%         Physics2HWParams = HW2PhysicsParams;
%         
%         val = 1.0;
%         AO.(ifam).Monitor.HW2PhysicsParams{1}(1,:)                 = HW2PhysicsParams;
%         AO.(ifam).Monitor.HW2PhysicsParams{2}(1,:)                 = val;
%         AO.(ifam).Monitor.Physics2HWParams{1}(1,:)                 = Physics2HWParams;
%         AO.(ifam).Monitor.Physics2HWParams{2}(1,:)                 = val;
%         AO.(ifam).Setpoint.HW2PhysicsParams{1}(1,:)                 = HW2PhysicsParams;
%         AO.(ifam).Setpoint.HW2PhysicsParams{2}(1,:)                 = val;
%         AO.(ifam).Setpoint.Physics2HWParams{1}(1,:)                 = Physics2HWParams;
%         AO.(ifam).Setpoint.Physics2HWParams{2}(1,:)                 = val;
% end
setao(AO);

end


