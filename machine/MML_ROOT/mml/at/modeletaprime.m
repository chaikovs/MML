function [EtaPrimeX, EtaPrimeY, Sx, Sy, Tune] = modeletaprime(varargin)
%MODELETAPRIME - Returns the EtaPrime (dispersion derivative) function of the model
%  [EtaPrimeX, EtaPrimeY, Sx, Sy, Tune] = modeletaprime(Family1, DeviceList1, Family2, DeviceList2)
%  [EtaPrimeX, EtaPrimeY, Sx, Sy, Tune] = modeletaprime(Family1, DeviceList1);
%  [EtaPrimeX, EtaPrimeY, Sx, Sy, Tune] = modeletaprime(Family1, Family2)
%  [EtaPrimeX, EtaPrimeY, Sx, Sy, Tune] = modeletaprime('All');
%
%  INPUTS
%  1. Family1 and Family2 are the family names for where to measure the horizontal/vertical beta function.
%     A family name can be a middlelayer family or an AT family.  'All' returns beta at every element in
%     the model plus the end.  {Default or []: 'All'}
%  2. DeviceList1 and DeviceList2 are the device list corresponding to Family1 and Family2
%     {Default or []: the entire list}
%
%  OUTPUTS
%  1. EtaPrimeX and EtaPrimeY - Horizontal and vertical beta function [meters]
%  2. Sx and Sy are longitudinal locations in the ring [meters]
%  3. Tune
%
%  NOTE
%  1. Family1 and DeviceList1 can be any family.  For instance, if Family1='VCM'
%     and DeviceList1=[], then EtaPrimeX is the horizontal beta function at the 
%     vertical corrector magnets (similarly for Family2 and DeviceList2).
%  2. If no output exists, the beta function will be plotted to the screen.
%  3. Calls modeltwiss
%
%  See also modeltwiss, modeltune, modeldisp, modelchro, modelbeta

%
%  Written by Laurent S. Nadolski

if nargout == 0
    modeltwiss('EtaPrime', varargin{:});
elseif nargout < 5
    [EtaPrimeX, EtaPrimeY, Sx, Sy] = modeltwiss('EtaPrime', varargin{:});
else
    [EtaPrimeX, EtaPrimeY, Sx, Sy, Tune] = modeltwiss('EtaPrime', varargin{:});
end
