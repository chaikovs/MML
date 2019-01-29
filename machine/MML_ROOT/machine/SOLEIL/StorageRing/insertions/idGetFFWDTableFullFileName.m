function FileName=idGetFFWDTableFullFileName(idName, CorrectorName, idMode)
% Written by F. Briquez 30/03/2011
% 1) Inputs : idName : such as 'HU36_SIRIUS'
%           : CorrectorName : 'CHE', 'CHS', 'CVE' or 'CVS'
%           : idMode : 'ii', 'x', 'i2' or 'x2'  for parallel or anti-parallel normal/advanced modes.
%               (Not case-sensitive)
% 2) Output : String containing full file name of FFWD table used by the device
%              such as :
%               '/usr/Local/configFiles/InsertionFFTables/ANS-C15-HU36/FF_PARALLEL_CHE_TABLE.txt'
% 3) Returns empty string '' in case of wrong input.

FileName='';

Directory=idGetFFWDTableDirectory(idName);
if (isempty(Directory))
        fprintf ('Error in ''idGetFFWDTableFullFileName'' : wrong idName ''%s''\n', idName);
        return
end
if (strcmpi(CorrectorName, 'CVE')==0&&strcmpi(CorrectorName, 'CHE')==0&&strcmpi(CorrectorName, 'CVS')==0&&strcmpi(CorrectorName, 'CHS')==0)
    fprintf('Error in ''idGetFFWDTableFullFileName'' : Wrong corrector name\n')
    return
end
if strcmpi(idMode, 'II')
    idMode='PARALLEL';
elseif strcmpi(idMode, 'X')
    idMode='ANTIPARALLEL';
elseif strcmpi(idMode, 'I2')
    idMode='PARALLEL2';
elseif strcmpi(idMode, 'X2')
    idMode='ANTIPARALLEL2';
else fprintf('Error in ''idGetFFWDTableFullFileName'' : Wrong mode. It should be ''ii'' or ''x'' (not case-sensitive)\n')
    return
end
FileName=sprintf('FF_%s_%s_TABLE.txt', idMode, CorrectorName);
FileName=fullfile(Directory, FileName);
end
