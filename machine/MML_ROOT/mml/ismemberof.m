function  [IsTest, Index] = ismemberof(FamilyName, Field, MemberString)
%ISMEMBEROF - Returns turn if the membership information of a family (cell of strings)
%  [MemberOfBooleanVector, Index] = ismemberof(FamilyName, MemberString)
% 
%  If FamilyName is a matrix, then a column of individual ismemberof calls is returned.
%  MemberString must be a string.
%  If the family was not found, then [] is returned.
%
%  An optional Field input can be used to only look through subfields.
%  [MemberOfBooleanVector, Index] = ismemberof(FamilyName, Field, MemberString)
%  Subfield membership is usually not used.
%
% INPUTS
%  1. If FamilyName is a matrix, then a column of individual ismemberof calls is returned.
%  2. MemberString must be a string.
%  If the family was not found, then [] is returned.
%
%
%  See Also getmemberof, findmemberof, isfamily

%
%  Written by Gregory J. Portmann

if nargin < 2
    error('2 inputs required');
end
if nargin == 2
    MemberString = Field;
end

if isstruct(FamilyName)
    if isfield(FamilyName, 'FamilyName')
        FamilyName = FamilyName.FamilyName;
    else
        error('For structure inputs, FamilyName field must exist');
    end
end

IsTest = [];
Index = [];
for i = 1:size(FamilyName,1)
    Family = deblank(FamilyName(i,:));
    if nargin == 2
        IsTest(i,1) = any(strcmpi(MemberString, getmemberof(Family)));
    else
        IsTest(i,1) = any(strcmpi(MemberString, getmemberof(Family, Field)));
    end
    if IsTest(i,1) == 1
        Index = [Index; i];
    end
end
