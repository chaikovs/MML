function sRes = idAuxFormatPartCorElecBeamMeasDataFromFile(Directory, FileName)
    FileFullName=[Directory '/' FileName '.mat'];
    TempStruct=load(FileFullName);
    fprintf(idAuxFormatPartCorElecBeamMeasData(TempStruct.file))