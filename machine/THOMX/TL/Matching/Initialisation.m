global THERING;
twissin=THERING{1}.TwissData 
twissin.alpha;
%twissin.alpha(2); 
twissin.beta;
%twissin.beta(2); 
twissin.mu;
%twissin.mu(2); 
twissin.ClosedOrbit;
%TwissData.alpha=[-4.24,-4.34];TwissData.beta=[34.46,33.94];TwissData.ClosedOrbit=[0;0;0;0;];TwissData.mu=[0,0];
TD1=twissline(THERING,0,twissin,1:length(THERING)+1,'chrom');
S1=cat(1,TD1.SPos);
%Rin=[1e-3,0.0,1e-3,0.0,0.0]';
%a=linepass(THERING,Rin,1:length(THERING)+1);
%BPMxindex=family2atindex('BPMx',family2dev('BPMx',1));
%BPMzindex=family2atindex('BPMz',family2dev('BPMz',1));
%Rinit=linepass(THERING,Rin,BPMxindex);
%Introduction d'une erreur d'orbite
%R = measbpmresp('Model');
%Errh=setsptl('HCOR',1e-3,[1 1]);
%Errv=setsptl('VCOR',1e-3,[1 1]);
%E1=getsptl('BPMx',[1 1]);
%E2=getsptl('BPMz',[1 1]);
Errh=setsp('HCOR',1e-3,[1 1]);
Errv=setsp('VCOR',1e-3,[1 2]);
E1=getam('BPMx','linepass',[1 1]);
E2=getam('BPMz','linepass',[1 1]);
Rin=[0.0,0.0,0.0,0.0,0.0,0.0]';%zeros(6,1);%
a=linepass(THERING,Rin,1:length(THERING)+1);
BPMxindex=family2atindex('BPMx',family2dev('BPMx',1));
BPMzindex=family2atindex('BPMz',family2dev('BPMz',1));
Rinit=linepass(THERING,Rin,BPMxindex);