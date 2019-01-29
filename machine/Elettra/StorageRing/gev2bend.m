function Amps = gev2bend(varargin)
%GEV2BEND - Compute the energy based on the ramp tables
% Bend = gev2bend(Family, Field, GeV, DeviceList, BranchFlag)
%
%  INPUTS
%  1. Bend - Bend magnet family {Optional}
%  2. Field - Field {Optional}
%  3. GeV - Electron beam energy [GeV]
%  4. DeviceList - Bend magnet device list to reference energy to {Default: BEND(1,1)}
%  5. BranchFlag - 1 -> Lower branch
%                  2 -> Upper branch {Default}
%                  Not working at PLS yet
%
%  OUTPUTS
%  1. Bend - Bend magnet current [Amps]
%
%  Written by Greg Portmann


% Default
Family = '';
Field = '';
GeV = [];
DeviceList = [];
BranchFlag = [];
ModeFlag = '';  % model, online, manual
UnitsFlag = ''; % hardware, physics
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignor structures
    elseif iscell(varargin{i})
        % Ignor cells
    elseif strcmpi(varargin{i},'struct')
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        varargin(i) = [];
    elseif strcmpi(varargin{i},'physics')
        UnitsFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'hardware')
        UnitsFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'simulator') | strcmpi(varargin{i},'model')
        ModeFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'online')
        ModeFlag = varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'manual')
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
    if strcmpi(ModeFlag,'simulator') | strcmpi(ModeFlag,'model')
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
        gev1 = GeV;
    else
        gev1 = GeV(ii);
    end

    BEND = 815.2999877929688 * gev1 / 2.5;
 
%     % Convert to BEND current
%     brho = getbrho(gev1);
%     
%     C = getfamilydata(Family, Field, 'HW2PhysicsParams', DeviceList(ii,:));
%     C = C{1};
%     
%     % k is fixed to be:
%     k = 0.087266462*2;     
% 
%     bprime = k * brho;
%     b0 = bprime * 0.392348;
%     bl = b0;
%     
%     
%     % Solve for roots based on polynomial coefficient (coefficients already divided by Leff)
%     % p = [C(1) C(2) C(3) C(4) C(5) C(6) C(7) C(8) C(9)-bl]; 
%     % C(9) = 0
%     
%     p = C;
%     p(9) = bl;
%     %p = [c7 c6 c5 c4 c3 c2 c1  c0 -bl];
%     
%        
%     if 0
%         % Real and between 200-800 amps approach
%         r = abs(roots(p));
%         
%         pp = poly(r);
%         
%         for i = 1:8
%             if (imag(r(i))==0. & real(r(i))<800. & real(r(i))>200.);
%                 BEND = r(i);
%             end
%         end
%         
%         
%     else
%         % Closest to the linear line approach 
%        
%         r1inear = abs(bl / C(end-1));
%         
%         r = abs(roots(p));    
%         
%         % Choose the closest solution to the linear one
%         BEND = inf;
%         for i = 1:length(r)
%             if isreal(r(i))
%                 %if r(i)>0 & abs(r(i)) < BEND(j,1)  % Smallest, positive 
%                 if abs(r(i) - r1inear) < abs(BEND - r1inear)  % Closest to linear solution
%                     BEND = r(i);
%                 end
%             end
%         end
%         
%         if isinf(BEND)
%             error(sprintf('Solution for GeV=%.3f not found (all roots are complex)', gev1));
%         end
%     end
    
    if size(GeV,2) == 1
        Amps(ii,1) = BEND;
    else
        Amps(1,ii) = BEND;
    end
end


if strcmpi(UnitsFlag,'Physics')
    Amps = hw2physics(Family, 'Setpoint', Amps, DeviceList, GeV);
end

