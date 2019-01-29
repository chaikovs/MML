function [BPMx, BPMy] = plotorbitdata(varargin)
%PLOTORBITDATA - Plots BPM statistics
%  [BPMx, BPMy] = plotorbitdata(FileName)
%
%  INPUTS
%  1.  FileName = Filename (w/ or w/o directory) where the data was saved
%      If empty then search for a file in the default BPM directory.
%      If '.' then search for a file in the present directory.
%
%  OUTPUTS
%  For numeric output:
%  1. BPMx - Horizontal data structure
%  2. BPMy - Vertical data structure

%
%  Written by Gregory J. Portmann
%  Modified by Laurent S. Nadolski

BPMxFamily = gethbpmfamily;
BPMyFamily = getvbpmfamily;

FileName = [];
if nargin >= 1
    FileName = varargin{1};
end


if isstruct(FileName)
    BPMx = FileName;
    if nargin >= 2
        BPMy = varargin{2};
    else
        BPMy = BPMx;
    end
    % BPM response matrix cludge
    if all(size(BPMx) == [2 2])
        BPMx = BPMx(1,1);
    end
else
    DirFlag = 0;
    if isdir(FileName)
        DirFlag = 1;
    else
        if length(FileName)>=1
            if strcmp(FileName(end),filesep)
                DirFlag = 1;
            end
        end
    end
    if strcmp(FileName,'.') || isempty(FileName) || DirFlag
        % Data root
        if strcmp(FileName,'.')
            [FileName, DirectoryName] = uigetfile('*.mat', 'Select a file to analyze');
        elseif DirFlag
            [FileName, DirectoryName] = uigetfile('*.mat', 'Select a file to analyze', FileName);
        else
            DirectoryName = getfamilydata('Directory','DataRoot');
            [FileName, DirectoryName] = uigetfile('*.mat', 'Select a file to analyze', DirectoryName);
        end
        if FileName == 0
            return
        end
        FileName = [DirectoryName FileName];
    end
    
    
    % Get data from file
    try
        BPMx = getdata(BPMxFamily, FileName, 'Struct');
        BPMy = getdata(BPMyFamily, FileName, 'Struct');
    catch
        try
            % BPM response
            BPMy = getbpmresp('Filename', FileName, 'Struct');
            BPMx = BPMy(1,1);
        catch
            try
                % Dispersion
                BPMx = getrespmat(BPMxFamily, 'RF', FileName, 'Struct');
                BPMy = getrespmat(BPMyFamily, 'RF', FileName, 'Struct');
            catch
                try
                    % Chromaticity
                    BPMx = load(FileName);
                catch
                    disp('Not sure what type of file this is');
                    return
                end
            end
        end
    end
end



if isfield(BPMx, 'CreatedBy') && (strcmpi(BPMx.CreatedBy, 'monbpm') || ...
        strcmpi(BPMx.CreatedBy, 'measbpmsigma'))
    
    if strcmpi(BPMx.CreatedBy, 'monbpm') 
        % Definition of standard deviations
        BPMxStd = std(BPMx.Data, 0, 2);
        BPMyStd = std(BPMy.Data, 0, 2);
        
        % Difference orbit sigma
        BPMxSigma = BPMx.Sigma;
        BPMySigma = BPMy.Sigma;
        
        Mx = BPMx.Data;
        My = BPMy.Data;
        
        tout = BPMx.tout;
    elseif strcmpi(BPMx.CreatedBy, 'measbpmsigma')
        % Definition of standard deviations
        BPMxStd = std(BPMx.RawData, 0, 2);
        BPMyStd = std(BPMy.RawData, 0, 2);
        
        % Difference orbit sigma
        BPMxSigma = BPMx.Data;
        BPMySigma = BPMy.Data;
        
        Mx = BPMx.RawData;
        My = BPMy.RawData;
        
        tout = BPMx.DCCT.tout;
    else
        error('Not sure how to analyze this file');
    end
    
    
    Mx0 = Mx(:,1);
    for i = 1:size(Mx,2)
        Mx(:,i) = Mx(:,i) - Mx0;
    end      
    
    %tout = BPMy.tout;
    My0 = My(:,1);
    for i = 1:size(My,2)
        My(:,i) = My(:,i) - My0;
    end
    
    BPMxMax = max(Mx, [], 2);
    BPMyMax = max(My, [], 2);
    
    BPMxMin = min(Mx, [], 2);
    BPMyMin = min(My, [], 2);
        
    [Sector, Nsectors, Ndevices] = sectorticks(BPMx.DeviceList);
    
    h = gcf;
    figure(h);
    clf reset
    subplot(2,2,1);
    plot(tout, Mx);
    grid on;
    xaxis([0 max(tout)]);
    xlabel('Time [Seconds]');
    ylabel(sprintf('Horizontal Data [%s]', BPMx.UnitsString));
    
    subplot(2,2,3);
    plot(tout, My);
    grid on;
    xaxis([0 max(tout)]);
    xlabel('Time [Seconds]');
    ylabel(sprintf('Vertical Data [%s]', BPMx.UnitsString));
    
    subplot(2,2,2);
    plot(Sector, abs(BPMxMax),'k');
    hold on
    plot(Sector, abs(BPMxMin),'r');
    plot(Sector, BPMxStd,'g');
    plot(Sector, BPMxSigma,'b');
    hold off
    grid on;
    xaxis([1 Nsectors+1])
    set(gca,'XTick',1:Nsectors);
    xlabel('Sector Number');
    ylabel(sprintf('Horizontal [%s]', BPMx.UnitsString));
    legend('abs(Max)','abs(Min)','std(Data)', 'std(Difference Orbits)',0)
    
    subplot(2,2,4);
    plot(Sector, abs(BPMyMax),'k');
    hold on
    plot(Sector, abs(BPMyMin),'r');
    plot(Sector, BPMyStd,'g');
    plot(Sector, BPMySigma,'b');
    hold off
    grid on;
    xaxis([1 Nsectors+1])
    set(gca,'XTick',1:Nsectors);
    xlabel('Sector Number');
    ylabel(sprintf('Vertical [%s]', BPMx.UnitsString));
    legend('abs(Max)','abs(Min)','std(Data)', 'std(Difference Orbits)',0)
    
    addlabel(.5,1,sprintf('BPM Data'), 10);
    addlabel(1,0,sprintf('%s', datestr(BPMx.TimeStamp)));
    orient landscape  
    
    h = h + 1;
    
    figure(h);
    clf reset
    subplot(2,1,1);
    bar(Sector, BPMxSigma);
    grid on;
    xaxis([1 Nsectors+1])
    set(gca,'XTick',1:Nsectors);
    xlabel('Sector Number');
    ylabel(sprintf('Horizontal STD [%s]', BPMx.UnitsString));
    title(sprintf('BPM Standard Deviation of Difference Orbits / sqrt(2)'));
    
    subplot(2,1,2);
    bar(Sector, BPMySigma);
    grid on;
    grid on;
    xaxis([1 Nsectors+1])
    set(gca,'XTick',1:Nsectors);
    xlabel('Sector Number');
    ylabel(sprintf('Vertical STD [%s]', BPMx.UnitsString));
    addlabel(1,0,sprintf('%s', datestr(BPMx.TimeStamp)));
    orient tall
    
elseif isfield(BPMx, 'DataDescriptor') && strcmpi(BPMx.DataDescriptor, 'Dispersion')
    plotdisp(BPMx, BPMy);
    
elseif isfield(BPMx, 'DataDescriptor') && strcmpi(BPMx.DataDescriptor, 'Chromaticity')
    plotchro(BPMx);
    
elseif isfield(BPMx, 'DataDescriptor') && strcmpi(BPMx.DataDescriptor, 'Response Matrix')  % strcmpi(BPMx.CreatedBy, 'measbpmresp') 
    %if exist('plotbpmresp','file')
    %    plotbpmresp(BPMy);
    %end
    figure;
    clf reset
    surf([BPMy(1,1).Data BPMy(1,2).Data; BPMy(2,1).Data BPMy(2,2).Data]);
    view(-70, 65);
    title('Orbit Response Matrix');
    xlabel('CM Number');
    ylabel('BPM Number');
    addlabel(1,0,sprintf('%s', datestr(BPMy(1,1).TimeStamp)));
    
elseif isfield(BPMx, 'QMS')
    quadplot(BPMx.QMS);
    
elseif isfield(BPMx, 'Data') && isfield(BPMx, 'DataDescriptor') && isfield(BPMx, 'TimeStamp')    
    h = gcf;
    figure(h);
    clf reset
    subplot(2,1,1);
    if size(BPMx.Data,2) > 1
        plot(tout, BPMx.Data);
        xlabel('Time [Seconds]');
    else
        [Sector, Nsectors, Ndevices] = sectorticks(BPMx.DeviceList);
        plot(Sector, BPMx.Data);
        xaxis([1 Nsectors+1])
        set(gca,'XTick',1:Nsectors);
        xlabel('Sector Number');
    end
    grid on;
    ylabel(sprintf('Horizontal [%s]', BPMx.UnitsString));
    title(sprintf('%s', BPMx.DataDescriptor));
    
    subplot(2,1,2);
    if size(BPMx.Data,2) > 1
        plot(tout, BPMy.Data);
        xlabel('Time [Seconds]');
    else
        [Sector, Nsectors, Ndevices] = sectorticks(BPMy.DeviceList);
        plot(Sector, BPMy.Data);
        xaxis([1 Nsectors+1])
        set(gca,'XTick',1:Nsectors);
        xlabel('Sector Number');
    end
    grid on;
    ylabel(sprintf('Vertical [%s]', BPMx.UnitsString));
    title(sprintf('%s', BPMy.DataDescriptor));
    addlabel(1,0,sprintf('%s', datestr(BPMx.TimeStamp)));
    orient tall
    
else
    fprintf('   Not sure how to plot data file %s.\n', FileName);
end

