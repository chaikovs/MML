function [S x y xm ym ba bb bc bd u v x0 y0]=bpm_BEM( n,m,methode, varargin)
% Used Boundary Element Method to compute charge on electrods of a BPM
% given a BPM geometry
%
% INPUTS
% 1. n nombre d'elements finis pour la 1�re tranche
% 2. m nombre d'elements finis pour la 2eme tranche
% 3. methode 'methode rectangle', 'chambrecomplete'
% Option:  acrtiver affichage Chambre � vide 'NoDisplay', 'Display'
%
% OUTPUTS
% 1. S: Sigma (surface charge distribution)
% 2. x: chambre � vide horizontale
% 3. y: chambre � vide verticale
% 4. xm: middle H-position on mesh
% 5. ym: middle V-position on mesh
% 6. ba bb bc bd : Location of buttons A, B, C, D
% 7. u position H lue
% 8. v position V lue
% 9. x0  vecteur  qui donne la position H
% 10. y0  vecteur  qui donne la position V
% 11. xp longeur vecteur x0
% 12. yp longeur vecteur y0
% 13.a b c d : charge Q sur chaque electrode


% Ecrit par Foued Talbi, SOLEIL 2011

DisplayFlag = 1;
if nargin > 3
    if strcmpi(varargin{1}, 'NoDisplay')% strcmpi=comparer des tableaux de chaines de memes dimensions et renvoient un tab de 0/1...
        %1 si les chaines sont egales , 0 sinon.
        DisplayFlag = 0;
    elseif strcmpi(varargin{1}, 'Display')
        DisplayFlag = 1;
    else
        DisplayFlag = 1;
    end
end

spacing = 1; % dummy (((.espacement
%
%methode = 'chambrecomplete';
xstep=spacing;
ystep=spacing;
%xstep=0.25;
%ystep=0.125;
%n = 50;% nombre des petits segments
%m = 50;
bd=8.86; % diametre boutton (mm)


% build chamber geometry

% bpm in arc vessel
% Simplified model

% range for computation

xrange=23;%x=(-23/+23)
yrange=5;

p = 161;

bcs=16; % distance (mm) entre deux bouttons suivant x (cad A et B )
x=[l(-42,-42,n) l(-42,-15,m) l(-15,15,p) l(15,42,m) l(42,42,n)];
y=[l(0.1,2.6241,n)   l(2.6241,12.5,m)     l(12.5,12.5,p)       l(12.5,2.6241,m) l(2.6241,0,n)];
x=[x  fliplr(x) x(1)];%fliplr(x)=renversement droite/gauche
y=[y -fliplr(y) y(1)];

%tracer la chambre a vide
if DisplayFlag
    figure;
    plot(x,y); ylim([-50 50]); xlim([-50 50]);
    xlabel('x(mm)'); ylabel('z(mm)'); title('BPM vacuum chamber profile')
    set(gca,'XDir','reverse')
end



%calcul du milieu des segments d'elements finis
e=length(x)-1;
xm=(x(1:e)+x(2:e+1))/2;
ym=(y(1:e)+y(2:e+1))/2;
bx1=bcs/2-bd/2; bx2=bcs/2+bd/2;

% button location between bx1 and bx2, defined before
% b as button
% position des bouttons(taille boutton)
ba=find(and((xm(1:e/2)>bx1),(xm(1:e/2)<bx2))); % upper right button %find=trouve les indices des �l�ments non nuls
bb=find(and((xm(1:e/2)>-bx2),(xm(1:e/2)<-bx1))); % upper left button
bc=find(and((xm(e/2:e)>-bx2),(xm(e/2:e)<-bx1)))+e/2-1; % lower left button
bd=find(and((xm(e/2:e)>bx1),(xm(e/2:e)<bx2)))+e/2-1; % lower right button
% construire matrice G ( proportionel � la g�ometrie de la chambre � vide)
tic
G=zeros(e,e);
for j=1:e
    sl(j)=sqrt((x(j+1)-x(j))^2+(y(j+1)-y(j))^2);
    for i=1:e
        if i==j
            G(j,i)=2*sl(j)*(1-log(sl(j)));
        else
            G(i,j)=-log(sqrt((xm(j)-xm(i))^2+(ym(j)-ym(i))^2))*sl(j);
        end
    end
end
ig=inv(G); %inverse de G
%creer 1 strucure S
S.xm = xm;
S.ym = ym;
S.ig = ig;
S.ba = ba;
S.bb = bb;
S.bc = bc;
S.bd = bd;


B=zeros(1,e);

%x0 = [0 1.0];
%y0 = [0 1.0];
xmax = 42; % mm
ymax = 12.5; % mm
x0=0:1:xmax;%creer vecteur x0 qui donne la position H
y0=0:1:ymax;%creer vecteur x0 qui donne la posit


%methode = 'methode rectangle';
%methode = 'chambrecomple';

% calcul des positions lues par le BPM et les gains Kx Ky


switch methode
    case {'methode rectangle'}
        x0 =[-xrange:xstep:0 xstep:xstep:xrange];
        y0 =[-yrange:ystep:0 ystep:ystep:yrange];
    
        disp('methode rectangle')
        xp=length(x0);
        yp=length(y0);
        u=zeros(xp,yp);v=zeros(xp,yp);
        % Calcul des positions lues en fonctions  de positions vraies
        for yi=1:yp
            for xi=1:xp
                [a, b, c, d] = buttons(ig, x0(xi), y0(yi), xm, ym, ba, bb, bc, bd);
                s=a+b+c+d;
                u(xi,yi)= (a-b-c+d)/s;%position lue H
                v(xi,yi)= (a+b-c-d)/s;%position lue V
            end
        end
        %% Calcul des Gains des BPMS
        xi0=find(x0==0);
        yi0=find(y0==0);
        Kx=diff(x0([xi0 xi0+1]))/diff(u([xi0 xi0+1],yi0));
        Ky=diff(y0([yi0 yi0+1]))/diff(v(xi0,[yi0 yi0+1]));
        u=u*Kx;v=v*Ky;
        S.Kx=Kx;
        S.Ky=Ky;
        fprintf('Calibration factors are Kx=%f Ky=%f\n', Kx, Ky')
        toc
        if DisplayFlag
            figure
            plot(x,y,'k-',xm(ba),ym(ba),'rd',xm(bb),ym(bb),'rd',xm(bc),ym(bc),'rd',xm(bd),ym(bd),'rd')%Tracer les bouttons ( rouge)
            hold on
            [xs,ys] = meshgrid(x0, y0);
            plot(xs, ys, 'g.', 'MarkerSize', 6);%tracer positions vrai (  vert )
            plot(u,v,'kx');%Tracer les positions lu (reconstruit) (  noir)
            axis equal
            set(gca,'XDir','reverse')
            xlim([-50 50])
            
            %%erreur u(reconstruit= lu) par rapport � x vrai
            OrbitError = sqrt(power(u-xs',2)+power(v-ys',2))';
            figure
            plot(x,y,'k-',xm(ba),ym(ba),'rd',xm(bb),ym(bb),'rd',xm(bc),ym(bc),'rd',xm(bd),ym(bd),'rd')
            hold on
            [xs,ys] = meshgrid(x0, y0);
            %plot(xs, ys, 'go');
            surf(xs,ys,OrbitError, 'LineStyle', 'None');
            colorbar
            shading interp
            xlabel('x (mm)')
            ylabel('z (mm)')
            title('Error (mm) with (u,v) w.r.t. (x,z)')
            axis equal
            set(gca,'XDir','reverse')
            xlim([-50 50])
        end
        
        
    case 'chambrecomplete'
        [xt yt] = chambrecomplete;
        disp('methode complete')
        u=xt*0;v=yt*0; % initialisation des variables
        
        % Calcul des positions lues en fonctions de la matrice de positions
        % vraies
        for yi=1:size(yt,2)
            for xi=1:size(xt,1)
                [a, b, c, d] = buttons(ig, xt(xi,yi), yt(xi,yi), xm, ym, ba, bb, bc, bd);
                s=a+b+c+d;
                u(xi,yi)= (a-b-c+d)/s;%position lue H
                v(xi,yi)= (a+b-c-d)/s;%position lue V
            end
        end
        Kx=11.601562; Ky=11.433759;
        u=u*Kx;v=v*Ky;
        
        
        toc
        if DisplayFlag
    figure
    plot(x,y,'k-',xm(ba),ym(ba),'rd',xm(bb),ym(bb),'rd',xm(bc),ym(bc),'rd',xm(bd),ym(bd),'rd')%Tracer les bouttons ( rouge)
    hold on
    
    plot(xt, yt, 'g.', 'MarkerSize', 6);%tracer positions vrai (  vert )
    plot(u,v,'kx');%Tracer les positions lu (reconstruit) (  noir)
    axis equal
    set(gca,'XDir','reverse')
   % xlim([-50 50])
    %%
    %%erreur u lue par rapport � x vrai
    OrbitError = sqrt(power(u-xt,2)+power(v-yt,2))';
    figure
    plot(x,y,'k-',xm(ba),ym(ba),'rd',xm(bb),ym(bb),'rd',xm(bc),ym(bc),'rd',xm(bd),ym(bd),'rd')
    hold on
    surf(xt,yt,OrbitError', 'LineStyle', 'None');
    colorbar
    shading interp
    xlabel('x (mm)')
    ylabel('z (mm)')
    title('Error (mm) with (u,v) w.r.t. (x,z)')
    axis equal
    set(gca,'XDir','reverse')
   %%
   %tracer l'erreur normalis�e (orbiterreur/distance entre centre chambre a
   %vide et position vraie du faisceau)
   errornormalise = OrbitError' ./ sqrt(power(xt,2)+power(yt,2));
   figure
   plot(x,y,'k-',xm(ba),ym(ba),'rd',xm(bb),ym(bb),'rd',xm(bc),ym(bc),'rd',xm(bd),ym(bd),'rd')
    hold on
    
    surf(xt,yt,errornormalise, 'LineStyle', 'None');
    
    colorbar
    shading interp
    xlabel('x (mm)')
    ylabel('z (mm)')
    title('Errornormalise (mm) with (u,v) w.r.t. (x,z)')
    axis equal
    set(gca,'XDir','reverse')
    %%
    %courbes d'iso erreurs en pourcentage
   plot(x,y,'k-',xm(ba),ym(ba),'rd',xm(bb),ym(bb),'rd',xm(bc),ym(bc),'rd',xm(bd),ym(bd),'rd')
     hold on
   [ C h] = contour(xt, yt, errornormalise*100,[0:5:100]);
   set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)%modifier les propri�t�s des objets graphiques
   colormap(jet)
    xlabel('x (mm)')
    ylabel('z (mm)')
    title('courbes erreur en pourcentage')
    axis equal
    set(gca,'XDir','reverse')
    
   
end
        
    otherwise
       error('Unknown method.')
end

% this is our mapping:
% charges = ig * a_nonlinear_function(x, y, geometry)
% ba etc. contain the indices of the buttons in the geometry
% charge on button A = sum(charges(ba))
% add matrix rows to get mapping from xy the sum of the
% charge over the 4 buttons
Ma = sum(ig(S.ba, :), 1);% charge Qa
Mb = sum(ig(S.bb, :), 1);
Mc = sum(ig(S.bc, :), 1);
Md = sum(ig(S.bd, :), 1);
% matrice des 4 potentiels (diamond V)
S.bmat = [Ma; Mb; Mc; Md];

return

%% Compute Charge for each electrod
function [a,b,c,d] = buttons(ig, x, y, xm, ym, ba, bb, bc, bd)
% return button signal at x, y
%fonction calcul le charge Q a chaque electrode(a=Qa,b=Qb,...)
% Formula from BEM (see A. Stella, Daphne, CD-10, Frascati, 2007)
B= -log(sqrt((x-xm).^2+(y-ym).^2)); % signed reversed at diamond
sig=-ig*B.';
% Charge for each electrod A, B, C ,D
a=sum(sig(ba));b=sum(sig(bb));c=sum(sig(bc));d=sum(sig(bd));

function ll=l(a,b,c)
ll=linspace(a,b,c+1);%divis� l'abscisse sur des segments egales (fonction linspace) c+1 segments
ll=ll(1:c);