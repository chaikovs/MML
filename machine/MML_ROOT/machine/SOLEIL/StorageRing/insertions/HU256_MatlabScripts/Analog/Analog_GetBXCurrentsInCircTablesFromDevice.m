function BXCurrents=Analog_GetBXCurrentsInCircTablesFromDevice(HU256Cell)
% Returns vector of BX currents corresponding to BX Circ tables
%% Check the cell
if (HU256Cell==4)
    FFWDDirectory='/usr/Local/configFiles/InsertionFFTables/ANS-C04-HU256';
elseif (HU256Cell==12)
    FFWDDirectory='/usr/Local/configFiles/InsertionFFTables/ANS-C12-HU256';
elseif (HU256Cell==15)
    FFWDDirectory='/usr/Local/configFiles/InsertionFFTables/ANS-C15-HU256';
else
   fprintf('''AnalogGetFFWDTableFromDevice'' : Wrong cell\n')
    return
end

ListOfTables=dir([FFWDDirectory, filesep, 'Table_circ_*.txt']);
NumberOfTables=length(ListOfTables);
BXCurrents=zeros(NumberOfTables, 1);
for i=1:NumberOfTables
    Structure=ListOfTables(i);
    TableName=Structure.name;
    Position1=findstr(TableName, 'Table_circ_');
    Position2=findstr(TableName, '.txt');
    TempString=TableName(Position1+length('Table_circ_'): Position2-1);
    BXCurrent=str2double(TempString);
    if isnan(BXCurrent)
        fprintf ('Analog_GetBXCurrentsInCircTablesFromDevice : uncoherent result\n')
        BXCurrents=[];
        return
    end
    BXCurrents(i)=BXCurrent;
end
BXCurrents=sort(BXCurrents);
end