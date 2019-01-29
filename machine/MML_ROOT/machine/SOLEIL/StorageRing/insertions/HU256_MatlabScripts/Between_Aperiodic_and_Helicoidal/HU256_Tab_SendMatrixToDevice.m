function Result=HU256_Tab_SendMatrixToDevice(Matrix, HU256Cell, PowerSupply, Aperiodic)
    global SENSEOFCURRENT;
    global HU256CELL;
    HU256CELL=HU256Cell;

    Result=-1;
    
    if (HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15)
        fprintf('Problem in HU256_Tab_SendMatrixToDevice -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    DataFolder=['/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C' num2str(HU256Cell, '%02.0f') '-HU256'];
    
    %DataFolder='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/';
    %DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/';
    DataFolderForOldFiles=[DataFolder filesep 'OldFiles'];
    %DataFolderForOldFiles='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/OldFiles/';
    
    if (strcmp(PowerSupply, 'bz')==1)
        if (Aperiodic==1)
            UpName='FF_AH_UP.txt';
            DownName='FF_AH_DOWN.txt';
        else
            UpName='FF_LH_UP.txt';
            DownName='FF_LH_DOWN.txt';
        end
    elseif (strcmp(PowerSupply, 'bx')==1)
        if (Aperiodic==1)
            UpName='FF_AV_UP.txt';
            DownName='FF_AV_DOWN.txt';
        else
            UpName='FF_LV_UP.txt';
            DownName='FF_LV_DOWN.txt';
        end
    else
        fprintf('Problem in HU256_Tab_SendMatrixToDevice -> PowerSupply should be ''bz'' or ''bx''\n');
    end
    %if (strcmp(Corrector, 'CHE')==0&&strcmp(Corrector, 'CHS')==0&&strcmp(Corrector, 'CVE')==0&&strcmp(Corrector, 'CVS')==0)
    %    fprintf('Corrector est non correct\n');
    %    return Result
    %end
    if (size(Matrix, 2)~=9)
        fprintf('Problem in HU256_Tab_SendMatrixToDevice -> The matrix should contain 9 columns\n');
        return
    end
    NewMatrix=(Matrix)';
    UpMatrix=vertcat(NewMatrix(1, :), NewMatrix(3:2:9, :));
    DownMatrix=vertcat(NewMatrix(1, :), NewMatrix(2:2:8, :));
    
    OldFileUpName=[UpName(1:length(UpName)-4) '_' datestr(now, 30) '.txt'];
    OldFileDownName=[DownName(1:length(DownName)-4) '_' datestr(now, 30) '.txt'];
    FullUpName=[DataFolder filesep UpName];
    FullOldUpName=[DataFolderForOldFiles filesep OldFileUpName];
    FullDownName=[DataFolder filesep DownName];
    FullOldDownName=[DataFolderForOldFiles filesep OldFileDownName];
    movefile(FullUpName, FullOldUpName)
    movefile(FullDownName, FullOldDownName)
    fprintf('Moving "%s" to "%s"\n', FullUpName, FullOldUpName);
    fprintf('Moving "%s" to "%s"\n', FullDownName, FullOldDownName);
        
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
    if (strcmp(PowerSupply, 'bz')==1)
        if (Aperiodic==1)
            fprintf(UpFid, 'BZP,CVE,CHE,CVS,CHS\r\n');
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
    if (strcmp(PowerSupply, 'bx')==1)
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
    if (strcmp(PowerSupply, 'bz')==1&&Aperiodic==1)
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
    clear global SENSEOFCURRENT;
    clear global HU256CELL;    
end