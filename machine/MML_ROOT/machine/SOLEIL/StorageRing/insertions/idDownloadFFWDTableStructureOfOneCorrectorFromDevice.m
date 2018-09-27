function FFWDTableStructure=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, CorrectorName, idMode)
%% Written by F. Briquez 30/03/2011
% 1) Inputs : idName : such as 'HU36_SIRIUS'
%           : CorrectorName : 'CHE', 'CHS', 'CVE' or 'CVS'
%           : idMode : 'ii', 'x', 'i2' or 'x2' for parallel or anti-parallel normal/advanced modes.
%               (Not case-sensitive)
% 2) Output : Structure with fields :
%               - vPhases       : 1xNphases vector containing phase values
%               - vGaps         : 1xNgaps vector containing gap values
%               - Table         : NphasesxNgaps matrix containing correction current values
%               - TableWithArgs : (Nphases+1)x(Ngaps+1) matrix containing
%                                   correction current values, with headers
%               - idName        : idName
%               - CorrectorName : CorrectorName
%               - idMode        : idMode
% 3) Returns empty structure (0x0 without field) in case of inexisting file
%    or wrong input.

%% Create empty structure
    FFWDTableStructure=struct;

%% Check the name of ID
    Directory=idGetFFWDTableDirectory(idName);
    if (isempty(Directory))
            fprintf ('Error in ''idDownloadFFWDTableStructureOfOneCorrectorFromDevice'' : wrong idName ''%s''\n', idName);
            return
    end

%% Check the corrector name
    if (strcmpi(CorrectorName, 'CVE')==0&&strcmpi(CorrectorName, 'CHE')==0&&strcmpi(CorrectorName, 'CVS')==0&&strcmpi(CorrectorName, 'CHS')==0)
        fprintf('Error in ''idDownloadFFWDTableStructureOfOneCorrectorFromDevice'' : Wrong corrector name\n')
        return
    end

%% Check the mode of ID
    if strcmpi(idMode, 'II')
    %     idMode='PARALLEL';
    elseif strcmpi(idMode, 'X')
    %     idMode='ANTIPARALLEL';
    elseif strcmpi(idMode, 'I2')
    %     idMode='PARALLEL 2';
    elseif strcmpi(idMode, 'X2')
    %     idMode='ANTIPARALLEL 2';
    else fprintf('Error in ''idDownloadFFWDTableStructureOfOneCorrectorFromDevice'' : Wrong mode. It should be ''II'', ''X'', ''I2'' or ''X2''\n')
        return
    end

%% Check that FFWD table file exists
    FileFullName=idGetFFWDTableFullFileName(idName, CorrectorName, idMode);

    if (exist(FileFullName, 'file')~=2)
        fprintf('Error in ''idDownloadFFWDTableStructureOfOneCorrectorFromDevice'' : could not find table file ''%s''\n', FileFullName);
        return
    end

%% Extracts data from FFWD table file and puts in output structure fields
   FFWDTableStructure=idGetFFWDTableStructureOfOneCorrectorFromTextFile(FileFullName, idName, CorrectorName, idMode);
    return
end