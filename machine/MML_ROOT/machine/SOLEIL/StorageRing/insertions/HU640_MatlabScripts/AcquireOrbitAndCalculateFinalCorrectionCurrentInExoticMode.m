function AcquireOrbitAndCalculateFinalCorrectionCurrentInExoticMode(SESSION, PSName,PS,BckgYesNo)
% Example: AcquireOrbitAndCalculateFinalCorrectionCurrentInExoticMode('SESSION_22_01_11', 'PS1',600)
    global CHE
    global CHS
    global CVE
    global CVS
getx
MeasDataPath=['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION];
idDevServPS=['ans-c05/ei/l-hu640/current' PSName];
idDevServPS1=['ans-c05/ei/l-hu640_PS1'];
idDevServPS2=['ans-c05/ei/l-hu640_PS2'];
idDevServPS3=['ans-c05/ei/l-hu640_PS3'];
idDevServCHE=['ans-c05/ei/l-hu640_corr2'];
idDevServCHS=['ans-c05/ei/l-hu640_corr1'];
idDevServCVE=['ans-c05/ei/l-hu640_corr4'];
idDevServCVS=['ans-c05/ei/l-hu640_corr3'];


t=60
    
    
fid= fopen(['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/Exotic_Table.txt'], 'a');
PathAndBckgFileName=[MeasDataPath '/Bckg'];
if BckgYesNo==1
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndBckgFileName], 0);
end
writeattribute([idDevServPS], PS);
pause(t)
PS1=readattribute(['ans-c05/ei/l-hu640_PS1/current']);
PS2=readattribute(['ans-c05/ei/l-hu640_PS2/current']); 
PS3=readattribute(['ans-c05/ei/l-hu640_PS3/current']); 
CHE0=readattribute(['ans-c05/ei/l-hu640_Corr2/current']);
CHS0=readattribute(['ans-c05/ei/l-hu640_Corr1/current']); 
CVE0=readattribute(['ans-c05/ei/l-hu640_Corr4/current']); 
CVS0=readattribute(['ans-c05/ei/l-hu640_Corr3/current']); 


FileName=['PS1_' Num2Str(round((PS1)*1000)) '_PS2_' Num2Str(round((PS2)*1000)) '_PS3_' Num2Str(round((PS3)*1000))];
PathAndFileName=[MeasDataPath '/' FileName];
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName], 0);
Result=HU640_CalculateCorrCur([PathAndFileName], PathAndBckgFileName);
CHE1=CHE0+CHE;
CHS1=CHS0+CHS;
CVE1=CVE0+CVE;
CVS1=CVS0+CVS;
writeattribute([idDevServCHE '/current'], CHE1);
writeattribute([idDevServCHS '/current'], CHS1);
writeattribute([idDevServCVE '/current'], CVE1);
writeattribute([idDevServCVS '/current'], CVS1);
pause(10)
fprintf('%s\t %s\n','                                                                  AVANT CORRECTION ', '                                         APRES CORRECTION ');
fprintf('%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', 'PS1            ', 'PS2          ', 'PS3          ', 'CHE          ', 'CHS         ', 'CVE          ', 'CVS          ', 'CHE          ', 'CHS          ', 'CVE          ', 'CVS          ');
fprintf(fid,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n', PS1, PS2, PS3, CHE0, CHS0, CVE0, CVS0, CHE1, CHS1, CVE1, CVS1);
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n', PS1, PS2, PS3, CHE0, CHS0, CVE0, CVS0, CHE1, CHS1, CVE1, CVS1);
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(10)
fclose(fid);
end

