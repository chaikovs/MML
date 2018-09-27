%  reglage correcteur verticaux LTI pour injection booster 

setsp('VCOR',vcor0);
dz=0 ;         % pos (mm) 
QP=10;          % num QP


n1=QP-1;  % Num CV
n2=QP;
n3=QP+1;
T1=+dz*0.08/1.2;
T2=-dz*0.04/1.2;
T3=+dz*0.08/1.2;
 stepsp('VCOR',T1,[n1 1]); 
 stepsp('VCOR',T2,[n2 1]); 
 stepsp('VCOR',T3,[n3 1]); 

%dev2tango('VCOR',[[n1 1] ; [n2 1] ;[n3 1]])
%getam('VCOR',[[n1 1]; [n2 1] ;[n3 1]])