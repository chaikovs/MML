function Result=HU256_Tab_SendLinearScriptMatrixToDeviceFormatFile(Matrix, Directory, FileName, TitleLine, NumberOfMainCurrentLines, AperiodicMatrix)
%% Infos
% Written by F.Briquez 08/10/2008
% 1) Makes a backup of the DeviceServer file specified by Directory and FileName
% 2) Takes the Matlab generated linear type Matrix
% 3) transforms it in the wright DeviceServer style, according to TitleLine, NumberOfMainCurrentLines and AperiodicMatrix
% 4) writes it in the file specified by Directory and FileName
% 
% Updated by F.Briquez 10/10/2008:  - Chapters added
%                                   - Aperiodic put before Correctors
%                                   - Check of matrix compatibility added.
%                                   - Possibility of several MainCurrent lines added
%                                   - Message of creation / re-writing of DeviceServer table
% Updated by F.Briquez 09/02/2009 : Correctors put before Aperiodic!! Else, the beam is killed!!
% Returns 1 if succeeded, -1 else
    Result=-1;
%% Backup
    Backup=HU256_Tab_BackupDeviceFile(Directory, FileName);
    if (Backup==-1)
        fprintf('HU256_Tab_SendLinearScriptMatrixToDeviceFormatFile : Could not backup old table! => nothing is done\n')
        return
    end
    FileNameLength=size(FileName, 2);
    if (strcmp(FileName(FileNameLength-3:FileNameLength), '.txt')==0)
        FileName=[FileName '.txt'];
    end
    FileFullName=[Directory filesep FileName];
    NumberOfColumns=size(Matrix, 2);
%% Title line
    TempResult=HU256_Tab_AddLineToFileFromScriptMatrixColumn(FileFullName, 1, 1, 1, TitleLine);
    if (TempResult==-1)
        return
    end
%% Main current line(s)
    for i=1:NumberOfMainCurrentLines
        TempResult=HU256_Tab_AddLineToFileFromScriptMatrixColumn(FileFullName, Matrix, 1, 0, '');
        if (TempResult==-1)
            return
        end
    end

%% Correctors lines
    for Column=2:2:NumberOfColumns-1
       TempResult=HU256_Tab_AddLineToFileFromScriptMatrixColumn(FileFullName, Matrix, [Column Column+1], 0, '');
        if (TempResult==-1)
            return
        end
    end
%% Aperiodic lines
    
    if (isscalar(AperiodicMatrix)~=1&&isempty(AperiodicMatrix)==0)
        MatrixMainCurrents=Matrix(:,1);
        AperiodicMatrixMainCurrents=AperiodicMatrix(:,1);
        MatrixMainCurrents=MatrixMainCurrents'
        MainCurrentsSize=size(MatrixMainCurrents)
        AperiodicMatrixMainCurrents=AperiodicMatrixMainCurrents'
        AperiodicMainCurrentsSize=size(AperiodicMatrixMainCurrents)
        Condition1=(MainCurrentsSize==AperiodicMainCurrentsSize);
        if (sum(Condition1(1))==2)
            Condition2=ones(MatrixMainCurrents==AperiodicMatrixMainCurrents);
        else
            Condition2=0;
        end
        if (Condition2~=1)
            InterpAperiodicMatrix=HU256_Tab_InterpolScriptMatrix(AperiodicMatrix, MatrixMainCurrents');
            AperiodicMatrix=InterpAperiodicMatrix;
            fprintf('Aperiodic matrix interpolated\n')
        end
        NumberOfAperiodicMatrixColumns=size(AperiodicMatrix, 2);
        for Column=2:NumberOfAperiodicMatrixColumns
            TempResult=HU256_Tab_AddLineToFileFromScriptMatrixColumn(FileFullName, AperiodicMatrix, Column , 0, '');
            if (TempResult==-1)
                return
            end
        end
    end
%% Message
    if (Backup==0)  % The DeviceServer table was not existing yet
        fprintf(': %s created\n', FileFullName);
    else    % The DeviceServer table was existing yet
        fprintf(': %s re-writed\n', FileFullName);
    end
    Result=1;
end