function [AM, tout, DataTime, ErrorFlag] = gety(varargin)
%GETY - Returns the vertical orbit
%  [AM, tout, DataTime]  = gety(DeviceList, t, FreshDataFlag, TimeOutPeriod)
%         or
%  [AM, tout, DataTime]  = gety(DataStructure, t, FreshDataFlag, TimeOutPeriod)
%
%  INPUTS
%  1. DeviceList or DataStructure  (see help getpv)
%  2. t  (see help getpv)
%  3. FreshDataFlag  (see help getpv)
%  4. TimeOutPeriod  (see help getpv)
%  5. 'Struct' will return a data structure
%     'Numeric' will return a vector output {default}
%  6. 'Archive' will save a BPM data structure to \<DataRoot>\BPM\
%      with filename BPMy<Date><Time>.mat
%
%  OUTPUTS
%  1. AM = orbit vector or data structure
%  2. tout  (see help getpv)
%  3. DataTime
%
%  NOTE
%  1. 'Struct', 'Numeric', and 'Archive' are not case sensitive
%  2. All inputs are optional
%
%  EXAMPLE
%  1. <a href="matlab: plot(getspos(getvbpmfamily),gety); xlabel('BPM Position [meters]'); ylabel('Vertical Orbit');">plot(gety);</a>
%
%  See also getx, getbpm, getam, getpv
%
%  Written by Greg Portmann


Family = getvbpmfamily;


% Get input flags
StructOutputFlag = 0;
ArchiveFlag = 0;
for i = length(varargin):-1:1
    if isstr(varargin{i})
        if strcmpi(varargin{i},'struct')
            StructOutputFlag = 1;
            %varargin(i) = [];
        elseif strcmpi(varargin{i},'numeric')
            StructOutputFlag = 0;
            %varargin(i) = [];
        elseif strcmpi(varargin{i},'archive')
            ArchiveFlag = 1;
            varargin(i) = [];
        end
    end
end


% Get data
if isempty(varargin)
    [AM, tout, DataTime, ErrorFlag] = getpv(Family, 'Monitor');
elseif isstruct(varargin{1})
    [AM, tout, DataTime, ErrorFlag] = getpv(varargin{:});
else
    [AM, tout, DataTime, ErrorFlag] = getpv(Family, 'Monitor', varargin{:});
end

if StructOutputFlag
    % Structure output
    AM.CreatedBy = 'gety';
    AM.DataDescriptor = 'Vertical Orbit';
end


% Archive data structure
if ArchiveFlag
    DirStart = pwd;
    FileName = appendtimestamp([getfamilydata('Default', 'BPMArchiveFile') 'y'], clock);
    DirectoryName = getfamilydata('Directory','BPMData');
    if isempty(DirectoryName)
        DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM\'];
    end
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    BPMyData = gety('struct');
    save(FileName, 'BPMyData');
    cd(DirStart);
end
