function [zmax] = atdynapz_fast(ring,xfix,zlist,dpp,nt)
%Compute the dynamic aperture for z fixed on negative side
%
if nargin < 5, nt=300; end
if nargin < 4, dpp=0.0; end

if isnumeric(dpp)
clorb=[findorbit4(ring,dpp);dpp;0];
else
   clorb=findorbit6(ring);
end

zmax = 0.0;
for i=1:length(zlist)
   rin=[xfix;0;zlist(i);0;dpp;0];
   [dummy,lost]=ringpass(ring,rin,nt,'reuse'); %#ok<ASGLU>
   if lost, break; end
end
if i>1 ; zmax=zlist(i-1);end
end
