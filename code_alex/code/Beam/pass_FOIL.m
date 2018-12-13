function [phasespace]=pass_FOIL(phasespace,L,L0) 
% Apply FOIL pass in kick approx by increasing the divergence
% Chao handbook formula (P. 267)
% L  foil thickness en m
% LO radiation length in m (according to material)
global  DYNAMIC
EC=DYNAMIC.energy;
E0=DYNAMIC.restmass;
%
if (nargin<3); L0=0.089 ; end % Default for Alumina foil
df=L/L0;
%
sigf=26.6*abs(1 + 0.038*log(df))*sqrt(df);  % 
gam =(EC*(1+phasespace(6,:))+E0)/E0;
%
np=length(phasespace);
%
% Apply divergence diffusion of ammplitude sigf/gam
phasespace(2,:)=phasespace(2,:) + sigf*randn(1,np)./gam;
phasespace(4,:)=phasespace(4,:) + sigf*randn(1,np)./gam;


return
    
