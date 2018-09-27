function [orbit]=load_orbit_corr

istart=27;
iend  =200;
nbpmx=22;

clear Zm Xm


[Xm,Zm] = getboobpm(nbpmx,iend,istart);

orbit.x=Xm;
orbit.z=Zm;
orbit.corx=getam('HCOR');
orbit.corz=getam('VCOR');

save 'orbit_19-jun-2008_extraction.mat' 'orbit'

