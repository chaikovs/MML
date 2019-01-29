function printSourcePoint

S.posX = getpv('BeamLine','Positionx');
S.angleX = getpv('BeamLine','Anglex');
S.posY = getpv('BeamLine','Positionz');
S.angleY = getpv('BeamLine','Anglez');
S.dcct = getdcct;
elemName =  family2tangodev('BeamLine');
elemName =  family2common('BeamLine');
 
fprintf('\nBeamline         X (mm)  X''(mrad)   Z (mm)  Z''(mrad)\n');

for k=1:length(S.posX)
    fprintf('%15s % 8.3f % 8.3f % 8.3f % 8.3f\n',elemName{k}, ...
    S.posX(k), S.angleX(k), S.posY(k), S.angleY(k));
end
    