function [Dy0, Dy0p,Dy1,Dy1p, Dy2, Dy2p] = findDy2(RING, varargin)
%function [Dy0, Dy0p,Dy1,Dy1p] = findDy2(RING, REFPTS)
%find the dispersion function up to second order at the REFPTS
%by default REFPTS = 1:length(RING)
%\Delta x = Dy0 \delta + Dy1 \delta^2
%Dy0p = d(Dy0)/ds,  Dy1p = d(Dy1)/ds
%
%Turn OFF the cavity and radiation in the model!!!

REFPTS = 1:length(RING);
if nargin>=2
    REFPTS = varargin{1};
end
if max(REFPTS) >= length(RING) + 1
    disp('out of range')
    Dy = [];
end

%dp = 0.0001*[-10:10];
dp = 0.0005*[-20:20];

for ii=1:length(dp)
    X0(:,:,ii) = findorbit4(RING, dp(ii), REFPTS);
end

for jj=1:length(REFPTS)
    %fit x = Dy0 + Dy1 dp
    for ii=1:length(dp)
       x1(ii) = X0(3,jj,ii); 
       x1p(ii)= X0(4,jj,ii);
    end
    
   [fp,fs] = polyfit(dp, x1,3);
   Dy0(jj) = fp(end-1);
   Dy1(jj) = fp(end-2);
   Dy2(jj) = fp(end-3);
   
   [fp,fs] = polyfit(dp, x1p,3);
   Dy0p(jj) = fp(end-1);
   Dy1p(jj) = fp(end-2);
   Dy2p(jj) = fp(end-3);
end


