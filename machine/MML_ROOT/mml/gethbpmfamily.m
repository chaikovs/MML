function Family = gethbpmfamily
%GETHBPMFAMILY - Return the default horizontal BPM family
%  Family = gethbpmfamily
%
%  The family name is determined by the MemberOf field equal to 'BPMx' or 'HBPM' 
%
%  NOTES
%  1. Skip extra faimlies if more than one
%
%  See also getvbpmfamily, gethcmfamily, getvcmfamily
%
%  Writen by Greg Portmann

persistent WarningFlag 

Family = findmemberof('BPMx');

if isempty(Family)
    Family = findmemberof('HBPM');
    if isempty(Family)
        %Family = {'BPMx'};
        if isempty(WarningFlag)
            fprintf('\n   No default horizontal BPM family has been specified in the MML.\n');
            fprintf('   To define one, add ''BPMx'' or ''HBPM'' to the .MemberOf field for the default family.\n\n');
            WarningFlag = 1;
        end

        Family = {''};
    end
end

Family = Family{1};

