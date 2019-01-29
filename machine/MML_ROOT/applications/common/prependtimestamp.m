function FileName = prependtimestamp(FileName, TimeStamp)
%PREPENDTIMESTAMP - Prepend the time stamp to a file
%  FileName = prpendtimestamp(FileName, TimeStamp)
%
%  INPUTS
%  1. FileName - Filename for appending timestamp
%  2. TimeStamp - TimeStamp string
%
%  OUTPUTS
%  1. FileName - File name modified
%
%  NOTES
%  1. TimeStamp needs to by a vector as output by the Matlab clock function {Default: clock}
%
% See Also appendtimestamp

%
%  Written by Gregory Portmann

if nargin < 1
    error('At least 1 input required');
end
if nargin < 2
    TimeStamp = clock;
end

% Append date_Time to FileName
FileName = sprintf('%s_%s', datestr(TimeStamp,31), FileName);
FileName(11) = '_';
FileName(14) = '-';
FileName(17) = '-';
