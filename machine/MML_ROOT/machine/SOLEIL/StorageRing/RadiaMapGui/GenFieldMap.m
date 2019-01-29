function GenFieldMap(PathName,FileName,Length)
% Generate 2D radia map from the 1D map from the magnetic group  

%FileName = 'example_1Dmap.dat';
%Length = 3; % undulator length

%read the 1D radia map
fid = fopen([PathName,FileName]);
[x,Bx,Bz z] = textread(FileName,'%f %f %f %f','headerlines',1);
fclose(fid);

%change the unit to SI unit
x = x'*1e-3;   % [mm] --> [m]
z = z'*1e-3;
Bx = (Bx)'*1e-4; %[G.m] --> [T.m]
Bz = (Bz)'*1e-4;

%find the last component of z 
idx = find(z==0,2,'first');
z(idx(2):end) = [];


%find the extension of the file
exid = strfind(FileName,'.');
extension = FileName(exid:end);
%find the main file name
savefilename = [PathName,FileName(1:exid-1)];


%% generate 2D map, by repeat the field values, then save the data
fid =fopen([savefilename,'_2Dmap',extension],'wt');
%save the headlines
fprintf(fid,'%s\n','# Author:  User');
fprintf(fid,'%s\n',['# Radia 2nd order map, based on the file: ',FileName]);
fprintf(fid,'%s\n','# Undulator Length [m]');
fprintf(fid,'%-10.5f\n',Length);
fprintf(fid,'%s\n','# Number of Horizontal Points');
fprintf(fid,'%d\n',length(x));
fprintf(fid,'%s\n','# Number of Vertical Points');
fprintf(fid,'%d\n',length(z));
fprintf(fid,'%s\n','# Horizontal 2nd Order Kick[T2m2]');
fprintf(fid,'%s\n','START');

%save the horizontal kick
 fprintf(fid,'  %10.5e',x);
 fprintf(fid,'\n');
for i=1:length(z)
    fprintf(fid,'  %10.5e',[z(i),Bz]);
    fprintf(fid,'\n');
end
%save the vertical kick
fprintf(fid,'%s\n','# Vertical 2nd Order Kick[T2m2]');
fprintf(fid,'%s\n','START');
fprintf(fid,'  %10.5e',x);
 fprintf(fid,'\n');
for i=1:length(z)
    fprintf(fid,'  %10.5e',[z(i),Bx]);
    fprintf(fid,'\n');
end
fclose(fid);