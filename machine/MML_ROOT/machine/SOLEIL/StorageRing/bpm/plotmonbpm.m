function BPM = plotmonbpm(varargin)
%PLOTMONBPM - plot BPM noise data archived
%
%  INPUTS
%  1. FileName
%
%  See Also monbpm

%
% Written by Laurent S. Nadolski

SummaryFlag = 1;
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Summary')
        SummaryFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoSummary')
        SummaryFlag = 0;
        varargin(i) = [];
    end
end

if length(varargin) <1
    FileName = '';
else
    FileName = varargin{1};
end


if isempty(FileName)
    DirectoryName = getfamilydata('Directory','BPMData');
    if isempty(DirectoryName)
        DirectoryName = [getfamilydata('Directory','DataRoot'), filesep, 'BPM', filesep];
    else
        % Make sure default directory exists
        DirStart = pwd;
        [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
        cd(DirStart);
    end
    [FileName, DirectoryName] = uigetfile('*.mat', 'Select a BPM Monitor File', [DirectoryName FileName]);
    FileName = fullfile(DirectoryName, FileName);
elseif FileName == -1
    FileName = appendtimestamp('BPMData');
    DirectoryName = getfamilydata('Directory','BPMData');
    if isempty(DirectoryName)
        DirectoryName = [getfamilydata('Directory','DataRoot'), filesep, 'BPM', filesep];
    end
    FileName = [DirectoryName, FileName];
end

if exist(FileName, 'file') ~=2
    error('File does not exist');
end

A = load(FileName);
if ~isfield(A, 'BPMxData') || ~isfield(A, 'BPMxData')
    error('Wrong file, no BPM data')
end

BPM(1) = A.BPMxData;
BPM(2) = A.BPMyData;

% Compute the standard deviation

% Low frequency drifting increases the STD.  For many purposes, like LOCO,
% this is not desireable.  Using difference orbits mitigates the drift problem.



% plot part
figure
subplot(2,2,1);

tout = BPM(1).tout;
Mx = BPM(1).Data;
% Orbit compared to first set
for i = 1:size(Mx,2)
    Mx(:,i) = Mx(:,i) - BPM(1).Data(:,1);
end

plot(tout, Mx);
grid on;
%title(sprintf('BPM Data (%s)', datestr(BPM(1).TimeStamp)))
xlabel('Time [Seconds]');
ylabel('Horizontal Relative Position [mm]');


tout = BPM(2).tout;
% Orbit compared to first set
My = BPM(2).Data;
for i = 1:size(My,2)
    My(:,i) = My(:,i) -  BPM(2).Data(:,1);
end

subplot(2,2,3);
plot(tout, My);
grid on;
xlabel('Time [Seconds]');
ylabel(sprintf('Vertical Position [%s]', BPM(2).UnitsString));

subplot(2,2,2);
List = BPM(1).DeviceList;
Nsectors = max(List(:,1));
Ndevices = max(List(:,2));
Sector = List(:,1) + List(:,2)/Ndevices + 1/Ndevices/2;
[Sector Idx] = sort(Sector);
plot(Sector, BPM(1).Sigma(Idx));
grid on;
xaxis([1 Nsectors+1])
set(gca,'XTick',1:Nsectors);
xlabel('Sector Number');
ylabel(sprintf('Horizontal STD [%s]', BPM(1).UnitsString));

subplot(2,2,4);
List = BPM(2).DeviceList;
Nsectors = max(List(:,1));
Ndevices = max(List(:,2));
Sector = List(:,1) + List(:,2)/Ndevices + 1/Ndevices/2;
[Sector Idx] = sort(Sector);
plot(Sector, BPM(2).Sigma(Idx));
grid on;
xaxis([1 Nsectors+1])
set(gca,'XTick',1:Nsectors);
xlabel('Sector Number');
ylabel(sprintf('Vertical STD [%s]', BPM(2).UnitsString));

addlabel(.5,1,sprintf('BPM Data (%s)', datestr(BPM(1).TimeStamp)), 10);
orient landscape

%plot fit of the dispersion in the H-plane
figure
spos = getspos('BPMx',BPM(1).DeviceList);
etax = modeldisp('BPMx',BPM(1).DeviceList);
% y = disp*delta + y0
x = lsqr([etax ones(size(BPM(1).Sigma))], BPM(1).Sigma*1e-3); % m
plot(spos, BPM(1).Sigma); hold on
plot(spos,(etax*x(1)+x(2))*1e3,'r'); hold on
legend('Data', 'fit')
title(sprintf('Noise in H-plane: Delta = %.2f %% (x0=%.2e mm)', x(1)*100, x(2)*1e3));
xlabel('s-position (m)')
ylabel('RMS x (mm)')

if SummaryFlag
    % Low frequency drifting increases the STD.  For many purposes, like LOCO,
    % this is not desireable.  Using difference orbits mitigates the drift problem.
    Mx = BPM(1).Data;
    for i = 1:size(Mx,2)-1
        Mx(:,i) = Mx(:,i+1) - Mx(:,i);
    end
    Mx(:,end) = [];

    My = BPM(2).Data;
    for i = 1:size(My,2)-1
        My(:,i) = My(:,i+1) - My(:,i);
    end
    My(:,end) = [];

    BPM(1).Sigma = std(Mx,0,2) / sqrt(2);   % sqrt(2) comes from substracting 2 random variables
    BPM(2).Sigma = std(My,0,2) / sqrt(2);


    [SortedData1 DataIdx1] = sort(BPM(1).Sigma,'descend');
    SortedDeviceList1 = BPM(1).DeviceList(DataIdx1,:);
    [SortedData2 DataIdx2] = sort(BPM(2).Sigma,'descend');
    SortedDeviceList2 = BPM(2).DeviceList(DataIdx2,:);

    % sort by drift
    maxBPM1 =  max(abs(Mx),[],2);
    [SortedData3 DataIdx3] = sort(maxBPM1,'descend');
    SortedDeviceList3 = BPM(1).DeviceList(DataIdx3,:);
    maxBPM2 =  max(abs(My),[],2);
    [SortedData4 DataIdx4] = sort(maxBPM2,'descend');
    SortedDeviceList4 = BPM(2).DeviceList(DataIdx4,:);

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
    [SortedData1 DataIdx1] = sort(BPM(1).Sigma,'descend');
    SortedDeviceList1 = BPM(1).DeviceList(DataIdx1,:);
    [SortedData2 DataIdx2] = sort(BPM(2).Sigma,'descend');
    SortedDeviceList2 = BPM(2).DeviceList(DataIdx2,:);

    % sort by drift
    maxBPM1 =  max(abs(Mx),[],2);
    [SortedData3 DataIdx3] = sort(maxBPM1,'descend');
    SortedDeviceList3 = BPM(1).DeviceList(DataIdx3,:);
    maxBPM2 =  max(abs(My),[],2);
    [SortedData4 DataIdx4] = sort(maxBPM2,'descend');
    SortedDeviceList4 = BPM(2).DeviceList(DataIdx4,:);

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