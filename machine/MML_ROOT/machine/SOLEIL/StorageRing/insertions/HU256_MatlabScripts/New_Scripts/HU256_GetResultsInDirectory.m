function HU256_GetResultsInDirectory(Integrals1_Kicks0, DirName, ReferenceDirIsInDirectory)
    %Crée dans le répertoire DirName un fichier texte contenant les
    %intégrales (si Integrals1_Kicks0=1) ou les kicks (si Integrals1_Kicks0=0) calculées à partir des orbites des fichiers.mat contenus
    %dans DirName, en comparaison avec un fichier .mat de Reference.
    %Ce fichier (nom sans importantce) est placé dans un répertoire situé dans DirName
    %(ReferenceDirIsInDirectory=1) ou dans le répertoire père (ReferenceDirIsInDirectory=0)

    ScriptDirName = Pwd; %'E:\Travail\HU256\Commissioning\MatlabScripts';
  
    %StructOfFiles=dir(DirName);
    StructOfFiles=dir([DirName filesep '*.mat']);
    %dir(fullfile(matlabroot,'toolbox/matlab/audiovideo/*.m'))
    NumberOfFiles=size(StructOfFiles, 1);
        
    cd (DirName)
    cd ..
    FatherDirName=cd;
    cd (ScriptDirName)
    if (ReferenceDirIsInDirectory==1)
        ReferenceFileDirName=[DirName filesep 'Reference'];
    elseif (ReferenceDirIsInDirectory==0)
        ReferenceFileDirName=[FatherDirName filesep 'Reference'];
    end
    
    fprintf ('Position du répertoire contenant le fichier de référence : %s\n', ReferenceFileDirName);
    if (exist(ReferenceFileDirName)==7)
        StructOfReferenceFiles=dir([ReferenceFileDirName filesep '*.mat']);
        NumberOfReferenceFiles=size(StructOfReferenceFiles);
       
        if (NumberOfReferenceFiles~=1)
           fprintf ('Fichier de référence non trouvé ou non unique!\n');
           cd (ScriptDirName)
        else
            cd (DirName)
            
            if (Integrals1_Kicks0==1)
                fid=fopen('Integrals_Measurements_Summary.txt', 'wt');
                StringToWriteInLine=sprintf('FileName\tReferenceFileName\tI1x\tI2x\tI1z\tI2z\n');
                %StringToWriteInLine='a\nb\nc'
            else
                fid=fopen('Kicks_Measurement_Summary.txt', 'wt');
                StringToWriteInLine=sprintf('FileName\tReferenceFileName\tKickEZ\tKickSZ\tKickEX\tKickSX\n');
            end
            fwrite(fid, StringToWriteInLine);
            fprintf(fid, '\n');
            ReferenceFileName=StructOfReferenceFiles(1).name;
            for (Number=1:NumberOfFiles)
                NameOfFile=StructOfFiles(Number).name;
                %fwrite(fid, [NameOfFile '\t'])
                %fwrite(fid, [ReferenceFileName '\t'])
                
                cd (ScriptDirName)
                Result=idCalcFldIntFromElecBeamMeasForUndSOLEIL_1('HU256_CASSIOPEE', '', [DirName filesep NameOfFile], [ReferenceFileDirName filesep ReferenceFileName], ScriptDirName, []);
                if (Integrals1_Kicks0==1)
                    StringToWriteInLine=sprintf([NameOfFile '\t' ReferenceFileName '\t' num2str(Result.I1X) '\t' num2str(Result.I2X) '\t' num2str(Result.I1Z) '\t' num2str(Result.I2Z)]);
                else
                    StringToWriteInLine=sprintf([NameOfFile '\t' ReferenceFileName '\t' num2str(Result.KicksZ(1)) '\t' num2str(Result.KicksZ(2)) '\t' num2str(Result.KicksX(1)) '\t' num2str(Result.KicksX(2))]);
                end
                fwrite(fid, StringToWriteInLine);
                fprintf(fid, '\n');
            end
            
            fclose (fid);
            cd (ScriptDirName)
        end
    else
        fprintf ('Répertoire contenant le fichier de référence non trouvé\n');
        cd (ScriptDirName)
    end

    %Int=idCalcFldIntFromElecBeamMeasForUndSOLEIL_1('HU256_CASSIOPEE', 'E:\Travail\HU256\Commissioning\SESSION_2006_10_13', 'HU256_CASSIOPEE_BZP_m200A_2006-10-13_12-11-38.mat', 'HU256_CASSIOPEE_BZP_0A_2006-10-13_12-04-38.mat', 'E:\Travail\HU256\Commissioning\MatlabScripts', [])