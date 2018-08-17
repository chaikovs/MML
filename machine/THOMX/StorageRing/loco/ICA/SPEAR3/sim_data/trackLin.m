clear
global sigma_bpm 
if 1
    %    load lat_2009-6-30 THERING
    sp3v82_lelt;
%     radiationon;
%     cavityon;
    
    ati=atindex(THERING);
    qfk = getcellstruct(THERING,'K',ati.QF);
    THERING = setcellstruct(THERING, 'K',ati.QF(1),qfk(1)*1.02);
    THERING = setcellstruct(THERING, 'PolynomB',ati.QF(1),qfk(1)*1.02,1,2);
    
    THERING = setcellstruct(THERING, 'K',ati.QF(9),qfk(9)*1.02);
    THERING = setcellstruct(THERING, 'PolynomB',ati.QF(9),qfk(9)*1.02,1,2);
    
    THERING = setcellstruct(THERING, 'K',ati.QF(15),qfk(15)*0.96);
    THERING = setcellstruct(THERING, 'PolynomB',ati.QF(15),qfk(15)*0.96,1,2);
    %
    qdk = getcellstruct(THERING,'K',ati.QD);
    THERING = setcellstruct(THERING, 'K',ati.QD(9),qdk(9)*0.96);
    THERING = setcellstruct(THERING, 'PolynomB',ati.QD(9),qdk(9)*1.04,1,2);
    
    THERING = setcellstruct(THERING, 'K',ati.QD(12),qdk(12)*1.08);
    THERING = setcellstruct(THERING, 'PolynomB',ati.QD(12),qdk(12)*1.02,1,2);
    
%     sfk2 = getcellstruct(THERING,'PolynomB',ati.SF,1,3);
%     THERING = setcellstruct(THERING, 'PolynomB',ati.SF,sfk2*1.05,1,3);
%     
%     sdmk2 = getcellstruct(THERING,'PolynomB',ati.SDM,1,3);
%     THERING = setcellstruct(THERING, 'PolynomB',ati.SDM,sdmk2*1.05,1,3);
    
    isf  =  findcells(THERING,'FamName','SF');
    isd  =  findcells(THERING,'FamName','SD');
    isfi =  findcells(THERING,'FamName','SFM');
    isdi =  findcells(THERING,'FamName','SDM');
    isAT  = sort([isf isd isfi isdi]);
    
    isext = [4 7 19 26 30 33 40 43 47 54 62 66 69];    %indices of 13 skew sextupole (on basis of 1-72 in SPEAR 3)
    isATon = isAT(isext);
    THERING = setcellstruct(THERING, 'PolynomA',isATon(5),0.05,1,2);
    THERING = setcellstruct(THERING, 'PolynomA',isATon(9),-0.05,1,2);
    
    [FitParamRef] = buildfitparameters(THERING);
    
     bpmindex = family2atindex('BPMx',getlist('BPMx'));
     bpmindex = bpmindex';
    
    if 1
%         load locoin_2009-6-30_5AM
        %     gx = BPMData(5).HBPMGain/BPMData(5).HBPMGain(34);
        %     gy = BPMData(5).VBPMGain/BPMData(5).VBPMGain(34);
        %     gx(33) = 1;
        %     gy(33) = 1;
        %     gy(11) = 1.05;
        gx = 1+0.02*randn(57,1);
        gy = 1+0.02*randn(57,1);
%         gx(16) = 1.1;
%         gy(28) = 0.9;
           
        %clear BPM gains for a test
        %     gx = ones(size(gx));
        %     gy = ones(size(gy));
        br = zeros(size(gx)); %BPM rolls
        br = 0.012*randn(size(br));
 
    else
        load bpmerr_case1 gx gy br
        gx = ones(size(gx));
        gy = gx;
    end
    
    tw = twissring(THERING,0,bpmindex,'chrom',1e-5);
    bet = cat(1,tw.beta);
    betx = bet(:,1);
    phi = cat(1,tw.mu);
    phix = phi(:,1);
    
    dispf = cat(1,tw.Dispersion);
    Dx0 = dispf(1:4:end);
    Dy0 = dispf(3:4:end);
    
    R0 = zeros(6,1);
    R0(1) = 0.002; %m
    R0(3) = 0.001; %m
    %     R0(1) = 0.002; %m
    %     R0(3) = 0.002; %m
    Nturn = 1100;
    
    tic
    [R1, loss] = ringpass(THERING,R0,Nturn);
    toc
    
    for ii=1:Nturn
        Rout = linepass(THERING, R1(:,ii), bpmindex);
        xa(:,ii) = Rout(1,:)';
        xpa(:,ii) = Rout(2,:)';
        ya(:,ii) = Rout(3,:)';
        ypa(:,ii) = Rout(4,:)';
    end
    
    %apply BPM gains and rolls
    Dx = Dx0;
    Dy = Dy0;
    for ii=1:length(bpmindex)
        %        xa(ii,:) = xa(ii,:)*gx(ii);
        %        ya(ii,:) = ya(ii,:)*gy(ii);
        xa(ii,:) = xa(ii,:)*gx(ii)*cos(br(ii))+ya(ii,:)*gy(ii)*sin(br(ii));
        ya(ii,:) = ya(ii,:)*gy(ii)*cos(br(ii))-xa(ii,:)*gx(ii)*sin(br(ii));
        Dx(ii) = Dx(ii)*gx(ii)*cos(br(ii))+Dy(ii)*gy(ii)*sin(br(ii));
        Dy(ii) = Dy(ii)*gy(ii)*cos(br(ii))-Dx(ii)*gx(ii)*sin(br(ii));
    end
    sigma_bpm = 0.02e-3;
    exa = randn(size(xa))*sigma_bpm*1;
    eya = randn(size(ya))*sigma_bpm*1;
    
    [tune,Chrom] = tunechrom(THERING,0,'chrom',1.0e-5);
    sigma_tune = 0.001;
    
    save data_track xa ya sigma_bpm exa eya bpmindex bet phi THERING FitParamRef  gx gy br tune sigma_tune Dx Dy  Dx0 Dy0
%    !move data_track.mat data_track_case1.mat
     !move data_track.mat data_track_case2.mat

else
    
    load data_track_case1
    
end

% exa = randn(size(xa))*sigma_bpm*1;
% eya = randn(size(ya))*sigma_bpm*1;
xa = xa+ exa;
ya = ya+ eya;

NBPM = size(xa,1);
% browseSVDmodes(xa);

if 0
[u,s,v] = svd([xa; ya]);
nmodes = 20; %2*NBPM; %20;
xya=u(:,1:nmodes)*s(1:nmodes,:)*v'; %remove white noises
xa = xya(1:NBPM,1:200);
ya = xya(NBPM+(1:NBPM),1:200);

end

return

%% use the

sp3v82_lelt;
[FitParameters] = buildfitparameters(THERING);


clear global g_costindex g_costweight
global g_costindex g_costweight
g_costindex = [1:length(FitParameters.Params)+NBPM*3-6]';
g_costweight = ones(size(g_costindex))*0.1;
g_costweight(1:length(FitParameters.Params)) = 0.001;
% g_costweight(86:89) = 0.0;

% g_costindex = [length(FitParameters.Params)+(1:NBPM*2-2)]';
% g_costweight = ones(size(g_costindex))*0.1;

tic
opt = 1;
switch opt
    case 1
        data.bpmindex = bpmindex;
        data.xa = xa;
        data.ya = ya;
        data.b1b2indx = [b1indx,b2indx];
        data.Chrom = Chrom;
        [FitParamOut,Xgain,Ygain,Broll] = fitRing(THERING,data,FitParameters);
        for ii=1:length(FitParamOut.Params)
            THERING = setparamgroup(THERING, FitParamOut.Params{ii}, FitParamOut.Values(ii)); %+FitParameters.Deltas(ii)
        end
end
figure
subplot(3,1,1)
plot(1:57,gx([35:end,1:34]),1:57, Xgain);
ylabel('BPM x');
subplot(3,1,2)
plot(1:57,gy([35:end,1:34]),1:57, Ygain);
ylabel('BPM y');
subplot(3,1,3)
plot(1:57,br([35:end,1:34]),1:57, Broll);
ylabel('BPM roll');

figure;
% h = plot(1:89, FitParamOut.Values - FitParameters.Values, 1:89, FitParamRef.Values - FitParameters.Values); grid on
h = plot(1:89, FitParamOut.Values./FitParameters.Values-1, 1:89, FitParamRef.Values./FitParameters.Values-1); grid on
% bar([FitParamOut.Values - FitParameters.Values, FitParamRef.Values - FitParameters.Values]);
legend(h, 'fitted','target',0);
xlabel('Fit Param');
ylabel('Delta K');

toc

% figure
% RING1=THERING;
% load data_track  THERING
% RING0=THERING;
% latcomp(RING0,RING1,0,1);

% sp3v82_lelt;
% figure
% latcomp(RING0,THERING,0,1)

