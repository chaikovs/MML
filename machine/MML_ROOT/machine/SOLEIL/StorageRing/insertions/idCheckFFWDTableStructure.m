function CheckResult=idCheckFFWDTableStructure(FFWDTableStructure)
%% Written by F. Briquez    26/04/2011
% Checks if input FFWD table structure contains all the appropriate fields
% contained in CellOfStructureFields

%%
CheckResult=-1;

CellOfStructureFields=cell(7, 1);
CellOfStructureFields{1}='vPhases';
CellOfStructureFields{2}='vGaps';
CellOfStructureFields{3}='Table';
CellOfStructureFields{4}='TableWithArgs';
CellOfStructureFields{5}='idName';
CellOfStructureFields{6}='idMode';
CellOfStructureFields{7}='CorrectorName';

for i=1:size(CellOfStructureFields, 1)
    CurrentField=CellOfStructureFields{i};
    if (isfield(FFWDTableStructure, CurrentField)==0)
        return
    end
end

CheckResult=1;
end
