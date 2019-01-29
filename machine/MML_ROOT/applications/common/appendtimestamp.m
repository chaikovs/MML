function FileName = appendtimestamp(FileName, TimeStamp)
%APPENDTIMESTAMP - Appends the time stamp to the file
%  FileName = appendtimestamp(FileName, TimeStamp)
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
% See Also prependtimestamp

%
% Written by Gregory J. Portmann

if nargin < 1
    error('At least 1 input required');
end
if nargin < 2
    TimeStamp = clock;
end

% Append date_Time to FileName
FileName = sprintf('%s_%s', FileName, datestr(TimeStamp,31));
FileName(end-8) = '_';
FileName(end-2) = '-';
FileName(end-5) = '-';
