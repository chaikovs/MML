function GeV = getenergymodel
%GETENERGYMODEL - Returns the model energy in GeV
% GeV = getenergymodel
%
% OUTPUTS
% 1. GeV - Energy in GeV
%
% See Also getenergy

%
%  Written by Gregory J. Portmann

GeV = [];

global THERING

% Look for .Energy
ATCavityIndex = findcells(THERING, 'Energy');

if ~isempty(ATCavityIndex)
    GeV = THERING{ATCavityIndex(1)}.Energy / 1e+009;
end

if isempty(GeV)
    % Note: this will be obsolete in the future
    global GLOBVAL
    GeV = GLOBVAL.E0 / 1e+009;
end