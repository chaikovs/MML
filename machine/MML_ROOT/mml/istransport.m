function Test = istransport
%ISTRANSPORT - Is this a transport line?
%
%  See also isstoragering, isbooster


MachineType = getfamilydata('MachineType');

Test = any(strcmpi(MachineType, {'Transport','TransportLine','Transport line'}));
