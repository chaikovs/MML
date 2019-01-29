function [BPM1, BPM2, FileName]=getbpm(varargin);   
%GETBPM - Returns the horizontal and vertical orbit
%         BPM   = getbpm(Dimension, BPMList);
%  [BPMx, BPMy, FileName] = getbpm(Dimension=1='x'='h', BPMListx, BPMListy);
%  [BPMy, BPMx, FileName] = getbpm(Dimension=2='y'='v', BPMListy, BPMListx);
%
%  INPUTS
%  1. Dimension = 1, 'x', 'h' - First Output Horizontal, Second Vertical
%                 2, 'z', 'y', 'v' - First Output Vertical,   Second Horizontal
%                 else - defaults to Dimension=1
%  2. BPMlistx = Horizontal BPM device list (default: all BPMs)
%  3. BPMlisty = Vertical BPM device list (default: all BPMs)
%  4. 'Struct' will return a data structure
%     'Numeric' will return a vector output {default}
%  5. 'NoArchive' - No file archive {Default}
%     'Archive'   - Save a BPM data structure to \<DataRoot>\BPM\<BPMArchiveFile><Date><Time>.mat
%                   To change the filename, included the filename after the 'Archive', '' to browse
%
%  OUTPUTS
%  1. BPM1 - Horizontal orbit vector or data structures
%  2. BPM2 - vertical orbit vector or data structures
%  3. Filename - Output filename if archived
%
%  NOTE
%  1. 'Struct', 'Numeric', and 'Archive' are not case sensitive
%  2. All inputs are optional
%  3. This function is usually used when it is useful to make Dimension a variable
%
%  See also getx, getz, getbpm, getam, getpv

%
% Written by Gregory J. Portmann
% Modified by Laurent S. Nadolski

% [BPM1, BPM2]=getbpm(Dim, BPMlist, BPMlist2, 'struct', 'archive');   


% Get input flags
StructOutputString = 'numeric';
ArchiveFlag = 0;
FileName = -1;
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'struct')
        StructOutputString = 'struct';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        StructOutputString = 'numeric';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'archive')
        ArchiveFlag = 1;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                varargin(i+1) = [];
            end
        end
        varargin(i) = [];
    end
end


% Get the dimension
if length(varargin) == 0
    Dim = 1;
else
    Dim = varargin{1};
end

if isstr(Dim)
   if strcmpi(Dim,'X')
      Dim = 1;
   elseif strcmpi(Dim,'Z') || strcmpi(Dim,'Y')
      Dim = 2;
   elseif strcmpi(Dim,'H')
      Dim = 1;
   elseif strcmpi(Dim,'V')
      Dim = 2;
   else
      Dim = 1;
   end
end

if (Dim == 2)
    if length(varargin) < 2
        BPMlist = family2dev(getvbpmfamily);
    else
        BPMlist = varargin{2};
    end
    if isempty(BPMlist)
        BPMlist = family2dev(getvbpmfamily);
    end                   
    BPM1 = gety(BPMlist, StructOutputString);    
else
    if length(varargin) < 2
        BPMlist = family2dev(gethbpmfamily);
    else
        BPMlist = varargin{2};
    end    
    if isempty(BPMlist)
        BPMlist = family2dev(gethbpmfamily);
    end                   
    BPM1 = getx(BPMlist, StructOutputString);
end 

if nargout >= 2,
    if (Dim == 2)
        if length(varargin) < 3
            BPMlist2 = family2dev(gethbpmfamily);
        else
            BPMlist2 = varargin{3};
        end    
        if isempty(BPMlist2)
            BPMlist2 = family2dev(gethbpmfamily);
        end                   
        BPM2 = getx(BPMlist2, StructOutputString);
    else
        if length(varargin) < 3
            BPMlist2 = family2dev(getvbpmfamily);
        else
            BPMlist2 = varargin{3};
        end
        if isempty(BPMlist2)
            BPMlist2 = family2dev(getvbpmfamily);
        end                   
        BPM2 = gety(BPMlist2, StructOutputString); 
    end 
end	



% Archive data structure
if ArchiveFlag
    if isempty(FileName)
        FileName = appendtimestamp(getfamilydata('Default', 'BPMArchiveFile'), clock);
        DirectoryName = getfamilydata('Directory','BPMData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM', filesep];
        end

        % Make sure default directory exists
        DirStart = pwd;
        [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
        cd(DirStart);

        [FileName, DirectoryName] = uiputfile('*.mat', 'Save BPM File to ...', [DirectoryName FileName]);
        if FileName == 0
            FileName = '';
            return
        end
        FileName = [DirectoryName, FileName];
    elseif FileName == -1
        FileName = appendtimestamp(getfamilydata('Default', 'BPMArchiveFile'), clock);
        DirectoryName = getfamilydata('Directory','BPMData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM', filesep];
        end
        FileName = [DirectoryName, FileName];
    end

    % If the filename contains a directory then make sure it exists
    [DirectoryName, FileName, Ext] = fileparts(FileName);
    DirStart = pwd;
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    BPMxData = getx('struct');
    BPMyData = gety('struct');
    save(FileName, 'BPMxData', 'BPMyData');
    fprintf('   BPM data saved to %s.mat\n', [DirectoryName FileName]);
    if ErrorFlag
        fprintf('   Warning: %s was not the desired directory\n', DirectoryName);
    end
    cd(DirStart);
    FileName = [DirectoryName FileName];
end
if FileName == -1
    FileName = '';
end


