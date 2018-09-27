%Mesures The Orbit X and Z / Tune Shift NuX and NuZ / Chromaticities KsiX and KsiZ
%First Argument: Name of the ID
%Second Argument: Measurement of the Chromaticities (Yes=1,No=0)
%Third Argument: Name of the file where the data are saved (Date and Time
%will be added at the end of the name)
%Fourth Argument: Display the results (Yes=1,No=0)
s=idMeasElecBeamUnd('HU640_DESIRS', 0, '/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/SESSION_01_10_06/DataInMatlabFormat/HU640_OFF_2006-10-01_17-20-28', 0)

%Calculates the First and Second integrals in X and Z from the Orbit
%Distortions and the Theoretical model of SOLEIL
%First Argument: Name of the ID
%Second Argument: Complete Name (including Path) of the Directory where the
%Matlab Structures have been saved
%Third Argument: Name of the Uncorrected Field Matlab Structure
%Fourth Argument: Name of the Backgroung Field Matlab Structure
st = idCalcFldIntFromElecBeamMeasForUndSOLEIL_1('HU640_DESIRS', '/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/SESSION_01_10_06/DataInMatlabFormat', 'HU640_PS2_m440_2006-10-01_18-07-53', 'HU640_PS2ON_2006-10-01_17-27-02','', -1)
  
%Converts Orbits X and Z into Text Format from the X or Z orbit Matlab
%Structure

SaveOrbitInTextFormat('/SESSION_01_10_06/DataInMatlabFormat/','HU640_PS2_m100_2006-10-01_17-58-15.mat','toto')
%First Argument: Complete Path where the Structure has been saved
%Name of the structure to be converted
% Destination Name of the Text file (. txt)