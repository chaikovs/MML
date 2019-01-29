function stepalpha2(dxix, dxiz, dalpha2)
% FUNCTION STEPALPHA2 - step chromaticities and alpha2 using sextupole families
%
%  INPUTS
%  1. dxix - horizontal tune variation
%  2. dxiz - vertical tune variation
%  3. dalpha2 - second order momentum compaction variation
%
%  Notes
%  1. Matrix generation
%  [DSx DSz DchroVal]     = modelchrosensitivity;
%  [SextuRmcf1 SextuRmcf2]= modelmcfsensitivity('Sextu');
%  2. Save matrices for operation
%     [DKx DKz DtuneVal]   = modeltunesensitivity;
%     [DSx DSz DchroVal]   = modelchrosensitivity;
%     [QuadRmcf1 QuadRmcf2]= modelmcfsensitivity('Quad');
%     [SextuRmcf1 SextuRmcf2]=modelmcfsensitivity('Sextu');
%     save('Rmatrix_alphaby10_nouveau_modele_janv10_opt_nonlin', 'DtuneVal', 'DchroVal', 'QuadRmcf1', 'QuadRmcf2', 'SextuRmcf1', 'SextuRmcf2');

%  3. S11 and S1 are linked together
%
%  See Also stepalpha1, physics_mcf, modelmcfsensitivity, modelalpharesponsemat

%
%% Written by Laurent S. Nadolski

InteractiveFlag = 1;

% Check input parameters
if nargin < 3
    error('Number of input parameters is at least than 3!')
end

% Default sextupole families to used
%familyList = [1 4 9]; % low alpha MAHER : ancien choix
%familyList = [10 9 8]; % low alpha AMOR : ancien choix
familyList = [4 9 8]; % low alpha AMOR + MAHER (nouveau choix janvier 2011)

% Load linear response matrices
% These are the sensibility matrices expressed in amperes
% DchroVal
%

dirName = getfamilydata('Directory','OpsData');
%load([dirName '..' filesep 'lowalpha_dec08' filesep 'Rmatrix_alphaby20_nouveau_modele_dec08_opt_nonlin']);
%load([dirName '..' filesep 'lowalpha_dec08' filesep 'Rmatrix_alphaby10_nouveau_modele_janv10_opt_nonlin']);
FileName = 'Rmatrix_alpha.mat';
DirectoryName = getfamilydata('Directory', 'OpsData');
load(fullfile(DirectoryName, FileName));

SextuFamNumber = length(familyList);
if nargin == 3
    %DI= ones(SextuFamNumber,1)*NaN;
    DI = pinv([DchroVal(:,familyList); SextuRmcf2(familyList)])*[dxix; dxiz; dalpha2];
else
    error('Wrong number of parameters')
end

%Display variation and ask confirmation
fprintf('\n\n Sextupole current values to be applied\n');
for iSextu = 1:SextuFamNumber,
    fprintf(sprintf('Sextupole step for S%d is %f A\n', familyList(iSextu), DI(iSextu)));
end

if InteractiveFlag
    % Ask user for applying correction
    reply = input('Apply values (Y/n) \n', 's');
    if isempty(reply)
        reply = 'Y';
    end

    switch reply
        case {'y', 'Y'}
            for iSextu = 1:SextuFamNumber,
                sprintf('S%d',iSextu);
                if familyList(iSextu) == 1, % step also S11
                    stepsp('S11', DI(iSextu));
                end
                stepsp(sprintf('S%d',familyList(iSextu)), DI(iSextu));
            end
            fprintf('Correction applied\n');
        otherwise
            fprintf('Aborting ...\n');
    end
else
    for iSextu = 1:SextuFamNumber,
        sprintf('S%d',iSextu);
        if familyList(iSextu) == 1, % step also S11
            stepsp('S11', DI(iSextu));
        end
        stepsp(sprintf('S%d',familyList(iSextu)), DI(iSextu));
    end
    fprintf('Correction applied\n');
end

