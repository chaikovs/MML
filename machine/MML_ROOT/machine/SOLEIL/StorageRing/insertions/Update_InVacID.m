function Update_InVacID(SESSION,CellName,SSType,UndType,TableName,SufUndName)
% SESSION: Folder where the data are stored: must be created previously
% CellName: name of the cell in the SR: for ex. ANS-C11
% SSType: Type of Straight Section: C or M or L
% UndType: Type of ID: U18 CRYO, U20, U24 or WSV50
% TableName : Name of the FF Table: for ex. FF_SIXS.txt. This table must
% previously exists, otherwise use GenerateFFtableWithZeros which creates a
% FF tables containing zeros with exponential step
% SufUndName is the suffix which indicates the position of the ID in the
% Straight Section: SufUndName can be:
%   '': when no other ID is installed in the SS
%   '.1','.2' ...: when the ID is installed at the position 1,2 ...
% Example:  Update_InVacID('SESSION_24_01_10','ANS-C11','M','U24','FF_PROXIMA2.txt','')
% Example:  Update_InVacID('SESSION_24_01_10','ANS-C07','C','U20','FF_GALAXIES.txt','')
% Example:  Update_InVacID('SESSION_26_06_10','ANS-C03','C','WSV50','FF_PSICHE.txt','')
% Example:  Update_InVacID('SESSION_23_09_11','ANS-C13','L','U18','FF_TOMO.txt','.1')
% Example:  Update_InVacID('SESSION_06_11_11','ANS-C13','L','U20','FF_NANO.txt','.2')
% Example:  Update_InVacID('SESSION_26_10_13','ANS-C06','M','W164','FF_PUMA_SLICING.txt','')

    global CHE
    global CHS
    global CVE
    global CVS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getx % avoid NaN Values due to Timeout BPMs reading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% READ THE CORRECTORS CURRENT IN THE PREVIOUS FF TABLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
UndNameAndPath=['/usr/Local/configFiles/InsertionFFTables/' CellName '-' UndType '/' TableName]
ID_param=importdata(UndNameAndPath);
param_length=length(ID_param);
t0=5%10; % time between points

% ID_param(i,j):
%               ID_param(1,j): line corresponding to the gap for any value of j
%               ID_param(2,j): line corresponding to CHE for any value of j
%               ID_param(3,j): line corresponding to CVE for any value of j
%               ID_param(4,j): line corresponding to CHS for any value of j
%               ID_param(5,j): line corresponding to CVS for any value of j
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ATTRIBUTE OF THE INSERTION DEVICE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idDevServGap=[CellName '/ei/' SSType '-' UndType SufUndName '/gap']
idDevServCHE=[CellName '/ei/' SSType '-' UndType SufUndName '_CHAN1'];
idDevServCVE=[CellName '/ei/' SSType '-' UndType SufUndName '_CHAN2'];
idDevServCHS=[CellName '/ei/' SSType '-' UndType SufUndName '_CHAN3'];
idDevServCVS=[CellName '/ei/' SSType '-' UndType SufUndName '_CHAN4'];

str1 = strrep(TableName, 'FF', UndType);
UndName=strrep(str1, '.txt', '')
GrpGMIUndFolder =['/home/data/GMI/' UndName]
GrpGMIUndFolderAndSessionName=[GrpGMIUndFolder '/' SESSION]
PathAndBckgFileName=[GrpGMIUndFolder '/' SESSION '/Bckg']
Date=datestr(clock,'mmm-dd-yyyy HH:MM:SS')
%Position_SourceX=[CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionX'];
%Position_SourceZ=[CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionZ'];
%Orbit=idMeasElecBeamUnd(UndName, 0,PathAndBckgFileName, 0, 0);
fprintf('%s\t %s\t %s\t %s\t %s\n','ENTREFER','CHE [A]', 'CHS [A]', 'CVE [A]', 'CVS [A]');
DeviceName=[CellName '/ei/' SSType '-' UndType]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAVE THE BACKGROUND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Orbit=idMeasElecBeamUnd(UndName, 0,PathAndBckgFileName, 0, 0);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEEDFORWARD TABLE CONSTRUCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=param_length:-1:1

    UndFileName=[GrpGMIUndFolderAndSessionName '_' Num2Str(1000*ID_param(1,j))];
    % Read State of DS
    %data = tango_read_attribute2(DeviceName, 'State');
    %val = readattribute([DeviceName '/State']);
    
    % ORBIT BEFORE GAP MOTION
    
  pause(2) 
    Orbit=idMeasElecBeamUnd(UndName, 0,PathAndBckgFileName, 0, 0);
 pause(2)  
    
    % GAP Change
    writeattribute(idDevServGap,ID_param(1,j));
    %pause(t0)
    idSetCurrentSync(idDevServCHE, ID_param(2,j), 0.01);
    idSetCurrentSync(idDevServCVE, ID_param(3,j), 0.01);
    idSetCurrentSync(idDevServCHS, ID_param(4,j), 0.01);
    idSetCurrentSync(idDevServCVS, ID_param(5,j), 0.01);
    pause(t0)
    
    % ACQUISITION OF ORBIT AND CORRECTION CURRENT CALCULATION
    Orbit=idMeasElecBeamUnd(UndName, 0,UndFileName, 0, 0);
    Result=InVac_CalculateCorrCur(UndName,UndFileName, PathAndBckgFileName);
    NewCHE(j)=ID_param(2,j)+CHE;
    NewCVE(j)=ID_param(3,j)+CVE;
    NewCHS(j)=ID_param(4,j)+CHS;
    NewCVS(j)=ID_param(5,j)+CVS;
    
    % APPLYING THE CORRECTION CURRENT
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',ID_param(1,j),NewCHE(j), NewCHS(j), NewCVE(j), NewCVS(j));
    idSetCurrentSync(idDevServCHE, NewCHE(j), 0.01);
    idSetCurrentSync(idDevServCHS, NewCHS(j), 0.01);
    idSetCurrentSync(idDevServCVE, NewCVE(j), 0.01);
    idSetCurrentSync(idDevServCVS, NewCVS(j), 0.01);
    pause(t0)

    % SECOND CURRENT CORRECTION
    Orbit=idMeasElecBeamUnd(UndName, 0,UndFileName, 0, 0);
    Result=InVac_CalculateCorrCur(UndName,UndFileName, PathAndBckgFileName);
    NewCHE(j)=NewCHE(j)+CHE;
    NewCVE(j)=NewCVE(j)+CVE;
    NewCHS(j)=NewCHS(j)+CHS;
    NewCVS(j)=NewCVS(j)+CVS;

    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',ID_param(1,j),NewCHE(j), NewCHS(j), NewCVE(j), NewCVS(j));
    idSetCurrentSync(idDevServCHE, NewCHE(j), 0.01);
    idSetCurrentSync(idDevServCHS, NewCHS(j), 0.01);
    idSetCurrentSync(idDevServCVE, NewCVE(j), 0.01);
    idSetCurrentSync(idDevServCVS, NewCVS(j), 0.01);
    pause(t0)
    
    
    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAVE THE NEW FEEDFORWARD TABLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Date=datestr(clock,'mmm-dd-yyyy HH:MM:SS')
fidNew= fopen([GrpGMIUndFolder '/' SESSION '/' UndName '_' Date '.txt'], 'w');
for j=1:param_length
 fprintf(fidNew,'%8.4f\t',ID_param(1,j));   
end   
fprintf(fidNew,'\n'); 


% The order of storage of corrector values must be CHE, CHS, CVE, CVS. But in the Device Server CVE and CHS are reversed
for j=1:param_length
 fprintf(fidNew,'%8.4f\t',NewCHE(j));   
end   
fprintf(fidNew,'\n'); 

for j=1:param_length
 fprintf(fidNew,'%8.4f\t',NewCVE(j));   
end   
fprintf(fidNew,'\n'); 

for j=1:param_length
 fprintf(fidNew,'%8.4f\t',NewCHS(j));   
end   
fprintf(fidNew,'\n'); 

for j=1:param_length
 fprintf(fidNew,'%8.4f\t',NewCVS(j));   
end   
fprintf(fidNew,'\n'); 

copyfile([GrpGMIUndFolder '/' SESSION '/' UndName '_' Date '.txt'] ,['/usr/Local/configFiles/InsertionFFTables/' CellName '-' UndType '/FF.txt'])
copyfile([GrpGMIUndFolder '/' SESSION '/' UndName '_' Date '.txt'] ,['/usr/Local/configFiles/InsertionFFTables/' CellName '-' UndType '/FF_' Date '.txt'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GAP OPENING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for j=1:param_length
%    writeattribute(idDevServGap,ID_param(1,j));
%    pause(2)
%    idSetCurrentSync(idDevServCHE, NewCHE(j), 0.01);
%    idSetCurrentSync(idDevServCHS, NewCHS(j), 0.01);
%    idSetCurrentSync(idDevServCVE, NewCVE(j), 0.01);
%    idSetCurrentSync(idDevServCVS, NewCVS(j), 0.01);
%    pause(2)
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose(fidNew);
end
