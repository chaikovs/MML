function AnalyseOrbitAndFixTheGapStep(SESSION,CellName,SSType,UndType,TableName,OrbitMax)
UndNameAndPath=['/usr/Local/configFiles/InsertionFFTables/' CellName '-' UndType '/' TableName]
ID_param=importdata(UndNameAndPath);
param_length=length(ID_param);
t0=1; % time between points

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
idDevServDiag=[CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionX']
for j=param_length:-1:1
    Gap(j)=ID_param(1,j)
%    writeattribute(idDevServGap,Gap(j));
    pause(t0);
    readattribute(idDevServDiag,PosX(j));
end
Gradient=diff(PosX)./diff(Gap);
end
