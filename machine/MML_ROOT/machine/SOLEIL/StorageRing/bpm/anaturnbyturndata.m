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

XposMean = mean(Xpos);
ZposMean = mean(Zpos);

Xamp = max(abs(Xpos-repmat(XposMean', 1, size(Xpos,1))'));
Zamp = max(abs(Zpos-repmat(ZposMean', 1, size(Zpos,1))'));

% XposRef = AMRef.Data.X(:,istart:iend)';
% ZposRef = AMRef.Data.Z(:,istart:iend)';
% 
% XposMeanRef = mean(XposRef);
% ZposMeanRef = mean(ZposRef);
% 
% Xamp = max(abs(Xpos-repmat(XposMean', 1, size(Xpos,1))'));
% Zamp = max(abs(Zpos-repmat(ZposMean', 1, size(Zpos,1))'));

if DisplayFlag
    figure
    subplot(2,1,1)
    plot(XposMean); hold on;
    plot(ZposMean, 'r')
    ylabel('Mean value (mm)')
    subplot(2,1,2)
    plot(Xamp); hold on;
    plot(Zamp, 'r')
    ylabel('Max amplitude (mm)')
    xlabel('BPM number');
    suptitle('Turn by turn data')
end