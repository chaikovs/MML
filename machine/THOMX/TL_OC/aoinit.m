function aoinit(SubMachineName)
%AOINIT - Initialization function for the Matlab Middle Layer (MML)
%
%
%  See Also soleilinit, setpathsoleil 

% Written by Laurent S. Nadolski



if exist('SubMachineName', 'var') && ~strcmpi(SubMachineName, 'TL_OC') %Modifiee par S.Chancé le 12/03/14 pour la correction d'orbite
    error('Wrong SubMachine %s', SubMachineName)
end

% The path should not be modified in standalone mode
if ~isdeployed_local

    MMLROOT = getmmlroot;
    MMLDATAROOT = getmmldataroot;
    
    %addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'LT2OpsData'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'TL_OC'));%Modifié pour correction d'orbite 12/03/14 S.Chancé
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'TL_OC', 'Lattices'));%Modifié pour correction d'orbite 12/03/14 S.Chancé
    addpath(fullfile(MMLROOT, 'machine', 'THOMX' , 'TL_OC', 'Orbit_TL_Correction_Final'));%Ajouté pour correction d'orbite 12/03/14 S.Chancé

    % Make sure mml is high on the path
    addpath(fullfile(MMLROOT, 'mml'),'-begin');

    %all these term related to Tango must be configure later...(17/07/2013@ ZHANG)
%    disp(['TANGO/MATLAB binding version: ' tango_version])
    disp('Startup file for Matlab Middle Layer read with success');

end

% Initialize the MML for machine

TLinit;

function RunTimeFlag = isdeployed_local
% isdeployed is not in matlab 6.5
V = version;
if str2double(V(1,1)) < 7
    RunTimeFlag = 0;
else
    RunTimeFlag = isdeployed;
end
