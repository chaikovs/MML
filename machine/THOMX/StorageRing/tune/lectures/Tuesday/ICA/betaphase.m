function [ax,ay,px,py] = betaphase(data)
%make sure the first two are a pair of x-modes, so are the next two
%there should be y-modes
%
m = round(size(data.A,1)/2);

ax = sqrt(data.A(1:m,1).^2+data.A(1:m,2).^2);
px = atan2(data.A(1:m,1),data.A(1:m,2));
px = unwrap(px);

ay = sqrt(data.A(m+1:end,3).^2+data.A(m+1:end,4).^2);
py = atan2(data.A(m+1:end,3),data.A(m+1:end,4));
py = unwrap(py);
