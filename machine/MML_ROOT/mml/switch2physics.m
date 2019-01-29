function ErrorFlag = switch2physics(Family)
%SWITCH2PHYSICS - Switch family to physics units
%
%   ErrorFlag = switch2physics(Family)
%
%   Family - Family name string 
%            Matrix of family name strings
%            Cell array of family name strings
%            {Default: All families}
%
%   ErrorFlag - Number of errors that occurred
%
%   See Also switch2hardware, switch2hw

%
%   Written by Gregory J. Portmann


ErrorFlag = 0;

if nargin == 0
    Family = getfamilylist;
end
if isempty(Family)
    Family = getfamilylist;
end


if ischar(Family)
    for i = 1:size(Family,1)
        FamilyNameCell(i) = {deblank(Family(i,:))};
    end
elseif iscell(Family)
    FamilyNameCell = Family;
else
    error('Familyname input must be empty, a string matrix, or a cell array of strings');
end


for i = 1:length(FamilyNameCell)
    AOFamily = getfamilydata(FamilyNameCell{i});
    try
        AllFields = fieldnames(AOFamily);
        for j = 1:length(AllFields)
            if isfield(AOFamily.(AllFields{j}),'Units')
                setfamilydata('Physics', AOFamily.FamilyName, AllFields{j}, 'Units');
            end
        end
    catch
        ErrorFlag = ErrorFlag + 1;
        fprintf('   Error switching %s family to physics units, hence ignored (switch2physics)\n', FamilyNameCell{i});        
    end
end


if ~ErrorFlag
    if length(FamilyNameCell) == 1
        fprintf('   Switched %s family to physics units (%s)\n', FamilyNameCell{1}, datestr(clock,0));
    else
        fprintf('   Switched %d families to physics units (%s)\n', length(FamilyNameCell)-ErrorFlag, datestr(clock,0));
    end
end

