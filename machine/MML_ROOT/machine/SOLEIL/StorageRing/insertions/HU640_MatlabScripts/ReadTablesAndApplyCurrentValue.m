function ReadTablesAndApplyCurrentValue(SESSION,PSName,PS)
% Read the Single Power Supply Table (PS1, PS2 or PS3), Apply the Correction value to correctors CHE, CHS, CVE, CVS
% taking into account the current value of the other Main Power Supply and Correctors
% SESSION: SESSION where saved the data: 'SESSION_06_10_08'
% PSName: Name of the power supply to driven
% PS: Value of the current to be applied
% Example: ReadTablesAndApplyCurrentValue('SESSION_06_10_08','PS1',600)
if (strcmp(PSName,'PS1')==0) && (abs(PS)>600)
    fprintf('%s\n','OUT OF RANGE')
end

if (strcmp(PSName,'PS2')==0) && (abs(PS)>440)
    fprintf('%s\n','OUT OF RANGE')
end

if (strcmp(PSName,'PS3')==0) && (abs(PS)>360) %#ok<STCMP>
    fprintf('%s\n','OUT OF RANGE')
end
% Offset to be added to corrector current %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid_Index_PS1=fopen(['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/Index_PS1'],'r');
A1=fscanf(fid_Index_PS1,'%g %g %g %g %g %g',[6 1]);

fid_Index_PS2=fopen(['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/Index_PS2'],'r');
A2=fscanf(fid_Index_PS2,'%g %g %g %g %g %g',[6 1]);

fid_Index_PS3=fopen(['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/Index_PS3'],'r');
A3=fscanf(fid_Index_PS3,'%g %g %g %g %g %g',[6 1]);

if (strcmp(PSName,'PS1')==1)
    CHE_Offset=A2(2,1)+A3(2,1);
    CHS_Offset=A2(3,1)+A3(3,1);
    CVE_Offset=A2(4,1)+A3(4,1);
    CVS_Offset=A2(5,1)+A3(5,1);
end    
if (strcmp(PSName,'PS2')==1)
    CHE_Offset=A1(2,1)+A3(2,1);
    CHS_Offset=A1(3,1)+A3(3,1);
    CVE_Offset=A1(4,1)+A3(4,1);
    CVS_Offset=A1(5,1)+A3(5,1);
end    
if (strcmp(PSName,'PS3')==1)
    CHE_Offset=A1(2,1)+A2(2,1);
    CHS_Offset=A1(3,1)+A2(3,1);
    CVE_Offset=A1(4,1)+A2(4,1);
    CVS_Offset=A1(5,1)+A2(5,1);
end    
fclose(fid_Index_PS1);
fclose(fid_Index_PS2);
fclose(fid_Index_PS3);

PS_path=['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/' PSName '_Table'];
% Indicate the location of the Device Servers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idDevServMainPS=['ans-c05/ei/l-hu640_' PSName];
idDevServCHE=['ans-c05/ei/l-hu640_corr2'];
idDevServCHS=['ans-c05/ei/l-hu640_corr1'];
idDevServCVE=['ans-c05/ei/l-hu640_corr4'];
idDevServCVS=['ans-c05/ei/l-hu640_corr3'];

fid_PS=fopen(PS_path,'r');

fid_Index_PS=fopen(['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/Index_' PSName],'r');
A=fscanf(fid_Index_PS,'%g %g %g %g %g %g',[6 1]);
Index_PS_Read=A(6,1);
PS_Read=A(1,1);
fclose(fid_Index_PS);
if PS==PS_Read
    fprintf('%s\n','SAME VALUE')
end
if PS~=PS_Read

fid_Index_PS=fopen(['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/Index_' PSName],'w');
A_PS=fscanf(fid_PS,'%g %g %g %g %g %g',[6 inf]);
N=length(A_PS);
i=Index_PS_Read;

while (PS~=A_PS(1,i)) || (A_PS(6,i)~=-1)
    CHE= A_PS(2,i);
    CHS= A_PS(3,i);
    CVE= A_PS(4,i);
    CVS= A_PS(5,i);
if i==N
%    seek(fid_PS, 0, 'bof');
    i=1;
end    
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',A_PS(1,i),CHE+CHE_Offset, CHS+CHS_Offset, CVE+CVE_Offset, CVS+CVS_Offset);    
    %writeattribute([idDevServMainPS '/current'], A_PS(1,i));    
    %writeattribute([idDevServCHE '/current'], CHE+CHE_Offset);
    %writeattribute([idDevServCHS '/current'], CHS+CHS_Offset);
    %writeattribute([idDevServCVE '/current'], CVE+CVE_Offset);
    %writeattribute([idDevServCVS '/current'], CVS+CVS_Offset);
    pause(1)

i=i+1;
end
if (PS==A_PS(1,i)) && (A_PS(6,i)==-1)
    CHE= A_PS(2,i);
    CHS= A_PS(3,i);
    CVE= A_PS(4,i);
    CVS= A_PS(5,i);
    fprintf(fid_Index_PS,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f %2.0f\n',A_PS(1,i),CHE, CHS, CVE, CVS,i); 
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',A_PS(1,i),CHE+CHE_Offset, CHS+CHS_Offset, CVE+CVE_Offset, CVS+CVS_Offset);    
    %writeattribute([idDevServMainPS '/current'], A_PS(1,i));    
    %writeattribute([idDevServCHE '/current'], CHE+CHE_Offset);
    %writeattribute([idDevServCHS '/current'], CHS+CHS_Offset);
    %writeattribute([idDevServCVE '/current'], CVE+CVE_Offset);
    %writeattribute([idDevServCVS '/current'], CVS+CVS_Offset);
    pause(1)
end
end
