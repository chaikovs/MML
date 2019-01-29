function [x_coeff1 x_coeff2 xp_coeff1 xp_coeff2 y_coeff1 y_coeff2 yp_coeff1 yp_coeff2] = FindCoeffPosAngleinDipole(varargin)
% gives the coeficients
% x = x_coeff1 * x0 + x_coeff2 * x2; 
% xp = xp_coeff1 * x0 + xp_coeff2 * x2;
% 
% y = y_coeff1 * y0 + y_coeff2 * y2;
% yp = yp_coeff1 * y0 + yp_coeff2 * y2;
%
% where :  
% x0, y0 (resp. x2, y2) are the beam horizontal and vertical position at BPM before dipole
% (resp. after dipole) in micrometer.
% x, xp (resp. y, yp) are the horizontal (resp. vertical) position and angle
% of the beam inside the dipole, at the specific marker "varargin", in
% micrometer.
% This marker must be listed in the lattice setdevelopmentmode(48)
%
% exemple : [x_coeff1 x_coeff2 xp_coeff1 xp_coeff2 y_coeff1 y_coeff2 yp_coeff1 yp_coeff2] = FindCoeffPosAngleinDipole('AXD')

%% run lattice with markers at all sources points, diagnostics and scrapers

setdevelopmentmode(48) ; %  nano_bxSDL01_09_11m from Oct. 2013 with TEMPO chicane and its marker at angle -50 µrad
disp('User chose nano_bxSDL01_09_11m from Oct optics, including TEMPO chicane and all Markers')
setcavity('on')
setradiation('on');
global THERING

updateatindex
ATi = atindex;
index_BPM = ATi.BPM ;

element = '';
for i = length(varargin):-1:1
    element = varargin{i}
end

if length(element)==0
        element = 'ODE' ; % test @ dipole C01-D2 1°
end 

%% compute matrices between reference points

[i1 j1] = find(index_BPM< ATi.(element));
n_BPM_entrance = j1(end) ;
[i2 j2] = find(index_BPM> ATi.(element));
n_BPM_exit = j2(1);

REFPTS = [ ATi.BPM(n_BPM_entrance)  ATi.(element)  ATi.BPM(n_BPM_exit)] ;

% get transport matrix  from entrance of lattice to reference points
clear M66 T
[M66,T] = findm66(THERING,REFPTS) ;

% M66 = FINDM66(RING)finds full one-turn 6-by-6
%    matrix at the entrance of the first element

% [M66,T] = FINDM66(RING,REFPTS) in addition to M finds
%    6-by-6 transfer matrixes  between entrances of
%    the first element and each element indexed by REFPTS.
%    T is 6-by-6-by-length(REFPTS) 3 dimentional array.

M = M66 ; % from begining to begining
M1 = T(:,:,1) ; % from begining to BPM at dipole entrance
M2 = T(:,:,2) ; % from begining to specific element in dipole
M3 = T(:,:,3) ; % from begining to BPM at dipole exit

A = M2 * inv(M1) ; % M_BPMentrance_to_elem
B = M3 * inv(M1) ; % M_BPMentrance_to_BPMexit
C = M3 * inv(M2) ; % M_elem_to_BPMexit
D = inv(C) ; % M_BPMexit_to_elem

%% horizontal plane
% x position at elem
% xp = angle at elem

x_coeff1 = A(1,1) - A(1,2) * (A(1,1) - D(1,2)*B(2,1))/(A(1,2) - D(1,2) * B(2,2));
x_coeff2 = A(1,2) * D(1,1) / (A(1,2) - D(1,2) * B(2,2));

x_coeff1 = x_coeff1 * 1e3;
x_coeff2 = x_coeff2 * 1e3;

xp_coeff1 = A(2,1) - A(2,2) * (A(1,1) - D(1,2)*B(2,1))/(A(1,2) - D(1,2)*B(2,2));
xp_coeff2 = A(2,2) * D(1,1) / (A(1,2) - D(1,2)*B(2,2));

xp_coeff1 = xp_coeff1 * 1e3;
xp_coeff2 = xp_coeff2 * 1e3;

% verif ODE
% in device : x_coeff1 = 534.36 ; x_coeff2 = 258.57 ;
% in device : xp_coeff1 = -248 ; xp_coeff2 = 257 ;

% x0 = 0.1 ;
% x2 = -0.1 ;
% x = x_coeff1 * x0 + x_coeff2 * x2;
% xp = xp_coeff1 * x0 + xp_coeff2 * x2;

%% vertical plane
% y position at elem
% yp = angle at elem

y_coeff1 = A(3,3) - A(3,4) * (A(3,3) - D(3,4)*B(4,3))/(A(3,4) - D(3,4) * B(4,4));
y_coeff2 = A(3,4) * D(3,3) / (A(3,4) - D(3,4) * B(4,4));

y_coeff1 = y_coeff1 * 1e3;
y_coeff2 = y_coeff2 * 1e3;

yp_coeff1 = A(4,3) - A(4,4) * (A(3,3) - D(3,4)*B(4,3))/(A(3,4) - D(3,4)*B(4,4));
yp_coeff2 = A(4,4) * D(3,3) / (A(3,4) - D(3,4)*B(4,4));

yp_coeff1 = yp_coeff1 * 1e3;
yp_coeff2 = yp_coeff2 * 1e3;

% verif ODE
% in device : y_coeff1 = 871 ; y_coeff2 = 469 ;
% in device : yp_coeff1 = -339 ; yp_coeff2 = 345 ;

% y0 = 0.1 ;
% y2 = -0.1 ;
% y = y_coeff1 * y0 + y_coeff2 * y2;
% yp = yp_coeff1 * y0 + yp_coeff2 * y2;

