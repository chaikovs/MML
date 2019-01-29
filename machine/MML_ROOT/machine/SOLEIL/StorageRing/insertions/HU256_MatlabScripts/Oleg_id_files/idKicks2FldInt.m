function [i1, i2] = idKicks2FldInt(vKicks, x_or_z_pos, idLen, idKickOfst, elecEn_GeV)

m = PhysConstant.electron_mass.value  % Mass of electron in kg
e = PhysConstant.electron_volt.value  % Charge of electron in Coulomb
c = PhysConstant.speed_of_light_in_vacuum.value; % speed of light [m/s]


gam = elecEn_GeV/(0.511e-03);

cf = 10000.*m*c*gam/e; % To obtain results in [G*m], [G*m^2]
if strcmp(x_or_z_pos, 'z') ~= 0
    cf = -cf;
end

i1 = cf*(vKicks(1) + vKicks(2));

distBwKicks = idLen - 2*idKickOfst;
i2 = 0.5*cf*((idLen + distBwKicks)*vKicks(1) + (idLen - distBwKicks)*vKicks(2));

