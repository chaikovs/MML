function HU256_Test(MeasDir)
    Liste=dir([MeasDir filesep '*.mat']);
    N=size(Liste, 1);
    Cellule=cell(N, 4);
        
    for i=1:6
        Nom=getfield(Liste, {i}, 'name');
        TempIndex=findstr('.mat', Nom);
        if (length(TempIndex)~=1)
            fprintf('%s\n', 'Problème')
        else
            Nom=Nom(1:length(Nom)-4)
        end
        index_=findstr('_', Nom);
        if (length(index_)~=5&&length(index_)~=7)
            fprintf('%s\n', 'Gross Problem!')
        end
        Pos_BX=findstr(Nom, 'BX');
        Pos_BZ=findstr(Nom, 'BZ');
        if (length(Pos_BX)==1)
            AlimBX=1;
            TempIndex=find(index_==Pos_BX-1);
            index_(TempIndex+1);
            index_(TempIndex+2);
            CourantBX=str2num(Nom(index_(TempIndex+1)+1:index_(TempIndex+2)-1));
        else
            AlimBX=0;
        end
        if (length(Pos_BZ)==1)
            AlimBZ=1;
            TempIndex=find(index_==Pos_BZ-1);
            index_(TempIndex+1);
            index_(TempIndex+2);
            CourantBZ=str2num(Nom(index_(TempIndex+1)+1:index_(TempIndex+2)-1));
        else
            AlimBZ=0;
        end
        if (AlimBZ==0&&AlimBX==0)
            fprintf('%s\n', 'Problème: Format d''alim incorrect')
        end
        
        Dernier_=index_(length(index_));
        AvantDernier_=index_(length(index_)-1);
        Heure=Nom(Dernier_+1:length(Nom));
        Date=Nom(AvantDernier_+1:Dernier_-1);
        
        indexTirets=findstr('-', Heure);
        if (indexTirets~=[3 6])
            fprintf('%s\n', 'Problème: Format d'' heure incorrect')
        end
        Heures=str2num(Heure(1:indexTirets(1)-1));
        Minutes=str2num(Heure(indexTirets(1)+1:indexTirets(2)-1));
        Secondes=str2num(Heure(indexTirets(2)+1:length(Heure)));
        NumHeure=Heures*3600+Minutes*60+Secondes
        
        indexTirets=findstr('-', Date);
        if (indexTirets~=[3 6])
            fprintf('%s\n', 'Problème: Format de date incorrect')
        end
        Annee=str2num(Date(1:indexTirets(1)-1));
        Mois=str2num(Date(indexTirets(1)+1:indexTirets(2)-1));
        Jour=str2num(Date(indexTirets(2)+1:length(Date)));
        NumDate=Annee*365+Mois*30+Jour
        
        Num=NumHeure+NumDate*24*3600
        Cellule{i, 1}=Nom;
        Cellule{i, 2}=Date;
        Cellule{i, 3}=Num;
    end
    
    %fprintf('%s\t%d\n', Cellule(1, 2), Cellule(1, 2))
    %fprintf('%s\t%d\n', Cellule(2, 2), Cellule(2, 2))
    
    %fprintf('%s\t%d', Date1, datenum(Date1));
    %fprintf('%s\t%d', Date2, datenum(Date2));
    %Cellule

    %toto1=load('E:\Travail\HU256\Commissioning\2ème Run\SESSION_2006_12_5\HU256_CASSIOPEE_BX_175_2006-12-05_12-17-05.mat');
    %toto2=load('E:\Travail\HU256\Commissioning\2ème Run\SESSION_2006_12_5\HU256_CASSIOPEE_BX_175_2006-12-05_12-18-54.mat');
        
  
