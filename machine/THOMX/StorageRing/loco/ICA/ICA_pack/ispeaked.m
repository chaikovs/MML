function [res, varargout] = ispeaked(s,varargin)
%[res, varargout] = ispeaked(s,varargin)
%tell a signal s has a peak in its FFT spectrum or not
%by:
%	1. sorting f = abs(fft(s))
%	2. calculate the total area covered by f, a = sum(f)
%	3. find the least number of points, h,  which account for a certain 
%		percentage of the total area a. 
%	4. The smaller h/N is, the more like a peaked signal s is
%
%s = in, Nx1, signal
%varargin = {per,  r_thresh}, where per is percentage of area, and r_thresh is the h/N threshold
%res =out,  yes (>0) or no (=0)
%varargout = h/N
%
%parameter per should be smaller for weaker peak or lower SNR
%
per = 0.3; % 0.3 of a
if nargin >=2 
	per = varargin{1};
end

r_thresh = 0.25*per; %h/l < 0.2 ---> peak
if nargin >=3 
	r_thresh = varargin{2}*per;
end


N = length(s);
f = abs(fft(s));
a = sum(f);

sf = sort(f);
i=N;
ha = 0.0;
while ha < a*per
	ha = ha + sf(i);
	i = i-1;
end

h = N-i;
res = (h*1.0/N < r_thresh);
if nargout >=2
	varargout{1} = h*1.0/N;
end