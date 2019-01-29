function MMLROOT = getmmlroot(varargin)
%GETMMLROOT - Returns root directory of the Matlab Middle Layer
%  MMLRootDirectory = getmmlroot
%
%  Written by Greg Portmann


MMLROOT = '';


% This is legacy
MMLROOT = getenv('MLROOT');

if isempty(MMLROOT)
    %if exist('getsp','file')
    %    % Base on getsp file
    %    [MMLROOT, FileName, ExtentionName] = fileparts(which('getsp'));
    %else
        % Base on the location of this file
        [MMLROOT, FileName, ExtentionName] = fileparts(mfilename('fullpath'));
    %end
    MMLROOT = [MMLROOT, filesep];
end

% End MMLROOT with a file separator
if ~strcmp(MMLROOT(end), filesep)
    MMLROOT = [MMLROOT, filesep];
end


% Make MMLROOT root 1 up from the MML directory
i = findstr(MMLROOT, filesep);
if length(i) < 2
    MMLROOT = MMLROOT;
else
    MMLROOT = MMLROOT(1:i(end-1));
end




