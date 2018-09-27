function monbpmhistory(varargin)
% monbpmhistory - Read history buffer of all the BPMs
%
%  INPUTS
%  2 and 4. BPMxFamily and BPMyFamily are the family names of the BPM's, {Default or []: the entire list}
%  3 and 5. BPMxList and BPMyList are the device list of BPM's, {Default or []: the entire list}
%  6. 'Struct'  will return data structures instead of vectors
%     'Numeric' will return vector outputs {Default}
%  7.  FileName = Filename (including directory) where the data was saved (if applicable)
%  8. 'Archive'   - save a data array structure to \<BPMData Directory>\<BPMData><Date><Time>.mat  {Default}
%     'NoArchive' - no data will be saved to file
%     'Summary' - Sort BPM by decreasind STD value
%
%  OUTPUTS
%  For numeric output:
%  1-2. BPMx and BPMy are the raw orbit data matrices or structures 
%  3. DCCT is a row vector containing the beam current
%  4. tout is a row vector of times as returned by getam           
%  5-6. BPMxSTD and BPMySTD are standard deviation of the difference orbits
%  7. FileName = Filename (including directory) where the data was saved (if applicable)
%
%  For structures:
%  BPMxSTD and BPMySTD are the .Sigma field 

% Written by Laurent S. Nadolski
% TODO Not all options are operational

FileName = -1;
ArchiveFlag = 0;
StructOutputFlag = 0;
DisplayFlag=1;
SummaryFlag = 1;

% Look if 'struct' or 'numeric' in on the input line
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Struct')
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Numeric')
        StructOutputFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Archive')
        ArchiveFlag = 1;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                varargin(i+1) = [];
            end
        end
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoArchive')
        ArchiveFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Summary')
        SummaryFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoSummary')
        SummaryFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    end
end

%%
if isempty(varargin)
    BPM(1).DeviceList = family2dev('BPMx');
    BPM(2).DeviceList = family2dev('BPMz');
    devName = family2tangodev('BPMx');
else
    BPM(1).DeviceList = varargin{:};
    BPM(2).DeviceList = varargin{:};
    devName = family2tangodev('BPMx',varargin{:});
end

%%
Xpos = [];
Zpos = [];
Xrmspos = [];
Zrmspos = [];

TimeStart = gettime;

for k = 1:length(devName),
    %rep = tango_read_attributes(devName{k},{'XPosSAHistory','ZPosSAHistory','XRMSPosSA','ZRMSPosSA'});
    rep = tango_read_attributes(devName{k},{'XPosSAHistory','ZPosSAHistory'});
    Xpos(:,k) = rep(1).value;
    Zpos(:,k) = rep(2).value;
end

BPM(1).Data = Xpos;
BPM(2).Data = Zpos;
BPM(1).Sigma = std(Xpos);
BPM(2).Sigma = std(Zpos);
BPM(1).UnitsString = 'mm';
BPM(2).UnitsString = 'mm';

xtime = (1:size(Xpos,1))/10;

if ArchiveFlag
    if isempty(FileName)
        FileName = appendtimestamp('BPMDataHistory');
        DirectoryName = getfamilydata('Directory','BPMData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot'), filesep, 'BPM', filesep];
        else
            % Make sure default directory exists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [FileName, DirectoryName] = uiputfile('*.mat', 'Select a BPM Monitor File', [DirectoryName FileName]);
        if FileName == 0
            ArchiveFlag = 0;
            fprintf('   monbpm canceled\n');
            varargout{1} = [];
            return
        end
        FileName = [DirectoryName, FileName];
    elseif FileName == -1
        FileName = appendtimestamp('BPMDataHistory');
        DirectoryName = getfamilydata('Directory','BPMData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot'), filesep, 'BPM', filesep];
        end
        FileName = [DirectoryName, FileName];
    end
end


%

if DisplayFlag
    List = BPM(1).DeviceList;
    Nsectors = max(List(:,1));
    Ndevices = max(List(:,2));Sector = List(:,1) + List(:,2)/Ndevices + 1/Ndevices/2;
    [Sector Idx] = sort(Sector);
    figure
    subplot(2,2,1)
    plot(xtime, BPM(1).Data-repmat(BPM(1).Data(1,:),size(BPM(1).Data,1),1))
    xaxis([1 size(BPM(1).Data,1)/10])
    ylabel('DX (mm)')
    xlabel('time [s]')
    grid on
    subplot(2,2,2)
    plot(Sector,BPM(1).Sigma)
    xaxis([1 Nsectors+1])
    set(gca,'XTick',1:Nsectors);
    xlabel('Sector Number');
    ylabel(sprintf('Horizontal STD [%s]', BPM(1).UnitsString));
    grid on
    subplot(2,2,3)
    plot(xtime, BPM(2).Data-repmat(BPM(2).Data(1,:),size(BPM(2).Data,1),1))
    xaxis([1 size(BPM(2).Data,1)/10])
    ylabel('DZ (mm)')
    xlabel('time [s]')
    grid on
    subplot(2,2,4)
    plot(Sector,BPM(2).Sigma)
    xaxis([1 Nsectors+1])
    set(gca,'XTick',1:Nsectors);
    xlabel('Sector Number');
    ylabel(sprintf('Horizontal STD [%s]', BPM(1).UnitsString));
    grid on

    addlabel(datestr(tango_shift_time(rep(2).time)));
end

% Save data in the proper directory
if ArchiveFlag | ischar(FileName)
    [DirectoryName, FileName, Ext] = fileparts(FileName);
    DirStart = pwd;
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    if ErrorFlag
        fprintf('\n   There was a problem getting to the proper directory!\n\n');
    end
    BPMxData = BPM(1);
    BPMyData = BPM(2);
    save(FileName, 'BPMxData', 'BPMyData');
    %save(FileName, 'BPM');
    cd(DirStart);
    FileName = [DirectoryName, FileName, '.mat'];

    if DisplayFlag
        fprintf('   BPM data saved to %s\n', FileName);
        fprintf('   The total measurement time was %.2f minutes.\n', (gettime-TimeStart)/60);
    end
else
    FileName = '';
end


if SummaryFlag
    % sort by sigmas
    [SortedData1 DataIdx1] = sort(BPM(1).Sigma,'descend');
    SortedDeviceList1 = BPM(1).DeviceList(DataIdx1,:);
    [SortedData2 DataIdx2] = sort(BPM(2).Sigma,'descend');
    SortedDeviceList2 = BPM(2).DeviceList(DataIdx2,:);

    % sort by drift
    maxBPM1 = max(abs(BPM(1).Data-repmat(BPM(1).Data(1,:),size(BPM(1).Data,1),1)));
    [SortedData3 DataIdx3] = sort(maxBPM1,'descend');
    SortedDeviceList3 = BPM(1).DeviceList(DataIdx1,:);
    maxBPM2 = max(abs(BPM(2).Data-repmat(BPM(2).Data(1,:),size(BPM(2).Data,1),1)));
    [SortedData4 DataIdx4] = sort(maxBPM2,'descend');
    SortedDeviceList4 = BPM(2).DeviceList(DataIdx1,:);
    
    fprintf('\n\n BPMxname DevList     Max drift           BPMzname DevList       Max drift\n');
    for k=1:size(BPM(1).DeviceList,1),
        fprintf('%s    [%2d %2d]      %6.2e [%s]        %s    [%2d %2d]      %6.2e [%s] \n', ...
            'BPMx', SortedDeviceList3(k,1), SortedDeviceList3(k,2), SortedData3(k), BPM(1).UnitsString, ...
            'BPMz', SortedDeviceList4(k,1), SortedDeviceList4(k,2), SortedData4(k), BPM(2).UnitsString);
    end

    fprintf('\n\n BPMxname DevList     STD value           BPMzname DevList       STD value\n');
    for k=1:size(BPM(1).DeviceList,1),
        fprintf('%s    [%2d %2d]      %6.2e [%s]        %s    [%2d %2d]      %6.2e [%s] \n', ...
            'BPMx', SortedDeviceList1(k,1), SortedDeviceList1(k,2), SortedData1(k), BPM(1).UnitsString, ...
            'BPMz', SortedDeviceList2(k,1), SortedDeviceList2(k,2), SortedData2(k), BPM(2).UnitsString);
    end
end

if StructOutputFlag
    % Output variables
    varargout{1} = BPM(1);    
    varargout{2} = BPM(2);    
    varargout{3} = FileName;
else
    % Output variables
    varargout{1} = BPM(1).Data;
    varargout{2} = BPM(2).Data;
    varargout{3} = 0; % tout
    varargout{4} = 0; %DCCT;
    varargout{5} = BPM(1).Sigma;
    varargout{6} = BPM(2).Sigma;
    varargout{7} = FileName;
end

