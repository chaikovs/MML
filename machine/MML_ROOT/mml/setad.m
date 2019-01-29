function  setad(AD)
%SETAD - Sets the MML AcceleratorData cell array to appdata
%  setad(AD)
%
% INPUTS 
% 1. Accelerator Data Structure
%
% See also getad

%
% Written by Gregory J. Portmann

if ~isempty(AD)
    setappdata(0,'AcceleratorData', orderfields(AD));
else
    setappdata(0,'AcceleratorData', AD);
end