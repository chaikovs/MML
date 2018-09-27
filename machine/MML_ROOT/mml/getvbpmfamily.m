function Family = getvbpmfamily
%GETVBPMFAMILY - Return the default vertical BPM family
%  Family = getvbpmfamily
%
%  The family name is determined by the MemberOf field equal to 'BPMy' or 'VBPM' 
%
%  NOTES
%  1. Skip extra faimlies if more than one
%
%  See also gethbpmfamily, gethcmfamily, getvcmfamily
%
%  Writen by Greg Portmann

persistent WarningFlag 

Family = findmemberof('BPMy');

if isempty(Family)
    Family = findmemberof('VBPM');
    if isempty(Family)
        %Family = {'BPMy'};
        if isempty(WarningFlag)
            fprintf('\n   No default vertical BPM family has been specified in the MML.\n');
            fprintf('   To define one, add ''BPMy'' or ''VBPM'' to the .MemberOf field for the default family.\n\n');
            WarningFlag = 1;
        end

        Family = {''};
    end
end


Family = Family{1};

