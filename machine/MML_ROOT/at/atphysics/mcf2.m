function a = mcf2(RING,delta)
%MCF2(RING) calculates momentum compaction factor of RING versus energy
%shift
%
% Warning this is an effective momentum compaction at a given energy

%
% Modified by Laurent S. Nadolski

if nargin < 1 
    error('Syntax is mcf2(RING)');
elseif ~iscell(RING)
    error('argument is not a AT RING')
end

dP  = 1e-6;
fpp = findorbit4(RING, dP/2+delta);
fpm = findorbit4(RING,-dP/2+delta);
% Build initial condition vector that starts
% on the fixed point
x0p = [fpp; delta+dP/2; 0];

X0m = [fpm; delta-dP/2;0];

% Track X0 for 1 turn
T = ringpass(RING,[X0m x0p]);
% Calculate alpha
RingLength = findspos(RING,length(RING)+1);
a = (T(6,2)-T(6,1))/(dP*RingLength);

