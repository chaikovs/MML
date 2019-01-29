function printao(FamilyName, DeviceList)
% PRINTAO - print various nomenclautre of a family
%
%  INPUTS
%  1. FamilyName - Family Name
%  2. DeviceList - No working yet
%
%  EXAMPLES
%  1. printao('HCOR')
%
%  See Also showao

%%

if nargin == 0
    FamilyName = 'HCOR';
end


if nargin == 2
    DeviceList_ = DeviceList;
else
    DeviceList_ = [];
end

FamStruct = getfamilydata(FamilyName);
len = length(FamStruct.DeviceList);

Idx = ones(1,len)*nan;
devList_ = FamStruct.DeviceList(find(FamStruct.Status),:)
Idx(find(FamStruct.Status))=1:length(devList_);


fileName = tempname;
Fid = fopen(fileName, 'w');

fprintf(Fid, '\n#############################################################\n');
fprintf(Fid, '#%-30s DevList ElemList Status Index\n', 'DeviceName');
fprintf(Fid, '#############################################################\n');

for k=1:len,
    fprintf(Fid, '%-30s [%2d %2d] %5d % 6d % 6d\n', ...
        FamStruct.DeviceName{k}, FamStruct.DeviceList(k,:), ...
        FamStruct.ElementList(k), FamStruct.Status(k), Idx(k));
end

fprintf(Fid, '#############################################################\n');
fprintf(Fid, 'printed with %s, date: %s\n', mfilename, datestr(now));
fprintf(Fid, '#############################################################\n');

fclose(Fid);
open(fileName);