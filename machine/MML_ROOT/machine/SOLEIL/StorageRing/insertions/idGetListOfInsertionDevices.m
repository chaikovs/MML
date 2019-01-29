function res=idGetListOfInsertionDevices(Types)
% idGetListOfInsertionDevices - Returns a (nx3) cell array containing : 
%Alias of idGetParamForUndSOLEIL;
%  OUTPUTS
%  1. a cell array
%       - undulator name
%       - Storage Ring cell number
%       - straight section type

% Types can be :    - a string containing 'InVac' and/or 'Apple2' and/or 'EM'
%                   - 'all' => all IDs (even those unknown or empty Straight Sections)
%                   - ''    => usual types : 'InVac', 'Apple2' and 'EM'

%
%% Written by A.Bence
    
    res2=idGetParamForUndSOLEIL(Types);
    res(:,1)={res2.name};
    res(:,2)={res2.cell};
    res(:,3)={res2.straight};
    res(:,4)={res2.type};
    
