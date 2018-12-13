function [freq, amp, Xr] = naff_other(X,varargin);
%[freq, amp, Xr] = naff(X)
%[freq, amp, Xr] = naff(X, win)
%[freq, amp, Xr] = naff(X, GUESS,DELTA)
%X, and N x n data matrix, each column is a sample
%win = [lo, hi], the window within which tune is to be searched
%GUESS, DELTA,   win = GUESS+[-DELTA, DELTA]
%freq, 1 x n, the tunes on each of the n samples
%amp, 1 x n,  the complex amplitude for the tune
%Xr, N x n,   the residue after the tune component is subtracted
%
%written by Andrei Terebilo, dated 9/2/2004  
%edited by Xiaobiao Huang, 10/30/2006  
%

setwin = 0;  %no search window by default
if nargin==2
	win = varargin{1};
    GUESS = mean(win);
    DELTA = (win(2) - win(1))/2.0;
    setwin = 1;
elseif nargin==3
    GUESS = varargin{1};
    DELTA = varargin{2};
    setwin = 1;
end

[NT, NP] = size(X);

f0 = NaN*ones(1,NP);
W = sin(pi*(0:NT-1)'/(NT-1)).^4;
F = (0:NT-1)'/NT;

XFFTABS = abs(fft(X));
%Z = zeros(size(XFFTABS));
if setwin == 1

%     LR = floor(N*(GUESS-DELTA));
%     UR = ceil(N*(GUESS+DELTA));
%     Z(sub2ind(size(XFFTABS),LR,1:length(LR))) = 1;
%     Z(sub2ind(size(XFFTABS),UR+1,1:length(UR)))= -1;
    
    
    searchrange = floor(NT*(GUESS-DELTA)):ceil(NT*(GUESS+DELTA));
    [psi_k,k] = max(XFFTABS(searchrange,:));
    k=k+floor(NT*(GUESS-DELTA))-1; 
    
else 
    % Exclude DC
    [psi_k,k] = max(XFFTABS(2:floor(NT/2),:));
    k = k+1;
end


OPTS = optimset('TolX',1/NT.^3);

n=(0:NT-1)';
for ii=1:NP
    freq(ii) = fminbnd(@fmaprojection,F(k(ii)-1),F(k(ii)+1),OPTS,X(:,ii),W);
    amp(ii)	= calcampli(X(:,ii)', freq(ii));
    Xr(:,ii) = X(:,ii) - 2.*real(amp(ii)*exp(i*2.*pi*freq(ii)*n));
    
end



function y = fmaprojection(f,X,W)
z = exp(-i*2*pi*f*(1:length(X)));
y =  -abs(sum(z(:).*X(:).*W(:)));


function c=calcampli(data, v)
%calculate the amplitude of frquency v in 1D series data
% data - (a+b*i) e(2 pi v t)  will contain no v component
% c= a+b*i;
N=length(data);
fq = fft(data);

n=1:N;
n = n-1;
em = exp(-2.*pi*i*v*n);

a = sum(real(data.*em))/N;
b = sum(imag(data.*em))/N;

c = a+ b*i;