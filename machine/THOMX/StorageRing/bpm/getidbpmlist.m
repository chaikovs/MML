function devlist = getidbpmlist(varargin)
%GETIDPMLIST - Return devicelist of IDBPM in the ring.....
%
%  INPUTS
%  1. CellNumber (optional) - cell number or seet of cell
%
%  OUTPUTS
%  1. devlist - IDBPM devicelist 
%
%  EXAMPLES
%  1. getidpmlist(1) - for cell 1
%  2. getidpmlist([2 3]) - for cells 2 and 3

%
%  Written by Laurent S. Nadolski
% Modified by Jianfeng Zhang for ThomX @ LAL, 08/01/2014

CellNumber = -1;

if ~isempty(varargin)
    CellNumber = varargin{1};
end


devlist = [
1     1
1     2
1     3
1     4
1     5
1     6
1     7
1     8
1     9
1     10
1     11
1     12
          ];

if CellNumber ~= -1
    ind = [];
    for k = 1:length(CellNumber)
        ind = [ind; find(devlist(:,1) == CellNumber(k))];
    end
    devlist = devlist(ind,:);
end
