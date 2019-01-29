function modelnonlindisp

%
%% Written by Laurent S. Nadolski

kmax = 50;
deltaRF = 50e-6; % Hz
alpha1 = modelmcf;

hMat(:,:) = zeros((2*kmax+1),length(getx));
vMat(:,:) = hMat(:,:);
rfVect = zeros((2*kmax+1),1);


steprf(-deltaRF*(kmax+1));
    
for k=1:(2*kmax+1),
    steprf(deltaRF)
    hMat(k,:) = getx;
    vMat(k,:) = getz;
    rfVect(k) = getrf;
end

steprf(-deltaRF*kmax);

%%
plot((rfVect-rfVect(kmax+1))*1e6, hMat(:,1)*alpha1*getrf/(2*deltaRF),'.-'); 
grid on

%%

refreshthering;
global THERING;

[CavityState, PassMethod, iCavity] = getcavity;

kmax = 50;
deltaRF = 40; % Hz
clear hMat rfVect vMat 
hMat(:,:) = zeros((2*kmax+1),length(THERING)+1);
vMat(:,:) = hMat(:,:);
rfVect = zeros((2*kmax+1),1);

CavityFrequency = THERING{iCavity(1)}.Frequency;

for k=1:(2*kmax+1),
    for kk = 1:length(iCavity)
        THERING{iCavity(kk)}.Frequency = CavityFrequency + deltaRF*(k - (kmax +1));
    end
    rep  = findorbit6(THERING, 1:length(THERING)+1);
    hMat(k,:) = rep(1,:);
    vMat(k,:) = rep(3,:);
    rfVect(k) = deltaRF*(k - (kmax +1));
end

for kk = 1:length(iCavity)
    THERING{iCavity(kk)}.Frequency = CavityFrequency;
end

% for k=1:kmax,
%   deltahOrbit(k,:) = hMat(end-(k+1),:) - hMat(k,:);
%   deltaRFVect(k) =   rfVect(end-(k+1)) - rfVect(k);
% end
    
%%
order = 4;
order4 = order-3; 
order3 = order-2;
order2 = order-1;
order1 = order;

spos = findspos(THERING,1:length(THERING)+1);
figure;
plot(rfVect, hMat(:,1),'.');

clear p;
for k = 1:length(THERING)+1,
    p(k,:) = polyfit(rfVect, hMat(:,k), order);
end
%%

pdelta = -p*alpha1*CavityFrequency;

figure;
subplot(4,1,1)
plot(spos, pdelta(:,order1))
subplot(4,1,2)
plot(spos, pdelta(:,order2))
subplot(4,1,3)
plot(spos, pdelta(:,order3))
% subplot(4,1,4)
% plot(spos, pdelta(:,order4))
