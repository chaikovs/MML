function [P,R44,nu1,nu2] = calcPmat(m44)
%calculate the P-matrix as defined in Yun Luo's 2004 PRSTAB paper (PRSTAB 7,
%124001) for a 4x4 transfer matrix. X = P Z, with X = (x, x',y,y') and
%Z=(sqrt(2J1)cos(Phi1), -sqrt(2J1)sin(Phi1),sqrt(2J2)cos(Phi2),
%-sqrt(2J2)sin(Phi2))'
%created by X. Huang, 7/17/2014
%
%[P,R,nu1,nu2] = calcPmat(m44)
%Input:  m44, the 4x4 transfer matrix
%Output:
%       m44 = P*R*inv(P), R=R(2*pi*nu1,2*pi*nu2)
%


[v,d] = eig(m44);   %m44*v = v*d

dd = diag(d);
angle_dd = angle(dd);
for ii=3:4
   if abs(angle_dd(1)+angle_dd(ii))<1.0e-5
       i2 = ii;
       v2 = v(:,i2);
       v(:,i2) = v(:,2);
       v(:,2) = v2;
       dd2 = dd(i2);
       dd(i2) = dd(2);
       dd(2) = dd2;
      break; 
   end
end
d = diag(dd);
angle_dd = angle(dd);
nu1 = abs(angle_dd(1))/2/pi;
nu2 = abs(angle_dd(3))/2/pi;

% norm(m44*v-v*d)  %should be zero

%% 
i = sqrt(-1);
theta1 = angle(v(1,1));
v(:,1) = v(:,1)*exp(i*(-pi/2-theta1));
v(:,2) = v(:,2)*exp(i*(pi/2+theta1));

theta2 = angle(v(3,3));
v(:,3) = v(:,3)*exp(i*(-pi/2-theta2));
v(:,4) = v(:,4)*exp(i*(pi/2+theta2));

P = 1/sqrt(2)*[i*(v(:,1)-v(:,2)), v(:,1)+v(:,2), i*(v(:,3)-v(:,4)), v(:,3)+v(:,4)];

P = real(P);
P = P/(det(P))^(1/4);
R44 = inv(P)*m44*P;


