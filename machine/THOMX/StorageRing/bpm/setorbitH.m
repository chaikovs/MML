function OCS = setorbitH(varargin)
%SETORBITH - Correct the horizontal orbit
%
%  INPUTS
%  1. GoalOrbit - Goal orbit (vector or cell array (if BPM is a cell array))
%                'Golden' for the golden orbit {Default}
%                'Offset' for the offset orbit
%  2. BPM - BPMDevList
%  3. CM - CMDevList
%  4. SVDIndex - vector, maximum number, 'All', or
%                base on a threshold of min/max singular value {Default: 1e-3}
%  5. NIter - Number of iterations  {Default: 1}
%            (NIter can be 0, see note 1 below)
%  6. BPMWeight - Weight applied to the BPMs (OCS.BPMWeight)
%  7. FLAGS  - 'Abs' or 'Absolute' - GoalOrbit is an absolute orbit {Default}
%              'Inc' or 'Incremental' - GoalOrbit is a incremental change
%              'ModelResp' - calculate the model response matrix {Default: measured response matrix}
%              'SetSP' - Make the setpoint change {Default}
%              'NoSetSP' - Don't set the magnets, just return the OCS
%              'Display' - plot orbit information before applying the correction
%              'FitRF' - Fit and change the RF frequency (use rmdisp before
%                        calling this function to remove the dispersion orbit)
%              'MeasDisp' - measure the dispersion  {Default}
%              'ModelDisp' - calculate the model dispersion
%              'GoldenDisp' - use the golden dispersion
%              'TypeFlag' - 'SOFB' {Default} or 'FOFB'
%              And the usual Units and Mode flags
%
%  OUTPUTS
%  1. OCS    - New orbit correction structure (OCS)
%
%  See Also setorbit, setorbitV

%
%% Written by Laurent S. Nadolski

TypeFlag = 'SOFB';
GoldenFlag = 0;
% Default BPM Family
BPMFamily = 'BPMx';
BPMlist = [];

% Default corrector
CMlist = [];

OCSFlags    = [];
InputFlags  = [];

% Defaults values
OCS.NIter           = 1; % Number of iteration
OCS.SVDIndex        = 12; % number of eigenvector for correction
OCS.IncrementalFlag = 'No';
OCS.FitRF       = 0; % take RF as a corrector

% Input parsing
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignore structures
    elseif iscell(varargin{i})
        % Ignore cells
    elseif strcmpi(varargin{i},'Golden')
        % Use the golden orbit
        GoldenFlag    = 1;
        OCS.GoalOrbit = 'Golden';
        OCSFlags      = [OCSFlags varargin(i)];
        varargin(i)   = [];
    elseif strcmpi(varargin{i},'Offset')
        % Use the offset orbit
        OCS.GoalOrbit = 'Offset';
        OCSFlags      = [OCSFlags varargin(i)];
        varargin(i)   = [];
    elseif strcmpi(varargin{i},'Display')
        OCSFlags    = [OCSFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay') || ...
            strcmpi(varargin{i},'No Display')
        InputFlags  = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'ModelResp')
        OCSFlags      = [OCSFlags varargin(i)];
        varargin(i)   = [];
    elseif strcmpi(varargin{i},'FitRF')
        OCSFlags    = [OCSFlags varargin(i)];
        OCS.SVDIndex =  OCS.SVDIndex + 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'ModelDisp')
        OCSFlags    = [OCSFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'MeasDisp')
        OCSFlags    = [OCSFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'GoldenDisp')
        OCSFlags    = [OCSFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Inc') || strcmpi(varargin{i},'Incremental')
        OCSFlags        = [OCSFlags varargin(i)];
        varargin(i)     = [];
    elseif strcmpi(varargin{i},'Abs') || strcmpi(varargin{i},'Absolute')
        OCSFlags        = [OCSFlags varargin(i)];
    elseif strcmpi(varargin{i},'SetSP')
        InputFlags  = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoSetSP')
        InputFlags  = [InputFlags varargin{i}];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Simulator') || strcmpi(varargin{i},'Model')
        OCSFlags    = [OCSFlags varargin(i)];
        InputFlags  = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        OCSFlags    = [OCSFlags varargin(i)];
        InputFlags  = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Manual')
        OCSFlags    = [OCSFlags varargin(i)];
        InputFlags  = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Physics')
        OCSFlags    = [OCSFlags varargin(i)];
        InputFlags  = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Hardware')
        OCSFlags    = [OCSFlags varargin(i)];
        InputFlags  = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Archive')
        % Just remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'noarchive')
        % Just remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'struct')
        % Just remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        % Just remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'FOFB')
        TypeFlag = 'FOFB';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'SOFB')
        TypeFlag = 'SOFB';
        varargin(i) = [];
    end
end

% switchard for typical orbit correction at SOLEIL ===>>>> see the needs
% for ThomX
switch TypeFlag
    case 'FOFB'
        % number of eigenvector for correction
        OCS.SVDIndex        = 12; 
        % Default corrector Family
        CMFamily  = 'FHCOR';
    case 'SOFB'
        % number of eigenvector for correction
        OCS.SVDIndex        = 12; 
        % Default corrector Family
        CMFamily  = 'HCOR';
    otherwise
        error('TypeFlag invalid')
end

% Get Goal orbit
if length(varargin) >= 1 && ~GoldenFlag
    OCS.GoalOrbit = varargin{1};
    varargin(1) = [];
end

% Get BPM knobs
if length(varargin) >= 1
    BPMlist = varargin{1};
    varargin(1) = [];
end

% Get CM knobs
if length(varargin) >= 1
    CMlist = varargin{1};
    varargin(1) = [];
end

% Get SVDIndex
if length(varargin) >= 1
    OCS.SVDIndex = varargin{1};
    varargin(1) = [];
end

% Get NIter
if length(varargin) >= 1
    OCS.NIter = varargin{1};
    varargin(1) = [];
end

% Get BPMWeight
if length(varargin) >= 1
    OCS.BPMWeight = varargin{1};
    varargin(1) = [];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build up Orbit correction Structures   %
%  for setorbit programme : OCSx and OCSy%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ORBIT CORRECTION STRUCTURE (OCS)
%    OCS.BPM (data structure)
%    OCS.CM  (data structure)
%    OCS.GoalOrbit
%    OCS.NIter
%    OCS.SVDIndex
%    OCS.IncrementalFlag = 'Yes'/'No'
%    OCS.BPMWeight
%    OCS.Flags = { 'FitRF' , etc.  }

% Horizontal plane
OCS.BPM = getx(BPMlist, 'struct');

if ~isfield(OCS, 'GoalOrbit')|| any(isnan(OCS.GoalOrbit))
    Xgoal = getgolden(BPMFamily, BPMlist);
    OCS.GoalOrbit = Xgoal;
end

OCS.CM = getsp(CMFamily, CMlist, 'struct');
OCS.Flags = OCSFlags;

if isempty(InputFlags)
    OCS = setorbit(OCS);
else
    OCS = setorbit(OCS,InputFlags);
end
