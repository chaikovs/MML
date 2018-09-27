function convertBPMData2CERNformat(CERNFileName,varargin)
%convertBPMData2CERNformat - Convert X and Z BPM data to ASCII file :
%  0 for H plan, 1 for V plane
%  BPM number or Device list
%  Data
%
%  INPUTS
%  1. CERNFileName - output filename
%  2. BPMStructureName - BPM data structure
%
%  OPTIONAL
%  1. 'File' - Select file with gui
%  2. 'File' followed by fileNale - Open directly the data file
%
%  EXAMPLES
%  1. convertBPMData2CERNformat('data4cernbis.txt', 'File', 'BPMTurnByTurn_2009-03-16_2kV_horizontal_ 4kV_vertical.mat')

% CERN experiment  the 29th and 30rd of March 2009
% Written by M.A. Tordeux
% Modified by Laurent S. Nadolski

DeviceFlag  = 0;
DisplayFlag = 0;
FileName = '';
FileFlag    = 0;
RawDataFlag = 1;

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'RawData')
        RawDataFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'RealData')
        RawDataFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'File')
        FileFlag = 1;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                [a a ext] = fileparts(FileName);
                if isempty(ext)
                    FileName = [FileName, '.mat'];
                end
                varargin(i+1) = [];
            end
        end
        varargin(i) = [];
    end
end

% Reads data structure if given as an input parameter
if length(varargin) > 1
    BPMStructureName = varargin{2};
    FileFlag = 0;
end

% If filename
if FileFlag
    if ~isempty(FileName) && exist(FileName, 'file')
        a = load(FileName);
        %BPMStructureName = getfield(a, 'AM');
        BPMStructureName = getfield(a, 'RawData');
    else
        DirectoryName = getfamilydata('Directory','BPMData');
        pwd_old = pwd;
        cd(DirectoryName);
        [Filename PathName] = uigetfile('BPMTurnByTurn*');
        cd(pwd_old);
        if  isequal(FileName,0)
            disp('User pressed cancel')
            exit(0);
        else
            a = load(fullfile(PathName, Filename));
            %AM = getfield(a, 'AM');
            AM = getfield(a, 'RawData');
        end
    end%
end

% Check if output file alread exists
if exist(CERNFileName, 'file')
    text = sprintf('Filename %s already exists. Continue (y/N) ? \n', CERNFileName);
    reply = input(text, 's');
    if isempty(reply) || ~strcmpi(reply, 'Y')
       fprintf('Action aborted\n')
        return;
    end
end

fid = fopen(CERNFileName, 'wt');
BPMStructureName.Data;
BPMStructureName.DeviceList;
if RawDataFlag
    DataLength = size(BPMStructureName.Data.X, 2);
else
    DataLength = size(BPMStructureName.Data.Xreal, 2);
end
%DataLength = 2000;
BPMListLength = size(BPMStructureName.DeviceList,1); % nombre de lignes (au cas où un seul BPM)

fprintf(fid, '#Synchrotron SOLEIL: %s \n', datestr(clock));  % plan H
F1 = repmat('% 6.4e ',1, DataLength); % format avec repere des BPM par le numéro du BPM
F0 = '%3d ';
strElemList = [F0 ' bpm%03d %6.3f ' F1 '\n'];
strDeviceList = [ F0 F0 F0 F1 '\n'];

if DeviceFlag
    %% format avec repere des BPM par la DeviceList
    for ibpm = 1:BPMListLength,
        if RawDataFlag
            fprintf(fid, strDeviceList, 0, BPMStructureName.DeviceList(ibpm,1), BPMStructureName.DeviceList(ibpm,2),BPMStructureName.Data.X(ibpm,1:DataLength));  % plan H
            fprintf(fid, strDeviceList, 1, BPMStructureName.DeviceList(ibpm,1), BPMStructureName.DeviceList(ibpm,2),BPMStructureName.Data.Z(ibpm,1:DataLength));  % plan V
        else
            fprintf(fid, strDeviceList, 0, BPMStructureName.DeviceList(ibpm,1), BPMStructureName.DeviceList(ibpm,2),BPMStructureName.Data.Xreal(ibpm,1:DataLength));  % plan H
            fprintf(fid, strDeviceList, 1, BPMStructureName.DeviceList(ibpm,1), BPMStructureName.DeviceList(ibpm,2),BPMStructureName.Data.Zreal(ibpm,1:DataLength));  % plan V
        end
    end
else

    %% format avec repere des BPM par le numéro du BPM
    ElementList =  dev2elem('BPMx', BPMStructureName.DeviceList);
    spos = getspos('BPMx', BPMStructureName.DeviceList);
    for ibpm = 1:BPMListLength
        if RawDataFlag
            fprintf(fid, strElemList, 0, ElementList(ibpm), spos(ibpm), BPMStructureName.Data.X(ibpm, 1:DataLength));  % plan H
            fprintf(fid, strElemList, 1, ElementList(ibpm), spos(ibpm), BPMStructureName.Data.Z(ibpm, 1:DataLength));  % plan V
        else
            fprintf(fid, strElemList, 0, ElementList(ibpm), spos(ibpm), BPMStructureName.Data.Xreal(ibpm, 1:DataLength));  % plan H
            fprintf(fid, strElemList, 1, ElementList(ibpm), spos(ibpm), BPMStructureName.Data.Zreal(ibpm, 1:DataLength));  % plan V
        end
    end
end

fclose(fid)
disp('end')
