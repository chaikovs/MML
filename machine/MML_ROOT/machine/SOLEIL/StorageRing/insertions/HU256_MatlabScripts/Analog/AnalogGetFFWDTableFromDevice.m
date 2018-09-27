function [FFWDTable, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, Mode)
%% Written by F. Briquez 08/07/2011
%% Modified 15/09/2011 : includes Transitions (TO BE COMPLETED...)
% HU256Cell : 4, 12 or 15
% Mode : 'LH', 'LV', 'AH', 'AV', 'BX' or 'BXvalue' (such as '250')

%% Create empty structure
FFWDTable=[];
PowerSupplies=cell(0, 1);

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

%% Check the mode
if (strcmpi(Mode, 'LH')==0&&strcmpi(Mode, 'LV')==0&&strcmpi(Mode, 'AH')==0&&strcmpi(Mode, 'AV')==0&&strcmpi(Mode, 'BX')==0&&isnan(str2double(Mode)==0))
    fprintf('''AnalogGetFFWDTableFromDevice'' : Wrong mode\n')
    return
end

%% Check that FFWD table file exists
BXCurrent=str2double(Mode);
if (isnan(BXCurrent)==0)
    FileName=sprintf('Table_circ_%g.txt', BXCurrent);
elseif strcmpi(Mode, 'BX')
    FileName='TableHelBx.txt';
else   
    FileName=sprintf('FF_%s.txt', Mode);
end
FileFullName=[FFWDDirectory filesep FileName];

if (exist(FileFullName, 'file')~=2)
    fprintf('Error in ''AnalogGetFFWDTableFromDevice'' : could not find table file ''%s''\n', FileFullName);
    return
end

%% Extracts data from FFWD table file 
% FFWDTable=load('-ascii', FileFullName);
% FileString=fileread(FileFullName);
% EndOfLine=findstr('\n', FileString);
FileID=fopen(FileFullName);
if (FileID==-1)
    fprintf('''AnalogGetFFWDTableFromDevice'' : could not open file ''%s''\n', FileFullName);
    return
end

% ListOfPowerSupplies=FileString(1:EndOfLine-1);
ListOfPowerSupplies=fgetl(FileID);
ListOfRemainingPs=[ListOfPowerSupplies ','];

TempPos=findstr(',', ListOfRemainingPs);
while(isempty(TempPos)==0)
    TempPos=findstr(',', ListOfRemainingPs);
    TempPsName=ListOfRemainingPs(1:TempPos-1);
    TempPsName=deblank(TempPsName);
    if (isempty(TempPsName)==0)
        PowerSupplies{size(PowerSupplies, 1)+1, 1}=TempPsName;
    end
    ListOfRemainingPs=ListOfRemainingPs(TempPos+1:length(ListOfRemainingPs));
end
res=fclose(FileID);
if (res~=0)
    fprintf('''AnalogGetFFWDTableFromDevice'' : could not close file ''%s''\n', FileFullName);
end
% NumberOfPowerSupplies1=
 FFWDTable = dlmread(FileFullName, '\t', 1, 0);
% FFWDTable = dlmread(FileFullName, '', 1, 0);

NumberOfPowerSupplies=size(FFWDTable, 1);
NumberOfCurrents=size(FFWDTable, 2);
if (size(PowerSupplies, 1)~=NumberOfPowerSupplies)
    fprintf('''AnalogGetFFWDTableFromDevice'' : mismatch in number of power supplies\n');
    FFWDTable=[];
    PowerSupplies=cell(0, 1);
    return
end
%fprintf ('%g currents in table ''%s''\n', NumberOfCurrents, FileFullName);
return
