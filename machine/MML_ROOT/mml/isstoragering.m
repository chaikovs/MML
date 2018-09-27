function Test = isstoragering
%ISSTORAGERING - Is this a storage ring?
%
%  See also isbooster, istransport


MachineType = getfamilydata('MachineType');

Test = isempty(MachineType) || any(strcmpi(MachineType, {'StorageRing', 'Storage Ring', 'Ring'}));
