function stepalpha1(dnux, dnuz, dalpha1, dalpha2)
% FUNCTION STEPALPHA1 - step tunes and alpha1 (and alpha2) using quadrupole families
%
%  INPUTS
%  1. dnux - horizontal tune variation
%  2. dnuz - vertical tune variation
%  3. dalpha1 - first order momentum compaction variation
%  4. dalpha2 - second order momentum compaction variation
%
%  Notes
%  1. Matrix generation
%  [DKx DKz DtuneVal]   = modeltunesensitivity;
%  [QuadRmcf1 QuadRmcf2]= modelmcfsensitivity('Quad');
%
%  See Also stepalpha2, physics_mcf, modelalpharesponsemat



%
%% Written by Laurent S. Nadolski

InteractiveFlag = 1;

if nargin < 3
    error('Number of input parameters is at least than 3!')
end

% Default families to used
if nargin == 3
    %familyList = [5 7 8]; % anciennes valeurs
    familyList = [5 6 7]; % valeurs décidées le 18 avril 2011, commune à MAHER et AMOR
end

if nargin == 4
    familyList = [5 7 8 10]; % lowalpha MAHER
    %familyList = [2 5 6 7]; % lowalpha AMOR
end

% Load linear response matrices
% These are the sensibility matrices expressed in amperes
% DtuneVal
%

dirName = getfamilydata('Directory','OpsData');
%load([dirName '..' filesep 'lowalpha_dec08' filesep 'Rmatrix_alphaby20_nouveau_modele_dec08_opt_nonlin']);
%load([dirName '..' filesep 'lowalpha_dec08' filesep 'Rmatrix_alphaby20_nouveau_modele_janv10_opt_nonlin']);
FileName = 'Rmatrix_alpha.mat';
DirectoryName = getfamilydata('Directory', 'OpsData');
load(fullfile(DirectoryName, FileName));

QuadFamNumber = length(familyList);
if nargin == 3
    DI = pinv([DtuneVal(:,familyList); QuadRmcf1(familyList)])*[dnux dnuz dalpha1]';
elseif nargin == 4
    %% step tunes and alpha1 and alpha2
    DI = pinv([DtuneVal(:,familyList); QuadRmcf1(familyList); QuadRmcf2(familyList)])*[dnux dnuz dalpha1 dalpha2]';
elseif nargin == 2
    DI = pinv([QuadRmcf1(familyList); QuadRmcf2(familyList)])*[dnux dnuz]';    
else
    error('Wrong number of parameters')
end

%Display variation and ask confirmation
fprintf('\n\n Quadrupole current values to be applied\n');
for iQuad = 1:QuadFamNumber,
    fprintf(sprintf('Quad step for Q%d is %f A\n', familyList(iQuad), DI(iQuad)));
end

if InteractiveFlag

    % Ask user for applying correction
    reply = input('Apply values (Y/n) \n', 's');
    if isempty(reply)
        reply = 'Y';
    end

    switch reply
        case {'y', 'Y'}
            for iQuad = 1:QuadFamNumber,
                sprintf('Q%d',iQuad);
                stepsp(sprintf('Q%d',familyList(iQuad)), DI(iQuad));
            end
            fprintf('Correction applied\n');
        otherwise
            fprintf('Aborting ...\n');
    end
else
    for iQuad = 1:QuadFamNumber,
        sprintf('Q%d',iQuad);
        stepsp(sprintf('Q%d',familyList(iQuad)), DI(iQuad));
    end
    fprintf('Correction applied\n');
end

