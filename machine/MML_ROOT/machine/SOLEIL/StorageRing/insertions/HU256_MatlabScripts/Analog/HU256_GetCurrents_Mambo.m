function res=HU256_GetCurrents_Mambo(HU256Cell, BeginDate, BeginHour, EndDate, EndHour, Database)
    res=-1;
    Error=-1;
    if HU256Cell~=4&&HU256Cell~=12&&HU256Cell~=15
        fprintf ('Wrong cell\n')
        return
    end
    BeginDateHour=[BeginDate ' ' BeginHour];
    EndDateHour=[EndDate ' ' EndHour];

    ListOfPs=cell(16, 3);

    Names=cell(1, 16);
    Names(:)='';
    Path=sprintf('ANS-C%02.0f/EI/M-HU256.2', HU256Cell);

    ListOfPs(1, :)={'BX1', '_BX1', 'current'};    
    ListOfPs(2, :)={'BX2', '_BX2', 'current'};
    ListOfPs(3, :)={'BZP', '_BZP', 'current'};    
    ListOfPs(4, :)={'CVE', '_Shim.2', 'current1'};
    ListOfPs(5, :)={'CHE', '_Shim.1', 'current1'};
    ListOfPs(6, :)={'CVS', '_Shim.2', 'current4'};
    ListOfPs(7, :)={'CHS', '_Shim.1', 'current4'};
    ListOfPs(8, :)={'Bzm1', '_Shim.1', 'current5'};
    ListOfPs(9, :)={'Bzm2', '_Shim.2', 'current5'};
    ListOfPs(10, :)={'Bzm3', '_Shim.3', 'current1'};
    ListOfPs(11, :)={'Bzm4', '_Shim.3', 'current2'};
    ListOfPs(12, :)={'Bzm5', '_Shim.3', 'current3'};
    ListOfPs(13, :)={'Bzm6', '_Shim.3', 'current4'};
    ListOfPs(14, :)={'Bzm7', '_Shim.3', 'current5'};
    ListOfPs(15, :)={'Bzm8', '_ShiBeginDateHourm.3', 'current6'};
    ListOfPs(16, :)={'Mode', '', 'functioningMode'};

    ArraySize=0;
    for i=1:16
        fprintf ('%g\n', i)
        Name=ListOfPs{i, 1};
        Dev=ListOfPs{i, 2};
        Attr=ListOfPs{i, 3};
        FullAttr=[Path Dev '/' Attr];
        Structure=arread(FullAttr, BeginDateHour, EndDateHour, Database);
        StructureData=Structure.ardata;
        if isstruct(StructureData)
            ValueVect=StructureData.dvalue;
            ValueVect=ValueVect';
            DateVect=StructureData.svalue;
        else
            fprintf ('Could not extract data from attribute ''%s''\n', FullAttr);
            return;
        end
        if length(ValueVect)>ArraySize
            ArraySize=length(ValueVect);
        end
    end
    ArrayCurrents=zeros(ArraySize, 16);
    ArrayCurrents(:, :)=nan;
    for i=1:16
        Name=ListOfPs{i, 1};
        Dev=ListOfPs{i, 2};
        Attr=ListOfPs{i, 3};
        FullAttr=[Path Dev '/' Attr];
        Structure=arread(FullAttr, BeginDateHour, EndDateHour, Database);
        StructureData=Structure.ardata;
        ValueVect=StructureData.dvalue;
        ValueVect=ValueVect';
        DateVect=StructureData.svalue;
        if length(ValueVect)==ArraySize
            ArrayCurrents(:, i)=ValueVect(:);
        elseif length(ValueVect)<ArraySize
            ArrayCurrents(1:length(ValueVect), i)=ValueVect(:);
        end
        Names{i}=Name;
    end
    res=struct('Currents', ArrayCurrents, 'Names', Names);
    return
end
