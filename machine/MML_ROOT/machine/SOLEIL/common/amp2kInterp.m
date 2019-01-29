function k = amp2kInterp(Family, Field, Amps, DeviceList, Energy, Param, K2AmpScaleFactor)
%AMP2Kinterp - Converts amperes to simulator values
%  k = amp2k(Family, Field, Amps, DeviceList, Energy, Param, K2AmpScaleFactor)
%    or
%  k = amp2k(Family, Field, Amps, DeviceList, Energy, MagnetCoreType, K2AmpScaleFactor)
%
%  Calculates the "K-value" from the coefficients (or MagnetCoreType), current [amps], energy, and linear scale factor
%
% INPUTS
% 1. Family - Family Name
% 2. Field  - Family Field (like 'Setpoint')
% 3. Amps   - Ampere vector to convert
% 4. DeviceList - Device list (Amps and DeviceList must have the same
% number of rows)
% 5. Energy - Energy in GeV {Default: getenergy}
%              If Energy is a vector, each output column will correspond to that energy.
%              Energy can be anything getenergy accepts, like 'Model' or 'Online'. 
%              (Note: If Energy is a vector, then Amps can only have 1
%              column)Family, Field, value(:,i), DeviceList, Energy, ParamsList{:}
% 6. Param - Data for Interpolation and Magnet Length
% 7. K2AmpScaleFactor - linearly scales the input current:  Amps = Amps ./ K2AmpScaleFactor
%
% OUTPUT
% 1. K and B - K-value and field in AT convention
%    For dipole:      k = B / Brho
%    For quadrupole:  k = B'/ Brho
%    For sextupole:   k = B"/ Brho / 2  (to be compatible with AT)
%
%  NOTES
%  1. If energy is not an input or empty, then the energy is obtained from getenergy.
%  2. Family and Field inputs are not used but there automatically part of the hw2physics call. 
%
% See Also magnetinterp, k2ampInterp, k2amp, magnetcoefficients



%
% Written by A.Bence 20-06-2016 adaptation of @amp2k


%JustInterp
NoInterpFlag=1;

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


% If Amps is a row vector make it a column vector
Amps = Amps(:);

% Scale solution if required
if nargin >= 7
    Amps = Amps ./ K2AmpScaleFactor;
end

brho = getbrho(Energy);




if any(size(Param,1) ~= length(Amps))
    if length(Amps) == 1
        Amps = ones(size(Param,1),1) * Amps;
    elseif size(Param,1) == 1
        %C = ones(size(Amps,1),1) * C;
    else
        error('Amps and Parameters must have equal number of rows or one must only have one row');
    end
end

% B, B', or B" scaled by energy
for i = 1:length(Amps)
    MLen=Param{i,2}; %Magnet Length
    MagnetMeasurementsData=Param{i,3}; 
    Coeff=Param{i,4};
    
    I=MagnetMeasurementsData(:,1); %Amps
    G=MagnetMeasurementsData(:,2); %Tesla
    G=G*Coeff;    

    if sign(Amps(i))==-1 % if current is negative just change sign of I and G
        k(i,1) = interp1(-I,-G,Amps(i),method)/brho/MLen;
    else
        k(i,1) = interp1(I,G,Amps(i),method)/brho/MLen;
    end
  
end


