function [DelSext, ActuatorFamily] = setchro(varargin)
%SETCHRO - Measures then sets the chromaticity
%  [DelSext, SextFamily] = setchro(NewChromaticity, ChroResponseMatrix, DeltaRF)
%
%  INPUTS
%  1.                   | Horizontal Chromaticity |
%     NewChromaticity = |                         | 
%                       | Vertical Chromaticity   |
%  2. ChroResponseMatrix - Chromaticity response matrix {Default: getchroresp}
%  3. ActuatorFamily -  Sextupoles to vary, ex {'S9', 'S10'} {Default: findmemberof('Chromaticity Corrector')'}
%  4. DeltaRF - measchro for an explaination of DeltaRF {Default comes from measchro}
%  5. Optional override of the units:
%     'Physics'  - Use physics  units
%     'Hardware' - Use hardware units
%  6. Optional override of the mode:
%     'Online'    - Set/Get data online  
%     'Model'     - Set/Get data on the simulated accelerator using AT
%     'Simulator' - Set/Get data on the simulated accelerator using AT
%     'Manual'    - Set/Get data manually
%     'FBT'       - For golden correction, used tune from FBT system
%
%
%  OUTPUTS
%  1. DelSext - Change in sextrupole strength (vector by family)
%  2. SextFamily - Families used (cell array)
%
%  ALGORITHM
%     SVD
%     DelSext = inv(CHROMATICITY_RESP_MATRIX) * (NewChromaticity-getchro)
%
%  NOTES
%  1. Beware of what units you are working in.  The default units are usually
%     hardware units so the default chromaticity is likely going to be negative.  
%     For instance, at Spear the physics units chromaticity of 1 unit corresponds to roughly 
%     -1.8 units in hardware units.  
%
%  EXAMPLES
%  1. use default families 
%      setchro([1 0.5])
%  2. use 10 families
%    Sfam = {'S1','S2','S3','S4','S5','S6','S7','S8','S9','S10'}; 
%    B = measchroresp('Model','Display',Sfam);
%    setchro([1 0.5],'Model',B,Sfam)
%  
%  Also See stepchro

%
%  Written by Gregory J. Portmann
%  Modification by Laurent S. Nadolski
%     Actuator family list as an optional input --> 3rd argument is now 4th
%     argument!

FBTFlag = 0; % tune measured using FBT


ActuatorFamily = {};
UnitsFlag = {'Physics'}; 
ModeFlag = {};
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'physics')
        UnitsFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'hardware')
        UnitsFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'simulator') | strcmpi(varargin{i},'model')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'online')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'manual')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'FBT')
        FBTFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoFBT')
        FBTFlag = 0;
        varargin(i) = [];
    end        
end


NewChro = [];
if length(varargin) >= 1
    NewChro = varargin{1};
end
if isempty(NewChro)
    if strcmpi(UnitsFlag{1}, 'Physics')
        NewChro = getgolden('Chromaticity');  % Physics units
    else
        NewChro = -getgolden('Chromaticity') / getrf / getmcf;  % Hardware units
    end
    NewChro = NewChro(1:2);
    NewChro = NewChro(:);
end
if isempty(NewChro)
    error('Golden chromaticity not found');
end

if length(varargin) >= 2
    ChroResponseMatrix = varargin{2};
else
    ChroResponseMatrix = [];    
end

if length(varargin) >= 3
    ActuatorFamily = varargin{3};
else
    ActuatorFamily = findmemberof('Chromaticity Corrector')';
    if isempty(ActuatorFamily)
        ActuatorFamily = {'S9','S10'};
    end
end

disp('   Begin initial chromaticity measurement...');
if FBTFlag
    if length(varargin) < 4
        MeasuredChrom = measchroFBT('Numeric', UnitsFlag{:}, ModeFlag{:});
    else
        MeasuredChrom = measchroFBT(varargin{3}, 'Numeric', UnitsFlag{:}, ModeFlag{:});
    end
else
    if length(varargin) < 4
        MeasuredChrom = measchro('Numeric', UnitsFlag{:}, ModeFlag{:});
    else
        MeasuredChrom = measchro(varargin{3}, 'Numeric', UnitsFlag{:}, ModeFlag{:});
    end
end

fprintf('   Measured Horizontal Chromaticity = %f (Goal is %f)\n', MeasuredChrom(1), NewChro(1));
fprintf('   Measured Vertical   Chromaticity = %f (Goal is %f)\n', MeasuredChrom(2), NewChro(2));

if strcmpi(questdlg('Do you want to change the chromaticity now?','Yes','No'), 'Yes')
    disp('   Begin chromaticity change...');
    [DelSext, ActuatorFamily] = stepchro([NewChro(1)-MeasuredChrom(1); NewChro(2)-MeasuredChrom(2)], ... 
        ChroResponseMatrix, ActuatorFamily, UnitsFlag{:}, ModeFlag{:});
    disp('   Finished chromaticity change');
else
    disp('   Chromaticity not changed');
    DelSext = zeros(length(ActuatorFamily),1);
end
