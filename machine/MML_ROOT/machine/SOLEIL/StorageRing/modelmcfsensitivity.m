function [Rmcf1 Rmcf2]=modelmcfsensitivity(varargin)
%modelmcfsensitivity - Computes 1st and 2nd mcf variation with quadrupole 
% and/or sextupole family magnets
%  INPUTS
%  'Quad'/'NoQuad'- Compute or not mcf variation versus quadrupoles
%  'Sextu'/'NoSextu'- Compute or not mcf variation versus quadrupoles
%
%  OUTPUTS
%  1. Rmcf1  - first order mcf response matrix
%  2. Rmcf2  - second order mcf response matrix
%
%  NOTES
%  1. S11 and S1 are seen as a unique family
%  2. Value depends on the optics for the moment see below the sextu steps  
%
%  See Also modeltunesensitivity, modechrosensitivity
%
%  Written by Laurent S. Nadolski

FirstOrderFlag = 0;
QuadFlag  = 0;
SextuFlag = 0;

% Flag factory parser
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Quad')
        QuadFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoQuad')
        QuadFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Sextu')
        SextuFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoSextu')
        SextuFlag = 0;
        varargin(i) = [];
    end
end

fprintf('   ******** Summary for ''%s'' ********\n', getlatticename);

quadFamList = findmemberof('QUAD');

if QuadFlag
    % remove nanoscopium
    quadFamList(12) = [];
    quadFamList(11) = [];
    % intitialization
    FamilyNumber= length(quadFamList);
    Rmcf1 = zeros(1,FamilyNumber);
    Rmcf2 = zeros(1,FamilyNumber);

    % Quadrupole variation in Ampere
    StepValue = ones(1,FamilyNumber)*0.1; % A

    fprintf('Quadrupole change for quadFamList change of %f A \n', StepValue(1));
    for k = 1:FamilyNumber,

        Family = quadFamList{k};

        stepsp(Family, 0.5*StepValue(k), 'Model'); % plus delta

        % Compute momentum compaction factor
        if FirstOrderFlag
            mcf1plus = getmcf('Model'); %linear value

            stepsp(Family, -StepValue(k), 'Model'); % minus delta

            mcf1minus = getmcf('Model');
        else
            [mcf1plus mcf2plus] = physics_mcf('Nodisplay'); %by fitting
           
            stepsp(Family, -StepValue(k), 'Model'); % minus delta

            [mcf1minus mcf2minus] = physics_mcf('Nodisplay');
        end

        stepsp(Family, 0.5*StepValue(k), 'Model'); % go back to nominal value

        % first mcf response matrix per Ampere
        Rmcf1(k) = (mcf1plus - mcf1minus) / StepValue(k);
        if ~FirstOrderFlag
            % second order mcf response matrix per Ampere
            Rmcf2(k) = (mcf2plus - mcf2minus) / StepValue(k);
            fprintf('%4s (1A): Delta MCF1 = %+1.2e Delta MCF2 = %+1.2e\n', ...
                Family, Rmcf1(k), Rmcf2(k));
        else
            fprintf('%4s (1A): Delta MCF1 = %1.2e\n', Family, Rmcf1(k));
        end

    end
end

if SextuFlag

    sextuFamList = findmemberof('Sext');
    sextuFamList(12) = []; % nanoscopium
    sextuFamList(11) = []; % S11 is linked to S1

    FamilyNumber= length(sextuFamList);
    Rmcf1  = zeros(1,FamilyNumber);
    Rmcf2 = zeros(1,FamilyNumber);

    % Sextupole variation in Ampere
    StepValue = ones(1,FamilyNumber)*0.1; % A

    fprintf('Sextupole change for sextuFamList change of %f A \n', StepValue(1));
    for k = 1:FamilyNumber,

        Family = sextuFamList{k};
       
        % step sextupole strength by  plus delta
        if strcmp(Family, 'S1') % S1 and S11 are linked
            stepsp('S11', 0.5*StepValue(k), 'Model'); % minus delta
        end
        stepsp(Family, 0.5*StepValue(k), 'Model');
        

        if FirstOrderFlag
            mcf1plus = getmcf('Model');

            stepsp(Family, -StepValue(k), 'Model'); % minus delta

            mcf1minus = getmcf('Model');
        else
            [mcf1plus mcf2plus] = physics_mcf('Nodisplay');           

            % step sextupole strength to minus delta
            if strcmp(Family, 'S1') % S1 and S11 are linked
                stepsp('S11', -StepValue(k), 'Model'); % minus delta
            end
            stepsp(Family, -StepValue(k), 'Model'); % minus delta
            
            [mcf1minus mcf2minus] = physics_mcf('Nodisplay');           
        end

        % First order mcf Response matrix per Ampere
        Rmcf1(k) = (mcf1plus - mcf1minus) / StepValue(k);

        % restore sextupole strength to nominal values
        if strcmp(Family, 'S1') % S1 and S11 are linked
            stepsp('S11', 0.5*StepValue(k), 'Model'); 
        end
        stepsp(Family, 0.5*StepValue(k), 'Model'); % come back to nominal value
         
        if FirstOrderFlag
            fprintf('%4s (1A): Delta MCF1 = %1.2e\n', ...
                Family, Rmcf1(k));
        else
            % Second order Response matrix per Ampere
            Rmcf2(k) = (mcf2plus - mcf2minus) / StepValue(k);
            fprintf('%4s (1A) : Delta MCF1 = %+1.2e Delta MCF2 = %+1.2e\n', ...
                Family, Rmcf1(k), Rmcf2(k));
        end
    end
end