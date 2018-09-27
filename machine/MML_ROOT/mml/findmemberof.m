function  FamilyName = findmemberof(MemberString, Field)
%FINDMEMBEROF - Finds all family members
%  FamilyName = findmemberof(MemberString, Field)
%  
%  An optional Field input can be used to only look through subfields.
%  FamilyNameCell = findmemberof(MemberString, Field)
%  Subfield membership is usually not used.
%
%  INPUTS
%  1. MemberString - Must be a string or cell array of strings
%  2. Field - Optional field
%
%  OUPUTS
%  1. FamilyName - Cell array of family name (Column cell) 
%                  {} if no member is found
%
%  EXAMPLES
%  1. findmemberof('Magnet')
%
%  See Also getmemberof, ismemberof, isfamily

%
% Written by Gregory J. Portmann
%


if nargin < 1
    error('1 inputs required');
end

FamilyName = {};
FamilyList = getfamilylist;

if nargin >= 2
    % Look for subfield membership
    for i = 1:size(FamilyList,1)
        Family = deblank(FamilyList(i,:));
        if iscell(MemberString)
            Hit = zeros(length(MemberString),1);
            for j = 1:length(MemberString)
                if any(strcmpi(MemberString{j}, getmemberof(Family, Field)))
                    Hit(j) = 1;
                end
            end
            if all(Hit)
                FamilyName = [FamilyName; {Family}];
            end
        else
            if any(strcmpi(MemberString, getmemberof(Family, Field)))
                FamilyName = [FamilyName; {Family}];
            end
        end
    end
else
    % Look for main field membership
    for i = 1:size(FamilyList,1)
        Family = deblank(FamilyList(i,:));
        if iscell(MemberString)
            Hit = zeros(length(MemberString),1);
            for j = 1:length(MemberString)
                if any(strcmpi(MemberString{j}, getmemberof(Family)))
                    Hit(j) = 1;
                end
            end
            if all(Hit)
                FamilyName = [FamilyName; {Family}];
            end
        else
            if any(strcmpi(MemberString, getmemberof(Family)))
                FamilyName = [FamilyName; {Family}];
            end
        end
    end
end
