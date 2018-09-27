function AnalyseOrbitAndFixTheGapStep(NewTable,CellName,SSType,UndType,TableName,OrbitMax)
% SESSION: Folder where the data are stored: must be created previously
% CellName: name of the cell in the SR: for ex. ANS-C11
% SSType: Type of Straight Section: C or M or L
% UndType: Type of ID: U18 (CRYO), U20, U24 or WSV50
% TableName : Name of the FF Table: for ex. FF_SIXS.txt. This table must
% previously exists, otherwise use GenerateFFtableWithZeros which creates a
% FF tables containing zeros with linear or exponential step
% OrbitMax: Maximum acceptable value of the Orbit in microns
% Example:
% AnalyseOrbitAndFixTheGapStep('FF_TEST.txt','ANS-C03','C','WSV50','FF_PSICHE.txt',5)
UndNameAndPath=['/usr/Local/configFiles/InsertionFFTables/' CellName '-' UndType '/' TableName]
ID_param=importdata(UndNameAndPath);
param_length=length(ID_param);
t0=25; % time between points

% ID_param(i,j):
%               ID_param(1,j): line corresponding to the gap for any value of j
%               ID_param(2,j): line corresponding to CHE for any value of j
%               ID_param(3,j): line corresponding to CHS for any value of j
%               ID_param(4,j): line corresponding to CVE for any value of j
%               ID_param(5,j): line corresponding to CVS for any value of j
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ATTRIBUTE OF THE INSERTION DEVICE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idDevServGap=[CellName '/ei/' SSType '-' UndType '/gap'];
idDevServDiagX=[CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionX'];
idDevServDiagZ=[CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionZ'];
fprintf('%s\t %s\t %s\n','X [microns]','Z [microns]', 'Entrefer [mm]');
for j=param_length:-1:1
    Gap(j)=ID_param(1,j);
end

for j=param_length:-1:1
    writeattribute(idDevServGap,Gap(j));
    pause(t0)
    PosX(j)=readattribute(idDevServDiagX);
    PosZ(j)=readattribute(idDevServDiagZ);
    fprintf('%8.4f\t %8.4f\t %8.4f\n',PosX(j),PosZ(j),Gap(j));
end
Pos=(PosX.*PosX+PosZ.*PosZ).^(0.5);
GapNew=AddPointsToStayUnderFixedValue(PosX,Gap,OrbitMax)
fid= fopen(['/usr/Local/configFiles/InsertionFFTables/' CellName '-' UndType '/' NewTable], 'w');
for N=1:length(GapNew)
    fprintf(fid,'%8.1f\t',GapNew(N));
end
fprintf(fid,'\n'); 
for N=1:length(GapNew)
    CHE(N)=0;
    fprintf(fid,'%8.4f\t',CHE(N));
end
fprintf(fid,'\n'); 
for N=1:length(GapNew)
    CHS(N)=0;
    fprintf(fid,'%8.4f\t',CHS(N));
end
fprintf(fid,'\n'); 
for N=1:length(GapNew)
    CVE(N)=0;
    fprintf(fid,'%8.4f\t',CVE(N));
end
fprintf(fid,'\n'); 
for N=1:length(GapNew)
    CVS(N)=0;
    fprintf(fid,'%8.4f\t',CVS(N));
end
fprintf(fid,'\n'); 
fclose(fid);
end
