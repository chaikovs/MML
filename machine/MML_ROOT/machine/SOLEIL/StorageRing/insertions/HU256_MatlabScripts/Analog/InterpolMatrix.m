function OutputMatrix=InterpolMatrix(InputMatrix, DeltaAbsMainCurrent)
% InputMatrix=  [MainCurrents] -200 -100 etc...
%               [CorrectorCurrents]
    OutputMatrix=-1;
    MainCurrents=InputMatrix(1, :);
    NumberOfMainCurrents=size(MainCurrents, 2);
    MainCurrentsAbsDeltas=zeros(1, NumberOfMainCurrents-1);
    for i=1:NumberOfMainCurrents-1
        MainCurrentsAbsDeltas(i)=abs(MainCurrents(i+1)-MainCurrents(i));
    end
%     MainCurrentsAbsDeltas
    if (std(MainCurrentsAbsDeltas)~=0)
        fprintf('Delta not equal among matrix\n');
        return
    end
%     MainCurrentsAbsDeltas
    OldDetlaAbsMainCurrent=mean(MainCurrentsAbsDeltas)
    if (DeltaAbsMainCurrent>=OldDetlaAbsMainCurrent||round(OldDetlaAbsMainCurrent/DeltaAbsMainCurrent)~=OldDetlaAbsMainCurrent/DeltaAbsMainCurrent)
        fprintf('Actual deltas of main currents must be sevarable by DeltaAbsMainCurrent \n');
        return
    end
    DeltaRatio=OldDetlaAbsMainCurrent/DeltaAbsMainCurrent;
    NewNumberOfCurrents=1+DeltaRatio*(NumberOfMainCurrents-1);
    NewNumberOfTempCurrents=1+DeltaRatio*(2-1);
    NewCurrents=zeros(1, NewNumberOfCurrents);
	OutputMatrix=zeros(size(InputMatrix, 1), NewNumberOfCurrents);
    

    for Current=1:NumberOfMainCurrents-1
        TempNewCurrents=zeros(1, NewNumberOfTempCurrents);
        FirstOldCurrent=InputMatrix(1, Current);
        FirstOldCurrentNewPosition=1+DeltaRatio*(Current-1);
        SecondOldCurrent=InputMatrix(1, Current+1);
        SecondOldCurrentNewPosition=1+DeltaRatio*(Current+1-1);
        DeltaSign=sign(SecondOldCurrent-FirstOldCurrent);
        TempNewMainCurrents=FirstOldCurrent:DeltaSign*DeltaAbsMainCurrent:SecondOldCurrent;
        NewMainCurrents(FirstOldCurrentNewPosition:FirstOldCurrentNewPosition+size(TempNewMainCurrents, 2)-1)=TempNewMainCurrents;
        for PowerSupply=2:size(InputMatrix, 1)
            TempNewCurrents=interp1(MainCurrents(Current:Current+1), InputMatrix(PowerSupply, Current:Current+1), TempNewMainCurrents);
            OutputMatrix(PowerSupply, FirstOldCurrentNewPosition:FirstOldCurrentNewPosition+size(TempNewCurrents, 2)-1)=TempNewCurrents;
        end
    end
    OutputMatrix(1,:)=NewMainCurrents;
        
%         if (Current~=1)
%             TempNewCurrents=TempNewCurrents(1, 2:NewNumberOfTempCurrents)
%         end
%         NewMainCurrents=[NewMainCurrents, TempNewCurrents]
%     end
    
%     for PowerSupply=2:2 %size(InputMatrix, 1)
%         TempCurrents=InputMatrix(PowerSupply, :);
%         MainCurrents
%         TempCurrents
% 
%         TempNewCurrents=interp1(MainCurrents, TempCurrents, TempNewCurrents);
%         TempNewCurrents
%         OutputMatrix(PowerSupply, :)=TempNewCurrents;
%     end
end