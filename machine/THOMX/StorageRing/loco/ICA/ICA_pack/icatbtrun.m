function varargout = icatbtrun(data,action,st,wid,tao,varargin)
%varargout = icatbt(datasrc,action,st,wid,tao,varargin)

el = 1.0;
if nargin > 5
    el = varargin{1};
end

preprocess = 'zero mean';
if nargin > 6
	preprocess = varargin{2};
end

pdK = 12;
% if nargin > 6
%     pdK = varargin{2};
% end


span = max([max(tao),20]); 
ed = st + wid - 1 + span;

switch action
case {1,4,5,6,7,8,9}
   
	if action==1
       %el = 2.0;
	    [z,s,A,w,dd,offF,el] = ICAamuse(data(:,1:(wid+tao)),tao,el);
    elseif action==4
    	%el = 2.0;
    	[z,s,A,w,dd,offF,el] = ICAamuse_jg(data(:,1:(wid + max(tao))),tao,el);
    	offF./sum(dd.^2,1)';
    elseif action == 5
		%el = 2.0;
		%disp('ICAsobi');
		[z,s,A,w,dd,offF,el] = ICAsobi(data(:,1:(wid + max(tao))),tao,el);
    	offF./sum(dd.^2,1)';
    elseif action == 6
        %el = 1.0;
    	[z,s,A,w,dd,offF,el] = ICAseons(data(:,1:(wid + max(tao))),tao,el);
        size(dd);
    	offF'./sum(dd.^2,1);
	elseif action == 7
		[z,s,A,w,dd,offF,el] = ICAacdc(data(:,1:(wid + max(tao))),tao,el);
		size(s)
		size(A)
		isempty(find(iscomplex(s)))
	elseif action == 8
		[z,s,A,w,dd,offF,el] = PCAmia(data(:,1:(wid )),el);
		tao = [];

	end
    dout.z = z;
	dout.s = s;
	dout.A = A;
	dout.w = w;
	dout.dd = dd;
 	dout.pdK = pdK;
    dout.offF = offF./sum(dd.^2,1)';
	
	dout.st = st;
	dout.wid = wid;
	dout.tao = tao;
	dout.el = el;
	dout.datasrc = '';
	dout.action = action;
	
	varargout{1} = dout;
 
	%orient landscape 
	%print -dpsc2 temp.ps

case {2}
	el = 1.e0;
	[z,s,A,w,dd] = ICAamuse(data(:,1:(wid+tao)),tao,el);
	
    [ns, trans] = orthonomal(s);
     AT = A*trans;
 %   varargout{3}=AT;
    m1 = 1;
    m2 = 2;
    beta = ((AT(:,m1).^2 + AT(:,m2).^2));
    psi  = atan(AT(:,m1)./AT(:,m2));

    varargout{1} = beta;
    varargout{2} = psi;
    
    subplot(2,1,1);
    plot(beta);
    subplot(2,1,2);
    plot(psi);
        
case {3}
	%tao = [1,2,3,4];
	el = .02;
	[z,V]=robustwhiten(data,tao,el);
	%[z,V] = ICAfsgc(data,tao,el);
	
	icom = size(z,1);
	n = 1:size(z,2);
		
	while 1
		subplot(2,1,1);
		h = plot(n, z(icom,:),'b');
		title(sprintf('MODE %d',icom));
		
		subplot(2,1,2);
		fq = fft(z(icom,:));
		len = floor(size(z,2)/2);
   		plot(1.-(1:len)/len/2.,abs(fq(1:len)),'b');hold on
    	[peak_v,peak_pos,peak_width] = peakdetect(abs(fq), 1,len,8);
    	plot(1.-peak_pos/len/2.,peak_v,'ro');hold off
		tune = [];
    	for i=length(peak_v):-1:1
       	 	tune = [tune,'  ',num2str(1.-peak_pos(i)/len/2)];
    	end
    	xlabel(tune);grid
		a = input(' ');
		if isempty(a)
			icom = mod(icom-2,size(z,1))+1;
		elseif a>0 & a<size(z,1)
			icom = a;
		else
			break
		end
		
	end
	varargout{1} = z;
    varargout{2} = V;



otherwise 
    disp('invalid action command')
    return
end

function [z,s,A,w,dd,offF,el] = ICAtest(data,tao,el)
%
tao = tao(1);
wid = size(data,2) - tao;
xt  = data(:,1:wid);
x   = data(:,(tao+1):(tao+wid));

C_ztao = x*xt';
meanC = (C_ztao + C_ztao')/2.;

[wt,d] = eig(meanC);
w = wt';

s = w*xt;
A = wt;

for i=1:size(s,1)
	ns(i) = norm(s(i,:));
	s(i,:) = s(i,:)/ns(i);
	A(:,i) = A(:,i) * ns(i);
end
indx = find(diag(d)==0);

z = x;
dd = diag(d);
offF = sum(sum(d.^2)) - sum(dd.^2);

function [z,s,A,w,dd,offF,el] = PCAmia(data,el)
%
rawdata = data;
wid = size(data,2);
[data1,V,u,dd,el] = whiten(data,el);
z  = data1(:,1:wid);
s  = z;
A = u*diag(dd);

offF = 0.;
w = [];

err = rawdata(:,1:wid) - A*s;
for i=1:size(err,1)
	errnorm(i) = norm(err(i,:));
end
%save temperr err errnorm
%****************************************************
%function [z,s,A,w,dd] = ICAamuse(data,tao,el)
%diagonalize autocorrelation matrix at one time lag
%use PCA as whitening method
%*****************************************************
function [z,s,A,w,dd,offF,el] = ICAamuse(data,tao,el)
%solve ICA problem for time series data
%data,	raw data, size(data,2) == wid + tao
%tao,   the shift to compute autocovariance
%el,	cut-off threshold for singular values to remove noise
%z is whitened data
%z = V*x
%x = A*s
%z = w'*s
%
wid = size(data,2) - tao;
[data1,V,u,sd,el] = whiten(data,el);
zt  = data1(:,1:wid);
z   = data1(:,(tao+1):(tao+wid));

C_ztao = z*zt';
meanC = (C_ztao + C_ztao')/2.;

[wt,d] = eig(meanC);
w = wt';
s = w*z;
A = u*diag(sd)*wt;
indx = find(diag(d)==0);

dd = diag(d);
offF = sum(sum(d.^2)) - sum(dd.^2);

dd(indx) = [];
s(indx,:) = [];
A(:,indx)=[];
w(indx,:) = [];

%****************************************************
%function [z,s,A,w,dd,offF] = ICAamuse_jg(data,tao,el)
%AMUSE with joint diagonalization
%use PCA for data whitening
%*****************************************************
function [z,s,A,w,dd,offF,el] = ICAamuse_jg(data,tao,el)
%ICA using autocorrelation matrices with several time lag 
%apply joint diagonalization method
%tao,   contains a series of time lags
%z is whitened data
%z = V*x
%x = A*s
%z = w'*s
%dd,    diagonal elements, each column for one tao entry
%offF, sum of of square of off-diagonal elements for each matrix after diagonalization
wid = size(data,2) - max(tao);

[data,V,u,sd,el] = whiten(data,el);
z = data(:,1:wid);
%size(z)

for i=1:length(tao)
	zt = data(:,(tao(i)+1):(tao(i)+wid));
	%size(zx)
	%size(zxt')
	Ct = z*zt'; %/wid;
	mC{i} = (Ct + Ct')/2.;
end

[wt,mCD] = jointdiag(mC,1.0e-8);%wt is orthonormal

%V = eye(size(z,1));

w = wt';
s = w*z;
%A = diag(sd.^2)*V'*wt;
A = u*diag(sd)*wt;

offF = zeros(length(tao),1);
for i=1:length(tao)
    dd(:,i) = diag(mCD{i});
    offF(i) = sum(sum(mCD{i}.^2)) - sum(dd(:,i).^2);
end

if 0
%norms = sqrt(diag(s*s')/size(s,2));
%indx = find(norms < 0.05);
indx = find(dd(:,1) == 0);
s(indx,:)=[];
w(indx,:)=[];
A(:,indx)=[];
dd(indx,:)=[];
end

%****************************************************
%function [z,s,A,w,dd,offF] = ICAseons(data1,tao,el)
%use 'robust whitening', see function robustwhiten 
%*****************************************************
function [z,s,A,w,dd,offF,el] = ICAseons(data1,tao,el)
%tao,   contains a series of time lags
%z is whitened data
%z = V*x
%x = A*s
%z = w'*s
%dd,    diagonal elements, each column for one tao entry
%offF, sum of of square of off-diagonal elements for each matrix after diagonalization
wid = size(data1,2) - max(tao);
[data,V] = robustwhiten(data1,tao,0.005);
z = data(:,1:wid);
%z = V x

%choose the size of submatrix
knum = floor(size(z,2)/size(data1,1)/4);
kl   = floor(size(z,2) / knum);
disp(sprintf('seons, %d submatrices with size %d', knum,kl));

cnt = 1;
st = 1;
for k=1:knum
    for i=1:length(tao)
        z = data(:,st:(st+kl-1));
    	zt = data(:,(tao(i)+st):(tao(i)+ st + kl-1));
    	Ct = z*zt'; %/wid;
    	mC{cnt} = (Ct + Ct')/2.;
        cnt = cnt + 1;
    end
    st = st + kl;
    
end
z = data(:,1:wid);

[wt,mCD] = jointdiag(mC,1.0e-8);%wt is orthonormal

w = wt';
s = w*z;
[ut,st,vt] = svd(V);
sst = diag(st);
mt = size(ut,1);
nt = size(vt,1);

A = vt*[diag(1./sst);zeros(nt-mt,mt)]*ut'*wt;
%A = inv(V'*V)*V'*wt;

offF = zeros(length(tao)*knum,1);
for i=1:length(mC)
    dd(:,i) = diag(mCD{i});
    offF(i) = sum(sum(mCD{i}.^2)) - sum(dd(:,i).^2);
end

if 1
	indx = find(dd(:,1) == 0);
	s(indx,:)=[];
	w(indx,:)=[];
	A(:,indx)=[];
	dd(indx,:)=[];
end

%****************************************************
%function [z,s,A,w,dd,offF] = ICAsobi(data,tao,el)
%use PCA to whiten data, but it subtract average noise singular values
%from that of signals. See function sobiwhiten
%*****************************************************
function [z,s,A,w,dd,offF,el] = ICAsobi(data,tao,el)
%this is essentially the same with ICAamuse_jg
%z is whitened data
%z = V*x
%x = A*s
%z = w'*s
%dd,    diagonal elements, each column for one tao entry
%offF, sum of of square of off-diagonal elements for each matrix after diagonalization

rawdata = data;
wid = size(data,2) - max(tao);
%[data,V,el] = PCAdimen(data,el); %test
[data,V,u,sd,el] = sobiwhiten(data,el); %SOBI
z = data(:,1:wid);

for i=1:length(tao)
	zt = data(:,(tao(i)+1):(tao(i)+wid));
	Ct = z*zt';  %/wid
	mC{i} = (Ct + Ct')/2.;
end
[wt,mCD] = jointdiag(mC,1.0e-8);%wt is orthonormal

w = wt';
s = w*z;
%s*s'
A = u*diag(sd)*wt;   %SOBI
%A = V'*wt; %test

offF = zeros(length(tao),1);
for i=1:length(tao)
	dd(:,i) = diag(mCD{i});
    offF(i) = sum(sum(mCD{i}.^2)) - sum(dd(:,i).^2);
end

if 1
	indx = find(dd(:,1) == 0);
	s(indx,:)=[];
	w(indx,:)=[];
	A(:,indx)=[];
	dd(indx,:)=[];
end

err = rawdata(:,1:wid) - A*s;
for i=1:size(err,1)
	errnorm(i) = norm(err(i,:));
end
save temperr err errnorm


function [z,s,A,w,dd,offF,el] = ICAacdc(data,tao,el)
%Using Arie Yeredor's Joint Approx. Diagonalization Algorithm
%the AC-DC method
%
wid = size(data,2) - max(tao);
%[data,V,el] = PCAdimen(data,el); %acdc
[data,V,u,sd,el] = sobiwhiten(data,el);
z = data(:,1:wid);
for i=1:length(tao)
	zt = data(:,(tao(i)+1):(tao(i)+wid));
	Ct = z*zt';  %/wid
	mC{i} = (Ct + Ct')/2.;
end

[wt,mCD] = jointdiag_acdc(mC);
%w = wt';
w = inv(wt);
s = w*z;

%A = V'*w'; %acdc
A = u*diag(sd)*wt;
for i=1:size(s,1)
	norms(i) = norm(s(i,:));
	s(i,:) = s(i,:)/norms(i);
	A(:,i) = A(:,i)*norms(i);
end

for i=1:length(tao)
	dd(:,i) = mCD{i};
end

offF = 0.;



%**************************************************
%whitening methods
%**************************************************
function [z,V,el] = PCAdimen(x,el)
%reduce dimension with PCA method
%z = V*x
[u,s,v]=svd(x);
d = diag(s);
if el <= 0
	el = findeldlg(d,v(:,1:length(d)));%findcutoff(d,u,v);
end
indx = find(d<el);

d(indx) = [];
u(:,indx) = [];

V =  u';  %note the difference between here and function whiten
z = V*x;  %z*z' = d.^2 ! instead of I


function [z,V,u,d,el] = whiten(x,el)
%PCA whitening, with noise reduction by removing 
%singular values less than el
%x = u diag(d,0,...,0) v'
%z = V x, is whitened data, (actually z = v', but 
%containing rows corresponding to d only)
%d  singular values that are greater than el
%el is the cut-off threshold for singular values
%	if el <=-1, then el = d(-el), i.e., -el is an integer indicating the number of 
%	modes to keep

[u,s,v]=svd(x);
d = diag(s);
if el == 0.0
	el = findeldlg(d,v(:,1:length(d)));%findcutoff(d,u,v);
elseif el <= -1
	el = d(-el);
end
indx = find(d<el);

d(indx) = [];
u(:,indx) = [];

V = diag(1./d)* u';
z = V*x;

function el = findcutoff(d,u,v)
%locating the cutoff singular value by viewing the PCs
%u,	spatical pattern
%v, temporal pattern
%d, SVs
	n=1:length(d);
	icom = 1;
	while 1
		subplot(2,1,1);
		plot(n,d,'bo',icom,d(icom),'k*');
		title('locating noise background: press q to quit at cut-off mode');
		xlabel(sprintf('mode %d, SV = %f',icom,d(icom)));
		subplot(2,1,2);
		plot(1:size(v,1),v(:,icom),'b');
		a = input('w>','s');
		if isempty(a)
			icom = mod(icom,length(d)) + 1;
		elseif a(1)=='f'
			icom = mod(icom+5,length(d)) + 1;
		elseif a(1)=='q'
			break
		elseif a(1)=='b'
			icom = mod(icom-2,length(d)) + 1;
		end
	end
	el = d(icom);


function [z,V,u,d,el] = sobiwhiten(x,el)
%PCA whitening, with noise reduction by removing 
%singular values less than el and subtracting average noise 
%SV's from signal SV's
%z = V x
%x = u diag(d,0,...,0) v'
%z = V x, is whitened data, (actually z = v', but 
%containing rows corresponding to d only)
%d  singular values that are greater than el
%el is the cut-off threshold for singular values
%	if el <=-1, then el = d(-el), i.e., -el is an integer indicating the number of 
%	modes to keep

[u,s,v]=svd(x);
ss = diag(s);
d  = ss;
if el == 0.0
	el = findeldlg(d,v(:,1:length(d)));%findcutoff(d,u,v);
elseif el <= -1
	el = ss(-el);
end

indx = find(d<el);
d(indx) = []; 
u(:,indx)=  [];

if length(indx)==0
    sgm2 = 0;
else
sgm2 = sum(ss(indx).^2)/length(indx);   
end
vss = sqrt(1./(d.^2 - sgm2));
%vss = [vss;;zeros(length(indx),1)];
%d  = [d; zeros(size(indx))];

vs = diag(vss);
V = vs * u';
z = V*x;


function [z,V]=robustwhiten(x,tao,el)
%whiten with diagonalizing autocorrelation matrix
%step 1: find coefficients to form a positive definite matrix 
%as a combination of autocorrelation matrices
%step 2: diagonalize the combined matrix to get a tranform matrix
%
%tao,	a series of tao values, i.e. shift of t in computing Cx
%z = V*x,	whitened data, rows of z are normalized (to have norm=1) 
%el,    a cut-off threshold that select the significant mode only
%

wid = round(size(x,2) - max(tao));
zx = x(:,1:wid);

R = [];
for i=1:length(tao)
	zxt = x(:,(tao(i)+1):(tao(i)+wid));
	Ct = zx*zxt'/wid;
	mC{i} = (Ct + Ct')/2.;
    R = [R,mC{i}];
end

[ur1,sr,vr] = svd(R);
ur = ur1(:,1:5);
%plot(1:length(diag(sr)),diag(sr),'o'); grid
%input(' xx')

for i=1:length(tao)
    F{i} = ur'*mC{i}*ur;
end

%call posdefinite, an external function to find coefficients cof
[M,cof] = posdefinite(F);
%cof

Cx = zeros(size(mC{1}));
for i=1:length(tao)
    Cx = Cx + mC{i}*cof(i);
end

[v,s] = eig(Cx);
ss = diag(s);
%subplot(1,1,1);
%plot(1:length(ss),ss,'o'); grid
%input(' xx')

indx = find(ss <= el);
ss(indx) = [];
v(:,indx) = [];

V = diag(1./sqrt(ss))*v';
z = V*x;
for i=1:size(z,1)
    znorm = sqrt(z(i,:)*z(i,:)');
    z(i,:) = z(i,:)/znorm;
    V(i,:) = V(i,:)/znorm;
end

function [V, qD] = jointdiag(ml,el)
%ml,    each ml{i} is a n by n matrix , to be diagonalized
%el,    threshold, typically 1.0e-8
%V,     the transform matrix to joint diagonalization, ml{i} = V qD{i} V'
%       suppose ml{i} = z z', then s = V' z will leads to s s' = qD{i}
%qD,    each qD{i} is a n by n diagonal (probablly approximate) matrix

nlist = length(ml);
n = size(ml{1},1);

A = [];
for i=1:nlist
    A = [A, ml{i}];
end

[m,nm] = size(A);
V=eye(m);

if nargin==1, el=sqrt(eps); end;

encore=1;
while encore, encore=0;
 for p=1:m-1,
  for q=p+1:m,
   %%%computation of Givens rotations
   g=[ A(p,p:m:nm)-A(q,q:m:nm) ; A(p,q:m:nm)+A(q,p:m:nm) ];
   g=g*g';
   ton =g(1,1)-g(2,2); toff=g(1,2)+g(2,1);
   theta=0.5*atan2( toff , ton+sqrt(ton*ton+toff*toff) );
   c=cos(theta);s=sin(theta);
   encore=encore | (abs(s)>el);
    %%%update of the A and V matrices 
   if (abs(s)>el) ,
    Mp=A(:,p:m:nm);Mq=A(:,q:m:nm);
    A(:,p:m:nm)=c*Mp+s*Mq;A(:,q:m:nm)=c*Mq-s*Mp;
    rowp=A(p,:);rowq=A(q,:);
    A(p,:)=c*rowp+s*rowq;A(q,:)=c*rowq-s*rowp;
    temp=V(:,p);V(:,p)=c*V(:,p)+s*V(:,q); V(:,q)=c*V(:,q)-s*temp;
   end% 
  end% 
 end% 
end% 
qDs = A ;

j = 1;
for i=1:nlist
    qD{i} = qDs(:,j:(j+n-1));
    j = j + n ;
end


function [v,qD] = jointdiag_acdc(ml)
%call acdc_sym.m to diagonalize mC
%ml,    each ml{i} is a n by n matrix , to be diagonalized
%V,     the transform matrix to joint diagonalization, ml{i} = V qD{i} V'
%       suppose ml{i} = z z', then s = V' z will leads to s s' = qD{i}
%qD,    each qD{i} is a n vector as diagonal elements of corresponding ml{i}

nlist = length(ml);
n = size(ml{1},1);

M = [];
for i=1:nlist
    M(:,:,i) =  ml{i};
end

A0=init4acdc(M);
[A,Lam,Nit,Cls] = acdc(M,ones(nlist,1),A0);

v = A;
for i=1:nlist
	qD{i} = Lam(:,i);
end

%=================================================================
function [ns, trans] = orthonomal(s)
%othonomalize row vector basis s to new basis ns
%s,     each row is a vector, the vectors are normalized (i.e. sum(s(i,:).*s(i,:)) = 1)
%ns,    each row is a vector and the vectors are orthonomalized
%trans  the transfer matrix from ns to s
%s = trans*ns
%
m = size(s,1);
ns = zeros(size(s));
trans = zeros(m,m);

ns(1,:) = s(1,:);
for i=2:m
    temp = 0.;
    for j=1:(i-1)
        temp = temp + (s(i,:)*ns(j,:)')*ns(j,:);
    end
    ns(i,:) = s(i,:) - temp;
    norm2 = ns(i,:)*ns(i,:)';
    ns(i,:) = ns(i,:)/sqrt(norm2);
end
mab = s*s';
trans = mab*inv(ns*s');


function r = matrixrank(x,sigma)
%determine the rank of matrix x according to its SVD spectrum
%and i.i.d gaussian noise model
%see Konstantinos Konstantinides and Kung Yao's paper 'Statistical Analysis of Effective ...'
%use Third Bounds
%x,     the matrix
%sigma, sigma of gaussian model of the noise distribution of matrix elements
%r,     the rank of x
xsize = size(x);
s = svd(x);
indx = find(s > sqrt(xsize(1)*xsize(2))*sigma );
r = length(indx);

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


%********************************************
%CONSTRUCTION ZONE
%********************************************
function [z,s,A,w,dd] = ICAamuse_ext(data,tao,el) %not finished 
%using several time lags instead of just 1
%
[z,s,A,w,dd] = ICAamuse(data,tao,el);

for i=1:length(tao)
	%compute meanC_tao here
	
end

maxtry = 10;
cnt = 0;
while cnt < maxtry
	dw = zeros(size(w));
	for i=1:length(tao)
		%compute Q_tao
		%dw = dw + Q_tao*w*meanC_tao
	end
	%w = w + dw *.1
	%normalize w
	
	cnt = cnt + 1;
end

function [z,V] = ICAfsgc(x,tao,el) %not finished
%see L. Tong's paper regarding FSGC
%

wid = size(x,2) - max(tao);

z = x(:,1:wid);
zt = x(:,(tao+1):(tao+wid));

L=[];
q = tao;
for i=1:size(x,1)
	for m=1:size(x,1)
		for n=1:size(x,1);
		Ci(m,n) = sum(z(m,:).*z(n,:).*zt(i,:))/wid;
		end
	end
	L = [L,Ci];
end
[ul,sl,vl]=svd(L);
diag(sl)

