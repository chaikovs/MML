function RUN_HU80_PLEIADES_BUMP()
% AFFICHAGE DE LA FREQUENCE RF
format long
getrf
% ENREGISTREMENT DE LA VALEUR DES CORRECTEURS DE LA MACHINE
hcor=getam('HCOR')
% VALEURS DES CORRECTEURS MACHINE À LEUR ANCIENNE VALEUR
setsp('HCOR',hcor)
% AFFICHAGE DES NOMBRES D'ONDE
gettune
% GENERATION DU BUMP EN X
setorbitbump('BPMx',[4 1;4 2],-1.0*[1;1],'HCOR',[-5 -4 -3 -2 -1 1 2 3 4 5],'FitRF')
% ENREGISTREMENT DE L'ORBITE L'ENTREFER 240 MM ET 15.5 MM
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_0mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_0mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-1mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-1mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-2mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-2mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-3mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-3mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-4mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-4mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-5mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-5mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-6mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-6mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-7mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-7mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-8mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-8mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-9mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-9mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-10mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_-10mm_G155'], 0);

setsp('HCOR',hcor)

Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_2_0mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_2_0mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_1mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_1mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_2mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_2mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_3mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_3mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_4mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_4mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_5mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_5mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_6mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_6mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_7mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_7mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_8mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_8mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_9mm_G155'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_9mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_10mm_G2400'], 0);
Orbit=idMeasElecBeamUnd_NoTime('HU80_PLEIADES', 0, ['/home/operateur/GrpGMI/HU80_PLEIADES/SESSION_20_09_10/BUMP_10mm_G155'], 0);

end
