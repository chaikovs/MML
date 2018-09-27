function UpdateOptics()
%Date=datestr(clock,'mmm-dd-yyyy HH:MM:SS');
%OpticsDir=['Optics_' Date]
%mkdir OpticsDir
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/PhX.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/PhX.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/PhZ.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/PhZ.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/EtaX.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/EtaX.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/EtaZ.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/EtaZ.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/BtX.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/BtX.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/BtZ.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/BtZ.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/AlpX.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/AlpX.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/AlpZ.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/AlpZ.mat'])
%copyfile(['/home/matlabML/machine/SOLEIL/StorageRing/insertions/NuXZ.mat'] ,['/home/matlabML/machine/SOLEIL/StorageRing/insertions/OpticsDir/NuXZ.mat'])

[Phx Phz]=modelphase('BPMx');
Nuxz=modeltune;
[Etax Etaz]=modeldisp('BPMx');
[Btx Btz]=modelbeta('BPMx');
[Alpx Alpz]=modelalpha('BPMx');
save 'PhX.mat' Phx
save 'PhZ.mat' Phz
save 'EtaX.mat' Etax
save 'EtaZ.mat' Etaz
save 'BtX.mat' Btx
save 'BtZ.mat' Btz
save 'AlpX.mat' Alpx
save 'AlpZ.mat' Alpz
save 'NuXZ.mat' Nuxz


