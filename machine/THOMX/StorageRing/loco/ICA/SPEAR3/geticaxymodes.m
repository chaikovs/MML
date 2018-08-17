function [resmodes,dout]=geticaxymodes(x,y,Nturn)
%Given turn by turn data matrices x and y, perform ICA and obtain the x-y normal modes. 
%Then calculate the beta function and phase advances for the primary and
%secondary components. 
%created by X. Huang, 7/17/2014
%

if nargin<3
   Nturn = size(x,2)-5; 
end
nbpm = size(x,1);

para.st=1;para.wid=Nturn+para.st+5;                                              
para.tao=[ 1 2 3]; para.preprocess='zero mean';                     
para.method='ICA'; para.el=-10;                                      
dout = icacmd('run',[x;y],para);                                     
% dout         

[lr,pr]=icacmd('pair',dout) ;

[fq1] = naff(dout.s(pr(1,1),:)');
[fq2] = naff(dout.s(pr(2,1),:)');
% [fq3] = naff(dout.s(pr(3,1),:)');
% [fq4] = naff(dout.s(pr(4,1),:)')

if fq1 < fq2
    idx = pr(1,:);
    idy = pr(2,:);
    resmodes.tunes = [fq1, fq2];
else
    idx = pr(2,:);
    idy = pr(1,:);
    resmodes.tunes = [fq2, fq1];
end
dout.pr = [idx; idy];

idbpmx = 1:nbpm;
idbpmy = idbpmx + nbpm;

resmodes.xI = dout.A(idbpmx, idx(1:2))*sqrt(2/Nturn);
resmodes.xII = dout.A(idbpmx, idy(1:2))*sqrt(2/Nturn);
resmodes.yI = dout.A(idbpmy, idx(1:2))*sqrt(2/Nturn);
resmodes.yII = dout.A(idbpmy, idy(1:2))*sqrt(2/Nturn);


%% primary modes
betx_amp = sqrt(dout.A(idbpmx, idx(1)).^2 + dout.A(idbpmx, idx(2)).^2)*sqrt(2/Nturn);  %*2/Nturn to normalize s to max 1
psix = atan2(dout.A(idbpmx,idx(1)),dout.A(idbpmx,idx(2)));
psix = unwrap(psix);

bety_amp = sqrt(dout.A(idbpmy, idy(1)).^2 + dout.A(idbpmy, idy(2)).^2)*sqrt(2/Nturn);
psiy = atan2(dout.A(idbpmy,idy(1)),dout.A(idbpmy,idy(2)));
psiy = unwrap(psiy);

resmodes.betx_amp = betx_amp;
resmodes.bety_amp = bety_amp;

flag_reverse_x = 0;
if diff(psix(1:2)) < 0
    psix = -psix;
    flag_reverse_x = 1;
end
flag_reverse_y = 0;
if diff(psiy(1:2)) < 0
    psiy = -psiy;
    flag_reverse_y = 1;
end
resmodes.psix1 = psix;
resmodes.psiy2 = psiy;
% resmodes.Dx = Dx;
% resmodes.Dy = Dy;


if 0
spos = getspos('BPMx');
figure
subplot(2,1,1);
plot(spos, betx,'o-');
xlabel('spos (m)');
ylabel('betax');

subplot(2,1,2);
plot(spos, psix,'o-');
xlabel('spos (m)');
ylabel('psix');

figure
subplot(2,1,1);
plot(spos, bety,'o-');
xlabel('spos (m)');
ylabel('betay');

subplot(2,1,2);
plot(spos, psiy,'o-');
xlabel('spos (m)');
ylabel('psiy');
end

%% secondary (coupling) modes
betx2_amp = sqrt(dout.A(idbpmx, idy(1)).^2 + dout.A(idbpmx, idy(2)).^2)*sqrt(2/Nturn);
if flag_reverse_y  %coefficient c, d
    psix2 = atan2(-dout.A(idbpmx,idy(1)),dout.A(idbpmx,idy(2)));
else
    psix2 = atan2(dout.A(idbpmx,idy(1)),dout.A(idbpmx,idy(2)));
end
psix2 = unwrap(psix2);

bety1_amp = sqrt(dout.A(idbpmy, idx(1)).^2 + dout.A(idbpmy, idx(2)).^2)*sqrt(2/Nturn);
if flag_reverse_x % coefficient a, b
    psiy1 = atan2(-dout.A(idbpmy,idx(1)),dout.A(idbpmy,idx(2)));
else
   psiy1 = atan2(dout.A(idbpmy,idx(1)),dout.A(idbpmy,idx(2))); 
end
psiy1 = unwrap(psiy1);

resmodes.betx2_amp = betx2_amp;
resmodes.bety1_amp = bety1_amp;

resmodes.psix2 = psix2;
resmodes.psiy1 = psiy1;
% resmodes.dpsi1 = mod(psiy2-psix,2*pi); %phase of mode 1 on y - phase of modes 1 on x
% resmodes.dpsi2 = mod(psix2-psiy,2*pi); %phase of mode 2 on x - phase of modes 2 on y

save res_data_ica resmodes dout 

