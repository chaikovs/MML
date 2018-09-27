function  [DelSext, ActuatorFamily] = stepchro(varargin)
%STEPCHRO - Incremental change in the chromaticity (Delta Tune / Delta RF)
%  [DelSext, SextFamily] = stepchro(DeltaChromaticity, ChroResponseMatrix)
%
%  Step change in storage ring chromaticity using the default chromaticty correctors (findmemberof('Chromaticity Corrector'))
%
%  INPUTS
%  1.                     | Change in Horizontal Chromaticity |
%     DeltaChromaticity = |                                   | 
%                         | Change in Vertical Chromaticity   |
%  2. ChroResponseMatrix - Chromaticity response matrix {Default: getchroresp}
%  3. ActuatorFamily -  Sextupoles to vary, ex {'S9', 'S10'} {Default: findmemberof('Chromaticity Corrector')'}
%  4. Optional override of the units:
%     'Physics'  - Use physics  units
%     'Hardware' - Use hardware units
%  5. Optional override of the mode:
%     'Online'    - Set/Get data online  
%     'Model'     - Set/Get data on the simulated accelerator using AT
%     'Simulator' - Set/Get data on the simulated accelerator using AT
%     'Manual'    - Set/Get data manually
%
%
%  OUTPUTS
%  1. DelSext
%  2. SextFamily - Families used (cell array)
%
%  ALGORITHM  
%     SVD method
%  DelSext = inv(CHROMATICITY_RESP_MATRIX) * DeltaChromaticity
%
%  NOTES
%  1. Beware of what units you are working in.  The default units for chromaticity
%     are physics units.  This is an exception to the normal middle layer convention.
%     Hardware units for "chromaticity" is in tune change per change in RF frequency.  
%     Since this is an unusual unit to work with, the default units for chromaticity
%     is physics units.  Note that goal chromaticity is also stored in physics units.
%  2. The actuator family comes from findmemberof('Chromaticity Corrector') or 'SF','SD' if empty
%  
%  EXAMPLES
%  1. use default families 
%      stepchro([1 0.5])
%  2. use 10 families
%    Sfam = {'S1','S2','S3','S4','S5','S6','S7','S8','S9','S10'}; 
%    B = measchroresp('Model','Display',Sfam);
%    stepchro([1 0.5],'Model',B,Sfam)
%  3. To know by how much chromaticity change 
%     getchroresp('Hardware')*[-31; 8]*getmcf*getrf
%
%  See Also setchro

%
%  Written by Gregory J. Portmann 
%  Modifed by Laurent S. Nadolski
%  add ActuatorFamily as optional input

ModeFlag = {};
UnitsFlag = {'Physics'}; 
DisplayFlag = 1;

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Physics')
        UnitsFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Hardware')
        UnitsFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Simulator') | strcmpi(varargin{i},'Model')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Manual')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end        
end


if length(varargin) >= 1
    DeltaChrom = varargin{1};
else
    DeltaChrom = [];    
end
if isempty(DeltaChrom)
    answer = inputdlg({'Change the horizontal chromaticity by', 'Change the vertical chromaticity by'},'STEPCHRO',1,{'0','0'});
    if isempty(answer)
        return
    end
    DeltaChrom(1,1) = str2num(answer{1});
    DeltaChrom(2,1) = str2num(answer{2});
end
DeltaChrom = DeltaChrom(:);
if size(DeltaChrom,1) ~= 2
    error('Input must be a 2x1 column vector.');
end
if DeltaChrom(1)==0 && DeltaChrom(2)==0
    return
end

if length(varargin) >= 2
    ChroResponseMatrix = varargin{2};
else
    ChroResponseMatrix = [];    
end
if isempty(ChroResponseMatrix)
    ChroResponseMatrix = getchroresp(UnitsFlag{:});
end
if isempty(ChroResponseMatrix)
    error('The chromaticity response matrix must be an input or available in one of the default response matrix files.');
end

if length(varargin) >= 3
    ActuatorFamily = varargin{3};
else
    ActuatorFamily = findmemberof('Chromaticity Corrector')';
    if isempty(ActuatorFamily)
        ActuatorFamily = {'S9','S10'};
    end
end

% 1. SVD Tune Correction
% Decompose the chromaticity response matrix:
[U, S, V] = svd(ChroResponseMatrix, 'econ');
% ChroResponseMatrix = U*S*V'
%
% The V matrix columns are the singular vectors in the sextupole magnet space
% The U matrix columns are the singular vectors in the chromaticity space
% U'*U=I and V*V'=I
%
% CHROCoef is the projection onto the columns of ChroResponseMatrix*V(:,Ivec) (same space as spanned by U)
% Sometimes it's interesting to look at the size of these coefficients with singular value number.
CHROCoef = diag(diag(S).^(-1)) * U' * DeltaChrom;
%
% Convert the vector CHROCoef back to coefficents of ChroResponseMatrix
DelSext = V * CHROCoef;


% 2. Square matrix solution
%DelSext = inv(ChroResponseMatrix) * DeltaChrom;


SP = getsp(ActuatorFamily, UnitsFlag{:}, ModeFlag{:});

if iscell(SP)
    for i = 1:length(SP)
        SP{i} = SP{i} + DelSext(i);
    end
else
    SP = SP + DelSext;
end


if DisplayFlag && strcmpi(UnitsFlag,'Physics')
    fprintf('%s Changing the chromaticities by dxix = %.2f and dxiz = %.2f\n', ...
        datestr(clock), DeltaChrom);
end
setsp(ActuatorFamily, SP, UnitsFlag{:}, ModeFlag{:});

