function [ DIM ] = dim_theo_MML(Qmin, Qmax,npas, emitx, emity, directory)
%theoretical dimensions at yag sreen 1 

%Calcule théoriquement les dimensions à l'écran en voie directe %%%
%A partir des paramètres de twiss en sortie de la section
% accélératrice et de l'émittance normalisée et de l'énergie%%%


%% Global
global THERING


%% matrice twiss initiale %%%
%   Ax=TwissData.alpha(1);
%   Ay=TwissData.alpha(2);
%   Bx=TwissData.beta(1);
%   By=TwissData.beta(2);
%   Gx= (1+Ax^2)/Bx;
%   Gy=(1+Ay^2)/By;
%   Twiss_init=[Bx Ax 0 0; Ax Gx 0 0; 0 0 By Ay; 0 0 Ay Gy];
  
  %% Définition section 1 triplet + section longue jusqu'au YAG
paramk=linspace(Qmin, Qmax,npas);
  
  %% Matrice de transfert, calcul des dimensions,QP calcul en lentille épaisse
  

  for i=1:length(paramk)
    setpv('QP1L',paramk(i));
    TD1=twissline(THERING,0,THERING{1}.TwissData,1:(length(THERING)+1)); 
    %mat44=cat(1,TD1.M44)
    matalpha=cat(1,TD1.alpha);
    matbeta=cat(1,TD1.beta);
    
   % Mtot=mat44(end-3:end,:)
    
    
    if i==1
        dimX=sqrt(matbeta(end,1)*emitx);
        dimY=sqrt(matbeta(end,2)*emity);
    else
        dimX=[dimX sqrt(matbeta(end,1)*emitx)];
        dimY=[dimY sqrt(matbeta(end,2)*emity)];
    end
  end

  %% Incertitudes des dimensions
  
  Delta_dimX=0.1*rand(1,length(dimX)).*dimX;
  Delta_dimY=0.1*rand(1,length(dimX)).*dimY;
  
  %% Plot des dimensions
  
%   figure,
%   errorbar(paramk, dimX, - Delta_dimX,  Delta_dimX,'-k');
%   hold on,
%   errorbar(paramk, dimY, - Delta_dimY,  Delta_dimY,'-r.');
%   legend('horizontal','vertical');
%   xlabel('QP strength k (m^-^2)'), ylabel('transverse dimensions (m)') 
%   set(gcf,'Color','white');

  
  %% Ecriture dans le fichier pour test programme emittance
  
  DIM=[dimX' Delta_dimX' dimY' Delta_dimY'];
  file=[directory '/dimension.txt']
  dlmwrite(file, DIM, 'delimiter','\t');
  