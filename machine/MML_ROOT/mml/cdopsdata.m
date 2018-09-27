function DirectoryName = cdopsdata
%CDOPSDATA - Change to the MML operational data directory
%  DirectoryName = cdopsdata

DirectoryName = getfamilydata('Directory', 'OpsData'); 
cd(DirectoryName);

