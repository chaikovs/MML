function DirectoryName = cddataroot
%CDDATAROOT - Change to the MML data directory
% DirectoryName = cddataroot

DirectoryName = getfamilydata('Directory', 'DataRoot'); 
cd(DirectoryName);

