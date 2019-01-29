function [AlphaX, AlphaY, Sx, Sy, Tune] = modelalpha(varargin)
%MODELALPHA - Returns the alpha (beta derivative) function of the model
%  [AlphaX, AlphaY, Sx, Sy, Tune] = modelalpha(Family1, DeviceList1, Family2, DeviceList2)
%  [AlphaX, AlphaY, Sx, Sy, Tune] = modelalpha(Family1, DeviceList1);
%  [AlphaX, AlphaY, Sx, Sy, Tune] = modelalpha(Family1, Family2)
%  [AlphaX, AlphaY, Sx, Sy, Tune] = modelalpha('All');
%
%  INPUTS
%  1. Family1 and Family2 are the family names for where to measure the horizontal/vertical beta function.
%     A family name can be a middlelayer family or an AT family.  'All' returns beta at every element in
%     the model plus the end.  {Default or []: 'All'}
%  2. DeviceList1 and DeviceList2 are the device list corresponding to Family1 and Family2
%     {Default or []: the entire list}
%
%  OUTPUTS
%  1. AlphaX and AlphaY - Horizontal and vertical beta function [meters]
%  2. Sx and Sy are longitudinal locations in the ring [meters]
%  3. Tune
%
%  NOTE
%  1. Family1 and DeviceList1 can be any family.  For instance, if Family1='VCM'
%     and DeviceList1=[], then AlphaX is the horizontal beta function at the 
%     vertical corrector magnets (similarly for Family2 and DeviceList2).
%  2. If no output exists, the beta function will be plotted to the screen.
%  3. Calls modeltwiss
%
%  See also modeltwiss, modeltune, modeldisp, modelchro, modelbeta

%
%  Written by Laurent S. Nadolski

if nargout == 0
    modeltwiss('alpha', varargin{:});
elseif nargout < 5
    [AlphaX, AlphaY, Sx, Sy] = modeltwiss('alpha', varargin{:});
else
    [AlphaX, AlphaY, Sx, Sy, Tune] = modeltwiss('alpha', varargin{:});
end
