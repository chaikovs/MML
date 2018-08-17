function r = wmat(filename,a)
%r = wmat(filename,a)
%write a matlab matrix to a text file
fid = fopen(filename,'w');
m=size(a,1);
n=size(a,2);
for i=1:m
	for j=1:n
	fprintf(fid,'%f\t',a(i,j));
	end
	fprintf(fid,'\n');
end
fclose(fid);
