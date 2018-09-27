function DeleteRadiaMapLine(PathName,FileName,x,Bx,Bz,Lu,forder,funit,deleteLnstr,str)


%% find the extension of the file
exid = strfind(FileName,'.');
extension = FileName(exid:end);
%find the main file name
savefilename = [PathName,FileName(1:exid-1)];

%%  delete the lines from the data

% get the size of Bx and Bz before delete
    [Pz Px] = size(Bx);  
    
if (strncmp(deleteLnstr,'first',5))
   DLn = 1;
elseif(strncmp(deleteLnstr,'last',4)&&strncmp(str,'horizontal',10))
    DLn = Pz;
elseif(strncmp(deleteLnstr,'last',4)&&strncmp(str,'vertical',8))
    DLn = Px-1;
end

   
    
switch str  
    case 'horizontal'
      Bx(DLn,:) =[];
      Bz(DLn,:) =[];
  
      
    case 'vertical'
      Bx(:,DLn+1) =[];    % the first colum of Bx is y cooridinates
      Bz(:,DLn+1) =[];    % the first colum of Bx is y cooridinates
   end    
   
%% get the size of Bx and Bz
    [Pz Px] = size(Bx);    

%% save the data into a file
fid =fopen([savefilename,'_delete',extension],'wt');
%save the headlines
fprintf(fid,'%s\n','# Author:  User');
fprintf(fid,'%s\n',['# ',FileName,' after delete the line' ]);
fprintf(fid,'%s\n','# Undulator Length [m]');
fprintf(fid,'%-10.2f\n',Lu);
fprintf(fid,'%s\n','# Number of Horizontal Points');
fprintf(fid,'%d\n',Px);
fprintf(fid,'%s\n','# Number of Vertical Points');
fprintf(fid,'%d\n',Pz);



%save the interploted horizontal kick
fprintf(fid,'%s\n',['# Horizontal ',forder,' Order Kick ',funit]);
fprintf(fid,'%s\n','START');
fprintf(fid,'    %10.5e',x); %the first element is non exit
fprintf(fid,'\n');
for i=1:Pz
fprintf(fid,'%10.5e   ',Bz(i,:)); 
fprintf(fid,'\n');
end

%save the interploted vertical kick
fprintf(fid,'%s\n',['# Vertical ',forder,' Order Kick ',funit]);
fprintf(fid,'%s\n','START');
fprintf(fid,'    %10.5e',x); %the first element is non exit
fprintf(fid,'\n');
for i=1:Pz
fprintf(fid,'%10.5e   ',Bx(i,:)); 
fprintf(fid,'\n');
end

fclose(fid);
