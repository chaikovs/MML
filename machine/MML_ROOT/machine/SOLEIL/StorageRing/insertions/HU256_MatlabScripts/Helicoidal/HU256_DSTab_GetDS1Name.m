function DS1Name=HU256_DSTab_GetDS1Name(HU256Cell, CurrentName)

DS1Name='';
DS1CoreName='ANS-C%02d/EI/M-HU256.2_%s/%s';
    
if (strncmpi(CurrentName, 'C', 1))
    if (strncmpi(CurrentName, 'CH', 2))
        DS1PartOfName='Shim.1';
    elseif (strncmpi(CurrentName, 'CV', 2))
        DS1PartOfName='Shim.2';
    end
    if (strcmpi(CurrentName(numel(CurrentName)), 'E'))
        AttributeName='current1';
    elseif (strcmpi(CurrentName(numel(CurrentName)), 'S'))
        AttributeName='current4';
    else
        fprintf('HU256_DSTab_DriveDS1UsingDSTable : %s is a wrong Current name\n', CurrentName);
        return
    end
elseif (strncmpi(CurrentName, 'BX', 2)||strcmpi(CurrentName, 'BZP'))
    DS1PartOfName=CurrentName;
    AttributeName='current';
elseif (strncmpi(CurrentName, 'Bzm', 3))
    BzmNumber=str2double(CurrentName(4));
    if (BzmNumber<1||BzmNumber>8)
        fprintf('HU256_DSTab_DriveDS1UsingDSTable : %s is a wrong CurrentName\n', CurrentName);
        return
    end
    if (BzmNumber==1)
        DS1PartOfName='Shim.1';
        AttributeName='current5';
    elseif (BzmNumber==2)
        DS1PartOfName='Shim.2';
        AttributeName='current5';
    else
        DS1PartOfName='Shim.3';
        AttributeName=['current' num2str(BzmNumber-2)];
    end
end
DS1Name=sprintf(DS1CoreName, HU256Cell, DS1PartOfName, AttributeName);
return