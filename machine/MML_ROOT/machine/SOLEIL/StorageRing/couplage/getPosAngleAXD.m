function [x xp z zp] = getPosAngleAXD

% July 2016
% find Horizontal and vertical position and angle of photons on convertor of AXD
% using data from BPMs before and after dipole C12 - D2.


%% data for AXD

% source point C12 - D2 @ 3.8° (cannot be changed)
% BPM1        = [12 6] ;
% BPM2        = [12 7] ;
% distance_AXD_BPM2 = 0.05 ; % m (may be changed)
% spos_sourcepoint_C12_D2 = 255.2498 ; % m (need mml and specific lattice to calculate..)
% distance_sourcepoint_AXD = getspos('BPMx',[12 7]) - distance_AXD_BPM2 - spos_sourcepoint_C12_D2

distance_sourcepoint_AXD = 1.323 ; % distance in m

%% get beam transverse positions at source point

dev     = 'ANS-C12/DG/CALC-D2-POSITION-ANGLE' ;
% pos angle at source point in micrometer and microradian
temp    = tango_read_attribute2(dev,'AXD_positionX');   x_sp = temp.value;
temp    = tango_read_attribute2(dev,'AXD_positionZ');   z_sp = temp.value;
temp    = tango_read_attribute2(dev,'AXD_angleX');      xp_sp = temp.value;
temp    = tango_read_attribute2(dev,'AXD_angleZ');      zp_sp = temp.value;

%% get beam transverse positions at AXD

% pos and angle of photons on AXD in micrometer and microradian
x = x_sp + xp_sp*distance_sourcepoint_AXD ;
z = z_sp + zp_sp*distance_sourcepoint_AXD ;
 
xp = xp_sp ;
zp = zp_sp ;

