function [t]=get_laps(tau,I,dI)
% tau lifetime hours
% I current
% dI currenr loss <0
% t in mn
% from I=I0*exp(-t/tau)

t=-tau*log(dI/I+1);
t=t*60;