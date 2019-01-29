function Family = getvcmfamily
%GETVCMFAMILY - Returns the default vertical corrector family
%  Family = getvcmfamily
%
%  The family name is determined by the MemberOf field equal to 'VCM' 
%
%  See also gethbpmfamily, getvbpmfamily, gethcmfamily
%
%  Writen by Greg Portmann

persistent WarningFlag 

Family = findmemberof('VCM');

if isempty(Family)
    Family = findmemberof('VCOR');
    if isempty(Family)
        %Family = {'VCM'};
        if isempty(WarningFlag)
            fprintf('\n   No default vertical corrector family has been specified in the MML.\n');
            fprintf('   To define one, add ''VCM'' or ''VCOR'' to the .MemberOf field for the default family.\n\n');
            WarningFlag = 1;
        end

        Family = {''};
    end
end

Family = Family{1};

