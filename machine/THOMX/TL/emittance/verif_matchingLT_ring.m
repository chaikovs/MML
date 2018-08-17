global THERING

%% initialisation TL
setpaththomx('TL')
TLinit(2) 

%% valeurs mesurées à SST1
betax_in= 34.46;
betay_in=34.46;
alphax_in=4.24;
alphay_in=4.24;
emitx=51.16e-9;
emity=51.16e-9

%% %Commenter ces deux lignes si vous voulez conserver les valeurs par défault de la maille 
THERING{1}.TwissData.beta=[betax_in ; betay_in];
THERING{1}.TwissData.alpha=[alphax_in ; alphay_in];

%% Tranport dans la TL
TD1=twissline(THERING,0,THERING{1}.TwissData,1:(length(THERING)+1)); %%%%% Attention mettre end quand maille bien défiie avec bend intégré
matalpha=cat(1,TD1.alpha);
matbeta=cat(1,TD1.beta);

betax_out= matbeta(end,1);
betay_out=matbeta(end,2);
alphax_out=matalpha(end,1);
alphay_out=matalpha(end,2);
gammax_out= (1+alphax_out^2)/betax_out;
gammay_out= (1+alphay_out^2)/betay_out;

%% valeurs à l'entrée de l'anneau
setpaththomx
thomxinit(11)
betax_ring= THERING{1}.TwissData.beta(1,1);
betay_ring=THERING{1}.TwissData.beta(2,1);
alphax_ring=THERING{1}.TwissData.alpha(1,1);
alphay_ring=THERING{1}.TwissData.alpha(2,1);
gammax_ring= (1+alphax_ring^2)/betax_ring;
gammay_ring= (1+alphay_ring^2)/betay_ring;

%% plot des ellipses sortie TL/entrée ring
%handles=guidata(hObject); 
%cla(handles.twiss_graf);
ellipseX_out=@(x,xp) gammax_out*x.^2+2*alphax_out*x.*xp+betax_out*xp.^2-emitx;
ellipseX_ring=@(x,xp) gammax_ring*x.^2+2*alphax_ring*x.*xp+betax_ring*xp.^2-emitx;

  bornemax1=max([2*sqrt(betax_out*emitx) 2*sqrt(betax_ring*emitx)]);
  bornemax2=max([2*sqrt(gammax_out*emitx)  2*sqrt(gammax_ring*emitx)]);
    %subplot(1,2,1) 
    figure,
    h1=ezplot(ellipseX_out,[-bornemax1, bornemax1,- bornemax2, bornemax2]);
    set(h1, 'Color', 'r');
    hold on,
    h2=ezplot(ellipseX_ring,[-bornemax1, bornemax1,- bornemax2, bornemax2]);
    set(h2, 'Color', 'b');

    ellipseY_out=@(x,xp) gammay_out*x.^2+2*alphay_out*x.*xp+betay_out*xp.^2-emity;
    ellipseY_ring=@(x,xp) gammay_ring*x.^2+2*alphay_ring*x.*xp+betay_ring*xp.^2-emity;

  bornemax1=max([2*sqrt(betay_out*emity) 2*sqrt(betay_ring*emity)]);
  bornemax2=max([2*sqrt(gammay_out*emity)  2*sqrt(gammay_ring*emity)]);
    %subplot(1,2,1) 
    hold on,
    h1=ezplot(ellipseY_out,[-bornemax1, bornemax1,- bornemax2, bornemax2]);
    set(h1, 'Color', 'k');
    hold on,
    h2=ezplot(ellipseY_ring,[-bornemax1, bornemax1,- bornemax2, bornemax2]);
    set(h2, 'Color', 'g');
    legend('LT out x','Ring in x','LT out y','Ring in y')

