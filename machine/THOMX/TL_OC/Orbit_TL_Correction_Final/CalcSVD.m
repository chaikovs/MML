%function M=CalcSVD(Type,Imax)
% SVD
%Initialisation;
R = measbpmresp('Model');
BPMxindex=family2atindex('BPMx',family2dev('BPMx',1));
BPMzindex=family2atindex('BPMz',family2dev('BPMz',1));
Routx=linepass(THERING,Rin,BPMxindex);
Routz=linepass(THERING,Rin,BPMzindex);
%X1=[Routx(1,:)]';
%Y1=[Routz(3,:)]';
%X=[X1*1e3;Y1*1e3];
%Ivec=1:Imax;
%X=getsptl('BPMx');
%Y=getsptl('BPMz');
%X=[X*1e3;Y*1e3];
AMX=getam('BPMx','linepass');
AMY=getam('BPMz','linepass');
X=AMX(:,1);
Y=AMY(:,1);
X=[X*1e3;Y*1e3];
Ivec=1:8;
[U,S,V]=svd(R);
DeltaAmps = -V(:,Ivec) * S(Ivec,Ivec)^-1 * U(:,Ivec)' *  X;
DeltaAmps1=DeltaAmps([1 2 3 4],[1]);
DeltaAmps2=DeltaAmps([5 6 7 8],[1]);
