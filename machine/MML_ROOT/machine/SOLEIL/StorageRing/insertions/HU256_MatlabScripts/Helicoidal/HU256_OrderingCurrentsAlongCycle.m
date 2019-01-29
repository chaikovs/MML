function Result=HU256_OrderingCurrentsAlongCycle(Currents, AddFirstColumnAtTheEnd, TypeOfResult)    
    Result=-1;
    NbCurrents=length(Currents);
    ZeroPos=find(Currents==0);
    if (isempty(ZeroPos)==1)
        fprintf('Warning : The Currents don''t contain the ''zero'' value!\n')
        CurrentOrderedPoints=Currents;
        Lines=Currents;
    else
        if (ZeroPos==1)
            CurrentOrderedPoints(1:NbCurrents)=Currents(1:NbCurrents);
            Lines(1:NbCurrents)=1:NbCurrents;
            CurrentOrderedPoints(NbCurrents+1:2*(NbCurrents-1))=Currents(NbCurrents-1:-1:2);
            Lines(NbCurrents+1:2*(NbCurrents-1))=NbCurrents-1:-1:2;
%             CurrentOrderedPoints(NbCurrents+1:2*NbCurrents-1)=Currents(NbCurrents-1:-1:1);
        else
            CurrentOrderedPoints(1:ZeroPos)=Currents(ZeroPos:-1:1);
            Lines(1:ZeroPos)=ZeroPos:-1:1;
            CurrentOrderedPoints(ZeroPos+1:ZeroPos+NbCurrents-1)=Currents(2:NbCurrents);
            Lines(ZeroPos+1:ZeroPos+NbCurrents-1)=2:NbCurrents;
            CurrentOrderedPoints(ZeroPos+NbCurrents:2*NbCurrents-2)=Currents(NbCurrents-1:-1:ZeroPos+1);            
            Lines(ZeroPos+NbCurrents:2*NbCurrents-2)=NbCurrents-1:-1:ZeroPos+1;
        end
    end
    if (AddFirstColumnAtTheEnd==1)
        CurrentOrderedPoints=[CurrentOrderedPoints CurrentOrderedPoints(:, 1)];
        Lines=[Lines Lines(1)];
    end
    if (strcmp(TypeOfResult, 'Lines'))
        Result=Lines;
    elseif (strcmp(TypeOfResult, 'Currents'))
        Result=CurrentOrderedPoints;
    else
        fprintf('HU256_OrderingCurrentsAlongCycle : TypeOfResult must be ''Lines'' or ''Currents''\n')
        return
    end
end