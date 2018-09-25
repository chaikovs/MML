function [meas_psix,meas_psiy,meas_betx,meas_bety] = icatest(filename)
%
load(filename,'BPMx','BPMy')
BPMx = BPMx';
BPMy = BPMy';

%[xa, ya] = icaloaddata('nqerr_noise');
NBPM = size(BPMx,1);

paraset.method = 'ICA';
paraset.st = 1;
paraset.wid = 1000;
paraset.tao = [0 1 2 3 ];
paraset.el = 0.01;
paraset.preprocess = 'zero mean';
dout = icacmd('run', [BPMx; BPMy],paraset);
[l1,l2] = icacmd('pair', dout);
ix = 1;
meas_betx = dout.A(1:NBPM,l2(ix,1)).^2+dout.A(1:NBPM,l2(ix,2)).^2;
meas_psix     = atan2(dout.A(1:NBPM,l2(ix,2)),dout.A(1:NBPM,l2(ix,1)));
meas_psix = unwrap(meas_psix);
if diff(meas_psix(1:2))<0
   meas_psix = -meas_psix; 
end
meas_psix = meas_psix-meas_psix(1);
meas_dpsix = mod(diff(meas_psix),2*pi);

iy = 2;
meas_bety = dout.A(1+NBPM:end,l2(iy,1)).^2+dout.A(1+NBPM:end,l2(iy,2)).^2;
meas_psiy     = atan2(dout.A(1+NBPM:end,l2(iy,2)),dout.A(1+NBPM:end,l2(iy,1)));
meas_psiy = unwrap(meas_psiy);
if diff(meas_psiy(1:2))<0
   meas_psiy = -meas_psiy; 
end
meas_dpsiy = -mod(diff(meas_psiy),2*pi)+2*pi;
meas_psiy = meas_psiy-meas_psiy(1);
