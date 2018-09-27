function setpathatesrf(ROOTDir)
%SETPATHAT Sets the AT Toolbox path
%  setpathat

if nargin == 0
    if isempty(getenv('ATROOT'))
        [DirectoryName, FileName, ExtentionName] = fileparts(which('getsp'));
        i = findstr(DirectoryName,filesep);
        ROOTDir = [DirectoryName(1:i(end)), 'at'];
        
        if ~isdir(ROOTDir)
            warning('   AT path has not been set.');
            return;
        end
    else
        ROOTDir = getenv('ATROOT');
    end
end


olddir = pwd;
cd(ROOTDir);
atpath(ROOTDir);

if strcmpi(version('-release'), '2009b')
    addpath(fullfile(ROOTDir, '..','BackwardsCompatibility'));
    addpath(fullfile(ROOTDir, '..','regressionTest'));
end

cd(olddir);

    