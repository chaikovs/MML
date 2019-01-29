function Test = isbooster
%ISBOOSTER - Is this a booster ring?
%
%  See also isstoragering, istransport


MachineType = getfamilydata('MachineType');

Test = any(strcmpi(MachineType, {'Booster', 'BoosterRing', 'Booster Ring'}));
