function Result=SortOrbitFileNamesInTimeOrder(Directory, UndulatorType, Beamline, Field)
    Result=-1;
    NameStructure=fullfile(Directory, [UndulatorType '_' Beamline '_' Field '*.mat']);
    
    ListOfFilesStructure=dir(NameStructure);
    
    NumberOfFiles=size(ListOfFilesStructure, 1);
    fprintf('%1.0f files found corresponding to ''%s''\n', NumberOfFiles, NameStructure)
%     FileNameCell=cell(NumberOfFiles);
%     for i=1:NumberOfFiles
%         ListOfFilesStructure.name;
    NameCell=cell(NumberOfFiles, 1);
    DateCell=cell(NumberOfFiles, 1);
    HourCell=cell(NumberOfFiles, 1);
    
    SummaryArray=nan(NumberOfFiles, 5); % row: file ; column: [(FileName, Date, Hour), Datenum, BZ, BZSense, BX, BXSense]
    
    BZCurrentArray=nan(NumberOfFiles, 1);
    BZSenseArray=nan(NumberOfFiles, 1);
    BXCurrentArray=nan(NumberOfFiles, 1);
    BXSenseArray=nan(NumberOfFiles, 1);
    DatenumArray=nan(NumberOfFiles, 1);
    
    for i=1:NumberOfFiles
        TempStruct=ListOfFilesStructure(i);
        OrbitName=TempStruct.name;
        Datenum=TempStruct.datenum;
        
        TempStruct=GiveInfosFromOrbitName(OrbitName, '_', '-', '-');
        if (isstruct(TempStruct)~=1&&TempStruct==-1)
           fprintf('WARNING : Orbit name ''%s'' of incorrect format!\n', OrbitName);
           return
        end
        Date=TempStruct.Date;
        Hour=TempStruct.Hour;
        
        CycleType=TempStruct.CycleType;
        BZCurrent=TempStruct.BZCurrent;
        BZSense=TempStruct.BZSense;
        BXCurrent=TempStruct.BXCurrent;
        BXSense=TempStruct.BXSense;
        NameCell{i}=OrbitName;
        DateCell{i}=Date;
        HourCell{i}=Hour;
        Datenum=CalculateTimeNumberFromDateAndHour(Date, Hour, '-', '-');
%         SummaryArray(i, 1)=Datenum;
        SummaryArray(i, 2)=BZCurrent;
        SummaryArray(i, 3)=BZSense;
        SummaryArray(i, 4)=BXCurrent;
        SummaryArray(i, 5)=BXSense;
        DatenumArray(i, 1)=Datenum;
        BZCurrentArray(i, 1)=BZCurrent;
        BZSenseArray(i, 1)=BZSense;
        BXCurrentArray(i, 1)=BXCurrent;
        BXSenseArray(i, 1)=BXSense;
    end
    NameArray=char(NameCell);
    DateArray=char(DateCell);
    HourArray=char(HourCell);
    

%     [NameArray, DateArray, HourArray, SummaryArray];
%     SummaryCell;
%     SummaryArray=char(SummaryCell(:,2));
%     size(SummaryArray)
    [SortedDatenum, Indexes]=sort(DatenumArray, 'ascend');
    TempArray=NameArray;
    for i=1:NumberOfFiles
        NameArray(i)=TempArray(Indexes(i));
    end
    SummaryArray;
    
    TempArray
    NameArray
    
    DatenumArray
    SortedDatenum
    Indexes
end