function res=GetDeliveredCurrents(HU256Cell)
    res=struct();
    ListOfPs=cell(17, 3);
    VectCurrents=zeros(1, 16);
    VectCurrents(:)=nan;
    Names=cell(1, 17);
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
    ListOfPs(15, :)={'Bzm8', '_Shim.3', 'current6'};
    ListOfPs(16, :)={'Mode', '', 'functioningMode'};
    ListOfPs(17, :)={'ModeStr', '', 'functioningModeStr'};
    for i=1:17
        Name=ListOfPs{i, 1};
        Dev=ListOfPs{i, 2};
        Attr=ListOfPs{i, 3};
        Structure=tango_read_attribute([Path Dev], Attr);
        if isstruct(Structure)
            ValueVect=Structure.value;
        end
        if ~strcmp(Name, 'ModeStr')
            VectCurrents(i)=ValueVect(1);
        else
            res.ModeStr=ValueVect;
        end
        if strcmp(Name, 'Mode')
            res.Mode=ValueVect(1);
        end
        Names{i}=Name;
    end
%     BZP=Vect(1);
%     BX1=Vect(2);
%     BX2=Vect(3);
%     CVE=Vect(4);
%     CHE=Vect(5);
%     CVS=Vect(6);
%     CHS=Vect(7);
%     Mode=Vect(8);
%     Bzm1=Vect(9);
%     Bzm2=Vect(10);
%     Bzm3=Vect(11);
%     Bzm4=Vect(12);
%     Bzm5=Vect(13);
%     Bzm6=Vect(14);
%     Bzm7=Vect(15);
%     Bzm8=Vect(16);
    res.Currents=VectCurrents;
    res.Names=Names;
    return
end