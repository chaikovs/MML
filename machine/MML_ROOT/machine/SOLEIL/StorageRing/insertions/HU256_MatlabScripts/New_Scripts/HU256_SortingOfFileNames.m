function OutStr=HU256_SortingOfFileNames(MeasDir)
    List=dir([MeasDir filesep '*.mat']);
    N=size(List, 1);
    Array=[];
    for (i=1:N)
        List_i=List(i);
        Name_i=List_i.name;
        Infos_i=HU256_GetInfosFromName(Name_i);
        Array(i, 2)=i;
        Array(i, 1)=Infos_i.NumSeconds;
        TempStr(i).name=Name_i;
    end
    Array=sortrows(Array);
    for (i=1:N)
       OutStr(i).Name=TempStr(Array(i, 2)).name;
   end