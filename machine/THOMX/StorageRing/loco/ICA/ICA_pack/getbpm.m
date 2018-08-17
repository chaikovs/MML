function [s,bx,ux,by,uy,dx,xtune,ytune,varargout]=getbpm(datfile,isunix)
%[s,bx,ux,by,uy,dx,xtune,ytune]=getbpm(datfile,isunix)
%get betafunctions at BPMs

fid = fopen(datfile,'r');

for i=1:6
    fgets(fid);
end
tline = fgetl(fid);
fline = tline(24:size(tline,2));
if length(fline)<5
	s = [];
	bx = [];
	ux = [];
	by = [];
	uy = [];
	dx = [];
	xtune = 0; ytune = 0;
	dy=[];
	if nargout>=1
		varargout{1} = dy;
	end
	return ;
end
ytune = sscanf(fline,'%f');
tline = fgetl(fid);
fline = tline(24:size(tline,2));
xtune = sscanf(fline,'%f');
disp(['x ' num2str(xtune) '  y ' num2str(ytune)])

for i=1:7
    fgets(fid);
end
dy=[];
i=1;
 while 1
            tline = fgetl(fid);
            if ~isstr(tline), break, end

			if size(findstr(tline,'"HP'),1)==0 & size(findstr(tline,'"BP'),1)==0
				continue;
            end
			%disp(tline);
			if ~isunix
				fline=tline(40:size(tline,2));
			else
				fline=tline(38:size(tline,2));
			end
			%disp(fline)
			a=sscanf(fline,'%f');
			
		s(i) =a(1); 
		bx(i)=a(2);
		ux(i)=a(3);
		by(i)=a(4);
		uy(i)=a(5);
        dx(i)=a(6);
		if length(a)>=7
			dy(i) = a(7);
		end
		
		i = i+1;	
		
        end
        
fclose(fid);
if nargout>=1
	varargout{1} = dy;
end
