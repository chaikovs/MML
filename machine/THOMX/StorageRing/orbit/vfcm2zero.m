function vfcm2zero(varargin)
%VFCM2ZERO - Set vertical corrector strengths to zero
%
% vfcm2zero(fraction, nstep)
%
%  INPUTS
%  1. fract - fraction of corrector strength to put to zero
%            {1} means correctors set to zero
%             0.5 means half of the corrector strength set to zero
%  2. nstep - number of step for zeroing correctors {Default: 5}
%  3. Optional - 'Interactive' Wait for user for each step {Default}
%                'NoInteractive' pause 10 s for each step     
%
%  See Also vhcm2zero

%
%  Written by Gregory J. Portmann
%  Adapted by Laurent S. Nadolski


% Input Parser
InteractiveFlag = 1;
DefaultNstep = 10;

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Interactive')
        InteractiveFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoInteractive')
        InteractiveFlag = 0;
        varargin(i) = [];
    end
end

VCORFamily = 'FVCOR';

if length(varargin) < 1
    fract = 1;
else
    fract = varargin{1};
end

if length(varargin) < 2
    nstep = DefaultNstep;
else
    nstep = varargin{2};
end

fprintf('1/ Verifier que le FOFB est arrété\n')
fprintf('2/ Mettre les alimentations des steerers en controle local  via LabVIEW\n')
fprintf('3/ Verifier que le SOFB tourne\n')
fprintf('Si OK presser la touche Entree\n')
pause

fprintf('Lecture des courant des steerers\n')

setpt = fract*getam(VCORFamily);

for k=1:nstep
    if InteractiveFlag
        %disp(['   Step ' num2str(k) ' of ' num2str(nstep) ' Hit Return key to continue (Ctrl-C to stop)']);
        disp(['   Etape ' num2str(k) ' sur ' num2str(nstep) ' Presser Enter pour continuer (Ctrl-C to stop)']);
        pause;
        fprintf('Attendre durant l''application des consignes et vérifier l''orbite ...\n')
        setsp(VCORFamily, (1-k/nstep)*setpt, [], -1);        
    else
        setsp(VCORFamily, (1-k/nstep)*setpt, [], -1);        
        pause(10)
    end
end