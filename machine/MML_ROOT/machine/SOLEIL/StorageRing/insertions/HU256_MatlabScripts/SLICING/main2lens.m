%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Claculation and optimization of the laser transport 
% for Slicing experiment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

% General input parameter vector: data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %data=[Lambda_L,w0,zR0,sigma0,L]
% Definition of the laser system
    % Laser wavelength [nm]
Lambda_L=800*10^(-9);  
    % M square factor
M2=1.5;   
    % Laser waist [m]
w0=5*10^(-3);               
    % Laser Rayleigh range [m]
zR0=pi*w0^2/(M2*Lambda_L);       
    % Radius of curvature
R0=10000000;        
    % Complex initial beam parameter
q0=1/R0-i*Lambda_L/(pi*w0^2);   
q0=1/q0;     
global Q0
Q0=[q0;1];

% Definition of the electron beam
%sigma0=200*10^(-6);
% Section courte :
%             Longueur=1.8 m
%             Betaz0=1.8882 m
%             Betax0=18.174 m
%             Etaz=0 m
%             Etax=0.2543 m
%  
% Section moyenne (valeurs au centre):
           % Longueur=5.5; % [m]
            Betaz0=1.737; % [m]
            Betax0=4.1901; % [m]
            Etaz=0; % [m]
            Etax=0.1439; % [m]
 
% Section longue :
%             Longueur=12 m
%             Betaz0=8 m
%             Betax0=10.895 m
%             Etaz=0 m
%             Etax=0.212 m

% Eta=dispersion (variation de l’orbite en fonction de la variation relative d’énergie). 
% Elle est approximée constante sur toute la section droite.

% Beta(s)=Beta0+(s/Beta0)^2;
% alpha(s)=-Beta’(s)/2=-s/Beta0;
coupling=0.004;                     % Coupling
emittance_x=3.74*10^(-9);           % Electron beam emittance [m.rad]
emittance_z=coupling*emittance_x;   % Electron beam emittance [m.rad]
sigma_gamma=1.016*10^(-3);          % Energy spread


% Definition of the modulator 
L=2.6;  % Modulator length [m]

% Definition of the fixed elements of the laser transport line
global d_S_L1
d_S_L1=35-6.5;       % Distance from laser system to (L1)

%d_L1_L2=0.5;      % Distance between (L1) and (M1)

%d_L2_C=0.5;    % Distance between (M1) and (L2)

d_C_E=L/2;      % Distance from the undulator centre to the undulator exit

global d_ToT
d_ToT=35;       % Total distance from laser to undulator center

data(1)=Lambda_L;
data(2)=w0;
data(3)=zR0;
data(4)=0;
data(5)=L;
data(6)=q0;
data(7)=Betax0;
data(8)=Betaz0;
data(9)=Etax;
data(10)=Etaz;
data(11)=emittance_x;
data(12)=emittance_z;
data(13)=sigma_gamma;


% Plot the filling factor as a function of zR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nplot=100;
for j=1:nplot
    x_zR(j)=0.1+3*j/nplot;
    x_z(j)=(j-1)*L/nplot;
    s_z(j)=x_z(j)-(L/2);
    Ff_zR(j)=filling_int_f(data,x_zR(j));
    sigma_z(j)=sigma_f(data,s_z(j),1);
end
% figure(1);
%    title('Filling factor')
% plot(x_zR,Ff_zR);

% Find the optimum zR for maximum filling factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[MaxFf,iOptzR]=max(Ff_zR);
OptzR=x_zR(iOptzR)

% Plot laser and electron beam sizes in the modulator
for j=1:nplot
    w_z(j)=w_f(data,x_z(j),OptzR);   
end

figure(2);
plot(x_z,sigma_z,'b',x_z,w_z/2,'r');
xlabel('z');
ylabel('Beam sizes (rms)');
title('Electron and Laser beam sizes in the modulator');
h2=legend('Electron beam','Laser beam');

% Calculation of the laser coeff at the center of the modulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w0f=sqrt(OptzR*Lambda_L*M2/pi);                           
R0f=10000000;        
    % Complex initial beam parameter
q0f=1/R0f-i*Lambda_L/(pi*w0f^2);    
q0f=1/q0f;
global Q0f
Q0f=[q0f;1];


% Find the transfer matrix which enables the matching in the undulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Equation to solve:
    % Q0f=M*QO
    
    
    
    % Unknown: [fL2,d_L1_L2,fL1]
%X=[-1,3,3,20]; % pas mal pour 30 m
%X=[-1,3,3,15];
X=[9,1,8];

options = optimset('MaxIter',50000,'MaxFunEvals',50000,'TolFun',0.05);
solution=fsolve(@delta_f,X,options);

delta_sol=delta_f(solution)

%solution=X;
%delta_sol=delta_f(solution)

fL1=solution(1)
d_L1_L2=solution(2)
fL2=solution(3)
%d_S_L1=solution(4)
feq=fL1*fL2/(fL1+fL2-d_L1_L2)
d_L2_C=d_ToT-d_L1_L2-d_S_L1;


% Calculation of the transport matrix at position zi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nzT=100;
dzT=(d_ToT+d_C_E)/nzT;
for i=1:(nzT+1)
    z=(i-1)*dzT;
    zT(i)=z;
    
            % Calculation of thr transport matrix at z
  if((z>0)&(z<d_S_L1))|(z==d_S_L1)|(z==0) 
    M_z=drift_f(z);

elseif ((z>d_S_L1)&(z<d_S_L1+d_L1_L2))|(z==d_S_L1+d_L1_L2) 
  dz=z-d_S_L1;
  M_z=drift_f(dz)*lens_f(fL1)*drift_f(d_S_L1);

  elseif ((z>d_S_L1+d_L1_L2)&(z<d_S_L1+d_L1_L2+d_L2_C))|(z==d_S_L1+d_L1_L2+d_L2_C) 
  dz=z-(d_S_L1+d_L1_L2);
  M_z=drift_f(dz)*lens_f(fL2)*drift_f(d_L1_L2)*lens_f(fL1)*drift_f(d_S_L1);

  elseif ((z>d_S_L1+d_L1_L2+d_L2_C)&(z<d_S_L1+d_L1_L2+d_L2_C+d_C_E))|(z==d_S_L1+d_L1_L2+d_L2_C+d_C_E) 
  dz=z-(d_S_L1+d_L1_L2+d_L2_C);
  M_z=drift_f(dz)*drift_f(d_L2_C)*lens_f(fL2)*drift_f(d_L1_L2)*lens_f(fL1)*drift_f(d_S_L1);
  
  else fprintf('out of modulator\n')
  M_z=[0,0;0,0];
  end

  wz_z(i)=wz_f(data,M_z,z);
  w0f_v(i)=w0f;
  
end


% Plot the final transport
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);
title('Laser beam size');
% x=[0.1:1:28]';
plot(zT',wz_z',zT',w0f_v');
hold on
plot(d_ToT,0.001,'--rs','MarkerSize',10);
hold off
