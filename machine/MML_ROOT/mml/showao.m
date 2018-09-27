function showao(Family)
%SHOWAO - Display the AcceleratorObjects fields containing Tango part
%
%  INPUTS
%  1. Family - Family Name
%
%  See Also getfamilylist, showfamily, isfamily, getfamilytype, printao

%
%  Written by Greogory J. Portmann
%  Modified by Laurent S. Nadolski
%  ChannelNames --> TangoNames

ao = getao;
if nargin < 1
    FieldNameCell = fieldnames(ao);
else
    FieldNameCell = {Family};
end

for i = 1:length(FieldNameCell)
    if isfield(ao, FieldNameCell{i})
        if isfield(ao.(FieldNameCell{i}),'FamilyName')
            fprintf('Family = %s\n', ao.(FieldNameCell{i}).FamilyName);
        end
        % Find all the subfields that are data structures
        SubFieldNameCell = fieldnames(ao.(FieldNameCell{i}));
        for ii = 1:length(SubFieldNameCell)
            if isfield(ao.(FieldNameCell{i}).(SubFieldNameCell{ii}),'TangoNames')
                fprintf('%s.%s\n', ao.(FieldNameCell{i}).FamilyName, SubFieldNameCell{ii});
            end
        end
        fprintf('\n');
    end
end