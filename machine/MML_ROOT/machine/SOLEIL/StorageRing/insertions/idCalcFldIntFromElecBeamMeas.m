function [i1x, i2x, i1z, i2z, k1x, k2x, k1z, k2z] = idCalcFldIntFromElecBeamMeas(ElecBeamDataMain, ElecBeamDataBkg, mCODx, mCODz, arIndsBPMsToSkip, idLen, idKickOfst, elecEn_GeV, kick2x_rad, kick2z_rad, vR0x, vR0z)
%Returns 1st and 2nd horizontal and vertical field integrals in [G*m] and [G*m^2] respectively,
% entrance and exit horizontal and vertical kicks in [G*m].

vDX = 0.001*(ElecBeamDataMain.X - ElecBeamDataBkg.X); %rel. hor. COD in [m] - vector of 120 (= number of BPMs) elements
vDZ = 0.001*(ElecBeamDataMain.Z - ElecBeamDataBkg.Z); %rel. vert. COD in [m] - vector of 120 elements

if(kick2x_rad ~= 0) %Subtracting 2nd order effect
    if(size(vR0x, 1) > 1)
        vDX = vDX - kick2x_rad*vR0x;
    end
end
if(kick2z_rad ~= 0) %Subtracting 2nd order effect
    if(size(vR0z, 1) > 1)
        vDZ = vDZ - kick2z_rad*vR0z;
    end
end

% Kicks in [rad] :
vKicksX = idLeastSqLinFit(mCODx, vDX, arIndsBPMsToSkip); %vector of 2 (= number of kicks) elements
vKicksZ = idLeastSqLinFit(mCODz, vDZ, arIndsBPMsToSkip); %vector of 2 (= number of kicks) elements

% Integrals and kicks in [Gm] or [Gm^2]
[i1z, i2z, k1z, k2z] = idKicks2FldInt(vKicksX, 'x', idLen, idKickOfst, elecEn_GeV);
[i1x, i2x, k1x, k2x] = idKicks2FldInt(vKicksZ, 'z', idLen, idKickOfst, elecEn_GeV);
