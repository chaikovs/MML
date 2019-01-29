function OutputStructure = HU256_DSTab_ReadDSTable(DSTableFullPath)
% function TableArray = HU256_ReadDSTable(DSTableFullPath)

OutputStructure=struct;

Fid=fopen(DSTableFullPath);
if (Fid==-1)
    fprintf ('HU256_ReadDSTable : incorrect file name\n');
    return
end
TempCell=textscan(Fid, '%s','EndOfLine', '\r\n');
CellOfPowerSupplies=TempCell{1};
ListOfPowerSupplies=CellOfPowerSupplies{1};
CellOfPowerSupplies=cell(0);

Condition=1;
while(Condition)
    [TempPowerSupplyName, RemainList]=strtok(ListOfPowerSupplies, ',');
    Condition=isempty(TempPowerSupplyName)==0;
    ListOfPowerSupplies=RemainList;
    if (numel(ListOfPowerSupplies)~=0)
        if (strcmp(ListOfPowerSupplies(1), ','))
            ListOfPowerSupplies=ListOfPowerSupplies(2:numel(ListOfPowerSupplies));
        end
    end
    if (Condition)
        CellOfPowerSupplies{numel(CellOfPowerSupplies)+1}=TempPowerSupplyName;
    end
end
fclose(Fid);

% PowerSupplies=textscan(ListOfPowerSupplies, 'Delimiter', ',');

% TableArray=textscan(Fid, '%f', 'HeaderLines', 2);%, 'Delimiter', '\n');
TempStructure=importdata(DSTableFullPath, '\t', 1);
TableArray=TempStructure.data;
if (numel(CellOfPowerSupplies)==size(TableArray, 1))
    OutputStructure.Table=TableArray;
    OutputStructure.PowerSupplies=CellOfPowerSupplies;
end
return

% string=HU256_ReadDSTable('/home/operateur/GrpGMI/HU256_CASSIOPEE/Tables_E
% CA/FF_AH (copy).txt')
