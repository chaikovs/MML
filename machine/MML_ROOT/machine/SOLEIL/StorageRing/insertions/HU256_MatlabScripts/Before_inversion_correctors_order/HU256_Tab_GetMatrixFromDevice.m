function Result=HU256_Tab_GetMatrixFromDevice(HU256Cell, PowerSupply)
    
    Result=-1;
    
    if (HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15)
        fprintf('Problem in HU256_Tab_GetMatrixFromDevice -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    DataFolder=['/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C' num2str(HU256Cell, '%02.0f') '-HU256/'];
    
    %DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/';
    %DataFolderForOldFiles='/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C15-HU256/OldFiles/';
    
    if (strcmp(PowerSupply, 'bz')==1)
        UpName='FF_BZP_UP.txt';
        DownName='FF_BZP_DOWN.txt';
    elseif (strcmp(PowerSupply, 'bx')==1)
        UpName='FF_BX_UP.txt';
        DownName='FF_BX_DOWN.txt';
    else
        fprintf('Problem in HU256_Tab_GetMatrixFromDevice : PowerSupply is ''%s'', but it should be ''bx'' or ''bz''\n', PowerSupply);
    end
    %if (strcmp(Corrector, 'CHE')==0&&strcmp(Corrector, 'CHS')==0&&strcmp(Corrector, 'CVE')==0&&strcmp(Corrector, 'CVS')==0)
    %    fprintf('Corrector est non correct\n');
    %    return Result
    %end
    
    fid1=fopen([DataFolder UpName]);
    fid2=fopen([DataFolder DownName]);
    if (fid1==-1)
        fprintf('Problem in HU256_Tab_GetMatrixFromDevice : Impossible to open "%s"! The path may be wrong\n', [DataFolder UpName]);
        return
    end
    fclose(fid1);
    if (fid2==-1)
        fprintf('Problem in HU256_Tab_GetMatrixFromDevice : Impossible to open "%s"! The path may be wrong\n', [DataFolder DownName]);
        return
    end
    fclose(fid2);
    UpMatrix = textread([DataFolder UpName]);    %, '%f', 'delimiter', '\t');
    DownMatrix = textread([DataFolder DownName]);    %, '%f', 'delimiter', '\t');
    
    if (size(UpMatrix, 1)~=5||size(DownMatrix, 1)~=5)
        fprintf('Le format des matrices construites n''est pas correct\n');
        return
    end
    UpMatrix=(UpMatrix)';
    DownMatrix=(DownMatrix)';
    
    if (UpMatrix(:, 1)~=DownMatrix(:, 1))
        fprintf('Le format des matrices construites n''est pas correct\n');
        return
    end
    OutMatrix=[DownMatrix(:, 1) DownMatrix(:, 2) UpMatrix(:, 2) DownMatrix(:, 3) UpMatrix(:, 3) DownMatrix(:, 4) UpMatrix(:, 4) DownMatrix(:, 5) UpMatrix(:, 5)];
    
    Result=OutMatrix;   
end