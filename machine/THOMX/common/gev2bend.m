function Amps = gev2bend(varargin)
%GEV2BEND - Converts beam energy TO BEND (ring) or BEND1 (TL), or BEND2 currents
%
% beam energy/dipole bending angle (BL/Brho) ---> dipole current
%
%  Jianfeng Zhang @ LAL, 09/10/2013
%  Currently used the physics unit, that is 1 Ampere = 1 physics unit.
%  Need to modify the setting with the measured magnet current.
%
%  Customized for ThomX machine by Jianfeng Zhang @ LAL, 21/06/2013 
%
%
%  Bend = gev2bend(Family, Field, GeV, DeviceList, BranchFlag)
%
%  INPUTS
%  1. Bend - Bend magnet family {Optional}
%  2. Field - Field {Optional}
%  3. GeV - Electron beam energy [GeV]
%  4. DeviceList - Bend magnet device list to reference energy to {Default: BEND(1,1)}
%  5. BranchFlag - 1 -> Lower branch
%                  2 -> Upper branch {Default}
%                  Not working at Spear yet
%  OUTPUTS
%  1. Amps = Bend magnet current [Amps]
%
%  ALGORITHM
%  I is the root of the polynom
%  BL = theta*BRHO
%  p = root(-theta*Brho  + c0 + c1*I + ... + cn*I^n)
%  I = root(p) closest to linear solution rlin
%  Linear solution is
%  rlin = (THETA*Brho - c0)/c1
%
%  See Also bend2gev

%
%  Written by Gregory J. Portmann
%  Modified by Laurent S. Nadolski

% Modified by Jianfeng Zhang @ LAL, 18/09/2013 
% Need to be modified when the magnet is ready...
%
%
% 24/02/2014 Jianfeng Zhang @ LAL
%      Fix the bugs to turn on/off the dipole current in TL, since
%      there are two types of dipoles in TL: BEND1, BEND2.
%
%
%


%  Default
Family = '';
Field = '';
GeV = [];
DeviceList = [];
BranchFlag = [];
ModeFlag = '';  % model, online, manual
UnitsFlag = ''; % hardware, physics
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignore structures
    elseif iscell(varargin{i})
        % Ignore cells
    elseif strcmpi(varargin{i},'Struct')
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Numeric')
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Physics')
        UnitsFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Hardware')
        UnitsFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Simulator') || strcmpi(varargin{i},'Model')
        ModeFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        ModeFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Manual')
        ModeFlag = varargin{i};
        varargin(i) = [];
    end        
end

if length(varargin) >= 1
    if ischar(varargin{1})
        Family = varargin{1};
        varargin(1) = [];
    else
        GeV = varargin{1};
        varargin(1) = [];
        if length(varargin) >= 1
            DeviceList = varargin{1};
            varargin(1) = [];
        end
        if length(varargin) >= 1
            BranchFlag = varargin{1};
            varargin(1:end) = [];
        end
    end
end
if length(varargin) >= 1 & ischar(varargin{1})
    Field = varargin{1};
    varargin(1) = [];
end
if length(varargin) >= 1
    GeV = varargin{1};
    varargin(1) = [];
end
if length(varargin) >= 1
    DeviceList = varargin{1};
    varargin(1) = [];
end
if length(varargin) >= 1
    BranchFlag = varargin{1};
    varargin(1) = [];
end


if isempty(Family)
    Family = 'BEND';
end
if isempty(Field)
    Field = 'Setpoint';
end

if isempty(UnitsFlag)
    UnitsFlag = getunits(Family);
end

if isempty(GeV)
    if isempty(ModeFlag)
        ModeFlag = getmode(Family);
    end
    if strcmpi(ModeFlag,'Simulator') || strcmpi(ModeFlag,'model')
        GeV = getenergymodel;
    else
        error('GeV input required');
    end
end

if isempty(DeviceList)
    DeviceList = family2dev(Family);
    if all(size(GeV)==[1 1])
        DeviceList = DeviceList(1,:);
    end
end
if isempty(BranchFlag)
    % Default is upper branch
    BranchFlag = 2;
end

% End of input checking
% Machine dependant stuff below

for ii = 1:size(DeviceList,1)
    if length(GeV) == 1
        GeV1 = GeV;
    else
        GeV1 = GeV(ii);
    end

      % [C, Leff, MagnetType, A] = magnetcoefficients('BEND');
    [C, Leff, MagnetType, A] = magnetcoefficients(Family);
    % Convert to BEND current
    AcceleratorName = getfamilydata('SubMachine');
    switch AcceleratorName
        case {'StorageRing'}

            % C = C * Leff;

            %     k = 0.31537858;  %% gradient of the dipole
            %     bprime = k * brho;
            %     b0 = bprime * 0.392348;
            %     bl = b0 * Leff;
            %     k = -k;
            % brho[Tm] = 3.33620907461447 * E[GeV]
            % brho = GeV1*3.33620907461447;
            % bl = -brho/5.3653*Leff;

            % Solve for roots based on polynomial coefficient (coefficients already divided by Leff)
            % p = [C(1) C(2) C(3) C(4) C(5) C(6) C(7) C(8) C(9)-bl];
            % C(9) = 0

            % p = C;
            % p(9) = bl;

            % Closest to the linear line approach

            brho = getbrho(GeV1);
            theta = 0.785398163397448; %rad <--> 45 degrees
            BL = brho*theta;
            p  = A;
            p(end)  = A(end) - BL;
            r1inear = (A(end)-BL) / A(end-1);
            
     case { 'TL','TL_SL'}
    
      % BEND1 & BEND2 have different field strength
      % main dipoles
      if(strcmp(Family,'BEND1'))
        
        brho = getbrho(GeV1);
        theta = 0.785398163397448; %rad <--> 45 degrees
        BL = brho*theta;
        p  = A;
        p(end)  = A(end) - BL;
        r1inear = (A(end)-BL) / A(end-1);
            
        % injection dipole
      elseif(strcmp(Family,'BEND2'))
        brho = getbrho(GeV1);
        theta = 0.1690000; %rad <--> 9.68 degrees
        BL = brho*theta;
        p  = A;
        p(end)  = A(end) - BL;
        r1inear = (A(end)-BL) / A(end-1);
      else
        error('Error! The dipole in the transfer line is either "BEND1" or "BEND2"');
            end
            
            
        case 'EL'
            brho = getbrho(GeV1);
            theta = 0.785398163397448; %rad <--> 15 degrees
            BL = brho*theta;
            p  = A;
            p(end)  = A(end) - BL;
            r1inear = (A(end)-BL) / A(end-1);

        otherwise
            error('Unknown AcceleratorName')
    end

    % magnet current is one of the roots
    r = roots(p);

    % Choose the closest solution to the linear one
    BEND = inf;
    for i = 1:length(r)
        if isreal(r(i))
            %if r(i)>0 & abs(r(i)) < BEND(j,1)  % Smallest, positive
            if abs(r(i) - r1inear) < abs(BEND - r1inear)  % Closest to linear solution
                BEND = r(i);
            end
        end
    end

    if isinf(BEND)
        error(sprintf('Solution for GeV=%.3f not found (all roots are complex)', GeV1));
    end

    if size(GeV,2) == 1
        Amps(ii,1) = BEND;
    else
        Amps(1,ii) = BEND;
    end
end 
    
if strcmpi(UnitsFlag,'Physics')
    Amps = hw2physics(Family, 'Setpoint', Amps, DeviceList, GeV1);
end
