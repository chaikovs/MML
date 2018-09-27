%function outM = idCreateModelOrbDistMatr(x_or_z, ModelData, indUpstrBPM, sectLenBwBPMs, idCenPos, idLen, idKickOfst)
function [outM, outR0] = idCreateModelOrbDistMatr(x_or_z, ModelData, GeomParUnd)

% Creates orbit distortion matrix to simulate effect of an ID on e-beam
% transverse positions along the ring

%indDownstrBPM = GeomParUnd.indUpstrBPM + 1; % To precise this
%if indDownstrBPM == 121
%    indDownstrBPM = 1;
%end

ringCircum = ModelData.circ; %354; % [m]
alpMomCompact = ModelData.alp1; %0.0004 @Soleil

%numBPMsToSkip = length(arIndsBPMsToSkip);

%[Btx, Btz] = modelbeta(strBPM);
%[Alpx, Alpz] = modeltwiss('alpha', strBPM);
%[Etax, Etaz] = modeldisp(strBPM); % Ask Laurent or Pascale
%[Phx, Phz] = modelphase(strBPM);
%Nuxz = modeltune;

Bt = ModelData.Btx; Alp = ModelData.Alpx; Eta = ModelData.Etax; Ph = ModelData.Phx; Nu = ModelData.Nuxz(1);
if strcmp(x_or_z, 'z') ~= 0
	Bt = ModelData.Btz; Alp = ModelData.Alpz; Eta = ModelData.Etaz; Ph = ModelData.Phz; Nu = ModelData.Nuxz(2);
end

numBPMsAr = size(Bt);
numBPMs = numBPMsAr(1);

indDownstrBPM = GeomParUnd.indUpstrBPM + 1; % To precise this
if indDownstrBPM > numBPMs
    indDownstrBPM = 1;
end

%distUpstrBPM_Kick1 = GeomParUnd.idCenPos - 0.5*GeomParUnd.sectLenBwBPMs - 0.5*GeomParUnd.idLen + GeomParUnd.idKickOfst;
%distUpstrBPM_Kick2 = GeomParUnd.idCenPos - 0.5*GeomParUnd.sectLenBwBPMs + 0.5*GeomParUnd.idLen - GeomParUnd.idKickOfst;
%distUpstrBPM_Kick0 = GeomParUnd.idCenPos;
% modifié le 24/10/08 par Pascale et Fabrice avec accord Oleg
distUpstrBPM_Kick1 = GeomParUnd.idCenPos + 0.5*GeomParUnd.sectLenBwBPMs - 0.5*GeomParUnd.idLen + GeomParUnd.idKickOfst;
distUpstrBPM_Kick2 = GeomParUnd.idCenPos + 0.5*GeomParUnd.sectLenBwBPMs + 0.5*GeomParUnd.idLen - GeomParUnd.idKickOfst;
distUpstrBPM_Kick0 = GeomParUnd.idCenPos + 0.5*GeomParUnd.sectLenBwBPMs;

btUpstr = Bt(GeomParUnd.indUpstrBPM);
alpUpstr = Alp(GeomParUnd.indUpstrBPM);
etaUpstr = Eta(GeomParUnd.indUpstrBPM);
etaDownstr = Eta(indDownstrBPM);
phUpstr = Ph(GeomParUnd.indUpstrBPM);
%phDownstr = Ph(indDownstrBPM);

gamUpstr = (1 + alpUpstr*alpUpstr)/btUpstr;
twoAlpUpstr = 2*alpUpstr;
btKick1 = btUpstr - distUpstrBPM_Kick1*twoAlpUpstr + distUpstrBPM_Kick1*distUpstrBPM_Kick1*gamUpstr;
btKick2 = btUpstr - distUpstrBPM_Kick2*twoAlpUpstr + distUpstrBPM_Kick2*distUpstrBPM_Kick2*gamUpstr;
btKick0 = btUpstr - distUpstrBPM_Kick0*twoAlpUpstr + distUpstrBPM_Kick0*distUpstrBPM_Kick0*gamUpstr;

etaDifBwBPMs = etaDownstr - etaUpstr;
etaKick1 = etaUpstr + (distUpstrBPM_Kick1/GeomParUnd.sectLenBwBPMs)*etaDifBwBPMs; % Ask Laurent or Pascale
etaKick2 = etaUpstr + (distUpstrBPM_Kick2/GeomParUnd.sectLenBwBPMs)*etaDifBwBPMs;
etaKick0 = etaUpstr + (distUpstrBPM_Kick0/GeomParUnd.sectLenBwBPMs)*etaDifBwBPMs;

%phDifBwBPMs = phDownstr - phUpstr;
%phKick1 = phUpstr + (distUpstrBPM_Kick1/GeomParUnd.sectLenBwBPMs)*phDifBwBPMs; % Ask Laurent or Pascale
%phKick2 = phUpstr + (distUpstrBPM_Kick2/GeomParUnd.sectLenBwBPMs)*phDifBwBPMs;
atan_alpUpstr = atan(alpUpstr);
phKick1 = phUpstr + atan_alpUpstr + atan(gamUpstr*distUpstrBPM_Kick1 - alpUpstr);
phKick2 = phUpstr + atan_alpUpstr + atan(gamUpstr*distUpstrBPM_Kick2 - alpUpstr);
phKick0 = phUpstr + atan_alpUpstr + atan(gamUpstr*distUpstrBPM_Kick0 - alpUpstr);

invTwoSinPiNu = 1./(2.*sin(pi*Nu));
invAlpCircum = 1./(alpMomCompact*ringCircum);

%numBPMsAr = size(Bt);
%numBPMs = numBPMsAr(1);
%outM = zeros(numBPMs - numBPMsToSkip, 2);

outM = zeros(numBPMs, 2); %Main matrix for 2 virual kicks located (roughly) at undulator extremities and simulating 1st order effects
outR0 = zeros(numBPMs, 1); %Vector for 1 virtual kick located in the middle of the undulator and simulating 2nd order effect

%countBPM = 1;
for i = 1:numBPMs
    %if(numBPMsToSkip > 0)
    %    skipThisBPM = 0;
    %    for j = 1:numBPMsToSkip
    %        if(i == arIndsBPMsToSkip(j))
    %            skipThisBPM = 1;
    %            break;
    %    	end
    %    end
    %    if(skipThisBPM ~= 0)
    %        continue;
    %    end
    %end
    %outM(countBPM, 1) = invTwoSinPiNu*sqrt(Bt(i)*btKick1)*cos(abs(Ph(i) - phKick1) - pi*Nu) + invAlpCircum*Eta(i)*etaKick1;
    %outM(countBPM, 2) = invTwoSinPiNu*sqrt(Bt(i)*btKick2)*cos(abs(Ph(i) - phKick2) - pi*Nu) + invAlpCircum*Eta(i)*etaKick2;
    %countBPM = countBPM + 1; 
    
	outM(i, 1) = invTwoSinPiNu*sqrt(Bt(i)*btKick1)*cos(abs(Ph(i) - phKick1) - pi*Nu) + invAlpCircum*Eta(i)*etaKick1;
	outM(i, 2) = invTwoSinPiNu*sqrt(Bt(i)*btKick2)*cos(abs(Ph(i) - phKick2) - pi*Nu) + invAlpCircum*Eta(i)*etaKick2;
	outR0(i, 1) = invTwoSinPiNu*sqrt(Bt(i)*btKick0)*cos(abs(Ph(i) - phKick0) - pi*Nu) + invAlpCircum*Eta(i)*etaKick0;
end
