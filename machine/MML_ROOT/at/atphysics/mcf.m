function alpha = mcf(RING)
%MCF - Calculates momentum compaction factor (MCF) of RING
%
% INPUTS
% 1. RING - Cell describing the RING in AT 
%
% OUTPUTS
% 1. alpha - Momentum compaction factor

%
% Modified by Laurent S. Nadolski
% Symmetry around 0 added for computing (second order finite difference)

if nargin < 1 
    error('Syntax is mcf(RING)');
elseif ~iscell(RING)
    error('argument is not a AT RING')
end

dP    = 1e-6;
coddpn = findorbit4(RING,-dP/2); % negative offset
coddpp = findorbit4(RING,+dP/2); % positive offset

% Build initial condition vector that starts
% on the fixed point
X0dPp = [coddpp; dP/2; 0];
X0dPn = [coddpn;-dP/2;0];

% Tracks X0 over 1 turn
T = ringpass(RING,[X0dPn X0dPp]);

% Calculates alpha
L0    = findspos(RING,length(RING)+1);
alpha = (T(6,2)-T(6,1))/(dP*L0);

