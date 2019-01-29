function TestForDS2_LV(ModeName,TableName)
fid= fopen(['/usr/Local/configFiles/InsertionFFTables/ANS-C05-HU640/' TableName '_Corr_Table'], 'r');
PS1Name='PS1';
CHEName='CHE';
CVEName='CVE';
CHSName='CHS';
CVSName='CVS';
ENERGYName='Energy';
DRFName='DRF';
for i=1:ValueNumber
    PS1(i)=0; 
    CHE(i)=0;
    CVE(i)=0;
    CVS(i)=0;
    CHS(i)=0;
    Energy(i)=0;
    DRF(i)=0;
end
fid= fopen(['/usr/Local/configFiles/InsertionFFTables/ANS-C05-HU640/' ModeName '_VD'], 'w');
fprintf(fid,'%s\n','<?xml version="1.0" encoding="UFT-8"?>');
fprintf(fid,'%s\n','<!DOCTYPE UNDULATOR_MODE SYSTEM "Undulators_data_model.dtd">');
fprintf(fid,'%s\n','<!-- Written on 17-Oct-2008 -->');
fprintf(fid,'%s\n','<UNDULATOR_MODE UNDULATOR_NAME="HU640" MODE_NAME="CIRCULAR_RIGHT" MODE_KIND="BASIC_MODE" HORIZONTAL_PS="PS1" VERTICAL_PS="PS2 PS3">');

Spaces(fid,0);
fprintf(fid,'%s\n','<BASIC_TABLES>');
Spaces(fid,1);
fprintf(fid,'%s\n','<POWER_SUPPLY_TABLES>');
Spaces(fid,2);
fprintf(fid,'%s\n','<MAIN_PS>');

PrintTable(fid,3,PS1Name,PS1);
PrintTable(fid,3,CVEName,CVE);
PrintTable(fid,3,CHEName,CHE);
PrintTable(fid,3,CVSName,CVS);
PrintTable(fid,3,CHSName,CHS);
PrintTable(fid,3,ENERGYName,Energy);
PrintTable(fid,3,DRFName,DRF);

Spaces(fid,2);
fprintf(fid,'%s\n','</MAIN_PS>');
Spaces(fid,1);
fprintf(fid,'%s\n','</POWER_SUPPLY_TABLES>');
Spaces(fid,0);
fprintf(fid,'%s\n','</BASIC_TABLES>');

fclose(fid)
end