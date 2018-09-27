function UploadState=idUploadFFWDTableStructureToDevice(FFWDTableStructure)
%% Writen by F. Briquez 25/04/2011
% Creates the FFWD table file used by the Device Server from the table
% structure
% 1) Input :    table structure containing at least fields :
%               - TableWithArgs
%               - idName
%               - idMode
%               - CorrectorName
% 2) Output :   -1 if failed. 1 if succeeded

%%
UploadState=-1;

CheckResult=idCheckFFWDTableStructure(FFWDTableStructure);
if (CheckResult==-1)
    fprintf('Error in ''idUploadFFWDTableStructureToDevice'' : wrong FFWD table structure\n')
end

% vPhases=FFWDTableStructure.vPhases;
% vGaps=FFWDTableStructure.vGaps;
% Table=FFWDTableStructure.Table;
TableWithArgs=FFWDTableStructure.TableWithArgs;
idName=FFWDTableStructure.idName;
idMode=FFWDTableStructure.idMode;
CorrectorName=FFWDTableStructure.CorrectorName;

UploadState=idUploadFFWDTableToDevice(TableWithArgs, idName, CorrectorName, idMode);