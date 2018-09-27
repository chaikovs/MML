function [x Bx,Bz,Px,Pz,Lu] =  ReadRadiaMap(FileName)

% plot the wiggler field map from radiamap.

%FileName = 'w150g11pole20_fin.dat';
%FileName = 'w150g11pole20_fin.dat_interpolation';


fid = fopen(FileName);



%% read field map
fopen(fid);
%read the undulator length, number of horizontal and vertical points
par = textscan(fid,'%f',1,'CommentStyle','#');
Lu = par{1};% undulator length [m]
par = textscan(fid,'%d',2,'CommentStyle','#');
Px  = par{1}(1);  % horizontal points
Pz  = par{1}(2);  % vertical points
Bx  = zeros(Pz,Px+1);
Bz  = zeros(Pz,Px+1);


%read the 'start' string;
start = textscan(fid,'%s',1,'CommentStyle','#');


% read the first line,the horizontal coordinates when the fields are measured 
%the number of  points data in this line is only 'Px'
L = textscan(fid,'%f',Px,'CommentStyle','#');     
x = L{:};

%%read horiztonal field map    
for i=1:Pz
     L = textscan(fid,'%f',Px+1,'CommentStyle','#'); % read the field strength line
    Bz(i,:) = L{:};  % assign each line values to array Bx 
end

%read start line
start = textscan(fid,'%s',1,'CommentStyle','#');
% skip the horizontal coordinates for the vertical field map
% since it is read before. 
L = textscan(fid,'%f',Px,'CommentStyle','#'); 
  
%read vertical field map
for i=1:Pz
     L = textscan(fid,'%f',Px+1,'CommentStyle','#'); % read the field strength line
    Bx(i,:) = L{:};  % assign each line values to array Bx 
end

fclose(fid);
