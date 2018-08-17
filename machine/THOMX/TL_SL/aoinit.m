function aoinit(SubMachineName)
%AOINIT - Initialization function for the Matlab Middle Layer (MML)
%
%
%  See Also TLinit, setpaththomx 

% Written by Laurent S. Nadolski
% Modified by Jianfeng Zhang for ThomX 
% Modified by Christelle Bruni

if exist('SubMachineName', 'var') && ~strcmpi(SubMachineName, 'TL') && ~strcmpi(SubMachineName, 'TL_SL')
    error('Wrong SubMachine %s', SubMachineName)
end

% The path should not be modified in standalone mode
if ~isdeployed_local

    MMLROOT = getmmlroot;
    MMLDATAROOT = getmmldataroot;
    
    %addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'LT2OpsData'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'TL_SL'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'TL_SL', 'lattices'));
    %addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'TL_SL', 'emittance'));

    % Make sure mml is high on the path
    addpath(fullfile(MMLROOT, 'mml'),'-begin');

    %all these term related to Tango must be configure later...(17/07/2013@ ZHANG)
%    disp(['TANGO/MATLAB binding version: ' tango_version])
    disp('Startup file for Matlab Middle Layer read with success');

end

% Initialize the MML for machine

TL_SLinit;

function RunTimeFlag = isdeployed_local
% isdeployed is not in matlab 6.5
V = version;
if str2double(V(1,1)) < 7
    RunTimeFlag = 0;
else
    RunTimeFlag = isdeployed;
end
