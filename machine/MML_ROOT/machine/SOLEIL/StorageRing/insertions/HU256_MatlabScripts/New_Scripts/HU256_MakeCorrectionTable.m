function HU256_MakeCorrectionTable(Component, Sense, MeasDir)
   %Component=Z ou X
   %Sense=Up ou Down
    ListOfZCurrents=[-200:20:200];
    ListOfXCurrents=[0:25:275];

    ZReference='HU256_CASSIOPEE_BZP_0A_2006-10-13_12-04-38';
    
    ArrayOfZMeasurements_Down = [
'HU256_CASSIOPEE_BZP_m200A_2006-10-13_12-11-38   ';
'HU256_CASSIOPEE_BZP_m180A_2006-10-13_12-11-18   ';
'HU256_CASSIOPEE_BZP_m160A_2006-10-13_12-10-10   ';
'HU256_CASSIOPEE_BZP_m140A_2006-10-13_12-09-45   ';
'HU256_CASSIOPEE_BZP_m120A_2006-10-13_12-08-43   ';
'HU256_CASSIOPEE_BZP_m100A_2006-10-13_12-07-57   ';
'HU256_CASSIOPEE_BZP_m80A_2006-10-13_12-07-40    ';
'HU256_CASSIOPEE_BZP_m60A_2006-10-13_12-07-02    ';
'HU256_CASSIOPEE_BZP_m40A_2006-10-13_12-06-38    ';
'HU256_CASSIOPEE_BZP_m20A_2006-10-13_12-05-47    ';
'HU256_CASSIOPEE_BZP_0A_2006-10-13_12-04-38      ';
'HU256_CASSIOPEE_BZP_20A_2006-10-13_12-31-52     ';
'HU256_CASSIOPEE_BZP_40A_2006-10-13_12-31-32     ';
'HU256_CASSIOPEE_BZP_60A_2006-10-13_12-31-16     ';
'HU256_CASSIOPEE_BZP_80A_2006-10-13_12-30-59     ';
'HU256_CASSIOPEE_BZP_100A_2006-10-13_12-30-30    ';
'HU256_CASSIOPEE_BZP_120A_2006-10-13_12-30-02    ';
'HU256_CASSIOPEE_BZP_140A_2006-10-13_12-29-43    ';
'HU256_CASSIOPEE_BZP_160A_2006-10-13_12-29-03    ';
'HU256_CASSIOPEE_BZP_180A_2006-10-13_12-28-22    ';
'HU256_CASSIOPEE_BZP_200A_2006-10-13_12-26-26    ';];

    ArrayOfZMeasurements_Up = [
'HU256_CASSIOPEE_BZP_m200A_2006-10-13_12-11-38   ';
'HU256_CASSIOPEE_BZP_m180A_Up_2006-10-13_12-14-15';
'HU256_CASSIOPEE_BZP_m160A_Up_2006-10-13_12-14-38';
'HU256_CASSIOPEE_BZP_m140A_Up_2006-10-13_12-15-40';
'HU256_CASSIOPEE_BZP_m120A_Up_2006-10-13_12-16-29';
'HU256_CASSIOPEE_BZP_m100A_Up_2006-10-13_12-17-15';
'HU256_CASSIOPEE_BZP_m80A_Up_2006-10-13_12-17-57 '
'HU256_CASSIOPEE_BZP_m60A_Up_2006-10-13_12-20-14 ';
'HU256_CASSIOPEE_BZP_m40A_Up_2006-10-13_12-20-53 ';
'HU256_CASSIOPEE_BZP_m20A_Up_2006-10-13_12-21-21 ';
'HU256_CASSIOPEE_BZP_0A_Up_2006-10-13_12-22-20   ';
'HU256_CASSIOPEE_BZP_20A_Up_2006-10-13_12-22-52  ';
'HU256_CASSIOPEE_BZP_40A_Up_2006-10-13_12-23-14  ';
'HU256_CASSIOPEE_BZP_60A_Up_2006-10-13_12-23-36  ';
'HU256_CASSIOPEE_BZP_80A_Up_2006-10-13_12-23-55  ';
'HU256_CASSIOPEE_BZP_100A_Up_2006-10-13_12-24-12 ';
'HU256_CASSIOPEE_BZP_120A_Up_2006-10-13_12-24-44 ';
'HU256_CASSIOPEE_BZP_140A_Up_2006-10-13_12-25-07 ';
'HU256_CASSIOPEE_BZP_160A_Up_2006-10-13_12-25-27 ';
'HU256_CASSIOPEE_BZP_180A_Up_2006-10-13_12-25-55 ';
'HU256_CASSIOPEE_BZP_200A_2006-10-13_12-26-26    ';];

    XReference='HU256_CASSIOPEE_BX_0A_Down_2006-10-13_13-59-31';

    ArrayOfXMeasurements_Down = [
'HU256_CASSIOPEE_BX_0A_Down_2006-10-13_13-59-31    ';
'HU256_CASSIOPEE_BX_25A_Down_2006-10-13_13-58-52   ';
'HU256_CASSIOPEE_BX_50A_Down_2006-10-13_13-58-14   ';
'HU256_CASSIOPEE_BX_75A_Down_2006-10-13_13-57-44   ';
'HU256_CASSIOPEE_BX_100A_Down_2006-10-13_13-57-12  ';
'HU256_CASSIOPEE_BX_125A_Down_2006-10-13_13-55-33  ';
'HU256_CASSIOPEE_BX_150A_Down_2006-10-13_13-54-36  ';
'HU256_CASSIOPEE_BX_175A_Down_2006-10-13_13-54-07  ';
'HU256_CASSIOPEE_BX_200A_Down_2006-10-13_13-53-21  ';
'HU256_CASSIOPEE_BX_225A_Down_2006-10-13_13-52-43  ';
'HU256_CASSIOPEE_BX_250A_Down_2006-10-13_13-52-08  ';
'HU256_CASSIOPEE_BX_275A_2006-10-13_14-56-17       ';];

    ArrayOfXMeasurements_Up = [
'HU256_CASSIOPEE_BX_0A_2006-10-13_13-41-44         ';
'HU256_CASSIOPEE_BX_25A_Up_2006-10-13_13-44-49     ';
'HU256_CASSIOPEE_BX_50A_Up_2006-10-13_13-45-19     ';
'HU256_CASSIOPEE_BX_75A_Up_2006-10-13_14-00-38     ';
'HU256_CASSIOPEE_BX_100A_Up_2006-10-13_13-46-05    ';
'HU256_CASSIOPEE_BX_125A_Up_2006-10-13_13-46-47    ';
'HU256_CASSIOPEE_BX_150A_Up_2006-10-13_13-47-18    ';
'HU256_CASSIOPEE_BX_175A_Up_2006-10-13_13-47-44    ';
'HU256_CASSIOPEE_BX_200A_Up_2006-10-13_13-48-16    ';
'HU256_CASSIOPEE_BX_225A_Up_2006-10-13_13-48-46    ';
'HU256_CASSIOPEE_BX_250A_Up_2006-10-13_13-49-42    ';
'HU256_CASSIOPEE_BX_275A_Up_2006-10-13_13-51-26    ';];

    NX=size(ArrayOfXMeasurements_Down, 1);
    NZ=size(ArrayOfZMeasurements_Down, 1);

    if (strcmp(Sense, 'Up')==0&&strcmp(Sense, 'Down')==0)
        fprintf('%s', 'Probleme 2!')
        return
    end
    if (strcmp(Component, 'Z'))
        ListOfCurrents=ListOfZCurrents;
        N=NZ;
        Reference=[ZReference '.mat'];
        if (strcmp(Sense, 'Up'))
            Array=ArrayOfZMeasurements_Up;
        else
            Array=ArrayOfZMeasurements_Down;
        end
    elseif (strcmp(Component, 'X'))
        ListOfCurrents=ListOfXCurrents;
        N=NX;
        Reference=[XReference '.mat'];
        if (strcmp(Sense, 'Down'))
            Array=ArrayOfXMeasurements_Up;
        else
            Array=ArrayOfXMeasurements_Down;
        end
    else
        fprintf('%s', 'Probleme!!')
        return
    end
    
[mCorRespX, mCorRespZ] = idCalcCorRespMatr('HU256_CASSIOPEE', 1, '/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_10_13/CorrectorsResponseMeasurements');

fprintf('%s\r\r', '')
fprintf('%25s\t%25s\n\n', Component, Sense)
fprintf('%10s\t%10s\t%10s\t%10s\t%10s\n', 'Current', 'Bxc1', 'Bxc28', 'Bzc1', 'Bzc27')

for i=1:N
    Name=[MeasDir FileSep Array(i,:)];
    Name=strtrim(Name);
    Name=[Name '.mat'];
    Result=CalculateCorrCur(Name, Reference);
    Bxc1=Result(1);
    Bxc28=Result(2);
    Bzc1=Result(3);
    Bzc27=Result(4);
    Current=ListOfCurrents(i);
    fprintf('%10i\t%10.4f\t%10.4f\t%10.4f\t%10.4f\n', Current, Bxc1, Bxc28, Bzc1, Bzc27)
    
end