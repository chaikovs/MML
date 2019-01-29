function [t,st,fe,unite,t0]=avl2mat(nomfichier)
% [t,st,fe,unite,t0]=avl2mat(nomfichier);
%
% Utilitaire qui relit les mesures faites avec AVLS SURVIB
% t : vecteur temps de 0 a fin mesure en s
% st : tableau des valeurs mesures
% fe : frequence d'echantillonnage
% unite : tableau des unites du fichier de mesure
% t0 : temps absolu du premier echantillon (echelle matlab)

DebugFlag = 0;

if nargin==0
    disp('[t,st,fe,unite,t0]=avl2mat(nomfichier);');
    return;
end

range='oui';

%enleve extension si il y en a une !!!!
if (length(nomfichier)>4) && strcmp(lower(nomfichier(length(nomfichier)-3:length(nomfichier))),'.avl')
    nomfichier=nomfichier(1:length(nomfichier)-4);  
end

if (exist([nomfichier,'.avl'])==2)
    if DebugFlag
        disp(['Conversion au format MATLAB à partir du fichier ',nomfichier,'.avl']);
    end
    % on ouvre
    fid=fopen([nomfichier,'.avl']);

    %on recupere sequentiellemnt les donnees
    Nvoies=fread(fid,1,'float64','ieee-be');
    t0_labview=fread(fid,1,'float64','ieee-be');  
    t0=t0_labview/(3600*24)+2/24+datenum([1904 1 1 0 0 0]);
    t1=(t0 - datenum([1904 1 1 0 0 0]) - 2/24)*3600*24;
    
    fe=fread(fid,1,'float64','ieee-be');
    NbreEch=fread(fid,1,'float64','ieee-be');
    
    unit=fread(fid,Nvoies,'float64','ieee-be');
    unit_string={'V','m','m/s','m/sï¿½','N','SPL','Pa','Eu'};

    sensi=fread(fid,Nvoies,'float64','ieee-be');
    
    if lower(range)=='oui'
        range_input=fread(fid,Nvoies,'float64','ieee-be');
    else
        range_input=zeros(size(sensi))+10;
    end

    
    overload=zeros(size(sensi));
    for indice=1:Nvoies,
        unite{indice}=unit_string{unit(indice)+1};
        st(:,indice)=fread(fid,NbreEch,'float32','ieee-be'); 
        if max(abs(st(:,indice)*sensi(indice)))>0.95*range_input(indice)
            overload(indice)=1;
            disp(['   ATTENTION : overload sur la voie n° %s',num2str(indice)]);
        end
        
    end
    
    fclose(fid);
    % creation d'un vecteur temps relatif !
    t=linspace(0,round(NbreEch/fe)-1/fe,NbreEch);
    sensibilite=sensi;
    unite=unite';
else
    disp(['   ATTENTION : le fichier ',nomfichier,'.avl n''est pas dans le répertoire courant'])
    t=[];
    st=[];
    fe=[];
    unite=[];
    t0=[];
    sensibilite=[];
end
