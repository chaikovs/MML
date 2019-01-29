function GeV = bend2gev(varargin)
%BEND2GEV - Compute the energy based on the ramp tables
% GeV = bend2gev(Family, Field, Amps, DeviceList, BranchFlag)
%
%  INPUTS
%  1. Bend - Bend magnet family {Optional}
%  2. Field - Field {Optional}
%  3. Amps - Bend magnet current
%  4. DeviceList - Bend magnet device list to reference energy to {Default: BEND(1,1)}
%  5. BranchFlag - 1 -> Lower branch
%                  2 -> Upper branch {Default}
%                  Not working at Spear yet, since there isn't any magnet measurements on hysteresis
%
%  OUTPUTS
%  1. GeV - Electron beam energy [GeV]
%
%  Written by Greg Portmann

% Default
Family = '';
Field = '';
Amps = [];
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
        UnitsFlag = 'Physics';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'hardware')
        UnitsFlag = 'Hardware';
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
        Amps = varargin{1};
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
    Amps = varargin{1};
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
if isempty(ModeFlag)
    ModeFlag = getmode(Family);
end

if isempty(Field)
    Field = 'Setpoint';
end
if isempty(DeviceList)
    DeviceList = family2dev(Family);
    if all(size(Amps)==[1 1]) | isempty(Amps)
        DeviceList = DeviceList(1,:);
    end
end
if isempty(BranchFlag)
    % Default is upper branch
    BranchFlag = 2;
end
if isempty(Amps)
    if strcmpi(ModeFlag,'simulator') | strcmpi(ModeFlag,'model')
        % The model energy is used only if Amps is empty
        % Otherwise "Maximum recursion limit"
        GeV = getenergymodel;
        return;
        
        %GeVmodel = getenergymodel;
        %kmodel = getpvmodel(Family, Field, DeviceList, 'Physics');
        %Amps = k2amp(Family, Field, kmodel, DeviceList, [], 1, GeVmodel);
    else 
        Amps = getpv(Family, Field, [1 1], 'Hardware', ModeFlag);
        UnitsFlag = 'UnitsFlag';
    end
end

% End of input checking
% Machine dependent stuff below


% Amps should be in hardware units
if strcmpi(UnitsFlag,'Physics')
    Amps = physics2hw(Family, 'Setpoint', Amps, DeviceList);
end


DeviceListTotal = family2dev(Family, 0);

for ii = 1:size(DeviceList,1)
    if length(Amps) == 1
        BEND = Amps;    
    else
        BEND = Amps(ii);    
    end

    % Convert to energy
    
    % C coefficients have been scaled to convert between AT units and hardware units and also includes a DC term:
    % c8 * I^8+ c7 * I^7+ c6 * I^6 + c5 * I^5 + c4 * I^4 + c3 * I^3 + c2 * I^2+c1*I + c0 = B or B' or B"
    % C = [c8 c7 c6 c5 c4 c3 c2 c1 c0]
    %[C1, Leff, MagnetType, A] = magnetcoefficients('BEND');
    
    C = getfamilydata(Family, Field, 'HW2PhysicsParams', DeviceList(ii,:));
    C = C{1};
    
    B = C(8)*BEND + C(7)*BEND.^2 + C(6)*BEND.^3 + C(5)*BEND.^4 + C(4)*BEND.^5 + C(3)*BEND.^6 + C(2)*BEND.^7 + C(1)*BEND.^8;
    % k(i,1) = polyval(C, Amps(i)) / brho;
    
    % k is fixed to be -0.31537858
    k = -0.31537858;
    
    % Convert to BEND angle
    %K2BendingAngle = 2.54842790129284; 
    if any(DeviceList(ii,1) == [1 9 10 18])
        K2BendingAngle = 2.54842790129284 * -0.43947079695140;   % BendAngle / K
    else
        K2BendingAngle = 2.54842790129284 * -0.58596106939159;  % BendAngle / K
    end
    %K2BendingAngle = -0.43947079695140;   % BendAngle / K
    k = K2BendingAngle * k;
    
    
    boverbprime = 0.392348;
    bprime = B / boverbprime;
    brho = bprime / k;
    
    % now return energy in GeV
    gev1 = brho / 3.33620907461447;
    
    
    if size(Amps,2) == 1
        GeV(ii,1) = gev1;
    else
        GeV(1,ii) = gev1;
    end

end


% cur = BEND;
% % Convert to energy
% 
% a7= 0.0137956;
% a6=-0.0625519;
% a5= 0.1156769;
% a4=-0.1141570;
% a3= 0.0652128;
% a2=-0.0216472;
% a1= 0.0038866;
% a0= 0.0028901;
% 
% i0=700.;
% c7=a7/(i0^7);
% c6=a6/(i0^6);
% c5=a5/(i0^5);
% c4=a4/(i0^4);
% c3=a3/(i0^3);
% c2=a2/(i0^2);
% c1=a1/i0;
% c0=a0;
% leff=1.5048;
% 
% 
% % kl = (cur/brho)*(c0+c1*cur+c2*cur^2+c3*cur^3+c4*cur^4+c5*cur^5+c6*cur^6+c7*cur^7);
% % k  = kl/Leff;
% % k is fixed to be -0.31537858
% k = -0.31537858;
% 
% BLeff = cur.*(c0+c1*cur+c2*cur.^2+c3*cur.^3+c4*cur.^4+c5*cur.^5+c6*cur.^6+c7*cur.^7);
% field = BLeff / Leff;
% 
% boverbprime = 0.392348;
% bprime = field / boverbprime;
% brho = bprime / k;
% 
% % now return energy in GeV
% GeV = brho / 3.33620907461447;



