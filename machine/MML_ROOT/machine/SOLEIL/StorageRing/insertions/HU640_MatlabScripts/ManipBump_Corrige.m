function ManipBump_Corrige(SESSION,X,PSName)

    global CHE
    global CHS
    global CVE
    global CVS
MeasDataPath=['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/' PSName];
PathAndBckgFileName=[MeasDataPath '/Bckg'];

idDevServMainPS1='ans-c05/ei/l-hu640_PS1';
idDevServCHE='ans-c05/ei/l-hu640_Corr2';
idDevServCHS='ans-c05/ei/l-hu640_corr1';
idDevServCVE='ans-c05/ei/l-hu640_corr4';
idDevServCVS='ans-c05/ei/l-hu640_corr3';
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0,PathAndBckgFileName, 0);

devemit = 'ANS-C02/DG/PHC-EMIT';
fprintf('%s\n','BUMP[mm]         Current[A]      EpsZ[nm.rd]     EpsX[pm.rd]     Couplage[%]     SigX[mic]       SigZ[mic]         TuneX         TuneZ          Iz[G.m]          Ix[G.m]               Life Time')

for PS1=[-600,-300,600,300,0]
idSetCurrentSync(idDevServCHE, 0, 0.01);
idSetCurrentSync(idDevServCHS, 0, 0.01);
idSetCurrentSync(idDevServCVE, 0, 0.01);
idSetCurrentSync(idDevServCVS, 0, 0.01);
idSetCurrentSync(idDevServMainPS1, PS1, 0.1);
pause(5)
FileName=['BUMP_' Num2Str(X) 'PS1_' Num2Str(PS1)];
PathAndFileName=[MeasDataPath '/' FileName];
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_0'], 0);
st=idCalcFldIntFromElecBeamMeasForUndSOLEIL_1('HU640_DESIRS',MeasDataPath,[PathAndFileName '_0'], PathAndBckgFileName,'', -1);
Result=HU640_CalculateCorrCur([PathAndFileName '_0'], PathAndBckgFileName);
idSetCurrentSync(idDevServCHE, CHE, 0.01);
idSetCurrentSync(idDevServCHS, CHS, 0.01);
idSetCurrentSync(idDevServCVE, CVE, 0.01);
idSetCurrentSync(idDevServCVS, CVS, 0.01);
pause(5)

CHE0=CHE;
CHS0=CHS;
CVE0=CVE;
CVS0=CVS;
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_1'], 0);
Result=HU640_CalculateCorrCur([PathAndFileName '_1'], PathAndBckgFileName);
CHE0=CHE+CHE0;
CHS0=CHS+CHS0;
CVE0=CVE+CVE0;
CVS0=CVS+CVS0;
idSetCurrentSync(idDevServCHE, CHE0, 0.01);
idSetCurrentSync(idDevServCHS, CHS0, 0.01);
idSetCurrentSync(idDevServCVE, CVE0, 0.01);
idSetCurrentSync(idDevServCVS, CVS0, 0.01);
pause(240)

EmittanceV=readattribute([devemit '/EmittanceV']);
EmittanceH=readattribute([devemit '/EmittanceH']);
Couplage=readattribute([devemit '/Coupling']);
SigH=readattribute([devemit '/SrcPointSigmaH']);
SigV=readattribute([devemit '/SrcPointSigmaV']);
LifeTime=readattribute(['ANS-C03/DG/DCCT/lifeTime']);
Tune=gettune;
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',X,PS1,Couplage,Tune(1),Tune(2),st.I1X,st.I1Z);
end

