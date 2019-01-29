function res=idSummarizeUndulators(Types, SaveFile, Display)%, SortBy)
%%

%% W164_PUMA_SLICING
    res=-1;
    % Types='all';    %'InVac Apple2';

    NbUndulators=0;
    if strncmp(Types, 'Sort', 4)
        ListTypes={'InVac', 'WIGGLER', 'Apple2', 'EMPHU', 'EM'};
        NbTypes=length(ListTypes);
%         for iType=1:NbTypes
%             TempListOfUndulators=idGetListOfInsertionDevices(ListTypes{iType});
%             NbUndulators=NbUndulators+size(TempListOfUndulators, 1);
%         end
%        ListOfUndulators=cell(NbUndulators, 1};

        ListOfUndulators=idGetListOfInsertionDevices(ListTypes{1});
        for iType=2:NbTypes
            PreviousNbUndulators=size(ListOfUndulators, 1);
            TempListOfUndulators=idGetListOfInsertionDevices(ListTypes{iType});
            TempNbUndulators=size(TempListOfUndulators, 1);
            for i=1:TempNbUndulators
                for j=1:size(ListOfUndulators, 2)
                    ListOfUndulators{PreviousNbUndulators+i, j}=TempListOfUndulators{i, j};
                end
            end
        end
        
    else
        ListOfUndulators=idGetListOfInsertionDevices(Types);
    end
    
    NbUndulators=size(ListOfUndulators, 1);
    ListTitles={'Name', 'State', 'Gap', 'Phase', 'Offset', 'PS1', 'PS2', 'PS3', 'Backlash', 'Gap FB', 'Phase FB', 'FFWD', 'IgnoreFFerrors', 'Safety', 'Following'};
    TableCell=cell(NbUndulators+1, length(ListTitles));
    ListPossibleAttributes={'gap', 'phase', 'offset', 'currentPS1', 'currentPS2', 'currentPS3', 'currentBX1', 'currentBX2', 'currentBZP', 'currentIBP', 'backlashEnabled', 'gapPositionFeedback', 'phasePositionFeedback', 'lffOutputEnabled', 'ignoreAnyOfffError'};
    ListCorrespondingTitles={'Gap', 'Phase', 'Offset', 'PS1', 'PS2', 'PS3', 'PS1', 'PS2', 'PS3', 'PS1', 'Backlash', 'Gap FB', 'Phase FB', 'FFWD', 'IgnoreFFerrors'};
    
    %TableCell{:, :}='';
    for j=1:length(ListTitles)
        TableCell{1, j}=ListTitles{1, j};
    end
    for iUnd=1:NbUndulators
        idName=ListOfUndulators{iUnd, 1};
        TableCell{iUnd+1, 1}=idName;
        
        DeviceServer=idGetUndDServer(idName);
        State=tango_state(DeviceServer);
        if ~isempty(State) && isstruct(State)
            StateString=State.name;
        else
            StateString='?';
        end
        TableCell{iUnd+1, 2}=StateString;
        
        CurrentListAttributes=tango_get_attribute_list(DeviceServer);
        for iPossibleAttribute=1:length(ListPossibleAttributes)
            PossibleAttribute=ListPossibleAttributes{iPossibleAttribute};
            AttributeFound=FindStringInCell(PossibleAttribute, CurrentListAttributes);
            if AttributeFound~=-1
                Title=ListCorrespondingTitles{iPossibleAttribute};
                Column=FindStringInCell(Title, ListTitles);
                Attribute=tango_read_attribute2(DeviceServer, PossibleAttribute);
                if isstruct(Attribute)
                    AttributeValue=Attribute.value;
                    AttributeValue=AttributeValue(1);
                    if isnan(AttributeValue)
                        AttributeValue='-';
                    end
                else    % could not read?
                    AttributeValue='x';
                end
                TableCell{iUnd+1, Column}=AttributeValue;
            end
        end
       
        Column=FindStringInCell('Safety', ListTitles);
        if Column~=-1
            Safety=idGetMotorizedInsertionInfo(idName, 'Safety');
             TableCell{iUnd+1, Column}=Safety;
        end
        Column=FindStringInCell('Following', ListTitles);
        if Column~=-1
            Safety=idGetMotorizedInsertionInfo(idName, 'ValidScanError');
             TableCell{iUnd+1, Column}=Safety;
        end
        
    end
        
    ColumnSeparator='  '; %'\t';
    if SaveFile
        FileName=sprintf ('Summary_%s_Undulators', Types);
        FileName=appendtimestamp(FileName);
        FileName=[FileName '.txt'];
        FileName=['/home/data/GMI/Points_Redemarrage/' FileName];
        PrintCellArrayOnScreeOrFile(TableCell, FileName, ColumnSeparator);
        fprintf ('Data saved in file ''%s''\n', FileName)
    end
        
    if Display
        PrintCellArrayOnScreeOrFile(TableCell, '', ColumnSeparator);
    end
    
    if ~SaveFile && ~Display
        res=TableCell;
    end
    
    return
    
end

function res=FindStringInCell(StringToFind, CellOfStrings)
    n=length(CellOfStrings);
    res=-1;
    for i=1:n
        if strcmp(StringToFind, CellOfStrings{i})
            res=i;
            return
        end
    end
    return
end

    
%% Display celle array on screen or in file
function res=PrintCellArrayOnScreeOrFile(TableCell, FileName, ColumnSeparator)
    res=-1;

    if (strcmp(FileName, '')==0)
        FileID=fopen(FileName, 'w+');
        if (FileID==-1)
            fprintf ('Could not open\n')
            return
        end
        fprintf (FileID, 'Undulator properties %s\n', date);
        res=fclose (FileID);
        if (res~=0)
            fprintf('Could not close\n')
            return
        end
        FileID=fopen(FileName, 'a');
        if (FileID==-1)
            fprintf ('Could not open\n')
            return
        end
    else
        fprintf('\n===============\n');
    end
    
   
    
%     NumberOfProperties=size(TableCell, 1);
%     NumberOfUndulators=size(TableCell, 2);
%     for i=1:NumberOfProperties
%         Line='';
%         for j=1:NumberOfUndulators
%             MaxLength=0;
%             for k=1:NumberOfProperties
%                 TempCell=TableCell{k, j};
%                 if (isscalar(TempCell))
%                     TempString=num2str(TempCell);
%                 elseif (ischar(TempCell))
%                     TempString=TempCell;
%                 end
%                 StrLength=length(TempString);
%                 if (StrLength>MaxLength)
%                     MaxLength=StrLength;
%                 end
%             end
%             TempCell=TableCell{i, j};
%             if (isscalar(TempCell))
%                 TempString=num2str(TempCell);
%             elseif (ischar(TempCell))
%                 TempString=TempCell;
%             end
%             if (length(TempString)<MaxLength)
%                 TempString=[TempString blanks(MaxLength-length(TempString))];
%             end

    TableCell=FormatCellArray(TableCell);
    for i=1:size(TableCell, 1)
        Line='';
        for j=1:size(TableCell, 2)
            TempString=TableCell{i, j};
            TempString=strjust(TempString, 'center');
            if (j~=1)
                Line=sprintf('%s%s%s', Line, ColumnSeparator, TempString);
            else
                Line=sprintf('%s%s', Line, TempString);
            end
        end
        if (strcmp(FileName, '')==0)
            fprintf (FileID, '%s\n', Line);
        else
            fprintf ('%s\n', Line);
        end
    end
    if (strcmp(FileName, '')==0)
        res=fclose(FileID);
        if (res~=0)
            fprintf('Could not close\n');
            return
        end
    end
    res=1;
    return
end

function NewCell=FormatCellArray(TableCell)
    % Create new cell with string fields of same length per each column
    
    NewCell=cell(size(TableCell));
    
    for j=1:size(TableCell, 2)
        MaxLength=0;
        for i=1:size(TableCell, 1)
            TempCell=TableCell{i, j};
            if (isscalar(TempCell))
                TempString=num2str(TempCell);
            elseif (ischar(TempCell))
                TempString=TempCell;
            end
            StrLength=length(TempString);
            if (StrLength>MaxLength)
                MaxLength=StrLength;
            end
        end
        for i=1:size(TableCell, 1)
        TempCell=TableCell{i, j};
            if isscalar(TempCell) || isempty(TempCell)
                TempString=num2str(TempCell);
            elseif (ischar(TempCell))
                TempString=TempCell;
            else
                TempString='';
            end
            if (length(TempString)<MaxLength)
                TempString=[TempString blanks(MaxLength-length(TempString))];
            end
            NewCell{i, j}=TempString;
        end
    end
    return
end

function OutputCell=SortCellByColumns(InputCell, Row)
    OutputCell=cell(size(InputCell));
    for i=1:size(OutputCell, 1)
        OutputCell{i, 1}=InputCell{i, 1};
    end
    [~, Indx]=sort(InputCell(Row, 2:size(InputCell, 2)));
    
    for j=2:size(OutputCell, 2)
        NewColumn=Indx(j-1)+1;
        for i=1:size(OutputCell, 1)
            OutputCell{i, j}=InputCell{i, NewColumn};
        end
    end
end