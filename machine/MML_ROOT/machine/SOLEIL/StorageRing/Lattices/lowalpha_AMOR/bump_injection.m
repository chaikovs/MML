% Etude injection kicker anneau

clear

%data 
L1=3 ; L2=4 ;  % espacement kicker
betax=11; tunex=0.4;%0.2012;
Xseptum=20;  % en mm
bump=19.5;   % en mm
T = 1.2; % période anneau
n=0 ; % nb tour
nt=40; % Nombre de point sur un tour
quart=3    %  1 2 3 ou 4

phi=tunex*2*pi;
M =[cos(phi) betax*sin(phi) ; -sin(phi)/betax cos(phi)];
SLplus=[1 (L1+L2/2); 0 1];  % revnir au centre section
SLmoins=[1 -(L1+L2/2); 0 1]; 
M=SLplus*M*SLmoins;   %matrice 1 tour après les kickers

SL1=[1 L1 ; 0 1];
SL2=[1 L2/2 ; 0 1];
SD= [1 -(L2+2*L1) ; 0 1];

sol2=-0.0;
sol4=+0.0;

dt=-T/4*(quart-1);
t1=-2.4 + dt;
t2=-2.4 + dt + sol2;
t3=-2.4 + dt;
t4=-2.4 + dt + sol4;

% coordonnées initiales du pulse
X_circ=ones(2,40)*0;  % x et xp
x=ones(1,nt/4)*(-26); xp=ones(1,nt/4)*0;
X_inj=[x ; xp];

t_circ=[];
t_inj=[];
X_stock=[];
X_sept=[];
X_accu=[];


for n=-3:10
    dev1=[];  
    dev2=[];
    dev3=[];
    dev4=[];
    for t=(n*T):(T/nt):((n+1)*T-T/nt)
        dev1=[dev1 -kicker(L1,L2,bump,t1,t)*0.9];
        dev2=[dev2 +kicker(L1,L2,bump,t2,t)*1.1];
        dev3=[dev3 +kicker(L1,L2,bump,t3,t)*1.1];
        dev4=[dev4 -kicker(L1,L2,bump,t4,t)*1.1];
    end
    
  % faisceau circulant  
    t_circ=[t_circ (n*T):(T/nt):((n+1)*T-T/nt)];
    % on revient au debut zone injection
    X_circ=SD*X_circ; 
    % on passe les 4 kickers
    X_circ(2,:)= X_circ(2,:)+dev1;
    X_circ=SL1*X_circ;
    X_circ(2,:)= X_circ(2,:)+dev2;
    X_circ=SL2*X_circ;
    X_sept=[X_sept  X_circ(1,:)];
    X_circ=SL2*X_circ;
    X_circ(2,:)= X_circ(2,:)+dev3;
    X_circ=SL1*X_circ;
    X_circ(2,:)= X_circ(2,:)+dev4;
    % on fait 1 tour
    X_circ=M*X_circ;
    X_stock=[X_stock  X_circ(1,:)];
   
  % faisceau injecté
    if (n==0)     % injection
        t_inj=[t_inj (n*T):(T/nt):((n+1/4)*T-T/nt)];
        X_accu=[X_accu  X_inj(1,:)];
        X_inj=SL2*X_inj;
        X_inj(2,:)= X_inj(2,:)+dev3(1:10);
        X_inj=SL1*X_inj;
        X_inj(2,:)= X_inj(2,:)+dev4(1:10);
        % on fait 1 tour
        X_inj=M*X_inj;
        
    elseif (n>0) % circule aussi
        tt=((n*T):(T/nt):((n+1/4)*T-T/nt));
        t_inj=[t_inj tt];
       % on revient au debut zone injection
        X_inj=SD*X_inj; 
        % on passe les 4 kickers
        X_inj(2,:)= X_inj(2,:)+dev1(1:10);
        X_inj=SL1*X_inj;
        X_inj(2,:)= X_inj(2,:)+dev2(1:10);
        X_inj=SL2*X_inj;
        X_accu=[X_accu  X_inj(1,:)];
        X_inj=SL2*X_inj;
        X_inj(2,:)= X_inj(2,:)+dev3(1:10);
        X_inj=SL1*X_inj;
        X_inj(2,:)= X_inj(2,:)+dev4(1:10);
        % on fait 1 tour
        X_inj=M*X_inj;
        
    end
    
end



Xseptum=-Xseptum*ones(1,length(t_circ));
figure(1)
plot(t_circ,Xseptum,'-k'); hold on;
plot(t_circ,X_sept,'-b',t_inj,X_accu,'or'); hold off;
%plot(X_circ(1,:),X_circ(2,:)) % last turn
%plot(X_stock') % turn to turn

X_inj=SLmoins*X_inj;
emtinj=sqrt(X_inj(1,:).*X_inj(1,:)/betax + X_inj(2,:).*X_inj(2,:)*betax);
X_circ=SLmoins*X_circ;
emtcirc=sqrt(X_circ(1,:).*X_circ(1,:)/betax + X_circ(2,:).*X_circ(2,:)*betax);
fprintf('%g  %g   %g\n',sol2,emtcirc(1),emtinj(1))
