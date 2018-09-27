function Result=HU256_Tab_SendMatrixToDevice(Matrix, HU256Cell, PowerSupply)
    
    Result=-1;
    
    if (HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15)
        fprintf('Problem in HU256_Tab_SendMatrixToDevice -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    DataFolder=['/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C' num2str(HU256Cell, '%02.0f') '-HU256/'];
    
    %DataFolder='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/';
    %DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/';
    DataFolderForOldFiles=[DataFolder '/OldFiles/'];
    %DataFolderForOldFiles='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/OldFiles/';
    
    if (strcmp(PowerSupply, 'bz')==1)
        UpName='FF_BZP_UP.txt';
        DownName='FF_BZP_DOWN.txt';
    elseif (strcmp(PowerSupply, 'bx')==1)
        UpName='FF_BX_UP.txt';
        DownName='FF_BX_DOWN.txt';
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
    
    
    movefile([DataFolder UpName], [DataFolderForOldFiles UpName '_' datestr(now, 30)]);
    movefile([DataFolder DownName], [DataFolderForOldFiles DownName '_' datestr(now, 30)])
    
    UpFid=fopen([DataFolder UpName], 'w+');
    DownFid=fopen([DataFolder DownName], 'w+');
    if (UpFid==-1)
        fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)', [DataFolder UpName])
        if (DownFid~=-1)
            fclose(DownFid);
        end
        return
    end
    if (DownFid==-1)
        fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)', [DataFolder DownName])
        fclose(UpFid);
        return
    end
    for line=1:5
        for column=1:size(Matrix, 1)
            fprintf(UpFid, '%+08.3f\t', UpMatrix(line, column));
            fprintf(DownFid, '%+08.3f\t', DownMatrix(line, column));
        end
        fprintf(UpFid, '\r\n');
        fprintf(DownFid, '\r\n');
    end
    fclose(UpFid);
    fclose(DownFid);
    
    Result=1;   
end