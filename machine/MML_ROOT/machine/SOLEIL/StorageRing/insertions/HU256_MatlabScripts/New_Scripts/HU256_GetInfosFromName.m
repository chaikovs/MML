function OutStr=HU256_GetInfosFromName(MeasName)
        % MeasName is the name without the path, but including the .mat
        % extension
        % MeasName should be like this :
        % TypeOfUndulator_NameOfLineOfLight_BX_BXCurrent_BZ_BZCurrent_YYYY-
        % MM-DD_HH-MM-SS
        % Exemple : MeasName='HU256_CASSIOPEE_BX_25_2006-12-05_12-20-15.mat'

        TempIndex=findstr('.mat', MeasName);
        if (length(TempIndex)~=1)
            fprintf('%s\n', 'Problème')
        else
            MeasName=MeasName(1:length(MeasName)-4);
        end
        index_=findstr('_', MeasName);
        if (length(index_)~=5&&length(index_)~=7)
            fprintf('%s\n', 'Probleme : Le nom ne respecte pas le format')
            OutStr.Name='MeasName';
            OutStr.Date='';
            OutStr.Hour='';
            OutStr.NumDays=-1;
            OutStr.NumSeconds=-1;
            OutStr.BZ=-1;
            OutStr.BZCur=-1;
            OutStr.BX=-1;
            OutStr.BXCur=-1;
            return
        end
        Pos_BX=findstr(MeasName, 'BX');
        Pos_BZ=findstr(MeasName, 'BZ');
        if (length(Pos_BX)==1)
            AlimBX=1;
            TempIndex=find(index_==Pos_BX-1);
            index_(TempIndex+1);
            index_(TempIndex+2);
            CourantBX=str2num(MeasName(index_(TempIndex+1)+1:index_(TempIndex+2)-1));
        else
            AlimBX=0;
            CourantBX=0;
        end
        if (length(Pos_BZ)==1)
            AlimBZ=1;
            TempIndex=find(index_==Pos_BZ-1);
            index_(TempIndex+1);
            index_(TempIndex+2);
            CourantBZ=str2num(MeasName(index_(TempIndex+1)+1:index_(TempIndex+2)-1));
        else
            AlimBZ=0;
            CourantBZ=0;
        end
        if (AlimBZ==0&&AlimBX==0)
            fprintf('%s\n', 'Problème: Format d''alim incorrect')
        end
        
        Dernier_=index_(length(index_));
        AvantDernier_=index_(length(index_)-1);
        Heure=MeasName(Dernier_+1:length(MeasName));
        Date=MeasName(AvantDernier_+1:Dernier_-1);
        
        indexTirets=findstr('-', Heure);
        if (indexTirets~=[3 6])
            fprintf('%s\n', 'Problème: Format d'' heure incorrect')
        end
        Heures=str2num(Heure(1:indexTirets(1)-1));
        Minutes=str2num(Heure(indexTirets(1)+1:indexTirets(2)-1));
        Secondes=str2num(Heure(indexTirets(2)+1:length(Heure)));
        NumHeure=Heures*3600+Minutes*60+Secondes;
        
        indexTirets=findstr('-', Date);
        if (indexTirets~=[5 8])
            fprintf('%s\n', 'Problème: Format de date incorrect')
        end
        Annee=str2num(Date(1:indexTirets(1)-1));
        Mois=str2num(Date(indexTirets(1)+1:indexTirets(2)-1));
        Jour=str2num(Date(indexTirets(2)+1:length(Date)));
        NumDate=Annee*365+Mois*30+Jour;
        
        Num=NumHeure+NumDate*24*3600;
        OutStr.Name=MeasName;
        OutStr.Date=Date;
        OutStr.Hour=Heure;
        OutStr.NumDays=NumDate;
        OutStr.NumSeconds=NumHeure;
        OutStr.BZ=AlimBZ;
        OutStr.BZCur=CourantBZ;
        OutStr.BX=AlimBX;
        OutStr.BXCur=CourantBX;


  
