function Result=HU256_Tab_SendMatrixToDevice(Matrix, PowerSupply)
    
    Result=-1;
    DataFolder='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/';
    %DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/';
    DataFolderForOldFiles='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/OldFiles/';
    
    if (strcmp(PowerSupply, 'bzp')==1)
        UpName='FF_BZP_UP.txt';
        DownName='FF_BZP_DOWN.txt';
    elseif (strcmp(PowerSupply, 'bx')==1)
        UpName='FF_BX_UP.txt';
        DownName='FF_BX_DOWN.txt';
    else
        fprintf('PowerSupply n''est pas correct\n');
    end
    %if (strcmp(Corrector, 'CHE')==0&&strcmp(Corrector, 'CHS')==0&&strcmp(Corrector, 'CVE')==0&&strcmp(Corrector, 'CVS')==0)
    %    fprintf('Corrector est non correct\n');
    %    return Result
    %end
    if (size(Matrix, 2)~=9)
        fprintf('Le format de la matrice n''est pas correct\n');
        return
    end
    NewMatrix=(Matrix)';
    UpMatrix=vertcat(NewMatrix(1, :), NewMatrix(3:2:9, :));
    DownMatrix=vertcat(NewMatrix(1, :), NewMatrix(2:2:8, :));
    
    
    movefile([DataFolder UpName], [DataFolderForOldFiles UpName '_' datestr(now, 30)]);
    movefile([DataFolder DownName], [DataFolderForOldFiles DownName '_' datestr(now, 30)])
    
    UpFid=fopen([DataFolder UpName], 'w+');
    DownFid=fopen([DataFolder DownName], 'w+');
    for line=[1:5]
        for column=[1:size(Matrix, 1)]
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