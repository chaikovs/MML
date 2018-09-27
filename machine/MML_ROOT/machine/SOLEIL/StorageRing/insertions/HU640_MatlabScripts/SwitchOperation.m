function SwitchOperation()
MeasDataPath=['/home/operateur/GrpGMI/HU640_DESIRS/OnLineCorrection/'];
PathAndBckgFileName=[MeasDataPath 'Bckg'];


idDevServMainPS1=['ans-c05/ei/l-hu640_PS1'];
idDevServMainPS2=['ans-c05/ei/l-hu640_PS2'];
idDevServMainPS3=['ans-c05/ei/l-hu640_PS3'];

idDevServCHE=['ans-c05/ei/l-hu640_Corr2'];
idDevServCHS=['ans-c05/ei/l-hu640_corr1'];
idDevServCVE=['ans-c05/ei/l-hu640_corr4'];
idDevServCVS=['ans-c05/ei/l-hu640_corr3'];

ReadPS1=readattribute(['ans-c05/ei/l-hu640_PS1/current']); 

CHE0=-1.097e-4*ReadPS1+5.85e-3;
CHS0=-2.44223e-4*ReadPS1+1.125e-2;
CVE0=-1.0675e-4*ReadPS1+1.115e-2;
CVS0=-3.40152e-5*ReadPS1-2.50909e-3;


idSetCurrentSync(idDevServMainPS1,-ReadPS1, 0.3);
fprintf('%s\n','PS1 is moving')
idSetCurrentSync(idDevServCHE, CHE0, 0.01);
idSetCurrentSync(idDevServCHS, CHS0, 0.01);
idSetCurrentSync(idDevServCVE, CVE0, 0.01);
idSetCurrentSync(idDevServCVS, CVS0, 0.01);

