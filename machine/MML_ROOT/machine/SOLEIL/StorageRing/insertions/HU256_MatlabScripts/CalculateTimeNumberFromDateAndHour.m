function Result=CalculateTimeNumberFromDateAndHour(Date, Hour, DateSeparator, HourSeparator)

    Result=-1;
    DateSeparators=findstr(DateSeparator, Date);
    HourSeparators=findstr(HourSeparator, Hour);
    if (length(DateSeparators)~=2||length(HourSeparators)~=2)
        return
    end
    Year=Date(1:DateSeparators(1)-1);
    Month=Date(DateSeparators(1)+1:DateSeparators(2)-1);
    Day=Date(DateSeparators(2)+1:length(Date));
    Hours=Hour(1:HourSeparators(1)-1);
    Minutes=Hour(HourSeparators(1)+1:HourSeparators(2)-1);
    Seconds=Hour(HourSeparators(2)+1:length(Hour));
    if (length(Year)~=4||length(Month)~=2||length(Day)~=2||length(Hours)~=2||length(Minutes)~=2||length(Seconds)~=2)
        return
    end
    Year=str2double(Year);
    Month=str2double(Month);
    Day=str2double(Day);
    Hours=str2double(Hours);
    Minutes=str2double(Minutes);
    Seconds=str2double(Seconds);
    Result=datenum([Year, Month, Day, Hours, Minutes, Seconds]);
%     Multiplyer=[;;24*60*60;60*60;60;1]
    return
end
    