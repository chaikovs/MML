function h = subfig(a, b, c, h)
%SUBFIG - Pops the current axes into a separate figure
%  h = subfig(s1, s2, s3, h_fig)
%
%  Written by Greg Portmann


if nargin < 3
    error('3 inputs required');
end
if nargin < 4
    h = figure;
else
    h = figure(h);
end

s = get(0, 'ScreenSize');

xbuf = .02 * s(3);
ybuf = .06 * s(4);

CommandWindowUnits = get(0,'Units');
FigUnits = get(h,'Units');
set(h,'Units', CommandWindowUnits);


Nx = 5;
Ny = 2;
if a == 1 & b == 1
    set(h, 'Position',[Nx*xbuf  Ny*ybuf  s(3)-2*Nx*xbuf s(4)-2*Ny*ybuf]);
    
elseif a == 2 & b ==2
    if c == 1
        set(h, 'Position',[       xbuf    s(4)/2+.5*ybuf  s(3)/2-1*xbuf s(4)/2-2*ybuf]);
    elseif c == 2
        set(h, 'Position',[s(3)/2+xbuf/2  s(4)/2+.5*ybuf  s(3)/2-1*xbuf s(4)/2-2*ybuf]);
    elseif c == 3
        set(h, 'Position',[       xbuf              ybuf   s(3)/2-1*xbuf s(4)/2-2*ybuf]);
    elseif c == 4
        set(h, 'Position',[s(3)/2+xbuf/2            ybuf   s(3)/2-1*xbuf s(4)/2-2*ybuf]);
    end
elseif a == 1 & b ==2
    if c == 1
        set(h, 'Position',[       xbuf    Ny*ybuf  s(3)/2-1*xbuf s(4)-2*Ny*ybuf]);
    elseif c == 2
        set(h, 'Position',[s(3)/2+xbuf/2  Ny*ybuf  s(3)/2-1*xbuf s(4)-2*Ny*ybuf]);
    elseif c == 3
        set(h, 'Position',[       xbuf    Ny*ybuf  s(3)/2-1*xbuf s(4)-2*Ny*ybuf]);
    elseif c == 4
        set(h, 'Position',[s(3)/2+xbuf/2  Ny*ybuf  s(3)/2-1*xbuf s(4)-2*Ny*ybuf]);
    end
end

set(h,'Units', FigUnits);

