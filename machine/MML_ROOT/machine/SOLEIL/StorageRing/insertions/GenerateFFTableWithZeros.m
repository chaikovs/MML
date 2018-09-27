function GenerateFFTableWithZeros(FolderAndFFTableName,GapMin,GapMax,Npts,LinExp)
% Generate A table with 0A for the correctors CHE, CVE, CHS and CVS. The Gap values are generated with linear or exponential step 
% between values.
% FolderAndFFTableName: Full Name and Path of FF table 
% GapMin: minimum gap
% GapMax: maximum gap
% Npts: Number of points
% LinExp:0 if the points are linearly spaced, 1 if they are exponentially
% spaced
% ex: GenerateFFTableWithZeros('/usr/Local/configFiles/InsertionFFTables/ANS-C03-WSV50/FF_TEST.txt',5.5,70,50,0)
fid= fopen(FolderAndFFTableName, 'w');
A=GapMin;
B=(1/(Npts-1))*log(GapMax/GapMin);
for N=1:Npts
    if (LinExp==0)
        Gap(N)=GapMin+(GapMax-GapMin)*(N-1)/(Npts-1);
    end
    if (LinExp==1)
        Gap(N)=A*exp(B*(N-1));
    end
    fprintf(fid,'%8.1f\t',Gap(N));
end
fprintf(fid,'\n'); 
for N=1:Npts
    CHE(N)=0;
    fprintf(fid,'%8.4f\t',CHE(N));
end
fprintf(fid,'\n'); 
for N=1:Npts
    CHS(N)=0;
    fprintf(fid,'%8.4f\t',CHS(N));
end
fprintf(fid,'\n'); 
for N=1:Npts
    CVE(N)=0;
    fprintf(fid,'%8.4f\t',CVE(N));
end
fprintf(fid,'\n'); 
for N=1:Npts
    CVS(N)=0;
    fprintf(fid,'%8.4f\t',CVS(N));
end
fprintf(fid,'\n'); 
fclose(fid);
end