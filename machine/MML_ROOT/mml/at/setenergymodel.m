function setenergymodel(GeV)
% SETENERGYMODEL -set energy in AT model
% setenergymodel(GeV)
%
%  INPUTS
%  1. GeV - energy in GeV
%
%  See Also getenergymodel

%
%  Written by Gregory J. Portmann

% GLOBVAL will be obsolete soon
if ~isempty(whos('global','GLOBVAL'))
    global GLOBVAL
    GLOBVAL.E0 = 1e+009 * GeV(end);
end

% Newer AT versions require 'Energy' to be an AT field
global THERING
THERING = setcellstruct(THERING, 'Energy', 1:length(THERING), 1e+009 * GeV(end));

 
