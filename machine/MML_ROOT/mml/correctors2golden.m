function correctors2golden
%CORRECTORS2GOLDEN - Sets the default corrector families to the golden configuration values
%  correctors2golden
%
%restore correctors to golden configuration values
%
%  See Also vcm2golden, hcm2golden

%
%  Written by Gregory J. Portmann

FileName = getfamilydata('OpsData', 'LatticeFile');
DirectoryName = getfamilydata('Directory', 'OpsData');

load([DirectoryName FileName]);


HCMFamily = gethcmfamily;
VCMFamily = getvcmfamily;


setpv(ConfigSetpoint.(HCMFamily).Setpoint, 0);
setpv(ConfigSetpoint.(VCMFamily).Setpoint, 0);
