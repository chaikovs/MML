function Result=HU256_Tab_GetMatrixFromDevice(HU256Cell, PowerSupply, Aperiodic)
    
    Result=-1;
    
    if (HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15)
        fprintf('Problem in HU256_Tab_GetMatrixFromDevice -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    DataFolder=['/usr/Local/DeviceServers/configFiles/InsertionFFTables/ANS-C' num2str(HU256Cell, '%02.0f') '-HU256/'];
    
    %DataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/';
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
    if (strcmp(PowerSupply, 'bz')==1)
        if (Aperiodic==1)
            
            UpMatrix = textread([DataFolder UpName], '%f', 'delimiter', '\t', 'headerlines', 1);   %, '%f', 'delimiter', '\t');
            if (mod(size (UpMatrix, 1), 5)~=0)
                fprintf('Problem in HU256_Tab_GetMatrixFromDevice : The Up matrix has not 5 lines!\nPlease check the number or lines, or check there is no blank character at the end.\n');
                return
            end
            N=size(UpMatrix, 1)/5;
            BZP=UpMatrix(1:N);
            CVE=UpMatrix(N+1:2*N);
            CHE=UpMatrix(2*N+1:3*N);
            CVS=UpMatrix(3*N+1:4*N);
            CHS=UpMatrix(4*N+1:5*N);
            UpMatrix=[BZP CVE CHE CVS CHS];
            
            DownMatrix = textread([DataFolder DownName], '%f', 'delimiter', '\t', 'headerlines', 1);   %, '%f', 'delimiter', '\t');
            if (mod(size (DownMatrix, 1), 13)~=0)
                fprintf('%f\n', size(DownMatrix, 1))
                fprintf('%f\n', size(DownMatrix, 1)/13)
                fprintf('Problem in HU256_Tab_GetMatrixFromDevice : The Down matrix has not 13 lines!\nPlease check the number or lines, or check there is no blank character at the end.\n');
                return
            end
            N=size(DownMatrix, 1)/13;
            BZP=DownMatrix(1:N);
            CVE=DownMatrix(N+1:2*N);
            CHE=DownMatrix(2*N+1:3*N);
            CVS=DownMatrix(3*N+1:4*N);
            CHS=DownMatrix(4*N+1:5*N);
            BZM1=DownMatrix(5*N+1:6*N);
            BZM2=DownMatrix(6*N+1:7*N);
            BZM3=DownMatrix(7*N+1:8*N);
            BZM4=DownMatrix(8*N+1:9*N);
            BZM5=DownMatrix(9*N+1:10*N);
            BZM6=DownMatrix(10*N+1:11*N);
            BZM7=DownMatrix(11*N+1:12*N);
            BZM8=DownMatrix(12*N+1:13*N);
            DownMatrix=[BZP CVE CHE CVS CHS BZM1 BZM2 BZM3 BZM4 BZM5 BZM6 BZM7 BZM8];
            
            %[Current, CVE, CHE, CVS, CHS, BZM1, BZM2, BZM3, BZM4, BZM5, BZM6, BZM7, BZM8] = textread([DataFolder UpName], '%f', 'delimiter', '\t', 'headerlines', 1)    %, '%f', 'delimiter', '\t');
            %UpMatrix=[Current; CVE; CHE; CVS; CHS ; BZM1; BZM2; BZM3; BZM4; BZM5; BZM6; BZM7; BZM8]
            %= textread([DataFolder DownName], '%f', 'delimiter', '\t', 'headerlines', 1)    %, '%f', 'delimiter', '\t');
            %UpMatrix DownMatrix 
        else %bz periodic
            
            UpMatrix = textread([DataFolder UpName], '%f', 'delimiter', '\t', 'headerlines', 1);   %, '%f', 'delimiter', '\t');
            if (mod(size (UpMatrix, 1), 5)~=0)
                fprintf('Problem in HU256_Tab_GetMatrixFromDevice : The Up matrix has not 5 lines!\nPlease check the number or lines, or check there is no blank character at the end.\n');
                return
            end
            N=size(UpMatrix, 1)/5;
            BZP=UpMatrix(1:N);
            CVE=UpMatrix(N+1:2*N);
            CHE=UpMatrix(2*N+1:3*N);
            CVS=UpMatrix(3*N+1:4*N);
            CHS=UpMatrix(4*N+1:5*N);
            UpMatrix=[BZP CVE CHE CVS CHS];
            
            DownMatrix = textread([DataFolder DownName], '%f', 'delimiter', '\t', 'headerlines', 1);   %, '%f', 'delimiter', '\t');
            if (mod(size (DownMatrix, 1), 5)~=0)
                fprintf('Problem in HU256_Tab_GetMatrixFromDevice : The Down matrix has not 5 lines!\nPlease check the number or lines, or check there is no blank character at the end.\n');
                return
            end
            N=size(DownMatrix, 1)/5;
            BZP=DownMatrix(1:N);
            CVE=DownMatrix(N+1:2*N);
            CHE=DownMatrix(2*N+1:3*N);
            CVS=DownMatrix(3*N+1:4*N);
            CHS=DownMatrix(4*N+1:5*N);
            DownMatrix=[BZP CVE CHE CVS CHS];
            %[Current, CVE, CHE, CVS, CHS] = textread([DataFolder UpName], '%f %f %f %f %f', 'delimiter', '\n','headerlines', 1)
            %UpMatrix=[Current; CVE; CHE; CVS; CHS];
            %= textread([DataFolder DownName], '%f', 'delimiter', '\t', 'headerlines', 1)    %, '%f', 'delimiter', '\t');
            %UpMatrix DownMatrix 
        end
    else %bx
        UpMatrix = textread([DataFolder UpName], '%f', 'delimiter', '\t', 'headerlines', 1);   %, '%f', 'delimiter', '\t');
        if (mod(size (UpMatrix, 1), 6)~=0)
            fprintf('Problem in HU256_Tab_GetMatrixFromDevice : The Up matrix has not 6 lines!\nPlease check the number or lines, or check there is no blank character at the end.\n');
            return
        end
        N=size(UpMatrix, 1)/6;
        BX1=UpMatrix(1:N);
        BX2=UpMatrix(N+1:2*N);
        CVE=UpMatrix(2*N+1:3*N);
        CHE=UpMatrix(3*N+1:4*N);
        CVS=UpMatrix(4*N+1:5*N);
        CHS=UpMatrix(5*N+1:6*N);
        UpMatrix=[BX1 BX2 CVE CHE CVS CHS];
        
        DownMatrix = textread([DataFolder DownName], '%f', 'delimiter', '\t', 'headerlines', 1);   %, '%f', 'delimiter', '\t');
        if (mod(size (DownMatrix, 1), 6)~=0)
            fprintf('Problem in HU256_Tab_GetMatrixFromDevice : The Down matrix has not 6 lines!\nPlease check the number or lines, or check there is no blank character at the end.\n');
            return
        end
        N=size(DownMatrix, 1)/6;
        BX1=DownMatrix(1:N);
        BX2=DownMatrix(N+1:2*N);
        CVE=DownMatrix(2*N+1:3*N);
        CHE=DownMatrix(3*N+1:4*N);
        CVS=DownMatrix(4*N+1:5*N);
        CHS=DownMatrix(5*N+1:6*N);
        DownMatrix=[BX1 BX2 CVE CHE CVS CHS];

    end
    
    A=size(UpMatrix, 1)~=size(DownMatrix, 1);
    B=Aperiodic~=1&&size(UpMatrix, 2)~=size(DownMatrix, 2);
    C=size(DownMatrix, 2)<5;
    D=sum(UpMatrix(:, 1)~=DownMatrix(:, 1));

    if (A~=0||B~=0||C~=0||D~=0)
        fprintf('The Up and Down matrixes have wrong format!\n');
        return
    end

    if (strcmp(PowerSupply, 'bz')==1)
        OutMatrix=[DownMatrix(:, 1) DownMatrix(:, 2) UpMatrix(:, 2) DownMatrix(:, 3) UpMatrix(:, 3) DownMatrix(:, 4) UpMatrix(:, 4) DownMatrix(:, 5) UpMatrix(:, 5)];
    else
        OutMatrix=[DownMatrix(:, 1) DownMatrix(:, 3) UpMatrix(:, 3) DownMatrix(:, 4) UpMatrix(:, 4) DownMatrix(:, 5) UpMatrix(:, 5) DownMatrix(:, 6) UpMatrix(:, 6)];
    end
    %[Current CVED CVEU CHED CHED CVSD CVSU CHSD CHSU]
    Result=OutMatrix; 
end