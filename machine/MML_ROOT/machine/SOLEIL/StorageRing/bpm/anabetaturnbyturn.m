function [bxmeas bzmeas nux nuz] = anabetaturnbyturn(varargin)
% ANABETATURNBYTURN - Compute beta function at BPM location using turn by turn data
%
%  INPUTS
%  1. Number of turn - Default and maximum value is depth read on BPM
%  Optional input arguments
%  1. Optional display
%     'Display'   - Plot the beta function {Default if no outputs exist}
%     'NoDisplay' - Bpmdata will not be plotted {Default if outputs exist}
%  2. 'File'      - Get from File (interactive)
%                 - if Filename given as a second argument, open the specified file
%  3. 'Ref'       - Comparison with a Reference File
%
%  OUTPUTS
%  1. bxmeas - Horizontal beta funtion at BPM location
%  2. bzmeas - Vertical beta funtion at BPM location
%  3. nux - H-Tune determined by FFT
%  4. nuz - V-Tune determined by FFT
%
%  See Also getbpmrawdata, findfreq, convertBPMData2CERNformat

%
% Written by Laurent S. Nadolski

FileFlag = 0;   % Get data from a file
ReferenceFlag = 1;
DisplayFlag = 1;
FileName = '';
imax = 1026; % Default number of turn


% if no output variable, display results
if nargout > 0
    DisplayFlag = 0;
end

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Ref')
        ReferenceFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoRef')
        ReferenceFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'File')
        FileFlag = 1;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                varargin(i+1) = [];
                [pathstr,name,ext] = fileparts(FileName);
                if isempty(ext)
                    FileName = [FileName, '.mat'];
                end
            end
        end
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoArchive')
        ArchiveFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Struct')
        StructureFlag = 1;
        varargin(i) = [];
    end
end

% Check if data depth (number of turns) is provided by user
if ~isempty(varargin)
    imax = varargin{1};
end
% Get File by asking users
    
if FileFlag
    if ~isempty(FileName) && exist(FileName, 'file')
        a = load(FileName);
        AM = getfield(a, 'AM');
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
            AM = getfield(a, 'AM');
        end
    end
else % Online data
    AM = getbpmrawdata('Struct');
end

istart = 15;
iend = min(istart + imax - 1, size(AM.Data.X, 2));
Xpos = AM.Data.X(:,istart:iend)';
Zpos = AM.Data.Z(:,istart:iend)';

if DisplayFlag
    figure
    subplot(2,1,1)
    plot(Xpos-repmat(mean(Xpos), size(Xpos,1),1))
    ylabel('X [mm]')
    subplot(2,1,2)
    plot(Zpos-repmat(mean(Zpos), size(Zpos,1),1))
    ylabel('Z [mm]')
    xlabel('Turn number');
    suptitle('Turn by turn data')
end
%%
%refreshthering;
%steptune([0.005 0.0125],'Model');
[bxm bzm] = modelbeta('BPMx');
%%
ind = (1:120); % All BPMs
[nux nuz ampx ampz] = findfreq(Xpos(:,ind),Zpos(:,ind));

% fit average beta values to model
factx  = mean(bxm)/mean(ampx.*ampx);
factz  = mean(bzm)/mean(ampz.*ampz);
bxmeas = (ampx.*ampx*factx)';
bzmeas = (ampz.*ampz*factz)';

if DisplayFlag    
    figure
    av = getspos('BPMx');
    %av = [av(1:30); av(1:30); av(1:30); av(1:30)];
    h1 = subplot(2,1,1);
    plot(av,bxmeas,'b*-',av,bxm,'k.-'); hold on;
    ylabel('betax [m]'); grid on;
    h2 = subplot(2,1,2);
    plot(av,bzmeas,'b*-',av,bzm,'k.-')
    linkaxes([h1 h2], 'x');
    grid on; ylabel('betaz [m]'); xlabel('s [m]');
    suptitle('Beta function fitted at BPM position from turn by turn data (blue stars) and theory (black)')
    %tmp = bxmeas(74);  bxmeas(74) = bxmeas(75) ; bxmeas(75) = tmp;
    addlabel(sprintf('H-betabeat %3.2f %% rms V-betabeat %3.2f %% rms               %s', ...
        std((bxmeas - bxm)./bxm)*100,std((bzmeas - bzm)./bzm)*100,AM.TimeStamp));

    figure
    av = getspos('BPMx');
    h1 = subplot(5,1,[1 2]);
    plot(av,nux,'b*-'); hold on;
    ylabel('nux'); grid on;
    yaxis([.205 .215])
    h2 = subplot(5,1,3);
    drawlattice;
    h3 = subplot(5,1,[4 5]);
    plot(av,nuz,'b*-')
    linkaxes([h1 h2 h3], 'x');
    grid on; ylabel('nuz'); xlabel('s [m]');
    yaxis([.315 .325])
    suptitle(sprintf('Tunes at BPM positions from turn by turn data over %d turns', imax));
    %tmp = bxmeas(74);  bxmeas(74) = bxmeas(75) ; bxmeas(75) = tmp;
    addlabel(sprintf('H-betabeat %3.2f %% rms V-betabeat %3.2f %% rms               %s', ...
        std((bxmeas - bxm)./bxm)*100,std((bzmeas - bzm)./bzm)*100,AM.TimeStamp));

    
    figure
    h1 = subplot(5,1,[1 2]);
    plot(av,(bxmeas-bxm)./bxm*100,'k.-'); hold on;
    ylabel('betax beating [%]'); grid on;
    yaxis([-20 20])
    h2 = subplot(5,1,3);
    drawlattice;
    h3 = subplot(5,1,[4 5]);
    plot(av,(bzmeas-bzm)./bzm*100,'k.-'); hold on;
    linkaxes([h1 h2 h3], 'x');
    set([h1 h2 h3],'XGrid','On','YGrid','On');
    yaxis([-20 20])
    grid on; ylabel('betaz beating [%]'); xlabel('s [m]');
    suptitle('Beta beatingfitted at BPM position from turn by turn data (black stars) and reference (red)')
    
    addlabel(sprintf('H-betabeat %3.2f %% rms V-betabeat %3.2f %% rms               %s', ...
        std((bxmeas - bxm)./bxm)*100,std((bzmeas - bzm)./bzm)*100,AM.TimeStamp));

    if ReferenceFlag
        RefDirName = getfamilydata('Directory', 'BPMData');
        RefFileName = 'BPMTurnByTurn_2009-03-28_09-32-07_betabeatref.mat';
        [Refbxmeas Refbzmeas Refnux Refnuz] = anabetaturnbyturn(imax, 'File', fullfile(RefDirName,RefFileName)); 
        plot(h1, av, (Refbxmeas-bxm)./bxm*100, 'r.-')
        plot(h3, av, (Refbzmeas-bzm)./bzm*100, 'r.-')
    end
    %IDList = getidState;
    %fprintf('Measurement: I= %4.1f A nux=%5.4f nuz=%5.4f\n',     IDList.current, IDList.tunes)
end

