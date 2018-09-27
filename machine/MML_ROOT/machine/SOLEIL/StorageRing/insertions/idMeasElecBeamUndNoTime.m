function outStruct = idMeasElecBeamUndNoTime(idName, inclPerturbMeas, fileNameCore, dispData)
%idMeasElecBeamUnd
%
%  INPUTS
%  1. idName - Insertion device name
%  2. inclPertubMeas - if 1 includes measurement of chromaticities and dispersion functions
%                      if 0 nothing  
%  3. fileNameCore - filename core for saving data
%  4. dispData - Flag. 1 for displaying data, 0 otherwise
%
%  OUPUTS
%  1. outStruct
%
%  EXAMPLE
%  For measuring the corrector efficiency versus orbit
%  first set the current to CVE to 6 A
%  then compute the efficiency of CVE as follows:
%  idMeasElecBeamUnd('U20_PROXIMA1test', 0, 'U20_PROXIMA1_CVE_6', 1)

outStruct.X = 0;

% measrures data (orbit, etc.)
outStruct = idMeasElecBeamNoTime(outStruct, inclPerturbMeas, dispData);

% Reads tango state, encoders, correctors of undulator
if strcmp(idName, '') == 0
    outStruct = idReadUndState(outStruct, idName, dispData);
end

% Saves the data to a file
if strcmp(fileNameCore, '') == 0
    outStruct.file = idSaveStructNoTime(outStruct, fileNameCore, idName, dispData);
end
