function [stCHEii, stCHSii, stCVEii, stCVSii, stCHEx, stCHSx, stCVEx, stCVSx, stCHEx2, stCHSx2, stCVEx2, stCVSx2]=idDownloadTableStructuresFromDevice(idName, Modeii, Modex, HU_Full)
% Written by F. Briquez 30/03/2011

if Modeii
    stCHEii=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CHE', 'II');
    stCHSii=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CHS', 'II');
    stCVEii=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CVE', 'II');
    stCVSii=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CVS', 'II');
end
if Modex
    stCHEx=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CHE', 'X');
    stCHSx=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CHS', 'X');
    stCVEx=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CVE', 'X');
    stCVSx=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CVS', 'X');
end
if Modex && HU_Full
    stCHEx2=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CHE', 'X2');
    stCHSx2=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CHS', 'X2');
    stCVEx2=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CVE', 'X2');
    stCVSx2=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, 'CVS', 'X2');
end
return