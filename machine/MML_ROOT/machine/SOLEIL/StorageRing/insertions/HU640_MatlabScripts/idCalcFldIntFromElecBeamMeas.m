
function [i1ex, i1sx, i1ez, i1sz] = idCalcFldIntFromElecBeamMeas(ElecBeamDataMain, ElecBeamDataBkg, mCODx, mCODz, arIndsBPMsToSkip, idLen, idKickOfst, elecEn_GeV)

vDX = 0.001*(ElecBeamDataMain.X - ElecBeamDataBkg.X);
vDZ = 0.001*(ElecBeamDataMain.Z - ElecBeamDataBkg.Z);
vKicksX = idLeastSqLinFit(mCODx, vDX, arIndsBPMsToSkip);
vKicksZ = idLeastSqLinFit(mCODz, vDZ, arIndsBPMsToSkip);
%[i1z, i2z] = idKicks2FldInt(vKicksX, 'x', idLen, idKickOfst, elecEn_GeV);
%[i1x, i2x] = idKicks2FldInt(vKicksZ, 'z', idLen, idKickOfst, elecEn_GeV);

[i1ez, i1sz] = idKicks2FldInt(vKicksX, 'x', idLen, idKickOfst, elecEn_GeV);
[i1ex, i1sx] = idKicks2FldInt(vKicksZ, 'z', idLen, idKickOfst, elecEn_GeV);
