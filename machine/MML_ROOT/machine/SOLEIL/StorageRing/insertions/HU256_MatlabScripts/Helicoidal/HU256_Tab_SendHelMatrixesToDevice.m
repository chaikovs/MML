function Result=HU256_Tab_SendHelMatrixesToDevice(FullNameOfDTable, FullNameOfUTable, HU256Cell, BXCurrent)
% for Helical tables only.
% Takes the text Files containing the Down Table and the Up Table (Script format)
% Creates the files used by the Device Server :
%   -the table Table_circ_BXCurrent and copy the old one (if FullNameOfDTable is not '')
%       and/or :
%   -the table TableHelBx_cycles and copy the old one (if FullNameOfUTable is not '')
% The Directory of tables used by the device server can be changed on line n°163 (DServerDataFolder)
% The Directory of copies is the directory "old" in DServerDataFolder. (line n°167,  DServerCopyDataFolder)
% The names of the files created are :
%   - for the Down table, on line n°171 (DServerDName)
%   - for the Up table, on line n°172 (DServerUName)


%% Initialisation
    global SENSEOFCURRENT;
    global HU256CELL;
    HU256CELL=HU256Cell;
    BackupSENSEOFCURRENT=SENSEOFCURRENT;
    BackupHU256CELL=HU256CELL;
    
    Result=-1;
    
    if (HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15)
        fprintf('Problem in HU256_Tab_SendHelMatrixesToDevice -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    
    DTable=~strcmp (FullNameOfDTable, '');
    UTable=~strcmp (FullNameOfUTable, '');
    
%% Getting matrixes from files  

    if (DTable==1)
        DMatrix=HU256_Tab_GetMatrixFromTable(FullNameOfDTable, 0, 0);
        if (size(DMatrix, 2)~=9)
            fprintf('Problem in HU256_Tab_SendHelMatrixesToDevice -> The DMatrix should contain 9 columns\n');
            return
        end
    end
    if (UTable==1)
        UTableNamesStructure.U=FullNameOfUTable;
        UTableNamesStructure.D='';
        UMatrix=HU256_Tab_GetMatrixFromTable(UTableNamesStructure, 1, 0)
        if (size(UMatrix, 2)~=5)
            fprintf('Problem in HU256_Tab_SendHelMatrixesToDevice -> The UMatrix 5 columns\n');
            return
        end
    end
    
%% Calculate Output Down matrix
    if (DTable==1)
        BZPCurrents=DMatrix(:, 1);
        BZPCurrents=BZPCurrents';
        MinBZP=min(BZPCurrents);
        MaxBZP=max(BZPCurrents);

    
        %OrderedBZPCurrents=HU256_OrderingCurrentsAlongCycle(BZPCurrents,
        %1, 'Currents');
        OrderedBZPCurrents=HU256_OrderingCurrentsAlongCycle(BZPCurrents, 0, 'Currents'); % 0 is not added at the end (analog spi version)
        index=zeros(1, length(OrderedBZPCurrents));


        for i=1:length(OrderedBZPCurrents);
            index(i)=find(BZPCurrents==OrderedBZPCurrents(i));
        end
    %     index
        OutDMatrix=nan(5, length(OrderedBZPCurrents));
        OutDMatrix(1, :)=OrderedBZPCurrents;
        for i=2:5   % i = row of OutDMatrix (=BZP, CVE, CHE, CVS, CHS)
            for j=1:1:length(OrderedBZPCurrents)  % j = col of OutMatrix (= 0 -100 -200 -100 ...)
                CurrentValue=OrderedBZPCurrents(j);
    %                 CurrentValue=BZPCurrents(index);

                if (j~=length(OrderedBZPCurrents))
                    CurrentValueOfNextPoint=OrderedBZPCurrents(j+1);
                    if (CurrentValue==MinBZP)
                        Sense=1;
                    elseif(CurrentValue==MaxBZP)
                        Sense=-1;
                    elseif (CurrentValueOfNextPoint-CurrentValue>0)
                        Sense=1;
                    elseif (CurrentValueOfNextPoint-CurrentValue<0)
                        Sense=-1;
                    else
                        Sense=-1;   %Default
                    end
                else
                    Sense=-1;     %Default
                end
                if (Sense==1)
                    OneMoreColumn=1;    % In the DTable, the U column is the corresponding D column +1
                else
                    OneMoreColumn=0;
                end
    %                
                fprintf('i : %1.0f, j : %1.0f, CurrentValue : %3.3f, Sense : %1.0f\n', i, j, CurrentValue, Sense)
    %                 index(j)
                OutDMatrix(i, j)=DMatrix(index(j), i+(i-2)+OneMoreColumn);

            end
        end
%         OutDMatrix
    end
    
%% Calculate Output Up matrix
    if (UTable==1)
        BXCurrents=UMatrix(:, 1);
        BXCurrents=BXCurrents';
%         MinBX=min(BXCurrents);
%         MaxBX=max(BXCurrents);

    
        OrderedBXCurrents=HU256_OrderingCurrentsAlongCycle(BXCurrents, 1, 'Currents');
        index=zeros(1, length(OrderedBXCurrents));


        for i=1:length(OrderedBXCurrents)
            index(i)=find(BXCurrents==OrderedBXCurrents(i));
        end
        OutUMatrix=nan(6, length(OrderedBXCurrents));
        OutUMatrix(1, :)=OrderedBXCurrents;
        OutUMatrix(2, :)=OrderedBXCurrents;
        for i=3:6   % i = row of OutUMatrix (=BX1, BX2, CVE, CHE, CVS, CHS)
            for j=1:1:length(OrderedBXCurrents)  % j = col of OutMatrix (= 0 -100 -200 -100 ...)
%                 CurrentValue=OrderedBXCurrents(j);
    %                 CurrentValue=BZPCurrents(index);

%                 if (j~=length(OrderedBXCurrents))
%                     CurrentValueOfNextPoint=OrderedBXCurrents(j+1);
%                     if (CurrentValue==MinBX)
%                         Sense=1;
%                     elseif(CurrentValue==MaxBX)
%                         Sense=-1;
%                     elseif (CurrentValueOfNextPoint-CurrentValue>0)
%                         Sense=1;
%                     elseif (CurrentValueOfNextPoint-CurrentValue<0)
%                         Sense=-1;
%                     else
%                         Sense=-1;   %Default
%                     end
%                 else
%                     Sense=-1;     %Default
%                 end
%                 if (Sense==1)
%                     OneMoreColumn=1;    % In the DTable, the U column is the corresponding D column +1
%                 else
%                     OneMoreColumn=0;
%                 end
    %                
%                 fprintf('i : %1.0f, j : %1.0f, CurrentValue : %3.3f, Sense : %1.0f\n', i, j, CurrentValue, Sense)
%                 fprintf('i : %1.0f, j : %1.0f, CurrentValue : %3.3f, Sense : %1.0f\n', i, j, CurrentValue, Sense)
    %                 index(j)
%                 OutUMatrix(i, j)=UMatrix(index(j), i+(i-2)+OneMoreColumn);
                OutUMatrix(i, j)=UMatrix(index(j), i-1);

            end
        end
    end
%     OutUMatrix;

%% Definition of destination Data folders and files
    
    DServerDataFolder=['/usr/Local/configFiles/InsertionFFTables/ANS-C' num2str(HU256Cell, '%02.0f') '-HU256'];
%%%%%%%%% For tests %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     DServerDataFolder='/home/operateur/GrpGMI/HU256_CASSIOPEE/MatlabScripts/Helicoidal/DeviceTablesForTests';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DServerCopyDataFolder=[DServerDataFolder filesep 'OldFiles'];
    if (isdir(DServerCopyDataFolder)==0)
        mkdir (DServerCopyDataFolder);
    end
    DServerDName=['Table_circ_' num2str(BXCurrent) '.txt'];
    DServerUName='TableHelBx_Up.txt';

	CopyDServerDName= ['Table_circ_' num2str(BXCurrent) '_' datestr(now, 30) '.txt'];
    CopyDServerUName= ['TableHelBx_Up_' datestr(now, 30) '.txt'];
    
    FullDServerDName=[DServerDataFolder filesep DServerDName];
    FullDServerUName=[DServerDataFolder filesep DServerUName];
    FullCopyDServerDName=[DServerCopyDataFolder filesep CopyDServerDName];
    FullCopyDServerUName=[DServerCopyDataFolder filesep CopyDServerUName];
    

%% Checking existing Down table and/or creating it
    if (DTable==1)    
    [DFid, Message]=fopen(FullDServerDName);
        if (DFid==-1&&strcmp(Message, 'No such file or directory')==1) % The Down DServer Table was not existing yet
            fprintf('The table %s doesn''t exist yet\n', FullDServerDName)
        else 
            movefile(FullDServerDName, FullCopyDServerDName)
            fprintf('"%s" was moved to "%s"\n', FullDServerDName, FullCopyDServerDName);
        end
    end
%% Checking existing Up table and/or creating it
    if (UTable==1)
    [UFid, Message]=fopen(FullDServerUName);
        if (UFid==-1&&strcmp(Message, 'No such file or directory')==1) % The Up DServer Table was not existing yet
            fprintf('The table %s doesn''t exist yet\n', FullDServerDName)
        else 
            movefile(FullDServerUName, FullCopyDServerUName)
            fprintf('"%s" was moved to "%s"\n', FullDServerUName, FullCopyDServerUName);
        end
    end
%% Backups from old tables
    if (DTable==1)
        DFid=fopen(FullDServerDName, 'w+');
    end
    if (UTable==1)
        UFid=fopen(FullDServerUName, 'w+');
    end
    if (UTable==1&&UFid==-1)  % Up File was not created correctly
        fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)\n', FullDServerUName)
        if (DFid~=-1&&DTable==1)    % Down file was created => it is deleted
            fclose(DFid);
            delete(FullDServerDName);
            % Backup
            copyfile(FullCopyDServerUName, FullDServerUName);
            copyfile(FullCopyDServerDName, FullDServerDName);
        else
            fclose(UFid);
            delete(FullDServerUName);
            % Backup
            copyfile(FullCopyDServerUName, FullDServerUName);
        end
        return
    end
    % Up File was created correctly

    if (DTable==1&&DFid==-1)    % Up File was created correctly but not Down File => Down File is deleted
        fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)\n', FullDServerDName)
        fclose(DFid);
        delete (FullDServerUName);
        % Backup
        copyfile(FullCopyDServerDName, FullDServerDName);
        return
    end
%% Filling in the destination Down Table
    
    if (DTable==1)
        % Header Line
        fprintf(DFid, 'BZP,CVE,CHE,CVS,CHS\r\n');
        % Contents for Main current and correctors
        for line=1:size(OutDMatrix, 1)
            for column=1:size(OutDMatrix, 2)
                fprintf(DFid, '%+08.3f\t', OutDMatrix(line, column));
            end
            fprintf(DFid, '\r\n');    
        end
    end

%% Filling in the destination Up Table
    if (UTable==1)
        % Header Line
        fprintf(UFid, 'BX1,BX2,CVE,CHE,CVS,CHS\r\n');
        % Contents for Main current and correctors
        for line=1:size(OutUMatrix, 1)
            for column=1:size(OutUMatrix, 2)
                fprintf(UFid, '%+08.3f\t', OutUMatrix(line, column));
            end
            fprintf(UFid, '\r\n');
        end
    end
    Result=1;

    
    
%     NewMatrix=(Matrix)';
%     UpMatrix=vertcat(NewMatrix(1, :), NewMatrix(3:2:9, :));
%     DownMatrix=vertcat(NewMatrix(1, :), NewMatrix(2:2:8, :));
%     
%     OldFileUpName=[UpName(1:length(UpName)-4) '_' datestr(now, 30) '.txt'];
%     OldFileDownName=[DownName(1:length(DownName)-4) '_' datestr(now, 30) '.txt'];
%     FullUpName=[DataFolder filesep UpName];
%     FullOldUpName=[DataFolderForOldFiles filesep OldFileUpName];
%     FullDownName=[DataFolder filesep DownName];
%     FullOldDownName=[DataFolderForOldFiles filesep OldFileDownName];

%     [UpFid, Message]=fopen(FullUpName);
%     if (UpFid==-1&&strcmp(Message, 'No such file or directory')==1) % The UpFile was not existing yet
%         fprintf('The file %s didn''t exist yet\n', FullUpName)
%     else 
%         movefile(FullUpName, FullOldUpName)
%         movefile(FullDownName, FullOldDownName)
%         fprintf('Moving "%s" to "%s"\n', FullUpName, FullOldUpName);
%         fprintf('Moving "%s" to "%s"\n', FullDownName, FullOldDownName);
%     end

%     [DownFid, Message]=fopen(FullDownName);
%     if (DownFid==-1&&strcmp(Message, 'No such file or directory')==1) % The DownFile was not existing yet
%         fprintf('The file %s didn''t exist yet\n', FullDownName)
%     else 
%         movefile(FullUpName, FullOldUpName)
%         movefile(FullDownName, FullOldDownName)
%         fprintf('Moving "%s" to "%s"\n', FullUpName, FullOldUpName);
%         fprintf('Moving "%s" to "%s"\n', FullDownName, FullOldDownName);
%     end

%     UpFid=fopen(FullUpName, 'w+');
%     DownFid=fopen(FullDownName, 'w+');
%     if (UpFid==-1)  % Up File was not created correctly
%         fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)\n', FullUpName)
%         if (DownFid~=-1)    % Down file was created => it is deleted
%             fclose(DownFid);
%             delete(FullDownName);
%             % Backup
%             copyfile(FullOldUpName, FullUpName);
%             copyfile(FullOldDownName, FullDownName);
%         end
%         return
%     end

%     if (DownFid==-1)    % Up File was created correctly but not Down File => Down File is deleted
%         fprintf('Problem in HU256_Tab_SendMatrixToDevice : Impossible to create "%s"! The path may be wrong(?)\n', FullDownName)
%         fclose(UpFid);
%         delete (FullUpName);
%         % Backup
%         copyfile(FullOldUpName, FullUpName);
%         copyfile(FullOldDownName, FullDownName);
%         return
%     end
%     
%     % Header Line
%     if (strcmp(PowerSupply_OrHelBXDownCurrent_Or_UpOrDown, 'bz')==1)
%         if (Aperiodic==1)
%             fprintf(UpFid, 'BZP,CVE,CHE,CVS,CHS,BZM1,BZM2,BZM3,BZM4,BZM5,BZM6,BZM7,BZM8\r\n');  %'BZP,CVE,CHE,CVS,CHS\r\n');
%             fprintf(DownFid, 'BZP,CVE,CHE,CVS,CHS,BZM1,BZM2,BZM3,BZM4,BZM5,BZM6,BZM7,BZM8\r\n');
%         else
%             fprintf(UpFid, 'BZP,CVE,CHE,CVS,CHS\r\n');
%             fprintf(DownFid, 'BZP,CVE,CHE,CVS,CHS\r\n');
%         end
%     else %bx
%         fprintf(UpFid, 'BX1,BX2,CVE,CHE,CVS,CHS\r\n');
%         fprintf(DownFid, 'BX1,BX2,CVE,CHE,CVS,CHS\r\n');
%     end
%     
%     % Contents for Main current and correctors : 1st line = BZP or BX1 currents
%     for column=1:size(Matrix, 1)
%         fprintf(UpFid, '%+08.3f\t', UpMatrix(1, column));
%         fprintf(DownFid, '%+08.3f\t', DownMatrix(1, column));
%     end
%     fprintf(UpFid, '\r\n');
%     fprintf(DownFid, '\r\n');
%     % For BX : 2nd line = BX2
%     if (strcmp(PowerSupply_OrHelBXDownCurrent_Or_UpOrDown, 'bx')==1)
%         if (Aperiodic==1)
%             for column=1:size(Matrix, 1)
%                 SENSEOFCURRENT=1;
%                 BX2Up=HU256_GetBX2CurrentForAperiodic(UpMatrix(1, column));
%                 SENSEOFCURRENT=-1;
%                 BX2Down=HU256_GetBX2CurrentForAperiodic(DownMatrix(1, column));
%                 fprintf(UpFid, '%+08.3f\t', BX2Up);
%                 fprintf(DownFid, '%+08.3f\t', BX2Down);
%             end
%             fprintf(UpFid, '\r\n');
%             fprintf(DownFid, '\r\n');
%         else
%             for column=1:size(Matrix, 1)
%                 fprintf(UpFid, '%+08.3f\t', UpMatrix(1, column));
%                 fprintf(DownFid, '%+08.3f\t', DownMatrix(1, column));
%             end
%             fprintf(UpFid, '\r\n');
%             fprintf(DownFid, '\r\n');
%         end
%     end
%     % 4 next lines = correctors currents
%     for line=1:4
%         for column=1:size(Matrix, 1)
%             fprintf(UpFid, '%+08.3f\t', UpMatrix(line+1, column));
%             fprintf(DownFid, '%+08.3f\t', DownMatrix(line+1, column));
%         end
%         fprintf(UpFid, '\r\n');
%         fprintf(DownFid, '\r\n');
%     end
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Contents for Aperiodic modes => TO BE COMPLETED !!
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if (strcmp(PowerSupply_OrHelBXDownCurrent_Or_UpOrDown, 'bz')==1&&Aperiodic==1)
%         for line=1:8
%             for column=1:size(Matrix, 1)
%                 SENSEOFCURRENT=1;
%                 BzmUp=HU256_GetBzmCurrentForAperiodic(UpMatrix(1, column), line);
%                 SENSEOFCURRENT=-1;
%                 BzmDown=HU256_GetBzmCurrentForAperiodic(DownMatrix(1, column), line);
%                 fprintf(UpFid, '%+08.3f\t', BzmUp);
%                 fprintf(DownFid, '%+08.3f\t', BzmDown);
%             end
%             fprintf(UpFid, '\r\n');
%             fprintf(DownFid, '\r\n');
%         end
%     end
%  
%     fclose(UpFid);
%     fprintf('"%s" was created successfully\n', FullUpName);
%     fclose(DownFid);
%     fprintf('"%s" was created successfully\n', FullDownName);
%     
%     Result=1;
%     SENSEOFCURRENT=BackupSENSEOFCURRENT;
%     HU256CELL=BackupHU256CELL;
% end