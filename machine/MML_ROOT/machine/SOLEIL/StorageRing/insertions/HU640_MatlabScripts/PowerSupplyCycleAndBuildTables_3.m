
function Result=PowerSupplyCycleAndBuildTables_3(SESSION,PSName,IPS,CyclageYesNo,CorrectionRFYesNo,NValue,to);

% Build FF Tables for the Power supply PSName varying from -IPS and +IPS N
% Hysteresis cycle from Zero to IPS to -IPS to Zero is firstly applied
% 
% PSName: Name of the Power supply
% IPS: Maximum value of the power supply
% SESSION is the name of the folder in which Data are saved
% NValue is the number of value in the whole cycle
% CyclageYesNo: execute Cycle if CyclageYesNo=1
% CorrectionRFYesNo: correction the RF shift due to the undulator when CorrectionRFYesNo=1
% to: delay between step in seconde
% Example: PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS1',600,0,0,40,5)
    global CHE
    global CHS
    global CVE
    global CVS
FileName=[PSName '_' Num2Str(IPS)];
MeasDataPath=['/home/data/GMI/HU640_DESIRS/' SESSION '/' PSName];
PathAndFileName=[MeasDataPath '/' FileName];
PathAndBckgFileName=[MeasDataPath '/' FileName '_Bckg'];
getx;
getz;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(PSName,'IPS1')==1
    AlpPS=1.4049e-4;
end
if strcmp(PSName,'IPS2')==1
    AlpPS=2.4841e-4;
end
if strcmp(PSName,'IPS3')==1
    AlpPS=2.9748e-4;
end
% Catch the frequency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=getrf()
% Indicate the location of the Device Servers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idDevServMain=['ans-c05/ei/l-hu640_' PSName];
idDevServCHE=['ans-c05/ei/l-hu640_corr2'];
idDevServCHS=['ans-c05/ei/l-hu640_corr1'];
idDevServCVE=['ans-c05/ei/l-hu640_corr4'];
idDevServCVS=['ans-c05/ei/l-hu640_corr3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=NValue;
% SET CURRENT TO ZERO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idSetCurrentSync(idDevServCHE, 0, 0.01);
idSetCurrentSync(idDevServCHS, 0, 0.01);
idSetCurrentSync(idDevServCVE, 0, 0.01);
idSetCurrentSync(idDevServCVS, 0, 0.01);
% HYSTERESIS CYCLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if CyclageYesNo == 1
idSetCurrentSync(idDevServMain, -IPS, 0.1);
pause(to);
idSetCurrentSync(idDevServMain, IPS, 0.1);
pause(to);
idSetCurrentSync(idDevServMain, 0, 0.1);
pause(to);
idSetCurrentSync(idDevServMain, -IPS, 0.1);
pause(to);
idSetCurrentSync(idDevServMain, IPS, 0.1);
pause(to);
idSetCurrentSync(idDevServMain, 0, 0.1);
pause(to);

fprintf('%s\n','CYCLAGE TERMINE !!!')
pause(5)
end
fprintf('%s\t %s\t %s\t %s\t %s\t %s\n','PSName','CHE [A]', 'CHS [A]', 'CVE [A]', 'CVS [A]    ','UpDown');
fprintf('%s\n','*******************************************************************************************');

fid= fopen(['/home/data/GMI/HU640_DESIRS/' SESSION '/' PSName '_Table'], 'w');
% ATTRIBUTE THE VALUES TO CORRECTORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CHE0=readattribute(['ans-c05/ei/l-hu640_Corr2/current']);
%CHS0=readattribute(['ans-c05/ei/l-hu640_Corr1/current']); 
%CVE0=readattribute(['ans-c05/ei/l-hu640_Corr4/current']); 
%CVS0=readattribute(['ans-c05/ei/l-hu640_Corr3/current']); 
CHE0=0;
CHS0=0;
CVE0=0; 
CVS0=0; 
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(2*to)
j=1;

% DOWNWARD TABLE PART %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=0:-1:-N 
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0,PathAndBckgFileName, 0);
UpDown=-1;
writeattribute([idDevServMain '/current'], i*IPS/N);
pause(to)
% RF FREQUENCY CORRECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NewRF=f0-275.95e-6*(AlpPS*i*IPS/N)^2;
%DeltaRF=-275.95e-6*((AlpPS*IPS/N)^2)*(2*i-1);
if i==0
    DeltaRF=0;
end

%if abs(NewRF-f0)>20e-6
%fprintf('%s\n','DELTA DE FREQUENCE EN Hz:');
%fprintf('%8.4f\n',NewRF)
%fprintf('%s\n','DELTA DE FREQUENCE SUPERIEURE A 20 Hz');
%fprintf('%s\n','LA CORRECTION EN FREQUENCE N''EST PAS APPLIQUEE');
%DeltaRF=0;
%end
if CorrectionRFYesNo==1
    steprf(DeltaRF);
end
pause(to)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileName=[PSName Num2Str(round((i*IPS/N)*1000))];
PathAndFileName=[MeasDataPath '/' FileName];
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_Up_0'], 0);
Result=HU640_CalculateCorrCur([PathAndFileName '_Up_0'], PathAndBckgFileName);
CHE0=CHE0+CHE;
CHS0=CHS0+CHS;
CVE0=CVE0+CVE;
CVS0=CVS0+CVS;
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(to)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_Up1'], 0);
Result=HU640_CalculateCorrCur([PathAndFileName '_Up1'], PathAndBckgFileName);
CHE0=CHE0+CHE;
CHS0=CHS0+CHS;
CVE0=CVE0+CVE;
CVS0=CVS0+CVS;
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(to)
fprintf(fid,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f %2.0f\t\n',i*IPS/N,CHE0, CHS0, CVE0, CVS0,UpDown);
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f %2.0f\t\n',i*IPS/N,CHE0, CHS0, CVE0, CVS0,UpDown);

PS(j)=i*IPS/N;
CCVE(j)=CVE0;
CCHE(j)=CHE0;
CCVS(j)=CVS0;
CCHS(j)=CHS0;
j=j+1;

end

% UPWARD TABLE PART %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=-N+1:1:N-1  
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0,PathAndBckgFileName, 0);
writeattribute([idDevServMain '/current'], i*IPS/N);
UpDown=+1;
pause(to)
% RF FREQUENCY CORRECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NewRF=f0-275.95e-6*(AlpPS*i*IPS/N)^2;
%DeltaRF=-275.95e-6*((AlpPS*IPS/N)^2)*(2*i-1);
if i==0
    DeltaRF=0;
end

%if abs(NewRF-f0)>20e-6
%fprintf('%s\n','DELTA DE FREQUENCE EN Hz:');
%fprintf('%8.4f\n',NewRF)
%fprintf('%s\n','DELTA DE FREQUENCE SUPERIEURE A 20 Hz');
%fprintf('%s\n','LA CORRECTION EN FREQUENCE N''EST PAS APPLIQUEE');
%DeltaRF=0;
%end

if CorrectionRFYesNo==1
    steprf(DeltaRF);
end
pause(to)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileName=[PSName Num2Str(round((i*IPS/N)*1000))];
PathAndFileName=[MeasDataPath '/' FileName];
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_Down_0'], 0);
Result=HU640_CalculateCorrCur([PathAndFileName '_Down_0'], PathAndBckgFileName);
CHE0=CHE0+CHE;
CHS0=CHS0+CHS;
CVE0=CVE0+CVE;
CVS0=CVS0+CVS;
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(to)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_Down1'], 0);
Result=HU640_CalculateCorrCur([PathAndFileName '_Down1'], PathAndBckgFileName);
CHE0=CHE0+CHE;
CHS0=CHS0+CHS;
CVE0=CVE0+CVE;
CVS0=CVS0+CVS;
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(to)

fprintf(fid,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f %2.0f\t\n',i*IPS/N,CHE0, CHS0, CVE0, CVS0,UpDown);
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f %2.0f\t\n',i*IPS/N,CHE0, CHS0, CVE0, CVS0,UpDown);

PS(j)=i*IPS/N;
CCVE(j)=CVE0;
CCHE(j)=CHE0;
CCVS(j)=CVS0;
CCHS(j)=CHS0;
j=j+1;

end

for i=N:-1:0  
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0,PathAndBckgFileName, 0);
writeattribute([idDevServMain '/current'], i*IPS/N);
UpDown=-1;
pause(to)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileName=[PSName Num2Str(round((i*IPS/N)*1000))];
PathAndFileName=[MeasDataPath '/' FileName];
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_Down_0'], 0);
Result=HU640_CalculateCorrCur([PathAndFileName '_Down_0'], PathAndBckgFileName);
pause(to)
CHE0=CHE0+CHE;
CHS0=CHS0+CHS;
CVE0=CVE0+CVE;
CVS0=CVS0+CVS;
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(to)
Orbit=idMeasElecBeamUnd('HU640_DESIRS', 0, [PathAndFileName '_Down1'], 0);
Result=HU640_CalculateCorrCur([PathAndFileName '_Down1'], PathAndBckgFileName);
CHE0=CHE0+CHE;
CHS0=CHS0+CHS;
CVE0=CVE0+CVE;
CVS0=CVS0+CVS;
writeattribute([idDevServCHE '/current'], CHE0);
writeattribute([idDevServCHS '/current'], CHS0);
writeattribute([idDevServCVE '/current'], CVE0);
writeattribute([idDevServCVS '/current'], CVS0);
pause(to)

fprintf(fid,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f %2.0f\t\n',i*IPS/N,CHE0, CHS0, CVE0, CVS0,UpDown);
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f %2.0f\t\n',i*IPS/N,CHE0, CHS0, CVE0, CVS0,UpDown);

PS(j)=i*IPS/N;
CCVE(j)=CVE0;
CCHE(j)=CHE0;
CCVS(j)=CVS0;
CCHS(j)=CHS0;
j=j+1;

end

fclose(fid);

fidICA= fopen(['/usr/Local/configFiles/InsertionFFTables/ANS-C05-HU640/' PSName], 'w');

for j=1:4*N
 fprintf(fidICA,'%8.4f\t',PS(j));   
end   
fprintf(fidICA,'\n'); 

for j=1:4*N
 fprintf(fidICA,'%8.4f\t',CCHE(j));   
end   
fprintf(fidICA,'\n'); 

for j=1:4*N
 fprintf(fidICA,'%8.4f\t',CCHS(j));   
end   
fprintf(fidICA,'\n'); 

for j=1:4*N
 fprintf(fidICA,'%8.4f\t',CCVE(j));   
end   
fprintf(fidICA,'\n'); 

for j=1:4*N
 fprintf(fidICA,'%8.4f\t',CCVS(j));   
end   
fprintf(fidICA,'\n'); 
fclose(fidICA); 
 

fid_Index_PS=fopen(['/home/data/GMI/HU640_DESIRS/' SESSION '/Index_' PSName '_Table.txt'],'w');
fprintf(fid_Index_PS,'%s\n','0 0 0 0 0 1');
fclose(fid_Index_PS);