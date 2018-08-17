function [M,cof] = posdefinite(ml)
%[M,cof] = posdefinite(ml)
%linearly combine symmetric matrices in ml to form a positive definite matrix 
%ml,	a list of symmetric matrices as ml{1},ml{2},...,
%		The size of the matrices should be the same
%M,		The resulting positive definite matrix
%cof,	The cofficient to members of ml
%M = ml{1}*cof(1) + ml{2}*cof(2) + ...
%
nlist = length(ml);
mlsize = size(ml{1});
if mlsize(1)~=mlsize(2)
	disp('not square matrix')
	return
end
if mlsize(1)==0
	disp('empty matrix not allowed')
	return
end
for i=2:nlist
	if ~isequal(mlsize,size(ml{i}))
		disp('matrices are of different sizes')
		return
	end
end

%cof = ones(nlist,1);%/sqrt(nlist);
cof = rand(nlist,1);

M = zeros(mlsize);
for i=1:nlist
	M = M + ml{i}*cof(i);
end
[res,um] = isposdef(M);

cnt = 0;
while res==0 & cnt < 50
	%disp(sprintf('count %d',cnt))
	%cof
	for i=1:nlist
		w(i,1) = um'*ml{i}*um;
	end
	cof = cof + w/sqrt(w'*w);
	%cof = cof/sqrt(cof'*cof);
	
	M = zeros(mlsize);
	for i=1:nlist
		M = M + ml{i}*cof(i);
	end
	[res,um] = isposdef(M);
	
	cnt = cnt + 1;
	
end
cof = cof/sqrt(cof'*cof);
cnt

function [res,um] = isposdef(M)
%to test if M is positive definite
%and return the eigenvector corresponding the smallest eigenvalue
%res,	1 if posdef, 0 if not
%um,	eigenvector with smallest eigenvalue

[v,d]=eig(M);
dd = diag(d);

[mindd,index] = min(dd);
res = (mindd >=0);
um = v(:,index);
%nz = find(dd<0);
%res =  isempty(nz);
