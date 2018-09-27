function saveBumpOrbit(SESSION,X,PS1)
FileName=['BUMP_' Num2Str(10*X) '_PS1_' Num2Str(PS1)];
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, ['/home/data/GMI/HU640_DESIRS/' SESSION '/PS1/' FileName], 0);
end