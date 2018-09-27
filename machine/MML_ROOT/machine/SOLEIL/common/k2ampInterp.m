function Amps = k2ampInterp(Family, Field, k, DeviceList, Energy, Param, K2AmpScaleFactor)
%K2AMPINTERP - Converts Physics values to amperes
%  Amps = k2ampInterp(Family, Field, k, DeviceList, Energy, Param, K2AmpScaleFactor)
%       or
%  Amps = k2ampInterp(Family, Field, k, DeviceList, Energy, MagnetCoreType, K2AmpScaleFactor)
%
%  Calculates the current [amperes] from the coefficients (or MagnetCoreType), "K-value", energy, and linear scale factor
%
%  INPUTS
%  1. Family - Family name
%  2. Field - Sub-field (like 'Setpoint')
%  3. K - "K-value" in AT convention
%          For dipole:      K = B / Brho
%          For quadrupole:  K = B'/ Brho
%          For sextupole:   K = B"/ Brho / 2
%  4. DeviceList - Device list (Amps and DeviceList must have the same number of rows)
%  5. Energy - Energy in GeV {Default: getenergy}
%              If Energy is a vector, each output column will correspond to that energy.
%              Energy can be anything getenergy accepts, like 'Model' or 'Online'. 
%              (Note: If Energy is a vector, then Amps can only have 1 column) 
%  6. Param - Data for Interpolation and Magnet Length
%  7. K2AmpScaleFactor - linearly scales the output current:  Amps =  K2AmpScaleFactor .* Amps
%
%  NOTES
%  1. If energy is not an input or empty, then the energy is obtained from getenergy.
%  2. Family and Field inputs are not used but there automatically part of the physics2hw call. 
%
% See Also amp2kinterp,magnetinterp, amp2k, magnetcoefficients

%
% Written by A.Bence 20-06-2016 adaptation of @k2amp


%interp1 
method='spline';
%method='pchip';


if nargin < 4
    error('At least 4 inputs required');
end

if nargin < 6
    Param = [];
end
if isempty(Param)
    %[C, Leff, MagnetName] = magnetcoefficients(Family);
    Param  = getfamilydata(Family, Field, 'HW2PhysicsData', DeviceList);
    Param = Param{1,:};
    %Leff = getleff(Family, DeviceList(ii,:));
end

if nargin < 5
    Energy = [];
end
if isempty(Energy)
    Energy = getenergy; % like getenergy('Production')
elseif ischar(Energy)
    Energy = getenergy(Energy);
end


% If k is a row vector make it a column vector
k = k(:);


brho = getbrho(Energy);




if any(size(Param,1) ~= length(k))
    if length(k) == 1
        Amps = ones(size(Param,1),1) * k;
    elseif size(Param,1) == 1
        %C = ones(size(k,1),1) * C;
    else
        error('k and Parameters must have equal number of rows or one must only have one row');
    end
end

% B, B', or B" scaled by energy
for i = 1:length(k)
    MLen=Param{i,2}; %Magnet Length
    MagnetMeasurementsData=Param{i,3}; 
    Coeff=Param{i,4};
    
    I=MagnetMeasurementsData(:,1); %Amps
    G=MagnetMeasurementsData(:,2); %Tesla
    G=G*Coeff;
    
    Gc=k(i)*brho*MLen;
    if sign(k(i))==-1 % if current is negative just change sign of I and G
        Amps(i,1) = interp1(-G,-I,Gc,method);
    else
        Amps(i,1) = interp1(G,I,Gc,method);
    end
end
%Scale solution if required
if nargin >= 7
    Amps = Amps .* K2AmpScaleFactor;   
end