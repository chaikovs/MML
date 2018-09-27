function sigmas = modelbeamsize
% function modelbeamsize - get beam sizes along the ring
%
%  OUPUTS
%  1. sigmas ! beam sizes in meters

%% Written by Laurent S. Nadolski
global THERING

[emit sigmas] = modelemit;
spos = findspos(THERING,1:length(THERING)+1);

figure

[A, H1, H2] = plotyy(spos,sigmas(1,:)*1e6,spos,sigmas(2,:)*1e6);


set(H1,'Marker','.')
set(A(1),'XLim',[0 spos(end)])
set(H2,'Marker','.')
set(A(2),'XLim',[0 spos(end)])

set(get(A(2),'Ylabel'), 'Color', 'r')
    set(H2,'Color', 'r');
    set(A(2),'Ycolor', 'r')
    
title('Principal axis of the beam ellipse [m]');
xlabel('s - position [m]');

atplotsyn(A(1), THERING);