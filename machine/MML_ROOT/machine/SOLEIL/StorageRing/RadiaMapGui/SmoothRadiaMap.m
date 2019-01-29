function [sx,sBx,sBz] = SmoothRadiaMap(PathName,FileName,x,Bx,Bz,Px,Pz,Lu,forder,funit)

% smooth the Radia Map of interstion device, to make the data more smooth,
% then can 

%% smooth the data and do spline interpolation

f = 5;
xn = (x(end)-x(1))/double((Px-1))/f;
sx = x(1):xn:x(end);
% smooth the Bx & By
for i = 1:Pz
sBx(i,:) = pchip(x,Bx(i,2:end),sx);
sBz(i,:) = pchip(x,Bz(i,2:end),sx);
end

% the new horizontal and vertical points
[sPz sPx] =  size(sBx);

%find the extension of the file
exid = strfind(FileName,'.');
extension = FileName(exid:end);
%find the main file name
savefilename = [PathName,FileName(1:exid-1)];

%%  save the data after interpolation 
fid =fopen([savefilename,'_interpolation',extension],'wt');
%save the headlines
fprintf(fid,'%s\n','# Author:  User');
fprintf(fid,'%s\n',['# ',FileName,' (after smooth)']);
fprintf(fid,'%s\n','# Undulator Length [m]');
fprintf(fid,'%-10.4f\n',Lu);
fprintf(fid,'%s\n','# Number of Horizontal Points');
fprintf(fid,'%d\n',sPx);
fprintf(fid,'%s\n','# Number of Vertical Points');
fprintf(fid,'%d\n',sPz);



%save the interploted horizontal kick
fprintf(fid,'%s\n',['# Horizontal ',forder,' Order Kick ',funit]);
fprintf(fid,'%s\n               ','START');
fprintf(fid,'% 10.5e   ',sx); %the first element is non exit
fprintf(fid,'\n');
for i=1:Pz
    fprintf(fid,'% 10.5e   ',[Bz(i,1),sBz(i,:)]);
fprintf(fid,'\n');
end

%save the interploted vertical kick
fprintf(fid,'%s\n',['# Vertical ',forder,' Order Kick ',funit]);
fprintf(fid,'%s\n               ','START');
fprintf(fid,'% 10.5e   ',sx); %the first element is non exit
fprintf(fid,'\n');
for i=1:Pz
    fprintf(fid,'% 10.5e   ',[Bx(i,1),sBx(i,:)]);
    fprintf(fid,'\n');
end

fclose(fid);


% %% plot the data before and after interpolation
%  figure(1);
%  plot(x,Bz(:,2:end),'b-');
%  hold on;
%  plot(sx,sBz,'r-');
%  xlabel('x[m]');
%  ylabel([forder, ' horizontal kick ',funit]);
%  legend('before smooth','after smooth');
%  title(['spline interpolation, data is amplified by ', num2str(f)]);
%  
%   figure(2);
%  plot(x,Bx(:,2:end),'b-');
%  hold on;
%  plot(sx,sBx,'r-');
%  xlabel('x[m]');
%  ylabel([forder, ' vertical kick ',funit]);
%  legend('before smooth','after smooth');
%  title(['spline interpolation, data is amplified by ', num2str(f)]);
