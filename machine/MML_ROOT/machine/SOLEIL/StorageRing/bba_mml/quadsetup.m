function quadsetup(DirName)
% QUADSETUP - Define directory for BBA measurement
%
%  See Also quadcenter

%
% Written by Laurent S. Nadolski


% current BBA root directory
RootDirectory = getfamilydata('Directory', 'BBA');
% save data in
AD = getad;
AD.Directory.BBAcurrent = DirName;
fprintf('Current BBA directory: %s\n', AD.Directory.BBAcurrent);
setad(AD);
