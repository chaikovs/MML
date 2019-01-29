function [centroidX centroidZ] = getcentroid4phc1
%  GETCENTROID4PHC1 - Return centroid coordinates of the beam at the pinhole camera 1
% 
%  OUTPUTS
%  1. centroidX - horizontal value of the beam centroid in micrometers
%  2. centroidZ - vertical value of the beam centroid in micrometers
% 

%
% Written by Laurent S. Nadolski

devName='ANS-C02/DG/phc-imageanalyzer';
attX = [devName '/CentroidX'];
attZ = [devName '/CentroidY'];

% try/catch to be added
centroidX = readattribute(attX);
centroidZ = readattribute(attZ);

