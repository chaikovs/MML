function OrbitCorrection(SESSION,UncorrectedOrbit,BckgOrbit,UnitOrbitEntrance,UnitOrbitExit,arIndsBPMsToSkip)
ClosedOrb = load('-mat',[SESSION '/' UncorrectedOrbit]);
BckgOrb = load('-mat',[SESSION '/' BckgOrbit]);
CalibrationOrbEntrance = load('-mat',[SESSION '/' UnitOrbitEntrance]);
CalibrationOrbExit = load('-mat',[SESSION '/' UnitOrbitExit]);
DeltaOrbX=ClosedOrb.X-BckgOrb.X;
DeltaOrbZ=ClosedOrb.Z-BckgOrb.Z;
for i=1:120
    Mx(i,1)=CalibrationOrbEntrance.X(i);
    Mx(i,2)=CalibrationOrbExit.X(i);
    Mz(i,1)=CalibrationOrbEntrance.Z(i);
    Mz(i,2)=CalibrationOrbExit.Z(i);
end
ShimX=idLeastSqLinFit(Mx, DeltaOrbX, arIndsBPMsToSkip)
ShimZ=idLeastSqLinFit(Mz, DeltaOrbZ, arIndsBPMsToSkip)

BPMx.Position = getspos('BPMx');
xdata = BPMx.Position;

figure(1)
plot(xdata,DeltaOrbZ,'b.-')
title('Déplacement relatif d''orbite Verticale')
figure(2)
plot(xdata,CalibrationOrbEntrance.Z,'r.-')
title('Orbite Verticale de calibration en entrée')
figure(3)
plot(xdata,CalibrationOrbExit.Z,'g.-')
title('Orbite Verticale de calibration en sortie')
figure(4)
plot(xdata,DeltaOrbX,'b.-')
title('Déplacement relatif d''orbite Horizontale')
figure(5)
plot(xdata,CalibrationOrbEntrance.X,'r.-')
title('Orbite Horizontale de calibration en entrée')
figure(6)
plot(xdata,CalibrationOrbExit.X,'g.-')
title('Orbite Horizontale de calibration en sortie')
