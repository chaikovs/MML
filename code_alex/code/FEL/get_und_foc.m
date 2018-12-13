function [K] = get_und_foc(E,Kd,ond)
%   input : K-Energy [MeV], Kd, deflexion parameter, ondulator period
%   ID focusing strength for BETA : K=B/Brho/ond

brho=E*1e6/3e8;
B = Kd/93.4/ond;
K =brho/B;     % beta input 

return

