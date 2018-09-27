function HU640_SetCorrectorsToZero()
    idDevServ='ans-c05/ei/l-hu640_Corr';
    for i=[1:4]
        writeattribute([idDevServ num2str(i) '/current'], 0);
    end
    pause(1);