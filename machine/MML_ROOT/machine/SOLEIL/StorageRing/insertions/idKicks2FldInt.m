function [i1, i2, k1, k2] = idKicks2FldInt(vKicks, x_or_z_pos, idLen, idKickOfst, elecEn_GeV)
%Returns 1st and 2nd field integrals in [G*m] and [G*m^2] respectively,
% Add-on by F. Briquez 26/03/2013 : returns also kicks converted from [rad]
% to [Gm]
% i1 : first ingegral
% i2 : second integral
% k1 : entrance kick
% k2 : exit kick
%assuming:
%   vKicks(1), vKicks(2) - two (virtual) kick values in [rad]
%   idLen - undulator length in [m]
%   idKickOfst - offset of position of virtual kicks with respect to
%   undulator extremities (== 0 means that kicks are located exactly at the extremities)
%   elecEn_GeV - electron energy in [GeV]

m = PhysConstant.electron_mass.value  % Mass of electron in kg
e = PhysConstant.electron_volt.value  % Charge of electron in Coulomb
c = PhysConstant.speed_of_light_in_vacuum.value; % speed of light [m/s]

gam = elecEn_GeV/(0.5109989e-03);

cf = 10000.*m*c*gam/e; % To obtain results in [G*m], [G*m^2]
if strcmp(x_or_z_pos, 'z') ~= 0
    cf = -cf;
end

vKicks_Gm=vKicks*cf;
k1=vKicks_Gm(1);
k2=vKicks_Gm(2);
i1=k1+k2;
distBwKicks =idLen-2*idKickOfst;
i2 = 0.5*((idLen+distBwKicks)*k1+(idLen-distBwKicks)*k2);
% i1 = cf*(vKicks(1) + vKicks(2));
% i2 = 0.5*cf*((idLen + distBwKicks)*vKicks(1) + (idLen - distBwKicks)*vKicks(2));

