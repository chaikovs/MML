function Result=GiveInfosFromOrbitName(OrbitName, MainSeparator, DateSeparator, HourSeparator)
    % Linear modes (To be completed for others?)
    % F.Briquez 24/06/08 - In order to calculate integrals among cycles
    % after orbit measurements
    % Update 20/07/08 Taking into account Helical mode
    % MainSeparator usually '_'
    % DateSeparator usually '-'
    % HourSeparator usually ':'
    Result=-1;
    Length=length(OrbitName);
    if (strcmp(OrbitName(Length-3:Length), '.mat')==1)
        OrbitName=OrbitName(1:length(OrbitName)-5);
    end
    Separators=findstr(MainSeparator, OrbitName);  % Positions of '_'
    NumberOfSeparators=length(Separators);
    NumberOfElements=NumberOfSeparators+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LinearExpectedNumberOfElements=7;
    LinearExpectedElements=cell(LinearExpectedNumberOfElements);
    LinearExpectedElements{1}='UndulatorType';
    LinearExpectedElements{2}='BeamLine';
    LinearExpectedElements{3}='Field';
    LinearExpectedElements{4}='Current';
    LinearExpectedElements{5}='Sense';
    LinearExpectedElements{6}='Date';
    LinearExpectedElements{7}='Hour';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    HelExpectedNumberOfElements=10;
    HelExpectedElements=cell(HelExpectedNumberOfElements);
    HelExpectedElements{1}='UndulatorType';
    HelExpectedElements{2}='BeamLine';
    HelExpectedElements{3}='BX';
    HelExpectedElements{4}='BXCurrent';
    HelExpectedElements{5}='BXSense';
    HelExpectedElements{6}='BZ';
    HelExpectedElements{7}='BZCurrent';
    HelExpectedElements{8}='BZSense';    
    HelExpectedElements{9}='Date';
    HelExpectedElements{10}='Hour';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (NumberOfElements==LinearExpectedNumberOfElements)
        ExpectedElements=LinearExpectedElements;
        ExpectedNumberOfElements=LinearExpectedNumberOfElements;
        CycleType='Linear';
    elseif (NumberOfElements==HelExpectedNumberOfElements)
        ExpectedElements=HelExpectedElements;
        ExpectedNumberOfElements=HelicalExpectedNumberOfElements;
        CycleType='Helical';
    else
        return
    end
    % Filling Result
    Result=struct;
    for i=1:ExpectedNumberOfElements
      
        if (i==1)
            Begin=1;
            End=Separators(i)-1;
        elseif (i==ExpectedNumberOfElements)
            Begin=Separators(i-1)+1;
            End=length(OrbitName);
        else
            Begin=Separators(i-1)+1;
            End=Separators(i)-1;
        end
        Result.(ExpectedElements{i})=OrbitName(Begin:End);
    end
    if (strcmp(CycleType, 'Linear')==1)
        if (strncmp(Result.Field, 'BX', 2)==1)
            Result.BXCurrent=Result.Current;
            Result.BXSense=Result.Sense;
            Result.BZCurrent=0;
            Result.BZSense='D';
        elseif (strncmp(Result.Field, 'BZ', 2)==1)
            Result.BZCurrent=Result.Current;
            Result.BZSense=Result.Sense;
            Result.BXCurrent=0;
            Result.BXSense='D';
        end
        Result=rmfield(Result, 'Field');
        Result=rmfield(Result, 'Current');
        Result=rmfield(Result, 'Sense');
    end
    Result.CycleType=CycleType;
    if (ischar(Result.BXCurrent)==1)
        TempLength=length(Result.BXCurrent);
        TempString=Result.BXCurrent(TempLength);
        if (strcmp(TempString, 'A')==1)
            TempString=Result.BXCurrent(1:TempLength-1);
        end
        TempValue=str2double(TempString);
        Result.BXCurrent=TempValue;
    end
    if (ischar(Result.BZCurrent)==1)
        TempLength=length(Result.BZCurrent);
        TempString=Result.BZCurrent(TempLength);
        if (strcmp(TempString, 'A')==1)
            TempString=Result.BZCurrent(1:TempLength-1);
        end
        TempValue=str2double(TempString);
        Result.BZCurrent=TempValue;
    end
    if (strncmp(Result.BXSense, 'D', 1)==1)
        Result.BXSense=-1;
    else
        Result.BXSense=1;
    end
    if (strncmp(Result.BZSense, 'D', 1)==1)
        Result.BZSense=-1;
    else
        Result.BZSense=1;
    end
    % Checking Result (Format of Date and Hour)
    FieldCell=cell(2);
    FieldCell{1}='Date';
    FieldCell{2}='Hour';
    FieldSeparator=cell(2);
    FieldSeparator{1}=DateSeparator;
    FieldSeparator{2}=HourSeparator;
    for i=1:2
        TempVect=findstr(FieldSeparator{i}, Result.(FieldCell{i}));
        if (length(TempVect)~=2)
            Result=-1;
        end
    end
    % Changing Date and Hour from strings to vectors
%     Separators=findstr('-', Result.Date);
%     VectDate=zeros(3, 1);
%     VectDate(1)=str2num(Result.Date(1:Separators(1)-1));
%     VectDate(2)=str2num(Result.Date(Separators(1)+1:Separators(2)-1));
%     VectDate(3)=str2num(Result.Date(Separators(2)+1:length(Result.Date)));
%     Separators=findstr('-', Result.Hour);
%     VectHour=zeros(3);
%     VectHour(1)=str2num(Result.Hour(1:Separators(1)-1));
%     VectHour(2)=str2num(Result.Hour(Separators(1)+1:Separators(2)-1));
%     VectHour(3)=str2num(Result.Hour(Separators(2)+1:length(Result.Hour)));
%     Result.Date=VectDate;
%     Result.Hour=VectHour;
end