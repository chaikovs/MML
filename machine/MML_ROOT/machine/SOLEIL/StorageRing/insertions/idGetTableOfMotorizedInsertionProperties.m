function res=idGetTableOfMotorizedInsertionProperties(FileName, Types, AddDynamicAttributes, SortByUndNames)
% Creates / overwrites file 'FileName' in /home/data/GMI and fills in it with
% table of devices properties values of motorized insertions.
% if FileName='' => displays table on screen
% Written by F. Briquez 07/07/2011
% Modified by F. Briquez 13/05/2016 : 
%   - Parts of script are set in separate sub functions
%   - add of dynamic attributes
%   - add of sorting by undulator names

    res=-1;
    ColumnSeparator=' '; %'\t';
    if (strcmp(FileName, '')==0)
        FileName=['/home/data/GMI/' FileName];
    end
    
    if isempty(Types)||strcmpi(Types, 'all')
        Types='Apple2 InVacuum EMPHU';
    end
    
    TableCell=CellArrayOfPropertiesAndDynamicAttributes(Types, AddDynamicAttributes);
    if SortByUndNames
        TableCell=SortCellByColumns(TableCell, 2);
    end
    res=PrintCellArrayOnScreeOrFile(TableCell, FileName, ColumnSeparator);
    return
end

function TableCell=CellArrayOfPropertiesAndDynamicAttributes(Types, AddDynamicAttributes)
    
    ListOfUndulators=idGetListOfInsertionDevices(Types);

    NumberOfUndulators=length(ListOfUndulators);
    if (NumberOfUndulators==0)
        return
    end
    for Undulator=1:NumberOfUndulators
        idName=ListOfUndulators{Undulator, 1};
        StorageRingCell=ListOfUndulators{Undulator, 2};
        UnderscorePos=findstr(idName, '_');
        UndulatorName=idName(1:UnderscorePos-1);
        Beamline=idName(UnderscorePos+1:length(idName));
        ListOfProperties=idGetMotorizedInsertionProperties(idName, 0);
        if (~isempty(ListOfProperties)) 
            if (Undulator==1)
                NumberOfProperties=size(ListOfProperties, 1);
                
                if AddDynamicAttributes
                    DynamicCell=idGetDynamicAttributes(Types, 0);
                    NbDynamic=size(DynamicCell, 1);
                else
                    NbDynamic=0;
                end
                
                TableCell=cell(NumberOfProperties+NbDynamic+3, NumberOfUndulators+1);
                TableCell{1, 1}='Cell';
                TableCell{2, 1}='Name';
                TableCell{3, 1}='BeamLine';
                for i=1:NumberOfProperties
                    TableCell{i+3, 1}=ListOfProperties{i, 3};
                end
                for i=1:NbDynamic
                    TableCell{i+3+NumberOfProperties, 1}=DynamicCell{i, 1};
                end
            end
            Column=Undulator+1;
            TableCell{1, Column}=StorageRingCell;
            TableCell{2, Column}=UndulatorName;
            TableCell{3, Column}=Beamline;
            for i=1:NumberOfProperties
                TableCell{i+3, Column}=ListOfProperties{i, 2};
            end
            for i=1:NbDynamic
                TableCell{i+3+NumberOfProperties, Column}=DynamicCell{i, Column};
            end
        end
    end
    return
end
    

function res=idGetMotorizedInsertionProperties(idName, DisplayResults)
% Constructs a cell array containing, for each property :
% - property name
% - property value
% - property label (same as property name, completed with blanks to make
% all names the same length)
% Written by F. Briquez 07/07/2011

%% Initialize
    res='';

    ListOfProperties=cell(5, 3);
    ListOfProperties{1, 1}='ExpectedMaxGap';
    ListOfProperties{2, 1}='ExpectedMaxPhase';
    ListOfProperties{3, 1}='ExpectedMinGap';
    ListOfProperties{4, 1}='ExpectedMinPhase';
    ListOfProperties{5, 1}='InsertionDeviceType';
    N1=size(ListOfProperties, 1);
    
    
    SecurityPropertyName='SECURITY-DO-NOT-EDIT';
    
    DServName = idGetUndDServer(idName);
    if (strcmp(DServName, ''))
        fprintf('idGetMotorizedInsertionProperties : idName ''%s'' is wrong\n', idName)
        return
    end

%% Fill in ListOfProperties with names and values of security properties
    CellOfSecurityProperties=tango_get_device_property(DServName, SecurityPropertyName);
    CellOfSecurityProperties=CellOfSecurityProperties{1};
    Nsecurity=length(CellOfSecurityProperties);
    for i=1:Nsecurity
        TempString=CellOfSecurityProperties{1, i};
        TwoPointsPos=findstr(TempString, ':');
        if (isempty(TwoPointsPos))
            return
        end
        if (~size(TwoPointsPos, 1)||~size(TwoPointsPos, 2))
            return
        end
        PropertyName=TempString(1:TwoPointsPos-1);
        PropertyValue=str2double(TempString(TwoPointsPos+1:length(TempString)));
        ListOfProperties{size(ListOfProperties, 1)+1, 1}=PropertyName;
        ListOfProperties{size(ListOfProperties, 1), 2}=PropertyValue;
    end

%% Fill in ListOfProperties with values of non-security properties
    for i=1:N1
        PropertyName=ListOfProperties{i, 1};
        %TempLength=length(PropertyName);
        PropertyValue=tango_get_device_property(DServName, PropertyName);
        if iscell(PropertyValue)
            PropertyValue=PropertyValue{1};
            PropertyValue=str2double(PropertyValue);
        else
            if PropertyValue==-1
                PropertyValue='Non existing';
            end
        end
        
        ListOfProperties{i, 2}=PropertyValue;
    end
    
%% Format Labels in ListOfProperties to reach the same length   
    N=size(ListOfProperties, 1);
    MaxLength=0;
    for i=1:N
        PropertyName=ListOfProperties{i, 1};
        TempLength=length(PropertyName);
        if (TempLength>MaxLength)
            MaxLength=TempLength;
        end
    end
    for i=1:N
        PropertyName=ListOfProperties{i, 1};
        TempLength=length(PropertyName);
        PropertyLabel=[PropertyName, blanks(MaxLength-TempLength)];
        ListOfProperties{i, 3}=PropertyLabel;
    end

%% Display results
    if (DisplayResults)
        for i=1:N
            PropertyLabel=ListOfProperties{i, 3};
            PropertyValue=ListOfProperties{i, 2};
            ListOfProperties{i, 3}=PropertyLabel;
            fprintf('%s\t%g\n', PropertyLabel, PropertyValue);
        end
    end
    res=ListOfProperties;
    return
end

%% Construct cell array of dynamic attributes
function res=idGetDynamicAttributes(Types, IncludeIdNames)
    res=-1;
    if IncludeIdNames~=0
        IncludeIdNames=1;TableCell=CellArrayOfPropertiesAndDynamicAttributes(Types, AddDynamicAttributes)
    end
    ListOfIds=idGetListOfInsertionDevices(Types);
    ListOfAttributes={'gap', 'phase', 'offset', 'gapVelocity', 'phaseVelocity', 'offsetVelocity'};
    NbIds=size(ListOfIds, 1);
    NbAttributes=size(ListOfAttributes, 2);
    output=cell(IncludeIdNames+2*NbAttributes, NbIds+1);
    
    if IncludeIdNames
        output{1, 1}='ID Name';
    end
    for j=1:NbAttributes
        attributeName=ListOfAttributes{j};
        for k=0:1
            if k==0
                name=[attributeName ' min'];
            else
                name=[attributeName ' Max'];
            end
            output{IncludeIdNames+(2*j)-1+k, 1}=name;
        end
    end
        
    for i=1:NbIds
        idName=ListOfIds{i, 1};
        if IncludeIdNames
            output{1, 1+i}=idName;
        end
        [DServName, ~, ~] = idGetUndDServer(idName);
        for j=1:NbAttributes
            attributeName=ListOfAttributes{j};
            TempSt=tango_get_attribute_config(DServName, attributeName);
            
            for k=0:1
                if k==0
                    if isstruct(TempSt)
                        value=str2double(TempSt.min_value);
                    else
                        value='Non existing';
                    end
                else
                    if isstruct(TempSt)
                        value=str2double(TempSt.max_value);
                    else
                        value='Non existing';
                    end
                end
                output{IncludeIdNames+(2*j-1)+k, 1+i}=value;
            end
        end
    end
     
    res=output;
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
            if (isscalar(TempCell))
                TempString=num2str(TempCell);
            elseif (ischar(TempCell))
                TempString=TempCell;
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

