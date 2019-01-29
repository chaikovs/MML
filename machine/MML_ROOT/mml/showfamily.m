function  AO = showfamily(Family)
%SHOWFAMILY - Displays a list of all families
%  AO = showfamily(Family)
%
%  INPUTS
%  1. Family -  Family name {Default: All families}
%  
%  OUTPUTS
%  1. AO - Structure for that family or the entire AO for no inputs
%
%  See also getfamilylist, showfamily, isfamily, getfamilytype

%
%  Written by J. Corbett
% Modified by Laurent S. Nadolski
% ChannelNames --> TangoNames

if nargin < 1
    AO = getao;
    FieldNameCell = fieldnames(AO);
    Ntotal = 0;
    
    for i = 1:length(FieldNameCell)
        if isfield(AO, FieldNameCell{i})
            if isfield(AO.(FieldNameCell{i}),'FamilyName')
                N = size(AO.(FieldNameCell{i}).DeviceList,1);
                fprintf('   Family = %s (%d devices)\n', AO.(FieldNameCell{i}).FamilyName,  N);
            else
                N = 0;
            end
            
            % Find all the subfields that are data structures
            SubFieldNameCell = fieldnames(AO.(FieldNameCell{i}));
            NDeviceFamily = 0;
            for ii = 1:length(SubFieldNameCell)
                if isfield(AO.(FieldNameCell{i}).(SubFieldNameCell{ii}),'TangoNames')  ...
                | isfield(AO.(FieldNameCell{i}).(SubFieldNameCell{ii}),'SpecialFunction')  ... 
                | isfield(AO.(FieldNameCell{i}).(SubFieldNameCell{ii}),'SpecialFunctionGet')  ... 
                | isfield(AO.(FieldNameCell{i}).(SubFieldNameCell{ii}),'SpecialFunctionSet')
                    
                    fprintf('   %s.%s\n', AO.(FieldNameCell{i}).FamilyName, SubFieldNameCell{ii});
                    NDeviceFamily = NDeviceFamily + N;
                    Ntotal = Ntotal + N;
                end
            end
            fprintf('\n');
        end
    end
    fprintf('   The total number of devices is %d\n', Ntotal);
    
else
    
    [Flag, AO] = isfamily(Family);
    
    if ~Flag  
        disp('Warning: Family not found in showfamily'); 
        return; 
    end
    
    fields = fieldnames(AO);
    
    disp('   =============================================');
    fprintf('   Fields contained in Family:  %s (%d devices)\n', AO.FamilyName,  size(AO.DeviceList,1));
    disp('   =============================================');
    for ii=1:length(fields)
        disp(['   ', fields{ii}])
        if isstruct(AO.(fields{ii}))                      %dynamic field names
            subfields=fieldnames(AO.(fields{ii}));
            for jj=1:length(subfields)
                disp(['      ' subfields{jj}])
            end
        end
    end
    fprintf('\n');
    
end
