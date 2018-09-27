function devlist = getdipolebpmlist(varargin)
%GETIDPMLIST - Return devicelist of dipole based BPMs
%
%  INPUTS
%  1. CellNumber (optional) - cell number or set of cells
%
%  OUTPUTS
%  1. devlist - dipole BPM devicelist 
%
%  EXAMPLES
%  1. getdipolebpmlist(1) - for cell 1
%  2. getdipolebpmlist([2 3]) - for cells 2 and 3
%
%  See Also getidbpmlist


%
%  Written by Laurent S. Nadolski

CellNumber = -1;

if ~isempty(varargin)
    CellNumber = varargin{1};
end

devlist = [
     1     3
     1     4
     1     6
     1     7
     2     3
     2     4
     2     7
     2     8
     3     3
     3     4
     3     7
     3     8
     4     3
     4     4
     4     6
     4     7
     5     3
     5     4
     5     6
     5     7
     6     3
     6     4
     6     7
     6     8
     7     3
     7     4
     6     7
     6     8
     8     3
     8     4
     8     6
     8     7
     9     3
     9     4
     9     6
     9     7
    10     3
    10     4
    10     7
    10     8
    11     3
    11     4
    11     7
    11     8
    12     3
    12     4
    12     6
    12     7
    13     3
    13     4
    13     6
    13     7
    14     3
    14     4
    14     7
    14     8
    15     3
    15     4
    15     7
    15     8
    16     3
    16     4
    16     6
    16     7
];

if CellNumber ~= -1
    ind = [];
    for k = 1:length(CellNumber)
        ind = [ind; find(devlist(:,1) == CellNumber(k))];
    end
    devlist = devlist(ind,:);
end
