function FileName = plotlocodata(varargin)
%PLOTLOCODATA - Plots for comparing LOCO runs
%  plotlocodata(FileName)
%
%  INPUTS (optional)
%  1. FileName(s)  - LOCO data file name or leave blank for an inputdlg
%  2. PlotRange - Flag + [startvalue endvalue] for plot only a specified range of Data
%  3. LineType - Flag + 'String Format' if you want a specific Line Type
%  4. DK - Flag plot additionnal figure with DK/K : DK =%  KFile(N)-KFile(N-1) !you need at least to file for use this option!
%
%  ex:
%   plotlocodata('PlotRange',[10 15])
%   plotlocodata('LineType','.-b')
%   plotlocodata('DK','PlotRange',[10 15])
%   plotlocodata
%
%  See Also gcr2loco, getgain, getroll, getcrunch

%
%  Written by Greg Portmann
%  modified by A.Bence


FileName1 = '';
PlotRangeFlag = 0;
DKFlag=0;
PlotRange='';
LineType = '.-';
previousFit=[];
DiffFileName={};


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
    elseif strcmpi(varargin{i},'PlotRange')
        PlotRangeFlag = 1;
        varargin(i) = []; % remove Flag argin       
        PlotRange = cell2mat(varargin(i));            
        varargin(i) = [];  % remove Value argin   
    elseif strcmpi(varargin{i},'LineType')
        varargin(i) = []; 
        LineType = varargin(i);            
        varargin(i) = [];     
    elseif strcmpi(varargin{i},'DK')
        varargin(i) = []; 
        DKFlag = 1;
        
       
    end
end

N=0;
FileName1={};

% LOCO file #1
if length(varargin) >= 1
    for i=1:length(varargin)
    FileName1{i} = varargin{i};
    N = N+1;
    end       
else
    N = 100; % arbitrary large number instead Inf which is not good matlabwise
    FileName1{N} = '';
end

figure(101);
clf reset

figure(102);
clf reset

figure(103);
clf reset

for iFile = 1:N
    
    if isempty(FileName1{iFile})
        [FileName2, PathName] = uigetfile('*.mat', 'Select A LOCO File (cancel to stop)', [getfamilydata('Directory','DataRoot'), 'LOCO', filesep]);
        drawnow;
        if ~ischar(FileName2)
            if iFile == 1
                return;
            else
                break
            end
        else
            FileName1{iFile} = [PathName, FileName2];
            
        end
    end

    load(FileName1{iFile});
    BPMData1 = BPMData;
    CMData1 = CMData;
    FitParameters1 = FitParameters;
    LocoFlags1 = LocoFlags;
    LocoMeasData1 = LocoMeasData;
    LocoMeasData1 = LocoMeasData;
    LocoModel1 = LocoModel;
    RINGData1 = RINGData;


    % Shorten the filenames
    [PATH,NAME,EXT]=fileparts(FileName1{iFile});
    FileName1{iFile}=[NAME EXT];

    % Iteration number to plot
    i1 = length(CMData1);

    nFig = 101; %gcf;
    figure(nFig);
    %clf reset
    
    ColorOrder = get(gca,'ColorOrder');
    
    x1 = 1:length(CMData1(i1).HCMKicks);
    y1 = 1:length(CMData1(i1).VCMKicks);

    subplot(2,2,1);
    if 1 % isempty(CMData1(i1).HCMKicksSTD)
        plot(x1(CMData1(i1).HCMGoodDataIndex), CMData1(i1).HCMKicks(CMData1(i1).HCMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(x1(CMData1(i1).HCMGoodDataIndex), CMData1(i1).HCMKicks(CMData1(i1).HCMGoodDataIndex), CMData1(i1).HCMKicksSTD(CMData1(i1).HCMGoodDataIndex), LineType)
        hold on
    end
    title(sprintf('Horizontal Corrector Magnet Fits'));
    ylabel('Horizontal Kick [mrad]');
    %xlabel('Horizontal Corrector Number');
    axis tight


    subplot(2,2,2);
    if 1 % isempty(CMData1(i1).VCMKicksSTD)
        plot(y1(CMData1(i1).VCMGoodDataIndex), CMData1(i1).VCMKicks(CMData1(i1).VCMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(y1(CMData1(i1).VCMGoodDataIndex), CMData1(i1).VCMKicks(CMData1(i1).VCMGoodDataIndex), CMData1(i1).VCMKicksSTD(CMData1(i1).VCMGoodDataIndex), LineType);
        hold on
    end
    title(sprintf('Vertical Corrector Magnet Fits'));
    ylabel('Vertical Kick [mrad]');
    %xlabel('Vertical Corrector Number');
    axis tight;


    subplot(2,2,3);
    if 1 % isempty(CMData1(i1).HCMKicksSTD)
        plot(x1(CMData1(i1).HCMGoodDataIndex), CMData1(i1).HCMCoupling(CMData1(i1).HCMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(x1(CMData1(i1).HCMGoodDataIndex), CMData1(i1).HCMCoupling(CMData1(i1).HCMGoodDataIndex), CMData1(i1).HCMCouplingSTD(CMData1(i1).HCMGoodDataIndex), LineType);
        hold on
    end
    %title(sprintf('Horizontal Corrector Magnet Fits'));
    ylabel('Horizontal Coupling');
    xlabel('Horizontal Corrector Number');
    axis tight


    subplot(2,2,4);
    if 1 % isempty(CMData1(i1).VCMCouplingSTD)
        plot(y1(CMData1(i1).VCMGoodDataIndex), CMData1(i1).VCMCoupling(CMData1(i1).VCMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(y1(CMData1(i1).VCMGoodDataIndex), CMData1(i1).VCMCoupling(CMData1(i1).VCMGoodDataIndex), CMData1(i1).VCMCouplingSTD(CMData1(i1).VCMGoodDataIndex), LineType);
        hold on
    end
    %title(sprintf('Vertical Corrector Magnet Fits'));
    ylabel('Vertical Coupling');
    xlabel('Vertical Corrector Number');
    axis tight;

    % H = addlabel(0,0,sprintf('Blue-%s   Red-%s', FileName1, FileName2));
    % set(H, 'Interpreter','None');

    orient landscape




    nFig = nFig + 1;
    figure(nFig);
    %clf reset

    x1 = 1:length(BPMData1(i1).HBPMGain);
    y1 = 1:length(BPMData1(i1).VBPMGain);

    subplot(2,2,1);
    if 1 % isempty(BPMData1(i1).HBPMGainSTD)
        plot(x1(BPMData1(i1).HBPMGoodDataIndex), BPMData1(i1).HBPMGain(BPMData1(i1).HBPMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(x1(BPMData1(i1).HBPMGoodDataIndex), BPMData1(i1).HBPMGain(BPMData1(i1).HBPMGoodDataIndex), BPMData1(i1).HBPMGainSTD(BPMData1(i1).HBPMGoodDataIndex), LineType);
        hold on
    end
    title(sprintf('Horizontal BPM Fits'));
    ylabel('Horizontal Gain');
    axis tight


    subplot(2,2,2);
    if 1 % isempty(BPMData1(i1).VBPMGainSTD)
        plot(y1(BPMData1(i1).VBPMGoodDataIndex), BPMData1(i1).VBPMGain(BPMData1(i1).VBPMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(y1(BPMData1(i1).VBPMGoodDataIndex), BPMData1(i1).VBPMGain(BPMData1(i1).VBPMGoodDataIndex), BPMData1(i1).VBPMGainSTD(BPMData1(i1).VBPMGoodDataIndex), LineType);
        hold on
    end
    title(sprintf('Vertical BPM Fits'));
    ylabel('Vertical Gain');
    axis tight;


    subplot(2,2,3);
    if 1 % isempty(BPMData1(i1).HBPMGainSTD)
        plot(x1(BPMData1(i1).HBPMGoodDataIndex), BPMData1(i1).HBPMCoupling(BPMData1(i1).HBPMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(x1(BPMData1(i1).HBPMGoodDataIndex), BPMData1(i1).HBPMCoupling(BPMData1(i1).HBPMGoodDataIndex), BPMData1(i1).HBPMCouplingSTD(BPMData1(i1).HBPMGoodDataIndex), LineType);
        hold on
    end
    %title(sprintf('Horizontal Corrector Magnet Fits'));
    ylabel('Horizontal Coupling');
    xlabel('Horizontal BPM Number');
    axis tight


    subplot(2,2,4);
    if 1 % isempty(BPMData1(i1).VBPMCouplingSTD)
        plot(y1(BPMData1(i1).VBPMGoodDataIndex), BPMData1(i1).VBPMCoupling(BPMData1(i1).VBPMGoodDataIndex), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on
    else
        errorbar(y1(BPMData1(i1).VBPMGoodDataIndex), BPMData1(i1).VBPMCoupling(BPMData1(i1).VBPMGoodDataIndex), BPMData1(i1).VBPMCouplingSTD(BPMData1(i1).VBPMGoodDataIndex), LineType);
        hold on
    end
    ylabel('Vertical Coupling');
    xlabel('Vertical BPM Number');
    axis tight;

    % H = addlabel(0,0,sprintf('Blue - %s    Red - %s', FileName1, FileName2));
    % set(H, 'Interpreter','None');

    orient landscape



    nFig = nFig + 1;
    figure(nFig);
    %clf reset

    ifit = 1:length(FitParameters1(i1).Values);
    x1 = 1:length(FitParameters1(i1).Values);
    if PlotRangeFlag
        ifit= PlotRange(1):PlotRange(2);
        x1= PlotRange(1):PlotRange(2);
    end    
       
    
    %subplot(2,1,1);
    if 1 % isempty(FitParameters1(i1).ValuesSTD)
        plot(x1, FitParameters1(i1).Values(ifit), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
        hold on            
    else
        errorbar(x1, FitParameters1(i1).Values(ifit), FitParameters1(i1).ValuesSTD(ifit), LineType);
    end
    hold on
    title(sprintf('Other Parameter Fit Values'));
    ylabel('Fit Values');
    xlabel('Fit Parameter Number');
    axis tight

    if DKFlag
        nFig = nFig + 1;
        figure(nFig);
        if ~isempty(previousFit)
            DK= (FitParameters1(i1).Values(ifit)- previousFit)./FitParameters1(i1).Values(ifit);
           plot(x1,DK , LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
           DiffFileName=cat(1,DiffFileName,strcat('Diff ',FileName1{iFile},'-',previousFileName));
           hold on
         end
        previousFit=FitParameters1(i1).Values(ifit); % store FitValue for make DK in next iteration
        previousFileName=FileName1{iFile}
    end 
   
%     ifit = 23:44;
% 
%     subplot(2,1,2);
%     if 1 % isempty(FitParameters1(i1).ValuesSTD)
%         plot(x1, FitParameters1(i1).Values(ifit), LineType, 'Color', ColorOrder(mod(iFile-1,size(ColorOrder,1))+1,:));
%         hold on
%     else
%         errorbar(x1, FitParameters1(i1).Values(ifit), FitParameters1(i1).ValuesSTD(ifit), LineType);
%     end
%     hold on
%     ylabel('QD [K]');
%     axis tight


    % H = addlabel(0,0,sprintf('Blue - %s    Red - %s', FileName1, FileName2));
    % set(H, 'Interpreter','None');

    orient tall

    
    %FileName{iFile} = FileName1;
    %FileName1 = '';
    
    clear FitParameters
end
% Remove Empty Cells
FileName1(cellfun('isempty',FileName1))=[];

nFig = 101;
figure(nFig);
subplot(2,2,1);
h = legend(FileName1);
set(h,'Interpreter','none');
hold off;
subplot(2,2,2);
hold off;
subplot(2,2,3);
hold off;
subplot(2,2,4);
hold off;

nFig = nFig +1;
figure(nFig);
subplot(2,2,1);
h = legend(FileName1);
set(h,'Interpreter','none');
hold off;
subplot(2,2,2);
hold off;
subplot(2,2,3);
hold off;
subplot(2,2,4);
hold off;

nFig = nFig +1;
figure(nFig);
%subplot(2,1,1);
h = legend(FileName1);
set(h,'Interpreter','none');
hold off;
%subplot(2,1,2);
%hold off;
 if DKFlag
     nFig = nFig +1;
    figure(nFig);
    h = legend(DiffFileName);
    set(h,'Interpreter','none');
    hold off;
 end    
