function plotgoldenorbit(varargin)
%PLOTGOLDENORBIT - Plots the golden orbit 
%  plotgoldenorbit(XAxisFlag)
%
%  INPUTS
%  1. XAxisFlag - 'Position' in meters {Default} or 'Phase'
%  2. PBpmz - add golden value of XBPM in outpuVector Default is False    
%  3. Print - Print Golden Data in temporaryFile Default is False
%  4. File - openfile selection dialogbox
%  ex: 
%       plotgoldenorbit
%       plotgoldenorbit('Print')
%       plotgoldenorbit('Phase','Print')
%       plotgoldenorbit('Position')
%       plotgoldenorbit('PBpmz') 
%
%  See Also plotoffsetorbit, getgolden, setgolden, savegoldenorbit

%
%  Written by Gregory J. Portmann
%  Modify by Laurent S. Nadolski
%  Modify by A.Bence

XAxisFlag = 'Position';
PrintFlag = 0;
PBpmzFlag=0;
FileFlag=0;
% Input parsing
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignore structures
    elseif iscell(varargin{i})
        % Ignore cells
    elseif strcmpi(varargin{i},'struct')
        % Just remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        % Just remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Position')
        XAxisFlag = 'Position';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Phase')
        XAxisFlag = 'Phase';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Print')
        PrintFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'PBpmz')
        PBpmzFlag = 1;
        varargin(i) = [];     
    elseif strcmpi(varargin{i},'File')
        FileFlag = 1;
        varargin(i) = [];     
    end
end

% Default orbit families
BPMxFamily = gethbpmfamily;
if PBpmzFlag
    BPMyFamily = 'PBPMz';
else 
    BPMyFamily = getvbpmfamily;
end    

% Get data
if FileFlag
    DirectoryName=getfamilydata('Directory','BPMGolden');
    FileName_ = uigetfile(DirectoryName); 
    FileName = fullfile(DirectoryName, FileName_);
    FileStruct1 = load(FileName);
    % if first file contains XBPM, then ask for BPM data
    if strcmp(FileStruct1.Data2.FamilyName,'PBPMz')
        PBpmzFlag=1;
        BPMyFamily = 'PBPMz';
        FileName_=uigetfile(DirectoryName,'Please Select the BPMFile');
        FileName = fullfile(DirectoryName, FileName_);
        FileStruct2 = load(FileName);
        Xoffset=FileStruct2.Data1.Data; 
        Yoffset=FileStruct2.Data2.Data;
        FileDeviceList = FileStruct2.Data1.DeviceList;
        xbpm=FileStruct1.Data2.Data;
        xbpm_index=find(getfamilydata('PBPMz','Type')==0); % check for xbpm in the family
        for i=1:size(xbpm_index,1), % insert xbpm golden data in the BPM golden data
            Yoffset = [Yoffset(1:xbpm_index(i)-1,:)' xbpm(i,:)' Yoffset(xbpm_index(i):size(Yoffset,1),:)']';
            Xoffset = [Xoffset(1:xbpm_index(i)-1,:)' NaN Xoffset(xbpm_index(i):size(Xoffset,1),:)']';
            FileDeviceList = [FileDeviceList(1:xbpm_index(i)-1,:) ; FileStruct1.Data1.DeviceList(i,:); FileDeviceList(xbpm_index(i):size(FileDeviceList,1),:)];
        end
        TimeStamp1=FileStruct2.Data1.TimeStamp;
        TimeStamp2=FileStruct1.Data2.TimeStamp;
    else    
        Xoffset=FileStruct1.Data1.Data;
        Yoffset=FileStruct1.Data2.Data ;
        TimeStamp1=FileStruct1.Data1.TimeStamp;
        TimeStamp2=FileStruct1.Data2.TimeStamp;
    end
else    
    Xoffset = getgolden(BPMxFamily);
    Yoffset = getgolden(BPMyFamily);
    TimeStamp1=getfamilydata(BPMxFamily,'GoldenTimeStamp');
    TimeStamp2=getfamilydata(BPMyFamily,'GoldenTimeStamp');
end

if PrintFlag
    FileName=tempname;
    fid=fopen(FileName,'w');
    fprintf(fid, datestr(TimeStamp1,'DD-mm-YYYY HH:MM:SS'));
    fprintf(fid,'\nGolden = [\n');
    if FileFlag
        fprintf(fid,'%3d %3d  %10.6f  %10.6f\n', [FileDeviceList,Xoffset, Yoffset]');
    else
        fprintf(fid,'%3d %3d  %10.6f  %10.6f\n', [family2dev(BPMyFamily),Xoffset, Yoffset]');
    end
    %fprintf(fid,'%3d %3d  %10.6f  %10.6f\n', [family2dev(BPMyFamily),getgolden(BPMxFamily), getgolden(BPMyFamily)]');
    fprintf(fid,'];');
    fclose(fid);
    open(FileName);
end   


if strcmpi(XAxisFlag, 'Phase')
    if exist('FileStruct1', 'var')
        [BPMxspos, BPMyspos, Sx, Sy, Tune] = modeltwiss('Phase', BPMxFamily, FileStruct1.Data1.DeviceList, BPMyFamily, FileStruct1.Data2.DeviceList);
    else
        [BPMxspos, BPMyspos, Sx, Sy, Tune] = modeltwiss('Phase', BPMxFamily, [], BPMyFamily, []);
    end
    BPMxspos = BPMxspos/2/pi;
    BPMyspos = BPMyspos/2/pi;
    XLabel = 'BPM Phase';
else
    if exist('FileStruct1', 'var')
        if PBpmzFlag == 0,
            BPMxspos = getspos(BPMxFamily, FileStruct1.Data1.DeviceList);
        else
            BPMxspos = getspos(BPMxFamily, FileStruct2.Data1.DeviceList);
        end
        BPMyspos = getspos(BPMyFamily, FileStruct1.Data2.DeviceList);
    else
        BPMxspos = getspos(BPMxFamily, family2dev(BPMxFamily));
        BPMyspos = getspos(BPMyFamily, family2dev(BPMyFamily));
    end
    XLabel = 'BPM Position [meters]';
end

% Change to physics units
if any(strcmpi('Physics',varargin))
    Xoffset = hw2physics(BPMxFamily, 'Monitor', Xoffset, family2dev(BPMxFamily));
    Yoffset = hw2physics(BPMyFamily, 'Monitor', Yoffset, family2dev(BPMyFamily));
end

UnitsString = getfamilydata(BPMxFamily, 'Monitor', 'HWUnits');

clf reset

subplot(2,1,1);
if isempty(BPMyspos)
    plot(Xoffset, '.-');
    ylabel(sprintf('Horizontal [%s]',UnitsString));
    title(strcat('Golden Orbit:BPM  ',datestr(TimeStamp1)));
    xlabel('BPMx Position [meters]');
    grid on
    subplot(2,1,2);
    plot(Yoffset, '.-');
     xlabel('PBPMz Position [meters]');
else
    plot(BPMxspos, Xoffset, '.-');
    ylabel(sprintf('Horizontal [%s]',UnitsString));
    title(strcat('Golden Orbit: ',datestr(TimeStamp1)));
    xlabel(XLabel);
    grid on
    subplot(2,1,2);
    plot(BPMyspos, Yoffset, '.-');
    xlabel(XLabel);
end
ylabel(sprintf('Vertical [%s]',UnitsString));
grid on 

orient tall

