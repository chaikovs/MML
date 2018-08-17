function [V, U,P, R44,nu1,nu2] = calcVmat(m44)
%given a 4x4 x-y transfer matrix, calculate the decoupling transformation
%matrix as done in D. Sagan and D. Rubin, PRSTAB 2, 074001 (1999)
%created by X. Huang, 7/22/2014
%[V, U,P, R44,nu1,nu2] = calcVmat(m44)
%m44 = P*R44*inv(P), P = V*U
%


M = m44(1:2,1:2); 
m = m44(1:2, 3:4);
n = m44(3:4, 1:2);
N = m44(3:4, 3:4);

%symplectic conjugate
np = [n(2,2), -n(1,2); -n(2,1), n(1,1)];
H = m+np;

trMN = trace(M-N);
detH = det(H);

gm = sqrt(0.5+0.5*sqrt(trMN^2/(trMN^2+4.0*detH)));
C = - H*sign(trMN)/gm/sqrt(trMN^2+4.0*detH);
Cp = [C(2,2), -C(1,2); -C(2,1), C(1,1)];

A = gm^2*M-gm*(C*n+m*Cp) + C*N*Cp;
B = gm^2*N-gm*(n*C+Cp*m) + Cp*M*C;

V = [gm*eye(2), C; -Cp gm*eye(2)];

AB = inv(V)*m44*V; 

A = AB(1:2,1:2);
B = AB(3:4,3:4);
[U1,R1,nu1] = getbetaUmat(A);
[U2,R2,nu2] = getbetaUmat(B);
U = [U1, zeros(2); zeros(2), U2];
R44 = [R1, zeros(2); zeros(2), R2];

P = V*U;

function [U,R,nu] = getbetaUmat(A)
%given a 2x2 tranfer matrix, find the transformation matrix U such that
%A=U*R*inv(U), and R is the rotation matrix
%

theta = acos(trace(A)/2.0);
beta = A(1,2)/sin(theta);
if beta<0
    theta=2*pi-theta;
    beta = -beta;
end
alfa = (A(1,1)-A(2,2))/2.0/sin(theta);
%gamma = (1+alfa^2)/beta;

U = [sqrt(beta), 0; -alfa/sqrt(beta), 1/sqrt(beta)];
nu = theta/2/pi;
R = inv(U)*A*U;







