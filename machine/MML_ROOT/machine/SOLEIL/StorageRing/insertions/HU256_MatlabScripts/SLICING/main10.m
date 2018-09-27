%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculation and optimization of the laser transport 
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
w0=7*10^(-3);               %5*10^(-3);               
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

% Section moyenne (valeurs au centre):
           % Longueur=5.5; % [m]
            Betaz0=1.77; % [m]
            Betax0=4.0; % [m]
            Etaz=0; % [m]
            Etax=0.13; % [m]

emittance_x=3.73*10^(-9);           % Electron beam emittance [m.rad]
emittance_z=0.0373*10^(-9);         % Electron beam emittance [m.rad]
sigma_gamma=1.016*10^(-3);          % Energy spread

% Definition of the modulator 
L=2.6;  % Modulator length [m]

% Definition of the fixed elements of the laser transport line
global d_ToT
d_ToT=36;       % Total distance from laser to undulator center
global d_S_L1
%d_S_L1=d_ToT-6.5;       % Distance from laser system to (L1)
%d_L1_L2=0.5;      % Distance between (L1) and (M1)
%d_L2_C=0.5;    % Distance between (M1) and (L2)
d_C_E=L/2;      % Distance from the undulator centre to the undulator exit

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
    sigma_x(j)=sigma_f(data,s_z(j),1);
    sigma_y(j)=sigma_f(data,s_z(j),2);
end

% Find the optimum zR for maximum filling factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[MaxFf,iOptzR]=max(Ff_zR);
OptzR=x_zR(iOptzR)



% Calculation of the laser coeff at the center of the modulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w0f=sqrt(OptzR*Lambda_L*M2/pi);                           
R0f=10000000;        
    % Complex initial beam parameter
q0f=1/R0f-i*Lambda_L/(pi*w0f^2);    
q0f=1/q0f;
global Q0f
Q0f=[q0f;1];


% Choose solution:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NbLens=1  --> 1 lens
        % NbLens=2  --> 2 lens
fprintf('Solution with Number of lenses =\n');
NbLens=2


% Find the transfer matrix which enables the matching in the undulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Equation to solve:
    % Q0f=M*QO
    
    % Unknown: X
if (NbLens==1)
    X=4;        % fL1
 
    %options = optimset('MaxIter',50000,'MaxFunEvals',50000,'TolFun',0.05);
    %solution=fsolve(@delta1_f,X,options);
    %delta_sol=delta1_f(solution)

    solution=X;
    %delta_sol=delta1_f(solution)

    fL1=solution
    d_L2_C=fL1;
    d_S_L1=d_ToT-(d_L2_C);

elseif (NbLens==2)
    %X=[-1,3,3,20]; % pas mal pour 30 m
    % [-4.95,0.7,4]
    X=[-5,1.1,4.0];  % [fL2,d_L1_L2,fL1]   
    delta=0;
    
    %options = optimset('MaxIter',50000,'MaxFunEvals',50000,'TolFun',0.05);
    %solution=fsolve(@delta_f,X,options);
    %delta_sol=delta_f(solution)

    solution=X;
    %delta_sol=delta_f(solution)

    fL1=solution(1)
    d_L1_L2=solution(2)
    fL2=solution(3)
    feq=fL1*fL2/(fL1+fL2-d_L1_L2)
    d_L2_C=11.6; 
    d_S_L1=d_ToT-d_L1_L2-d_L2_C;

else
    fprintf('Error in choice lens setup\n')
end

% Calculation of the transport matrix at position zi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global nzT
nzT=100;
dzT=(d_ToT+d_C_E)/nzT;

if (NbLens==1)
    for j=1:(nzT+1)
        z=(j-1)*dzT;
        zT(j)=z;
    
        % Calculation of thr transport matrix at z
        if((z>0)&(z<d_S_L1))|(z==d_S_L1)|(z==0) 
            M_z=drift_f(z);

        elseif ((z>d_S_L1)&(z<d_S_L1+d_L2_C))|(z==d_S_L1+d_L2_C) 
            dz=z-d_S_L1;
            M_z=drift_f(dz)*lens_f(fL1)*drift_f(d_S_L1);

        elseif ((z>d_S_L1+d_L2_C)&(z<d_S_L1+d_L2_C+d_C_E))|(z==d_S_L1+d_L2_C+d_C_E) 
            dz=z-(d_S_L1+d_L2_C);
            M_z=drift_f(dz)*drift_f(d_L2_C)*lens_f(fL1)*drift_f(d_S_L1);

        else fprintf('out of modulator\n')
            M_z=[0,0;0,0];
        end

        wz_z(j)=wz_f(data,M_z,z);
        w0f_v(j)=w0f;
  
    end

elseif (NbLens==2)
    for j=1:(nzT+1)
        z=(j-1)*dzT;
        zT(j)=z;
    
        % Calculation of the transport matrix at z
        if((z>0)&&(z<d_S_L1))||(z==d_S_L1)||(z==0) 
            M_z=drift_f(z);

        elseif ((z>d_S_L1)&&(z<d_S_L1+d_L1_L2))||(z==d_S_L1+d_L1_L2) 
            dz=z-d_S_L1;
            M_z=drift_f(dz)*lens_f(fL1)*drift_f(d_S_L1);

        elseif ((z>d_S_L1+d_L1_L2)&&(z<d_S_L1+d_L1_L2+d_L2_C))||(z==d_S_L1+d_L1_L2+d_L2_C) 
            dz=z-(d_S_L1+d_L1_L2);
            M_z=drift_f(dz)*lens_f(fL2)*drift_f(d_L1_L2)*lens_f(fL1)*drift_f(d_S_L1);

        elseif ((z>d_S_L1+d_L1_L2+d_L2_C)&&(z<d_S_L1+d_L1_L2+d_L2_C+d_C_E))||(z==d_S_L1+d_L1_L2+d_L2_C+d_C_E) 
            dz=z-(d_S_L1+d_L1_L2+d_L2_C);
            M_z=drift_f(dz)*drift_f(d_L2_C)*lens_f(fL2)*drift_f(d_L1_L2)*lens_f(fL1)*drift_f(d_S_L1);

        else fprintf('out of modulator\n')
            M_z=[0,0;0,0];
        end

        wz_z(j)=wz_f(data,M_z,z);
        w0f_v(j)=w0f;

    end
else
    fprintf('Error in choice lens setup\n')
end

% Calculate the final filling factor
jinit=floor((d_ToT-L/2)/dzT);
jend=nzT+1;
deltaj=jend-jinit;

for j=jinit:jend
  jbis=floor((j-jinit)*nplot/(deltaj+1))+1;
  a=1+(wz_z(j)/(2*sigma_x(jbis)))^2;
  b=1+(wz_z(j)/(2*sigma_y(jbis)))^2;
  k=j-jinit+1;
  Ff(k)=1/(sqrt(a+b));
  x(k)=(k-1)*dzT;
end

Ff_int=0;
for j=1:deltaj-1
  Ff_int=Ff_int+(Ff(j)+Ff(j+1))/2*dzT;
end
Ff_int



% Plot the final transport
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6);
plot(zT',wz_z'/2,'r');
hold on
plot(d_ToT,0.001,'--rs','MarkerSize',10);
hold on
xbis_z=x_z+d_ToT-L/2;
plot(xbis_z,sigma_x,'b',xbis_z,sigma_y,'g');
hold off
xlabel('z');
ylabel('Dimensions faisceaux (rms)');
title('Transport du laser dans le modulateur');
h2=legend('Laser','Centre modulateur','Electrons (x)','Electrons (y)');

figure(7);
plot(zT',wz_z'/2,'r');
hold on
plot(d_ToT,0.001,'--rs','MarkerSize',10);
hold on
xbis_z=x_z+d_ToT-L/2;
plot(xbis_z,sigma_x,'b',xbis_z,sigma_y,'g');
xlim([34 38]);
ylim([0 0.001]);
hold off
xlabel('z');
ylabel('Beam sizes (rms)');
title('Transport du laser dans le modulateur - zoom');
h2=legend('Laser','Centre modulateur','Electrons (x)','Electrons (y)');




% Plot laser and electron beam sizes in the modulator
for j=1:nplot
    w_z(j)=w_f(data,x_z(j),OptzR);   
end

figure(5);
plot(x_z,sigma_x,'b',x_z,sigma_y,'g',x_z,w_z/2,'r');
ylim([0 0.001]);
xlabel('z');
ylabel('Beam sizes (rms)');
title('Electron and Laser beam sizes in the modulator');
h2=legend('Electron beam in x','Electron beam in y','Laser beam');

