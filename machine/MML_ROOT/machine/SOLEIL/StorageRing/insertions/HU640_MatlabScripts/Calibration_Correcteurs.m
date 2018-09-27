function Calibration_Correcteurs()
Folder =['/home/data/GMI/HU640_DESIRS/CORRECTEURS_ACTIFS/']
%%%%%%%%%%%%%%%% Name of DS of Correctors %%%%%%%%%%%%%%%%%%%%%%%%%
idDevServCHE=['ANS-C05/EI/L-HU640_Corr2'];
idDevServCHS=['ANS-C05/EI/L-HU640_Corr1'];
idDevServCVE=['ANS-C05/EI/L-HU640_Corr4'];
idDevServCVS=['ANS-C05/EI/L-HU640_Corr3'];
t=10
idSetCurrentSync(idDevServCHE,0, 0.01);
idSetCurrentSync(idDevServCHS,0, 0.01);
idSetCurrentSync(idDevServCVE,0, 0.01);
idSetCurrentSync(idDevServCVS,0, 0.01);
pause(2*t)

%Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'TEST_DS_BPM'], 0);

%%%%%%%%%%%%%%%% Corrector 1: CHS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idSetCurrentSync(idDevServCHS,-1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr1_m10A'], 0);

idSetCurrentSync(idDevServCHS,-0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr1_m05A'], 0);

idSetCurrentSync(idDevServCHS,0, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr1_000A'], 0);

idSetCurrentSync(idDevServCHS,+0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr1_p05A'], 0);

idSetCurrentSync(idDevServCHS,+1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr1_p10A'], 0);

idSetCurrentSync(idDevServCHS,0, 0.01);
pause(2*t)
%%%%%%%%%%%%%%%% Corrector 2: CHE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idSetCurrentSync(idDevServCHE,-1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr2_m10A'], 0);

idSetCurrentSync(idDevServCHE,-0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr2_m05A'], 0);

idSetCurrentSync(idDevServCHE,0, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr2_000A'], 0);

idSetCurrentSync(idDevServCHE,+0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr2_p05A'], 0);

idSetCurrentSync(idDevServCHE,+1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr2_p10A'], 0);

idSetCurrentSync(idDevServCHE,0, 0.01);
pause(2*t)
%%%%%%%%%%%%%%%% Corrector 3: CVS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idSetCurrentSync(idDevServCVS,-1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr3_m10A'], 0);

idSetCurrentSync(idDevServCVS,-0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr3_m05A'], 0);

idSetCurrentSync(idDevServCVS,0, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr3_000A'], 0);

idSetCurrentSync(idDevServCVS,+0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr3_p05A'], 0);

idSetCurrentSync(idDevServCVS,+1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr3_p10A'], 0);

idSetCurrentSync(idDevServCVS,0, 0.01);
pause(2*t)
%%%%%%%%%%%%%%%% Corrector 4: CVE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idSetCurrentSync(idDevServCVE,-1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr4_m10A'], 0);

idSetCurrentSync(idDevServCVE,-0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr4_m05A'], 0);

idSetCurrentSync(idDevServCVE,0, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr4_000A'], 0);

idSetCurrentSync(idDevServCVE,+0.5, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr4_p05A'], 0);

idSetCurrentSync(idDevServCVE,+1, 0.01);
pause(2*t)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [Folder 'HU640_Corr4_p10A'], 0);

idSetCurrentSync(idDevServCVE,0, 0.01);
pause(2*t)
