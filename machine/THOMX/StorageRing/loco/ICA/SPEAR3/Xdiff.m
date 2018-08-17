function df = Xdiff(RING,icamodes,FitParam, p, varargin)
%the objective function to be passed to findLSmin.m
% @(FitValues)Xdiff(RING,icamodes,FitParam, p)
%
global g_FitValue_save g_Twiss g_Pl g_RING g_tunes g_psi1 g_psi2

Nfitpara = length(FitParam.Values);
FitValues = p(1:Nfitpara)+FitParam.Values;
flag_update = 0;
if isempty(g_FitValue_save) || (norm(FitValues - g_FitValue_save)>0) || isempty(g_RING) || isempty(g_Twiss)
    g_FitValue_save = FitValues;
    flag_update = 1;
end
bpmindex = icamodes.bpmindex;
NBPM = length(bpmindex);

Xgain = [p(Nfitpara+(1:NBPM));];
Ygain = [p(Nfitpara+NBPM+(1:NBPM));];
% Xgain = ones(NBPM,1);
% Ygain = Xgain;

Broll = [p(Nfitpara+(NBPM)*2+(1:NBPM));];

if flag_update
    for ii=1:length(FitParam.Params)
        RING = setparamgroup(RING, FitParam.Params{ii}, FitValues(ii)); %+
    end
%     fprintf('model recalculated\n');
    g_RING = RING;
%     [g_tunes,g_Chrom] = tunechrom(RING,0,'chrom',1.0e-5);
    g_Twiss = twissring(RING,0,bpmindex','chrom',1.0e-5);   
    
    [m44,T] = findm44(RING,0, bpmindex(:)');
    %[P,R44,nu1,nu2] = calcPmat(m44);
    [V1, U1,P, R44,nu1,nu2] = calcVmat(m44);
    g_tunes = [nu1,nu2];
    
    for ii=1:NBPM
        T1 = squeeze(T(:,:,ii));
        M44 =  T1*m44*inv(T1);
%         [P] = calcPmat(M44);
        [V1, U1,P] = calcVmat(M44);
        g_Pl{ii} = P;
        if ii>=2
            T12 = T1*inv(   squeeze(T(:,:,ii-1)) ) ;
            dR = inv(P)*T12*g_Pl{ii-1};
            %phase advances of normal modes between BPMs ii-1 and ii.
            dphi1(ii) = atan2(dR(1,2), dR(1,1));
            dphi2(ii) = atan2(dR(3,4), dR(3,3));
        else
            dphi1(ii) = 0;
            dphi2(ii) = 0;
        end
 
    end
    g_psi1 = cumsum(dphi1);
    g_psi2 = cumsum(dphi2);

end
mbeta = cat(1,g_Twiss.beta);
mpsi = cat(1,g_Twiss.mu);
mpsi(:,1) = unwrap(mpsi(:,1));
mpsi(:,2) = unwrap(mpsi(:,2));
mdif_psix = diff(mpsi(:,1));
mdif_psiy = diff(mpsi(:,2));
mtunes = g_tunes;
% 
dispersion = cat(1,g_Twiss.Dispersion);
mDx = dispersion(1:4:end);
mDy = dispersion(3:4:end);

%transformation matrix between [x, y]' and the normal modes, including BPM
%gains and rolls
for ii=1:NBPM
    trmat = [cos(Broll(ii)), sin(Broll(ii)); -sin(Broll(ii)), cos(Broll(ii))]*diag([Xgain(ii), Ygain(ii)]);
    trP(:,:,ii) = trmat*g_Pl{ii}([1,3],:); 
    trDisp(:,ii) = trmat*[mDx(ii), mDy(ii)]';
end

m_amp_x1 = zeros(NBPM,1);  %mode 1 on x, amplitude function, sqrt(\beta_1) when gain=1,roll=0
m_amp_x2 = zeros(NBPM,1);
m_amp_y1 = zeros(NBPM,1);
m_amp_y2 = zeros(NBPM,1);
m_psi_x1 = zeros(NBPM,1);
m_psi_y2 = zeros(NBPM,1);
m_psi_x2 = zeros(NBPM,1);
m_psi_y1 = zeros(NBPM,1);
for ii=1:NBPM
    m_amp_x1(ii) = norm(trP(1,1:2,ii));
    m_amp_x2(ii) = norm(trP(1,3:4,ii));
    m_amp_y1(ii) = norm(trP(2,1:2,ii));
    m_amp_y2(ii) = norm(trP(2,3:4,ii));
    
    m_psi_x1(ii) = atan2(trP(1,2,ii), trP(1,1,ii));
    m_psi_x2(ii) = atan2(trP(1,4,ii), trP(1,3,ii));
    m_psi_y1(ii) = atan2(trP(2,2,ii), trP(2,1,ii));
    m_psi_y2(ii) = atan2(trP(2,4,ii), trP(2,3,ii));

end

m_psi_x1 = unwrap(m_psi_x1+g_psi1');
m_psi_x2 = unwrap(m_psi_x2+g_psi2');
m_psi_y1 = unwrap(m_psi_y1+g_psi1');
m_psi_y2 = unwrap(m_psi_y2+g_psi2');


%% residual vector

%weight = [betx1, bety2, betx2, bety1, Dx, Dy, psix1, psix2,psiy1,psiy2,
%tunes]
wt = [0.5, 0.5, 1, 1, 0.8,0.8, 1, 0.2, 0.5, 1, 1];
sigbetx = 0.05; 
sigbety = 0.05;
sigDx = 0.01;
sigDy = 0.01;
sigpsix1 = 0.005;
sigpsiy2 = 0.005;
sigpsix2 = 0.05;
sigpsiy1 = 0.05;
sigtune = 0.001;

sqW1 = mean(icamodes.betx_amp./m_amp_x1);
sqW2 = mean(icamodes.bety_amp./m_amp_y2);

betx_amp = icamodes.betx_amp/sqW1;
bety_amp = icamodes.bety_amp/sqW2;
betx2_amp = icamodes.betx2_amp/sqW2;
bety1_amp = icamodes.bety1_amp/sqW1;

flag_plot = 0;
if nargin>=5
   flag_plot = varargin{1}; 
end
if flag_plot
figure
subplot(2,3,1)
plot(1:NBPM,betx_amp, 1:NBPM, m_amp_x1)
ylabel('sqrt betx1');
subplot(2,3,2)
plot(1:NBPM,bety_amp, 1:NBPM, m_amp_y2)
ylabel('sqrt bety2');

subplot(2,3,3)
plot(1:NBPM,betx2_amp, 1:NBPM, m_amp_x2)
ylabel('sqrt betx2');
subplot(2,3,4)
plot(1:NBPM,bety1_amp, 1:NBPM, m_amp_y1)
ylabel('sqrt bety1');

subplot(2,3,5)
plot(1:NBPM,trDisp(1,:)', 1:NBPM, icamodes.Dx)
ylabel('Dx');
subplot(2,3,6)
plot(1:NBPM,trDisp(2,:)', 1:NBPM, icamodes.Dy)
ylabel('Dy');
end

%phase difference between BPM 1 and ii
dpsi_1i_x1 = icamodes.psix1(2:end) - icamodes.psix1(1);
dpsi_1i_x2 = icamodes.psix2(2:end) - icamodes.psix2(1);
dpsi_1i_y1 = icamodes.psiy1(2:end) - icamodes.psiy1(1);
dpsi_1i_y2 = icamodes.psiy2(2:end) - icamodes.psiy2(1);

mdpsi_1i_x1 = (m_psi_x1(2:end) - m_psi_x1(1));
mdpsi_1i_x2 = (m_psi_x2(2:end) - m_psi_x2(1));
mdpsi_1i_y1 = (m_psi_y1(2:end) - m_psi_y1(1));
mdpsi_1i_y2 = (m_psi_y2(2:end) - m_psi_y2(1));

if flag_plot
figure
subplot(2,2,1)
plot(1:NBPM-1,cos(dpsi_1i_x1), 1:NBPM-1, cos(mdpsi_1i_x1))
ylabel('cos \Delta \psi, x1')
subplot(2,2,2)
plot(1:NBPM-1,cos(dpsi_1i_x2), 1:NBPM-1, cos(mdpsi_1i_x2))
ylabel('cos \Delta \psi, x2')
subplot(2,2,3)
plot(1:NBPM-1,cos(dpsi_1i_y1), 1:NBPM-1, cos(mdpsi_1i_y1))
ylabel('cos \Delta \psi, y1')
subplot(2,2,4)
plot(1:NBPM-1,cos(dpsi_1i_y2), 1:NBPM-1, cos(mdpsi_1i_y2))
ylabel('cos \Delta \psi, y2')
end

df = [wt(1)/sigbetx*(betx_amp-m_amp_x1); wt(2)/sigbety*(bety_amp-m_amp_y2); ...
    wt(3)/sigbetx*(betx2_amp-m_amp_x2); wt(4)/sigbety*(bety1_amp-m_amp_y1); ...
    wt(5)/sigDx*(trDisp(1,:)' - icamodes.Dx); wt(6)/sigDy*(trDisp(2,:)'-icamodes.Dy); ...
    wt(7)/sigpsix1*(cos(dpsi_1i_x1)-cos(mdpsi_1i_x1)); wt(7)/sigpsix1*(sin(dpsi_1i_x1)-sin(mdpsi_1i_x1));
      wt(8)/sigpsix2*(cos(dpsi_1i_x2)-cos(mdpsi_1i_x2)); wt(8)/sigpsix2*(sin(dpsi_1i_x2)-sin(mdpsi_1i_x2));
      wt(9)/sigpsiy1*(cos(dpsi_1i_y1)-cos(mdpsi_1i_y1)); wt(9)/sigpsiy1*(sin(dpsi_1i_y1)-sin(mdpsi_1i_y1));
    wt(10)/sigpsiy2*(cos(dpsi_1i_y2)-cos(mdpsi_1i_y2)); wt(10)/sigpsiy2*(sin(dpsi_1i_y2)-sin(mdpsi_1i_y2));
    wt(11)*(icamodes.tunes(:) - g_tunes(:))/sigtune];
    
df = df(:);

global g_indx_non_outlier
if isempty(g_indx_non_outlier)
   %determine the outliers
%    g_indx_non_outlier = [0;find(abs(df)<12)];
   g_indx_non_outlier = [0; (1:length(df))'];
end
if flag_plot
    figure
    indx_outlier = setxor(1:length(df), g_indx_non_outlier);
    plot(1:length(df), df, indx_outlier(2:end), df(indx_outlier(2:end)),'ro');
    
    save data_Xdiff_tmp
end
df = df(g_indx_non_outlier(2:end));






