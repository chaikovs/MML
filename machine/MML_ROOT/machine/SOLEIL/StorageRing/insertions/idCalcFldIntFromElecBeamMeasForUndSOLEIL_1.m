function outStruct = idCalcFldIntFromElecBeamMeasForUndSOLEIL_1(idName, dirMeasData, fileNameMeasMain, fileNameMeasBkgr, dirModel, arIndsBPMsToSkip, kick2x_rad, kick2z_rad)

% Calculates field integrals and kicks
% INPUTS :  - idName : "standard" id Name, such as 'HU36_SIRIUS'
%           - dirMeasData : directory containing measurements
%           - fileNameMeasMain : name of measurement structure (id closed/on)
%           - fileNameMeasBkgr : name of background meas. structure (id opened/off)
%           - dirModel : how to select optical functions to be used (see
%              below)
%           - arIndsBPMsToSkip : [1xN] array of BPMs to be skipped. BPM
%           numbers are given by the function dev2elem('BPMx', [Cell
%           Index])
%           - kick2x_rad : 2nd order kick (in rad) given in the horizontal plane
%           - kick2z_rad : 2nd order kick (in rad) given in the vertical plane
%
% Choice of dirModel :
% - dirModel=nan => model is read from actual values in used in control room
%   (through soleilinit)
% - dirModel ='id' => model is read from saved data in id default directory 
%   (i.e. '/home/GrpGMI/HU36_SIRIUS')
% - dirModel='AnotherDirectory' => model is read from saved data in
%   'AnotherDirectory')
% - dirModel='' => model is read from current directory (which should be 
%   '/home/production/matlab/matlabML/machine/SOLEIL/StorageRing/insertions')
%
% OUTPUTS : - one structure containing fields :
%               - I1x : horizontal field 1st integral [G*m]
%               - I1z : vertical field 1st integral [G*m]
%               - I2x : horizontal field 2nd integral [G*m²]
%               - I2z : vertical field 2nd integral [G*m²]
%               - K1x : entrance kick of horizontal field [G*m]
%               - K1z : entrance kick of vertical field [G*m]
%               - K2x : exit kick of horizontal field [G*m]
%               - K2z : exit kick of vertical field [G*m]
%               - KicksX : 1x2 vector containing entrance and exit kicks
%               having effect in the horizontal plane [rad]
%               - KicksZ : 1x2 vector containing entrance and exit kicks
%               having effect in the vertical plane [rad]
%               - DX_Meas : 1x122 vector containing orbit difference in the
%               horizontal plane (difference between fileNameMeasMain and
%               fileNameMeasBkgr)
%               - DZ_Meas : idem in the vertical plane
%               - DX_Fit : same as DX_Meas, but computed from KicksX (to
%               check that integrals are correct?)
%               - DZ_Fit : same as DZ_Fit


GeomParUnd = idGetGeomParamForUndSOLEIL(idName);

ElecBeamModelData = idReadElecBeamModel(dirModel);
[mCODx, vR0x] = idCreateModelOrbDistMatr('x', ElecBeamModelData, GeomParUnd);
[mCODz, vR0z] = idCreateModelOrbDistMatr('z', ElecBeamModelData, GeomParUnd);

dirStart = pwd;
if strcmp(dirMeasData, '') == 0
	cd(dirMeasData);
end
ElecBeamMeasMain = load(char(fileNameMeasMain));
ElecBeamMeasBkgr = load(char(fileNameMeasBkgr));
cd(dirStart);

% Modif 26/03/2013 by F. Briquez : extracts also entrance and exit kicks in [Gm]
%[outStruct.I1X, outStruct.I2X, outStruct.I1Z, outStruct.I2Z] = idCalcFldIntFromElecBeamMeas(ElecBeamMeasMain, ElecBeamMeasBkgr, mCODx, mCODz, arIndsBPMsToSkip, GeomParUnd.idLen, GeomParUnd.idKickOfst, ElecBeamModelData.E, kick2x_rad, kick2z_rad, vR0x, vR0z);
[outStruct.I1X, outStruct.I2X, outStruct.I1Z, outStruct.I2Z, outStruct.K1X, outStruct.K2X, outStruct.K1Z, outStruct.K2Z] = idCalcFldIntFromElecBeamMeas(ElecBeamMeasMain, ElecBeamMeasBkgr, mCODx, mCODz, arIndsBPMsToSkip, GeomParUnd.idLen, GeomParUnd.idKickOfst, ElecBeamModelData.E, kick2x_rad, kick2z_rad, vR0x, vR0z);


outStruct.DX_Meas = ElecBeamMeasMain.X - ElecBeamMeasBkgr.X;
outStruct.DZ_Meas = ElecBeamMeasMain.Z - ElecBeamMeasBkgr.Z;
outStruct.KicksX = idLeastSqLinFit(mCODx, outStruct.DX_Meas, arIndsBPMsToSkip);
outStruct.KicksZ = idLeastSqLinFit(mCODz, outStruct.DZ_Meas, arIndsBPMsToSkip);
outStruct.DX_Fit = mCODx*outStruct.KicksX;
outStruct.DZ_Fit = mCODz*outStruct.KicksZ;
