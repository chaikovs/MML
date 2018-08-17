function    [coff,freq,data] = ipfa(data,varargin)
%[coff,freq,data] = ipfa(data,varargin)
%ipfa - Iterative Precise Frequency Analysis
%Using precise tune measurement (R. Bartolini, et al "Algorithm for precise 
%determination of the betatron tune")
%to find the frequency peaks and corresponding amplitudes 
%with an iterative scheme (J.Laskar,"Frequency Map Analysis and Particle Accelerators"
%data,   a 1-D data series to be analyzed
%freq,   frequency of peaks mapped to [0,0.5]
%coff,   corresponding amplitude of peaks in freq
%

if size(data,1)~= 1 
    data = data.';
end
if size(data,1) > 1
    disp('only 1D data accepted')
    return
end

nmod = 1;
if nargin>1 
    nmod = varargin{1};
end

n=1:length(data);
data_power = norm(data);
power_ratio = 0.001;
k = 1;
dp_remain = data_power;
while k<=nmod & dp_remain>power_ratio*data_power
    [coff(k),freq(k)] = interpolatedFFT(data); % interp_hanning_FFT(data);  % 
    if isreal(data)
        data = data - 2.*real(coff(k)*exp(i*2.*pi*freq(k)*n));
    else
        data = data - coff(k)*exp(i*2.*pi*freq(k)*n);
    end
    dp_remain = norm(data);
	dpr(k) = dp_remain;
    
    k = k+1;
    
end

coff(find(freq<0)) = [];
freq(find(freq<0)) = [];

if nargin>2
	el=varargin{2};
	af=[];
	ai=[];
	for ii=1:length(freq)
		for j=1:length(af)
			tmp=abs(freq(ii)-af(j));
			if tmp<el
				ai = [ai,ii];
				break
			end
		end
		af = [af,freq(ii)];
	end
	freq(ai)=[];
	coff(ai)=[];

end
	

%[coff(1),freq(2)] = interp_hanning_FFT(data);
%[coff(1),freq(1)] = interpolatedFFT(data);

function [c,f]=interpolatedFFT(data)
%
afq = abs(fft(data));
N = length(data);
if isreal(data)
    k = 1:ceil(N/2);
else
    k=1:N;
end
[vm,im]=max(afq(k));
if im==1 
    im2 = im+1;
elseif im==length(k)
    im2 = im-1;
else
    if afq(im+1) > afq(im-1)
        im2 = im+1;
    else
        im2 = im-1;
    end
end

f = ( im-1 + (im2-im)*afq(im2)/(afq(im) + afq(im2)) )/N;
c = calcampli(data,f);

function [c,f]=interp_hanning_FFT(data)
%
N=length(data);
n=1:N;
chi = sin(pi*n/N).^2;
ndata = data.*chi;

afq = abs(fft(ndata));

if isreal(data)
    k = 1:ceil(N/2);
else
    k=1:N;
end
[vm,im]=max(afq(k));
if im==1 
    im2 = im+1;
elseif im==length(k)
    im2 = im-1;
else
    if afq(im+1) > afq(im-1)
        im2 = im+1;
    else
        im2 = im-1;
    end
end

f = (im-1 + (im2-im)*( 3.*afq(im2)/(afq(im)+afq(im2)) - 1 ))/N;
c = calcampli(data,f);


function c=calcampli(data, v)
%calculate the amplitude of frquency v in 1D series data
% data - (a+b*i) e(2 pi v t)  will contain no v component
% c= a+b*i;
N=length(data);
fq = fft(data);

% im = round(N*v)+1;
% k=[im-1,im,im+1];
% k(find(k<1)) = [];
% a = real(sum(fq(k)));
% b = imag(sum(fq(k)));

n=1:N;
em = exp(-2.*pi*i*v*n);

a = sum(real(data.*em))/N;
b = sum(imag(data.*em))/N;

c = a+ b*i;
