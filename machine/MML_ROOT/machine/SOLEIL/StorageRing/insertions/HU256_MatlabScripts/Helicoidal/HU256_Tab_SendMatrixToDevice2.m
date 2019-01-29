function Result=HU256_Tab_SendMatrixToDevice2(Matrix, HU256Cell, PowerSupplyOrHelBXDownCurrent, AperiodicOrHelBXUpMatrix)
    % Matrix is the unique matrix in Linear mode, and the DownBX matrix in Helical mode
    % PowerSupply0rHelBXDownCurrent is the PowerSupply in Linear mode, and the Value of BXDown current in Helical mode
    % AperiodicOrHelBXUpMatrix is Aperiodic in Linear mode, and the BXUp Matrix in Helical mode
% function Result=HU256_Tab_SendMatrixToDevice(Matrix, HU256Cell, PowerSupply, Aperiodic)
    global SENSEOFCURRENT;
    global HU256CELL;
    HU256CELL=HU256Cell;
    BackupSENSEOFCURRENT=SENSEOFCURRENT;
    BackupHU256CELL=HU256CELL;
    
    Result=-1;
    
    if (HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15)
        fprintf('Problem in HU256_Tab_SendMatrixToDevice -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    %DataFolder=['/usr/Local/configFiles/InsertionFFTables/ANS-C' num2str(HU256Cell, '%02.0f') '-HU256'];
%     DataFolder=['/usr/Local/configFiles/InsertionFFTables//ANS-C' num2str(HU256Cell, '%02.0f') '-HU256/temp'];
    %DataFolder='/usr/Local/configFiles/InsertionFFTables/ANS-C15-HU256/Transitions/Transition_LV_LH/2';
    %DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/';
%     DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/MatlabScripts/TempTests';
    DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/MatlabScripts/TempTests/Tables_modifiees';
    DataFolderForOldFiles=[DataFolder filesep 'OldFiles'];
    %DataFolderForOldFiles='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/OldFiles/';
    

    if (isa(PowerSupplyOrHelBXDownCurrent, 'char')==1)   % Linear mode    
        if (size(AperiodicOrHelBXUpMatrix, 1)~=1||size(AperiodicOrHelBXUpMatrix, 2)~=1)
            fprintf('Problem in HU256_Tab_SendMatrixToDevice -> when PowerSupply_OrHelBXDownCurrent = %s, AperiodicOrHelBXUpMatrix should be a number\n', PowerSupply_OrHelBXDownCurrent);
            return
        end
        if (strcmp(PowerSupplyOrHelBXDownCurrent, 'bz')==1)
            if (AperiodicOrHelBXUpMatrix==1)
                Name='FF_AH.txt';
            else
                Name='FF_LH.txt';
            end
        elseif (strcmp(PowerSupplyOrHelBXDownCurrent, 'bx')==1)
            if (AperiodicOrHelBXUpMatrix==1)
                Name='FF_AV.txt';
            else
                Name='FF_LV.txt';
            end
        else
            fprintf('Problem in HU256_Tab_SendMatrixToDevice -> PowerSupply_OrHelBXDownCurrent should be ''bx'' or ''bz'' as a string\n');
            return
        end
    elseif (isa(PowerSupplyOrHelBXDownCurrent, 'numeric')==1)   % Helical mode 
        if (size(PowerSupplyOrHelBXDownCurrent, 1)~=1||size(PowerSupplyOrHelBXDownCurrent, 2)~=1)
            fprintf('Problem in HU256_Tab_SendMatrixToDevice -> PowerSupplyOrHelBXDownCurrent should be either a string or a number, but not a matrix\n');
            return
        end 
        Name=['Table_circ_' num2str(PowerSupplyOrHelBXDownCurrent)];
    end
    
%     if (size(Matrix, 2)~=9)
%         fprintf('Problem in HU256_Tab_SendMatrixToDevice -> The matrix should contain 9 columns\n');
%         return
%     end




    NewMatrix=(Matrix)';
    UpMatrix=vertcat(NewMatrix(1, :), NewMatrix(3:2:9, :));
    DownMatrix=vertcat(NewMatrix(1, :), NewMatrix(2:2:8, :));
    
    OldFileUpName=[UpName(1:length(UpName)-4) '_' datestr(now, 30) '.txt'];
    OldFileDownName=[DownName(1:length(DownName)-4) '_' datestr(now, 30) '.txt'];
    FullUpName=[DataFolder filesep UpName];
    FullOldUpName=[DataFolderForOldFiles filesep OldFileUpName];
    FullDownName=[DataFolder filesep DownName];
    FullOldDownName=[DataFolderForOldFiles filesep OldFileDownName];
    [UpFid, Message]=fopen(FullUpName);
    if (UpFid==-1&&strcmp(Message, 'No such file or directory')==1) % The UpFile was not existing yet
        fprintf('The file %s didn''t exist yet\n', FullUpName)
    else 
        movefile(FullUpName, FullOldUpName)
        movefile(FullDownName, FullOldDownName)
        fprintf('Moving "%s" to "%s"\n', FullUpName, FullOldUpName);
        fprintf('Moving "%s" to "%s"\n', FullDownName, FullOldDownName);
    end
    [DownFid, Message]=fopen(FullDownName);
    if (DownFid==-1&&strcmp(Message, 'No such file or directory')==1) % The DownFile was not existing yet
        fprintf('The file %s didn''t exist yet\n', FullDownName)
    else 
        movefile(FullUpName, FullOldUpName)
        movefile(FullDownName, FullOldDownName)
        fprintf('Moving "%s" to "%s"\n', FullUpName, FullOldUpName);
        fprintf('Moving "%s" to "%s"\n', FullDownName, FullOldDownName);
    end
    UpFid=fopen(FullUpName, 'w+');
    DownFid=fopen(FullDownName, 'w+');
    if (UpFid==-1)  % Up File was not created correctly
        fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)\n', FullUpName)
        if (DownFid~=-1)    % Down file was created => it is deleted
            fclose(DownFid);
            delete(FullDownName);
            % Backup
            copyfile(FullOldUpName, FullUpName);
            copyfile(FullOldDownName, FullDownName);
        end
        return
    end
    if (DownFid==-1)    % Up File was created correctly but not Down File => Down File is deleted
        fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)\n', FullDownName)
        fclose(UpFid);
        delete (FullUpName);
        % Backup
        copyfile(FullOldUpName, FullUpName);
        copyfile(FullOldDownName, FullDownName);
        return
    end
    
    % Header Line
    if (strcmp(PowerSupply_OrHelBXDownCurrent_Or_UpOrDown, 'bz')==1)
        if (Aperiodic==1)
            fprintf(UpFid, 'BZP,CVE,CHE,CVS,CHS,BZM1,BZM2,BZM3,BZM4,BZM5,BZM6,BZM7,BZM8\r\n');  %'BZP,CVE,CHE,CVS,CHS\r\n');
            fprintf(DownFid, 'BZP,CVE,CHE,CVS,CHS,BZM1,BZM2,BZM3,BZM4,BZM5,BZM6,BZM7,BZM8\r\n');
        else
            fprintf(UpFid, 'BZP,CVE,CHE,CVS,CHS\r\n');
            fprintf(DownFid, 'BZP,CVE,CHE,CVS,CHS\r\n');
        end
    else %bx
        fprintf(UpFid, 'BX1,BX2,CVE,CHE,CVS,CHS\r\n');
        fprintf(DownFid, 'BX1,BX2,CVE,CHE,CVS,CHS\r\n');
    end
    
    % Contents for Main current and correctors : 1st line = BZP or BX1 currents
    for column=1:size(Matrix, 1)
        fprintf(UpFid, '%+08.3f\t', UpMatrix(1, column));
        fprintf(DownFid, '%+08.3f\t', DownMatrix(1, column));
    end
    fprintf(UpFid, '\r\n');
    fprintf(DownFid, '\r\n');
    % For BX : 2nd line = BX2
    if (strcmp(PowerSupply_OrHelBXDownCurrent_Or_UpOrDown, 'bx')==1)
        if (Aperiodic==1)
            for column=1:size(Matrix, 1)
                SENSEOFCURRENT=1;
                BX2Up=HU256_GetBX2CurrentForAperiodic(UpMatrix(1, column));
                SENSEOFCURRENT=-1;
                BX2Down=HU256_GetBX2CurrentForAperiodic(DownMatrix(1, column));
                fprintf(UpFid, '%+08.3f\t', BX2Up);
                fprintf(DownFid, '%+08.3f\t', BX2Down);
            end
            fprintf(UpFid, '\r\n');
            fprintf(DownFid, '\r\n');
        else
            for column=1:size(Matrix, 1)
                fprintf(UpFid, '%+08.3f\t', UpMatrix(1, column));
                fprintf(DownFid, '%+08.3f\t', DownMatrix(1, column));
            end
            fprintf(UpFid, '\r\n');
            fprintf(DownFid, '\r\n');
        end
    end
    % 4 next lines = correctors currents
    for line=1:4
        for column=1:size(Matrix, 1)
            fprintf(UpFid, '%+08.3f\t', UpMatrix(line+1, column));
            fprintf(DownFid, '%+08.3f\t', DownMatrix(line+1, column));
        end
        fprintf(UpFid, '\r\n');
        fprintf(DownFid, '\r\n');
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Contents for Aperiodic modes => TO BE COMPLETED !!
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (strcmp(PowerSupply_OrHelBXDownCurrent_Or_UpOrDown, 'bz')==1&&Aperiodic==1)
        for line=1:8
            for column=1:size(Matrix, 1)
                SENSEOFCURRENT=1;
                BzmUp=HU256_GetBzmCurrentForAperiodic(UpMatrix(1, column), line);
                SENSEOFCURRENT=-1;
                BzmDown=HU256_GetBzmCurrentForAperiodic(DownMatrix(1, column), line);
                fprintf(UpFid, '%+08.3f\t', BzmUp);
                fprintf(DownFid, '%+08.3f\t', BzmDown);
            end
            fprintf(UpFid, '\r\n');
            fprintf(DownFid, '\r\n');
        end
    end
 
    fclose(UpFid);
    fprintf('"%s" was created successfully\n', FullUpName);
    fclose(DownFid);
    fprintf('"%s" was created successfully\n', FullDownName);
    
    Result=1;
    SENSEOFCURRENT=BackupSENSEOFCURRENT;
    HU256CELL=BackupHU256CELL;
end