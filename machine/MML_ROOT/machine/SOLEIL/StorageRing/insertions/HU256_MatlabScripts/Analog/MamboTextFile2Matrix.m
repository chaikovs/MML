function Output=MamboTextFile2Matrix(FileFullName)
% MamboTextFile2Matrix('/home/operateur/GrpGMI/Archivage/Briquez/Mambo_FB.txt')
Output=struct();
CurrentNames=cell(0, 1);
Delimiter='	';
FileID=fopen(FileFullName);
if (FileID==-1)
    fprintf('''MamboTextFile2Matrix'' : could not open file ''%s''\n', FileFullName);
    return
end

ListOfCurrentNames=fgetl(FileID);
ListOfCurrentNames=strrep(ListOfCurrentNames, 'Time (s)', 'Time');
ListOfRemainingCurrentNames=ListOfCurrentNames;
%char2num(ListOfRemainingCurrentNames(5));
%TempPos=findstr(' ', ListOfCurrentNames);
TempPos=findstr(Delimiter, ListOfCurrentNames);
while ~isempty(TempPos)
    TempPos=findstr(Delimiter, ListOfRemainingCurrentNames);
    if ~isempty(TempPos)
        TempPos=TempPos(1);
        if TempPos~=1
            TempCurrentName=ListOfRemainingCurrentNames(1:TempPos-1);
            TempCurrentName=deblank(TempCurrentName);
            if ~isempty(TempCurrentName)
                CurrentNames{size(CurrentNames, 1)+1, 1}=TempCurrentName;
            end
            ListOfRemainingCurrentNames=ListOfRemainingCurrentNames(TempPos+1:length(ListOfRemainingCurrentNames));
        else
            ListOfRemainingCurrentNames=strtrim(ListOfRemainingCurrentNames);
        end
    end
end
res=fclose(FileID);
if (res~=0)
    fprintf('''AnalogGetFFWDTableFromDevice'' : could not close file ''%s''\n', FileFullName);
end

for i=1:size(CurrentNames, 1)
    TempCurrentName=CurrentNames{i, 1};
    ArrayOfSeparators=findstr(TempCurrentName, '/');
    NumberOfSeparators=size(ArrayOfSeparators, 2);
    NumberOfItems=NumberOfSeparators+1;
    if ~strcmp(TempCurrentName, 'Time')
        if NumberOfItems<3||NumberOfItems>5
            fprintf ('MamboTextFile2Matrix : wrong device attribute ''%s''\n', TempCurrentName);
            return
        end
    
        Zone=TempCurrentName(1:ArrayOfSeparators(1)-1);
        Group=TempCurrentName(ArrayOfSeparators(1)+1:ArrayOfSeparators(2)-1);
        Device=TempCurrentName(ArrayOfSeparators(2)+1:ArrayOfSeparators(3)-1);
        Attribute=TempCurrentName(ArrayOfSeparators(3)+1:ArrayOfSeparators(4)-1);
        if NumberOfItems==5
            ReadWrite=TempCurrentName(ArrayOfSeparators(4)+1:length(TempCurrentName));
        end
    end
end
    
%     TempCell=textscan('ANS-C08/EI/M-HU44.1/encoder6Position/read', 'ANS-C%02.0f/%s');
%     if size(TempCell, 2)~=2
%         fprintf ('error\n')
%         return
%     end
%     StorageRingCell=TempCell{1};
%     AttributeFullName=TempCell{2}{1};   % ANS-C12/EI/M-HU256.2/
%     if strncmp(AttributeFullName, 'EI/M-HU256.2', 12)
%         if (strncmp(AttributeFullName, 'EI/M-HU256.2_', 13)
%             
end


% % NumberOfPowerSupplies1=
% % FFWDTable = dlmread(FileFullName, '\t', 1, 0);
% % FFWDTable = dlmread(FileFullName, '', 1, 0);
% FFWDTable = dlmread(FileFullName, Delimiter, 1, 0);
% 
% return
% end
% 
% function res=GetAttrInfo(AttributeFullName)
%     CoreName='ANS-C%02.0f/EI/M-HU256.2_%s/read');
%     CoreName='ANS-C%02.0f/EI/M-HU256.2%s/%s/read';
%     
%     if ~stringmatch(Attribute
