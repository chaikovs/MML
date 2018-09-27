function Result=HU256_Tab_TransformLinearScriptToDevice(ScriptFileFullName, HU256Cell, Component, Aperiodic)
%% Infos
% Written by F.Briquez 10/10/2008
% 1) 
    Result=-1;
    if (HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15)
        fprintf('HU256_Tab_TransformLinearScriptToDevice : HU256Cell must be 4, 12 or 15\n');
        return
    end
    if (strcmp(Component, 'Bz')==0&&strcmp(Component, 'Bx')==0)
        fprintf('HU256_Tab_TransformLinearScriptToDevice : Component must be ''Bz'' or ''Bx''\n');
        return
    end
    Matrix=HU256_Tab_GetMatrixFromTable(ScriptFileFullName, 0, 0);
    if (size(Matrix)==[1 1])
        if (Matrix<0)
           fprintf('%s\n', 'HU256_Tab_TransformLinearScriptToDevice : Could not load the matrix\n');
            return
        end
    end
    if (Aperiodic==1)
        MoreInformation='Aperiodic';
        if (strcmp(Component, 'Bz'))
            TitleLine='BZP,CVE,CHE,CVS,CHS,BZM1,BZM2,BZM3,BZM4,BZM5,BZM6,BZM7,BZM8';
            AperiodicMatrix=HU256_GetBzmCurrentMatrixForAperiodic(HU256Cell);
            NumberOfMainCurrentLines=1;
        else
            TitleLine='BX1,BX2,CVE,CHE,CVS,CHS';
            AperiodicMatrix=HU256_GetBX2CurrentMatrixForAperiodic(HU256Cell);
            NumberOfMainCurrentLines=1;
        end
    else
        MoreInformation='';
        if (strcmp(Component, 'Bz'))
            TitleLine='BZP,CVE,CHE,CVS,CHS';
            AperiodicMatrix=0;
            NumberOfMainCurrentLines=1;
        else
            TitleLine='BX1,BX2,CVE,CHE,CVS,CHS';
            AperiodicMatrix=0;
            NumberOfMainCurrentLines=2;
        end
    end
    TempInfos=HU256_Tab_GetInfosOnDeviceServerTable(HU256Cell, 'Linear', Component, MoreInformation);
    Directory=TempInfos.Directory;
    FileName=[TempInfos.DeviceFileName '.txt'];
    Result=HU256_Tab_SendLinearScriptMatrixToDeviceFormatFile(Matrix, Directory, FileName, TitleLine, NumberOfMainCurrentLines, AperiodicMatrix);
end