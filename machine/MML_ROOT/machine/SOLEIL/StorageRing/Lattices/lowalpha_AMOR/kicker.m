function [dev]=kicker(L1,L2,A,t0,t)

% L1, L2 géometrie
% A max amplitude en mm
% t temps du passage
% t0 déclenchement kicker
% dev kick en mrad

pulse=6.5;  % durée du pulse kicker en µs

if (t<t0)
    dev=0;
elseif (t>t0) && (t<t0+pulse)
    dev=A/L1*sin(pi/pulse*(t-t0));
else
    dev=0;
end
    