function MMLROOT = setmmldirectories(MachineName, SubMachineName, ModeName, OpsFileExtension,varargin)
%SETMMLDIRECTORIES Sets the directory in the Matlab middle layer
%  setmmldirectories(MachineName, SubMachineName, ModeName, OpsFileExtension)

%
%  Written by Greg Portmann
%  Modifed by Laurent S. Nadolski
%  DVPTFLAG added for work on hyperion

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Directories which define the data and opsdata tree %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

OPSDIR = 'OpsData';
if (nargin > 4 && strcmpi(varargin{1}, 'DVPT'))
    OPSDIR = 'DvptData';
end
    
AD = getad;

% MML directories
MMLROOT = getmmlroot;
MMLDATAROOT = getmmldataroot;
MMLCONFIGROOT = getmmlconfigroot;

% DataRoot Location
% Base on normal middle layer directory structure
AD.Directory.DataRoot = fullfile(MMLDATAROOT, 'machine',  MachineName, SubMachineName, 'Data', ModeName, filesep);

% Operational directory and physdata file
if iscontrolroom
    AD.Directory.OpsData    = fullfile(MMLCONFIGROOT, 'machine', MachineName, [SubMachineName, OPSDIR], ModeName, filesep);
    %AD.OpsData.PhysDataFile = [MMLROOT, 'machine', filesep, MachineName, filesep, SubMachineName, OPSDIR, filesep, 'physdata.mat'];
    AD.OpsData.PhysDataFile = fullfile(MMLCONFIGROOT, 'machine', MachineName, [SubMachineName, OPSDIR], 'physdata.mat');
else    
    AD.Directory.OpsData    = fullfile(MMLROOT, 'machine', MachineName, [SubMachineName, OPSDIR], ModeName, filesep);
    %AD.OpsData.PhysDataFile = [MMLROOT, 'machine', filesep, MachineName, filesep, SubMachineName, OPSDIR, filesep, 'physdata.mat'];
    AD.OpsData.PhysDataFile = fullfile(MMLROOT, 'machine', MachineName, [SubMachineName, OPSDIR], 'physdata.mat');
end

% Setpoints files
AD.Directory.ConfigData     = fullfile(MMLROOT, 'machine', MachineName, SubMachineName,'MachineConfig', filesep);

%Data Archive Directories
if ~strcmpi(SubMachineName, 'LT1') && ~strcmpi(SubMachineName, 'LT2')
    AD.Directory.BPMData        = fullfile(AD.Directory.DataRoot, 'BPM', filesep);
    AD.Directory.TuneData       = fullfile(AD.Directory.DataRoot, 'Tune', filesep);
    AD.Directory.ChroData       = fullfile(AD.Directory.DataRoot, 'Chromaticity', filesep);
    AD.Directory.DispData       = fullfile(AD.Directory.DataRoot, 'Dispersion', filesep);
    %AD.Directory.QMS            = [AD.Directory.DataRoot, 'QMS',           filesep];

    %Response Matrix Directories
    AD.Directory.BPMResponse    = fullfile(AD.Directory.DataRoot, 'Response', 'BPM', filesep);
    AD.Directory.TuneResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Tune', filesep);
    AD.Directory.ChroResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Chromaticity', filesep);
    AD.Directory.DispResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Dispersion', filesep);
    AD.Directory.SkewResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Skew', filesep);

    %Default Data File Prefix
    AD.Default.BPMArchiveFile   = 'BPM';                % File in AD.Directory.BPM               orbit data
    AD.Default.TuneArchiveFile  = 'Tune';               % File in AD.Directory.Tune              tune data
    AD.Default.ChroArchiveFile  = 'Chro';               % File in AD.Directory.Chromaticity      chromaticity data
    AD.Default.DispArchiveFile  = 'Disp';               % File in AD.Directory.Dispersion        dispersion data
end

AD.Default.CNFArchiveFile   = 'CNF';                % File in AD.Directory.CNF               configuration data

if ~strcmpi(SubMachineName, 'LT1') && ~strcmpi(SubMachineName, 'LT2')
    %Default Response Matrix File Prefix
    AD.Default.BPMRespFile      = 'BPMRespMat';         % File in AD.Directory.BPMResponse       BPM response matrices
    AD.Default.TuneRespFile     = 'TuneRespMat';        % File in AD.Directory.TuneResponse      tune response matrices
    AD.Default.ChroRespFile     = 'ChroRespMat';        % File in AD.Directory.ChroResponse      chromaticity response matrices
    AD.Default.DispRespFile     = 'DispRespMat';        % File in AD.Directory.DispResponse      dispersion response matrices
    AD.Default.SkewRespFile     = 'SkewRespMat';        % File in AD.Directory.SkewResponse      skew quadrupole response matrices
end

%Operational Files
AD.OpsData.LatticeFile   = ['GoldenLattice',    OpsFileExtension];

if ~strcmpi(SubMachineName, 'LT1') && ~strcmpi(SubMachineName, 'LT2')
    %Operational Files
    AD.OpsData.InjectionFile = ['InjectionConfig', OpsFileExtension];
    AD.OpsData.BPMSigmaFile  = ['GoldenBPMSigma',  OpsFileExtension];
    AD.OpsData.DispFile      = ['GoldenDisp',      OpsFileExtension];
    AD.OpsData.BPMGainAndCouplingFile = ['GoldenBPMGainCoupling', OpsFileExtension];

    %Operational Response Files
    AD.OpsData.BPMRespFile  = ['GoldenBPMResp',  OpsFileExtension];
    AD.OpsData.BPMResp4FOFBFile  = ['GoldenBPM4FOFBResp',  OpsFileExtension];
    AD.OpsData.TuneRespFile = ['GoldenTuneResp', OpsFileExtension];
    AD.OpsData.ChroRespFile = ['GoldenChroResp', OpsFileExtension];
    AD.OpsData.DispRespFile = ['GoldenDispResp', OpsFileExtension];
    AD.OpsData.SkewRespFile = ['GoldenSkewResp', OpsFileExtension];
    AD.OpsData.RespFiles     = {...
        fullfile(AD.Directory.OpsData, AD.OpsData.BPMRespFile), ...
        fullfile(AD.Directory.OpsData, AD.OpsData.BPMResp4FOFBFile), ...
        fullfile(AD.Directory.OpsData, AD.OpsData.TuneRespFile), ...
        fullfile(AD.Directory.OpsData, AD.OpsData.ChroRespFile), ...
        fullfile(AD.Directory.OpsData, AD.OpsData.DispRespFile), ...
        fullfile(AD.Directory.OpsData, AD.OpsData.SkewRespFile)};
end
% Save AD
setad(AD);
