function [S, FileName] = getdata(varargin)
%GETDATA - Searches through a file (or group of files) for a data structure which matches the family name
%  [Data, FileName] = getdata(FamilyName, FileName)
%  [Data, FileName] = getdata(FamilyName, DeviceList, FileName)
%
%  INPUTS
%  1. FamilyName - Family name to search for.  This function will search through all 
%                  the variables in the file looking for a FamilyName match.  It will 
%                  also look through any array or cell array.  Arrays within a cell
%                  array will also be searched through.
%  2. FileName - File name to search in (or cell array of file names) {default: []}
%                [] - prompt the user to choose a file
%  3. DeviceList - Device list to index by (optional input)
%  4. 'Field' - Sometime searching on FamilyName is not enough.  To contraint which
%               Field to search for, use the keyword 'Field' followed 
%               by the desired name to look for (see example 3) (optional input).
%  5. 'Struct'  - Return a data structure
%     'Numeric' - Return numeric outputs  {Default}
%     'Object'  - Return a accelerator object (AccObj)
%
%  OUTPUTS
%  1. Data - Data found
%  2. FileName - File name where the data was found (including the path) 
%
%  EXAMPLES
%  1. Get BPM data in file abc.mat 
%     >> BPM = getdata('QF', 'abc.mat');
%  2. Get QF setpoint data in file abc.mat 
%     >> SP = getdata('QF', 'Struct', 'Field', 'Setpoint', 'abc.mat');
%
%  See also getrespmat
%
%  Written by Greg Portmann


% Input parsing
% [S, FileName] = getdata(Family, 'Field', 'Monitor', FileName, DeviceList)
% [S, FileName] = getdata(Family, FileName, DeviceList)
% [S, FileName] = getdata(Family, DeviceList)
% [S, FileName] = getdata(Family)


%%%%%%%%%%%%%%%%%
% Input Parsing %
%%%%%%%%%%%%%%%%%
StructOutputFlag = 0;
ObjectOutputFlag = 0;
FileName = '';
DeviceList = [];
FieldConstraint = '';
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignor structures
    elseif iscell(varargin{i})
        % Ignor cells
    elseif strcmpi(varargin{i},'Struct')
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Numeric')
        StructOutputFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Object')
        ObjectOutputFlag = 1;
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Field')
        varargin(i) = [];
        FieldConstraint = varargin{i};
        varargin(i) = [];
    end
end


if isempty(varargin)
    error('FamilyName input required');
end

if length(varargin) >= 1 
    Family = varargin{1};
end

if length(varargin) >= 2
    if ischar(varargin{2})
        FileName = varargin{2};
    else
        DeviceList = varargin{2};
    end
end

if length(varargin) >= 3
    if ischar(varargin{3})
        FileName = varargin{3};
    else
        DeviceList = varargin{3};
    end
end

if isempty(FieldConstraint)
    if ismemberof(Family,'BPM')
        FieldConstraint = 'Monitor';
    else
        FieldConstraint = 'Setpoint';        
    end
end
% End input parsing


if isempty(FileName)
    [FileName, DirectoryName, FilterIndex] = uigetfile('*.mat', 'Select a Data File');
    %[FileName, DirectoryName, FilterIndex] = uigetfile('*.mat', 'Select a Data File', getfamilydata('Directory', 'DataRoot'));
    if FilterIndex == 0
        S=[]; FileName=[];
        return
    end
    FileName = [DirectoryName FileName];
end


% Force FileNameCell to be a cell
if iscell(FileName)
    FileNameCell = FileName;
else
    FileNameCell = {FileName};
end

Data = [];
Found = 0;
for i = 1:length(FileNameCell)
    try
        % FileStruct is a structure of all the variable inside FileNameCell
        FileStruct = load(FileNameCell{i});
        
        % VarCell is a cell array of the field names of FileStruct
        VarCell = fieldnames(FileStruct);  
        
        for j = 1:length(VarCell)
            % OneField is one of the fields of FileStruct
            OneField = FileStruct.(VarCell{j});
            
            % Look through all the variable to find a structure with Monitor, Actuator, and Data fields
            for ii = 1:size(OneField,1)
                for jj = 1:size(OneField,2)
                    
                    if iscell(OneField)
                        
                        % If OneField is a cell
                        OneCell = OneField{ii,jj};
                        for mm = 1:size(OneCell,1)
                            for nn = 1:size(OneCell,2)
                                % If OneCell is an array, look through OneCell to find a structure with FamilyName and Data
                                if isfield(OneCell(mm,nn),'FamilyName') && isfield(OneCell(mm,nn),'Data')
                                    if strcmp(OneCell(mm,nn).FamilyName, Family)
                                        if ~isempty(FieldConstraint)
                                            if isfield(OneCell(mm,nn), 'Field')
                                                if strcmp(OneCell(mm,nn).Field, FieldConstraint)
                                                    S = OneCell(mm,nn);
                                                    Found = 1;
                                                    break
                                                end
                                            end
                                        else
                                            S = OneCell(mm,nn);
                                            Found = 1;
                                            break
                                        end
                                    end
                                    
                                elseif isfield(OneField(mm,nn), Family)
                                    % Config data structure
                                    if isfield(OneCell(mm,nn).(Family),'FamilyName') && isfield(OneCell(mm,nn).(Family),'Data')
                                        if ~isempty(FieldConstraint)
                                            if isfield(OneCell(mm,nn).(Family), 'Field')
                                                if strcmp(OneCell(mm,nn).(Family).Field, FieldConstraint) 
                                                    S = OneCell(mm,nn).(Family);
                                                    Found = 1;
                                                    break       
                                                end
                                            end
                                        else
                                            S = OneCell(mm,nn).(Family);
                                            Found = 1;
                                            break       
                                        end
                                    end
                                end
                            end
                        end
                        
                    else
                        % Structure
                        % If OneCell is an array, look through OneCell to find a structure with FamilyName and Data
                        if isfield(OneField(ii,jj),'FamilyName') && isfield(OneField(ii,jj),'Data')
                            if strcmp(OneField(ii,jj).FamilyName, Family)
                                if ~isempty(FieldConstraint)
                                    if isfield(OneField(ii,jj), 'Field')
                                        if strcmp(OneField(ii,jj).Field, FieldConstraint)
                                            S = OneField(ii,jj);
                                            Found = 1;
                                            break
                                        end
                                    end
                                else
                                    S = OneField(ii,jj);
                                    Found = 1;
                                    break
                                end
                            end
                                    
                        elseif isfield(OneField(ii,jj), Family)
                            if isfield(OneField(ii,jj).(Family),'FamilyName') && isfield(OneField(ii,jj).(Family),'Data')
                                % Old config data structure
                                if ~isempty(FieldConstraint)
                                    if isfield(OneField(ii,jj).(Family), 'Field')
                                        if strcmp(OneField(ii,jj).(Family).Field, FieldConstraint) 
                                            S = OneField(ii,jj).(Family);
                                            Found = 1;
                                            break       
                                        end
                                    end
                                else
                                    S = OneField(ii,jj).(Family);
                                    Found = 1;
                                    break       
                                end
                            elseif isfield(OneField(ii,jj), Family) && isfield(OneField(ii,jj).(Family),FieldConstraint)
                                % New config data structure
                                if ~isempty(FieldConstraint)
                                    if isfield(OneField(ii,jj).(Family), FieldConstraint) 
                                        if isfield(OneField(ii,jj).(Family).(FieldConstraint),'FamilyName') && isfield(OneField(ii,jj).(Family).(FieldConstraint),'Data')
                                            S = OneField(ii,jj).(Family).(FieldConstraint);
                                            Found = 1;
                                            break       
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if Found
                    break;
                end
            end
            if Found
                break;
            end    
        end
    catch
    end
    if Found
        break;
    end
end

if ~Found
    error('Could not find the data structure');
end


% If a DeviceList exists, index .Data, .Status, and .DeviceList
if ~isempty(DeviceList)
    if size(DeviceList,2) == 1
        % Convert element list to a device list 
        DeviceList = elem2dev(Family, DeviceList);
    end
    
    DeviceListTotal = S.DeviceList;
    [Index, iNotFound, iMonitor] = findrowindex(DeviceList,  DeviceListTotal);
    if ~isempty(iNotFound)
        % Error if a monitor is not found
        %for i = iNotFound(:)'
        %    fprintf('   %s(%d,%d) not found\n', S.FamilyName, DeviceList(i,1), DeviceList(i,2));
        %end
        %error(sprintf('Not all the devices found in %s', FileName));
        
        % Fill the missing .Data with NaN
        Data = NaN * ones(size(DeviceList,1), size(S.Data,2));
        Data(iMonitor,:) = S.Data(Index,:);
        S.Data = Data;
        
        % Fill the missing .Status with zeros
        if length(S.Status) == 1
            S.Status = S.Status * ones(size(S.Data,1),1);
        end
        Data = zeros(size(DeviceList,1), 1);
        Data(iMonitor,:) = S.Status(Index,:);
        S.Status = Data;
    else
        S.Data   = S.Data(Index, :);
        S.Status = S.Status(Index, :);
    end
    
    % Index the device list
    S.DeviceList = DeviceList;
    
    
    % Find other fields that need to be indexed
    SFields = fieldnames(S);
    for i = 1:length(SFields)
        if size(S.(SFields{i}),1) == size(DeviceListTotal,1)
            if ~isempty(iNotFound)
                Data = NaN * ones(size(DeviceList,1), size(S.(SFields{i}),2));
                Data(iMonitor,:) = S.(SFields{i})(Index,:);
                S.(SFields{i}) = Data;
            else
                % Fill the missing .Data with NaN
                Data = NaN * ones(size(DeviceList,1), size(S.(SFields{i}),2));
                Data(iMonitor,:) = S.(SFields{i})(Index,:);
                S.(SFields{i}) = Data;
                
                %S.(SFields{i}) = S.(SFields{i})(Index,:);
            end
        end
    end
end  


% Make the output an AccObj object
if ObjectOutputFlag
    Data = AccObj(Data);
end


if ~StructOutputFlag
    S = S.Data;
end

