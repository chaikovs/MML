function Data = modeldipole_twiss(DipoleIdx, Theta)
% MODELDIPOLE_TWISS - determine the Twiss and dispersion function ...
% inside a dipole at a specific angle inluding the edge focusing
%
%  INPUTS
%  1. DipoleIdx - Dipole Index
%  2. Theta - angle from dipole entrance in degree
%
%  OUPUTS
%  1. data - structure with 
%
%  NOTES Does not work if misalignement of the dipole

%
%% Written by Laurent S. Nadolski

global THERING

if ceil(DipoleIdx)~=DipoleIdx,
    error('First element should be a integer scalar');
end

if ~isfield(THERING{DipoleIdx}, 'BendingAngle')
    error('Element %d is not a dipole', DipoleIdx);
end

Data.theta_deg = Theta;
Theta = Theta/180*pi; % conversion from degree to radian
Data.theta_rad = Theta;

FullAngle = THERING{DipoleIdx}.BendingAngle;

if Theta < 0 || Theta > FullAngle,
    error('Angle %f rad is larger than total dipole angle %f rad', ...
    Theta, FullAngle);
end

TD = twissring(THERING, 0, DipoleIdx, 'chrom', 1e-8);

% etax etaxp etay etayp
eta0   = cat(2,TD.Dispersion);
beta0  = cat(1, TD.beta);
alpha0 = cat(1, TD.alpha);
gamma0 = (1 + alpha0.^2) ./ beta0;

% Dipole main parameters
K1         = THERING{DipoleIdx}.K;
Rho        = THERING{DipoleIdx}.Length/THERING{DipoleIdx}.BendingAngle;
Theta1     = THERING{DipoleIdx}.EntranceAngle;
Theta2     = THERING{DipoleIdx}.ExitAngle;
FullGap    = THERING{DipoleIdx}.FullGap;
FringeInt1 = THERING{DipoleIdx}.FringeInt1;
FringeInt2 = THERING{DipoleIdx}.FringeInt2;

% Compute dispersion and Twiss function
[Data.eta, Data.etap]   = calcdisp(Rho, Theta, Theta1, Theta2, eta0([1 3]), ...
    eta0([2 4]), K1, FullAngle, FullGap, FringeInt1, FringeInt2);
[Data.alpha, Data.beta] = calctwissEdge(Rho, Theta, Theta1, Theta2, ...
    alpha0, beta0, K1, FullAngle, FullGap, FringeInt1, FringeInt2);
Data.gamma = (1 + Data.alpha.^2) ./ Data.beta;


function [eta, etap] = calcdisp(Rho, Theta, Theta1, Theta2, eta0, etap0, ...
    K1, FullAngle, FullGap, FringeInt1, FringeInt2)
%calcdisp - calculate dispersion function inside a combined-function dipole
%  INPUTS
%  1. Rho   - Curvature radius
%  2. Theta - Angle
%  3. eta0  - Horizontal and vertical dispersion functions at the entrance
%  4. etap0 - Derivative of  horizontal and vertical dispersion functions at the entrance
%  5. K1    - Focusing
%
% Transfert matrix of A wedge dipole p58 Handbook af Accelerator Physics
s = Rho*Theta;

% Edge focusing
if Theta > 0,
    etap0(1) = eta0(1)/Rho*tan(Theta1) + etap0(1);
end

% Wedge dipole
Kx = K1;
if Kx>-1/Rho^2; %horizontal focusing
    sqK = sqrt(1/Rho^2+Kx);
    eta(1)  =  eta0(1)*cos(sqK*s)     + etap0(1)/sqK*sin(sqK*s)+(1-cos(sqK*s))/Rho/sqK^2;
    etap(1) = -eta0(1)*sqK*sin(sqK*s) + etap0(1)*cos(sqK*s)+sin(sqK*s)/Rho/sqK;
else %horizontal defocusing
    sqK = sqrt(-(1/Rho^2+Kx));
    eta(1)  = eta0(1)*cosh(sqK*s)    + etap0(1)/sqK*sinh(sqK*s)+(-1+cosh(sqK*s))/Rho/sqK^2;
    etap(1) = eta0(1)*sqK*sinh(sqK*s)+ etap0(1)*cosh(sqK*s)+sinh(sqK*s)/Rho/sqK;    
end

% Edge focusing
if Theta == FullAngle,
    etap(1) = eta(1)/Rho*tan(Theta2) + etap(1);
end

% Vertical plane

% Edge focusing
if Theta > 0,
    psi = FullGap*FringeInt1/Rho*(1+sin(Theta1)^2)/cos(Theta1);
    etap0(2) = -eta0(2)/Rho*tan(Theta1-psi) + etap0(2);
end

% Wedge dipole
Ky = -K1; % V-defocusing strength

if Ky>0; %vertical focusing
    sqK = sqrt(Ky);
    eta(2)  =  eta0(2)*cos(sqK*s)     + etap0(2)/sqK*sin(sqK*s)+(1-cos(sqK*s))/Rho/sqK^2;
    etap(2) = -eta0(2)*sqK*sin(sqK*s) + etap0(2)*cos(sqK*s)+sin(sqK*s)/Rho/sqK;
elseif Ky ==0
    eta(2)  = eta0(2)+ etap0(2)*s;
    etap(2) = etap0(2);
else %vertical defocusing
    sqK = sqrt(-Ky);
    eta(2)  = eta0(2)*cosh(sqK*s)    + etap0(2)/sqK*sinh(sqK*s);
    etap(2) = eta0(2)*sqK*sinh(sqK*s)+ etap0(2)*cosh(sqK*s);    
end

% Edge focusing
if Theta == FullAngle,
    psi = FullGap*FringeInt2/Rho*(1+sin(Theta2)^2)/cos(Theta2);
    etap(2) = -eta(2)/Rho*tan(Theta2-psi) + etap(2);
end

function [alpha, beta] = calctwissEdge(Rho, Theta, Theta1, Theta2, alpha0, ...
    beta0, b1, FullAngle, FullGap, FringeInt1, FringeInt2)
% calctwiss - calculate twiss function inside a combined-function dipole manget
%             including edge focusing

%Edge focusing
if Theta > 0
    Mx = [1 0; 1/Rho*tan(Theta1) 1];
    psi = FullGap*FringeInt1/Rho*(1+sin(Theta1)^2)/cos(Theta1);
    My = [1 0; -1/Rho*tan(Theta1-psi) 1];    
    [alpha, beta] = calctwiss(alpha0, beta0, Mx, My);
else
    alpha = alpha0;
    beta  = beta0;
end

% Wedge Dipole
[Mx My] = calcMxMy(Rho, b1,Theta);
[alpha, beta] = calctwiss(alpha, beta, Mx, My);

%Edge focusing
if Theta == FullAngle,
    Mx = [1 0; 1/Rho*tan(Theta2) 1];
    psi = FullGap*FringeInt2/Rho*(1+sin(Theta2)^2)/cos(Theta2);
    My = [1 0; -1/Rho*tan(Theta2-psi) 1];    
    [alpha, beta] = calctwiss(alpha, beta, Mx, My);
end

function [alpha, beta] = calctwiss(alpha0, beta0, Mx, My)
% calctwiss - calculate twiss function inside a combined-function dipole manget
%  INPUTS
%  1. Rho - curvature radius
%  2. Theta - angle
%  3. alpha0 - Horizontal and vertical alpha function at the entrance
%  4. beta0  - Horizontal and vertical beta function at the entrance
%  5. b1 - Focusing
%
%  [beta ] = [  Mx11^2        -2*MX11*Mx12         Mx12^2   ] [beta0 ]
%  [alpha] = [ -Mx11*Mx21 Mx11*Mx22 + Mx11*Mx21   -Mx12*Mx22] [alpha0]
%  [gamma] = [  Mx21^2        -2*MX21*Mx22         Mx22^2   ] [gamma0]


gamma0 = (1+alpha0.^2)./beta0;
twx2 = [Mx(1,1)^2, -2*Mx(1,1)*Mx(1,2), Mx(1,2)^2;
       -Mx(1,1)*Mx(2,1), Mx(1,1)*Mx(2,2)+Mx(1,2)*Mx(2,1),-Mx(1,2)*Mx(2,2);
        Mx(2,1)^2, -2*Mx(2,1)*Mx(2,2),Mx(2,2)^2] * [beta0(1), alpha0(1), gamma0(1)]';
alpha(1) = twx2(2);
beta(1)  = twx2(1);

twy2 = [My(1,1)^2, -2*My(1,1)*My(1,2), My(1,2)^2;
       -My(1,1)*My(2,1), My(1,1)*My(2,2)+My(1,2)*My(2,1),-My(1,2)*My(2,2);
        My(2,1)^2, -2*My(2,1)*My(2,2),My(2,2)^2] * [beta0(2), alpha0(2), gamma0(2)]';
alpha(2) = twy2(2);
beta(2)  = twy2(1);

function [Mx My]= calcMxMy(Rho,K,Theta)
% calcMx calculate transfer matrice of a combined-function dipole manget

s = Rho*Theta;

Kx = K; % H-focusing strength

if Kx>-1/Rho^2; %horizontal focusing
    sqK = sqrt(1/Rho^2+Kx);
    Mx = [cos(sqK*s), sin(sqK*s)/sqK; -sqK*sin(sqK*s), cos(sqK*s)];
else %horizontal defocusing
    sqK = sqrt(-(1/Rho^2+Kx));
    Mx = [cosh(sqK*s), sinh(sqK*s)/sqK; sqK*sinh(sqK*s), cosh(sqK*s)];
end

Ky = -K; % V-defocusing strength

if Ky>0; %vertical focusing
    sqK = sqrt(Ky);
    My = [cos(sqK*s), sin(sqK*s)/sqK; -sqK*sin(sqK*s), cos(sqK*s)];
elseif Ky ==0
    My = [1, s; 0, 1];
else %vertical defocusing
    sqK = sqrt(-Ky);
    My = [cosh(sqK*s), sinh(sqK*s)/sqK; sqK*sinh(sqK*s), cosh(sqK*s)];
end
