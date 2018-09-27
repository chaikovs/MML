function ReadCurrentsAndWriteattribute(SESSION,CurrentsName)
PathAndCurrents=['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/' CurrentsName '.txt'];

% ReadCurrentsAndWriteattribute('SESSION_14_09_08','FF_CR')

fident=fopen(PathAndCurrents,'r')
idDevServMainPS1=['ans-c05/ei/l-hu640_PS1'];
idDevServMainPS2=['ans-c05/ei/l-hu640_PS2'];
idDevServMainPS3=['ans-c05/ei/l-hu640_PS3'];
idDevServCHE=['ans-c05/ei/l-hu640_corr2'];
idDevServCHS=['ans-c05/ei/l-hu640_corr1'];
idDevServCVE=['ans-c05/ei/l-hu640_corr4'];
idDevServCVS=['ans-c05/ei/l-hu640_corr3'];


if CurrentsName =='FF_LH'
A=fscanf(fident,'%g %g %g %g %g %g',[6 inf]);
N=length(A)
for i=1:N
%writeattribute(idDevServMainPS2, A(2,i));
%writeattribute(idDevServMainPS3, A(3,i));
%writeattribute(idDevServCVE, A(4,i));
%writeattribute(idDevServCHE, A(5,i));
%writeattribute(idDevServCVS, A(6,i));
%writeattribute(idDevServCHS, A(7,i));
end
end

if CurrentsName =='TR_LV_LH'
A=fscanf(fident,'%g %g %g %g %g %g',[6 inf]);
N=length(A)
for i=1:N
%writeattribute(idDevServMainPS2, A(2,i));
%writeattribute(idDevServMainPS3, A(3,i));
%writeattribute(idDevServCVE, A(4,i));
%writeattribute(idDevServCHE, A(5,i));
%writeattribute(idDevServCVS, A(6,i));
%writeattribute(idDevServCHS, A(7,i));
end
end

if CurrentsName =='TR_CR_LH'
A=fscanf(fident,'%g %g %g %g %g %g',[6 inf]);
N=length(A)
for i=1:N
%writeattribute(idDevServMainPS2, A(2,i));
%writeattribute(idDevServMainPS3, A(3,i));
%writeattribute(idDevServCVE, A(4,i));
%writeattribute(idDevServCHE, A(5,i));
%writeattribute(idDevServCVS, A(6,i));
%writeattribute(idDevServCHS, A(7,i));
end
end

if CurrentsName =='TR_LH_CR'
A=fscanf(fident,'%g %g %g %g %g %g %g %g',[8 inf]);
N=length(A)
for i=1:N
    
%writeattribute(idDevServMainPS1, A(2,i));    
%writeattribute(idDevServMainPS2, A(3,i));
%writeattribute(idDevServMainPS3, A(4,i));
%writeattribute(idDevServCVE, A(5,i));
%writeattribute(idDevServCHE, A(6,i));
%writeattribute(idDevServCVS, A(7,i));
%writeattribute(idDevServCHS, A(8,i));
end
end

if CurrentsName =='FF_CR'
A=fscanf(fident,'%g %g %g %g %g %g %g %g',[8 inf]);
N=length(A)
for i=1:N
%writeattribute(idDevServMainPS1, A(2,i));    
%writeattribute(idDevServMainPS2, A(3,i));
%writeattribute(idDevServMainPS3, A(4,i));
%writeattribute(idDevServCVE, A(5,i));
%writeattribute(idDevServCHE, A(6,i));
%writeattribute(idDevServCVS, A(7,i));
%writeattribute(idDevServCHS, A(8,i));
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',A(2,i),A(3,i),A(4,i),A(5,i),A(6,i),A(7,i),A(8,i));   

end
end

if CurrentsName =='FF_LV'
A=fscanf(fident,'%g %g %g %g %g',[5 inf]);
N=length(A)
for i=1:N
%writeattribute(idDevServMainPS1, A(2,i));    
%writeattribute(idDevServCVE, A(3,i));
%writeattribute(idDevServCHE, A(4,i));
%writeattribute(idDevServCVS, A(5,i));
%writeattribute(idDevServCHS, A(6,i));
end
end

if CurrentsName =='TR_LH_LV'
A=fscanf(fident,'%g %g %g %g %g',[5 inf]);
N=length(A)
for i=1:N
%writeattribute(idDevServMainPS1, A(2,i));    
%writeattribute(idDevServCVE, A(3,i));
%writeattribute(idDevServCHE, A(4,i));
%writeattribute(idDevServCVS, A(5,i));
%writeattribute(idDevServCHS, A(6,i));
end
end