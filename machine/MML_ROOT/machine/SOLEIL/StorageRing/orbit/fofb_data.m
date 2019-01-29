%% FOFB - data ans small scripts

%%  48x48
IDBPM = getidbpmlist;

[betax betaz] = modeltwiss('beta', 'BPMx', IDBPM);
[mux muz] = modeltwiss('mu', 'BPMx', IDBPM);
R0 = measbpmresp('BPMx',IDBPM, 'BPMz', IDBPM, 'FHCOR', 'FVCOR', 'Model','Struct');
Rinv0H= inv(R0(1,1).Data);
Rinv0V= inv(R0(2,2).Data);
%save 'fofbdata96x96' betax betaz mux muz Rinv

%% 120x48 
BPM = family2dev('BPMx');

[betax betaz] = modeltwiss('beta', 'BPMx');
[mux muz] = modeltwiss('mu', 'BPMx');
R1 = measbpmresp('BPMx',BPM, 'BPMz', BPM, 'FHCOR', 'FVCOR', 'Model','Struct');
Rinv1H= pinv(R1(1,1).Data);
Rinv1V= pinv(R1(2,2).Data);
%Rinv1= pinv(R1);

save 'fofbdata240x96' betax betaz mux muz Rinv

%% SVD

h=figure;
set(h,'Position',[223 311 1087 420])
[U, S, V] = svd(R0(1,1).Data, 0);  %'econ');
S = diag(S);

subplot(1,2,1)
semilogy(S)
xlabel('Singular value number')
ylabel('Singular value amplitude')
grid on
xaxis([0 48])
title('H-plane')

subplot(1,2,2)
[U, S, V] = svd(R0(2,2).Data, 0);  %'econ');
S = diag(S);
semilogy(S)
xlabel('Singular value number')
ylabel('Singular value amplitude')
grid on
xaxis([0 48])
title('V-plane')

suptitle('FOFB 96x96')

%% 48 * 48 avec Rf
    
Eta = modeldisp('BPMx',IDBPM);
Smat = R0(1,1).Data;

RFWeight = 10 * mean(std(Smat)) / std(Eta);
Smat = [R0(1,1).Data RFWeight*Eta];

[U, S, V] = svd(Smat, 0);  %'econ');
S = diag(S);

subplot(1,2,1)
semilogy(S)
xlabel('Singular value number')
ylabel('Singular value amplitude')
grid on
xaxis([0 48]); hold on;
title('H-plane')

SVDIndex = 1:48;
RinvH = V(:,SVDIndex)*diag(S(SVDIndex).^(-1)) * U(:,SVDIndex)';

subplot(1,2,2)
[U, S, V] = svd(R0(2,2).Data, 0);  %'econ');
S = diag(S);
semilogy(S)
xlabel('Singular value number')
ylabel('Singular value amplitude')
grid on
xaxis([0 48])
title('V-plane')

suptitle('FOFB 96x96 + RF')


%% SVD 120x48
h=figure;
set(h,'Position',[223 311 1087 420])
[U, S, V] = svd(R1(1,1).Data, 0);  %'econ');
S = diag(S);

subplot(1,2,1)
semilogy(S)
xlabel('Singular value number')
ylabel('Singular value amplitude')
grid on
xaxis([0 48])
title('H-plane')

subplot(1,2,2)
[U, S, V] = svd(R1(2,2).Data, 0);  %'econ');
S = diag(S);
semilogy(S)
xlabel('Singular value number')
ylabel('Singular value amplitude')
grid on
xaxis([0 48])
title('V-plane')

suptitle('FOFB 96x96')

% Correction with 48 singular values
%% H-correction
dI = -pinv(R0(1,1).Data)*(getx(IDBPM)-GoalOrbitVec); stepsp('FHCOR',dI)

%% V-correction
dI = -pinv(R0(2,2).Data)*(getz(IDBPM) - GoalZOrbitVec); stepsp('FVCOR',dI)

%%
% Correction with n singular values
[U, S, V] = svd(R0(1,1).Data, 0);
S = diag(S);
%GoalOrbitVec = getgolden('BPMx', IDBPM)*0;
GoalOrbitVec = getgolden('BPMx', IDBPM);

%% H-correction
SVDIndex = 1:48;

b = U(:,SVDIndex)' * (GoalOrbitVec - getx(IDBPM));
b = diag(S(SVDIndex).^(-1)) * b;

% Convert the b vector back to coefficents of response matrix
Delcm = V(:,SVDIndex) * b;

stepsp('FHCOR', Delcm)

%%
clf
plot(getspos('BPMx', IDBPM), getx(IDBPM)); hold on
plot(getspos('BPMx', IDBPM), GoalOrbitVec,'k');

%%
clf
plot(getspos('BPMx', IDBPM), getx(IDBPM)-GoalOrbitVec); hold on

%%
Rinv = pinv(R0(1,1).Data);
Rinvfull=zeros(48,120);

Rinvfull(:,dev2elem('BPMx',IDBPM)) = Rinv;

%%
%A/mm = µA/nm
%(Rinvfull(4,:)*1714.412*1.77)*(getz - GoalZOrbitVec)/36000*10
