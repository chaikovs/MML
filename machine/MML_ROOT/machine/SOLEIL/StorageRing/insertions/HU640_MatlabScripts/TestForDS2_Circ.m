function TestForDS2_Circ(NValue)
PS1Name='PS1';
PS2Name='PS2';
PS3Name='PS3';
CHEName='CHE';
CVEName='CVE';
CHSName='CHS';
CVSName='CVS';
ENERGYName='Energy';
DRFName='DRF';


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

PrintTable(fid,3,PS1Name,HU640.RightCirc.PS1);
PrintTable(fid,3,PS2Name,HU640.RightCirc.PS2);
PrintTable(fid,3,PS3Name,HU640.RightCirc.PS3);
PrintTable(fid,3,CVEName,HU640.RightCirc.CVE);
PrintTable(fid,3,CHEName,HU640.RightCirc.CHE);
PrintTable(fid,3,CVSName,HU640.RightCirc.CVS);
PrintTable(fid,3,CHSName,HU640.RightCirc.CHS);
PrintTable(fid,3,ENERGYName,HU640.RightCirc.Energy);

Spaces(fid,2);
fprintf(fid,'%s\n','</MAIN_PS>');
Spaces(fid,1);
fprintf(fid,'%s\n','</POWER_SUPPLY_TABLES>');
Spaces(fid,0);
fprintf(fid,'%s\n','</BASIC_TABLES>');




Spaces(fid,0);
fprintf(fid,'%s\n','<ALTERNATIVE_TABLES>');
Spaces(fid,1);
fprintf(fid,'%s\n','<CROSSED_TABLES>');

for i:1:Nvalue
Spaces(fid,2);
fprintf(fid,'%s %i %s\n','<POWER_SUPPLY_TABLES> CROSSED_CURSOR_VALUE="',i,'">');

Spaces(fid,3);
fprintf(fid,'%s\n','<MAIN_PS>');

PrintTable(fid,4,PS1Name,HU640.Switch.PS1);
PrintTable(fid,4,PS2Name,HU640.Switch.PS2(i));
PrintTable(fid,4,PS3Name,HU640.Switch.PS3(i));
PrintTable(fid,4,CVEName,HU640.Switch.CVE);
PrintTable(fid,4,CHEName,HU640.Switch.CHE);
PrintTable(fid,4,CVSName,HU640.Switch.CVS);
PrintTable(fid,4,CHSName,HU640.Switch.CHS);
PrintTable(fid,4,ENERGYName,HU640.Switch.Energy);

Spaces(fid,3);
fprintf(fid,'%s\n','</MAIN_PS>');
Spaces(fid,2);
fprintf(fid,'%s\n','</POWER_SUPPLY_TABLES>');
end
Spaces(fid,1);
fprintf(fid,'%s\n','<CROSSED_TABLES>');
Spaces(fid,0);
fprintf(fid,'%s\n','</ALTERNATIVE_TABLES>');

fclose(fid)
end