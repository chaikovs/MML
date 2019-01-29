function [DSx DSz DchroVal] = modelchrosensitivity(varargin)
%modelchrosensitivity - Computes sextupole change for FamilyList given dxi
%
%  INPUTS 
%  1. dxix - horizontal tune change
%  2. dxiz - vertical tune change
%
%  OUTPUTS
%  1. DSx - sextupole change to get dxix
%  2. DSz - sextupole change to get dxiz
%
%  NOTES
%  1. S11 and S1 are seen as a unique family
%  2. Value depends on the optics for the moment see below the sextu steps  
%
%  See Also modeltunesensitivity, modelmcfsensitivity

%
%  Written by Laurent S. Nadolski

NumericFlag = 1;
Unit = 'Hardware';
Mode = 'Model';
DebugFlag = 0;

timeout = 1; % second

DSx= NaN; DSz=NaN;

% Switchyard factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Model')
        Mode = 'Model';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        Mode = 'Online';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Simulator')
        Mode = 'Simulator';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Physics')
        Unit = 'Physics';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Hardware')
        Unit = 'Hardware';
        varargin(i) = [];
    end
end


if isempty(varargin)
    dxix = 1e-1;
    dxiz = 1e-1;
elseif nvargin == 1
    dxix = varargin{1};
    dxiz = dxix;
end

fprintf('   ******** Summary for ''%s'' ********\n', getlatticename);

%fprintf('Sextupole change for dxix of %f and dxiz = %f \n',dxix,dxiz);

% get all sextupoles
FamilyList = findmemberof('SEXT');


%FamilyList(12) = []; % remove nanoscopium
%FamilyList(11) = []; % S11 seen as same family as S1
% Remove Sall as well

index_ = [];
for ik=1:length(FamilyList),
    if strcmpi(FamilyList(ik), 'Sall') || ...
        strcmpi(FamilyList(ik), 'S11') || ...
        strcmpi(FamilyList(ik), 'S12')
        index_ = [index_ ik];
    end
end
FamilyList(index_) = [];


FamilyNumber= length(FamilyList);

if ~NumericFlag
    for k = 1:FamilyNumber,

        Family = FamilyList{k};

        [bx bz] = modeltwiss('beta',Family);
        [etax etaz] = modeldisp(Family);

        L = getleff(Family);
        NQ = length(getspos(Family));

        DSx(k) =  2*pi*dxix/bx(1)/etax(1)/NQ/L(1);
        DSz(k) = -2*pi*dxiz/bz(1)/etax(1)/NQ/L(1);

        fprintf('%s : DSxL = %1.2e DSzL = %1.2e betax = %2.2f m betaz = %2.2f m etax = %2.2f m NQ = %2.0f  L= %1.2e m \n', ...
            Family, DSx(k)*L(1), DSz(k)*L(1), bx(1), bz(1), etax(1), NQ, L(1));
    end
else
    DchroVal  = zeros(2,FamilyNumber)*NaN;

    % sextupole variation in Ampere
    % alphaby10_nouveau_modele_dec08_opt_lin_1
    %            S1 S2 S3 S4 S5 S6 S7 S8 S9 S10
    StepValue = [10 40 10 10 50 50 50 25 5 10]; % A
    %StepValue = [1 1 1 1 1 1 1 1 1 1]*0.1; % A


    for k = 1:FamilyNumber,

        Family = FamilyList{k};

        if DebugFlag 
            fprintf('%s changed by %f\n', Family,  0.5*StepValue(k));
        end
        
        % step sextupole strength by plus delta
        if strcmp(Family, 'S1') % S1 and S11 are linked
            fprintf('S11 Delta I = %f\n', 0.5*StepValue(k));
            stepsp('S11', 0.5*StepValue(k), ...
                Mode, Unit); % plus delta
        end
        fprintf('%s Delta I = %f\n', Family, 0.5*StepValue(k));
        stepsp(Family, 0.5*StepValue(k), Mode, Unit); % plus delta
        
        
        if strcmp(Mode, 'Model')
            ChroValplus = modelchro(Mode);
        else
            pause(timeout);
            ChroValplus = measchro(Mode, 'NoDisplay');
        end
        if DebugFlag 
            fprintf('Xix = %f Xiz = %f \n', ChroValplus);
        end        

      
        % step sextupole strength to minus delta
        if strcmp(Family, 'S1') % S1 and S11 are linked
            fprintf('S11 Delta I = %f\n', -StepValue(k));
            stepsp('S11', -StepValue(k), Mode, Unit); % minus delta
        end
        fprintf('%s Delta I = %f\n', Family, -StepValue(k));
        stepsp(Family, -StepValue(k), Mode, Unit); % minus delta
        
        if strcmp(Mode, 'Model')
            ChroValminus = modelchro;
        else
            pause(timeout);
            ChroValminus = measchro(Mode, 'NoDisplay');
        end

        if DebugFlag
            fprintf('Xix = %f Xiz = %f \n', ChroValminus);
        end

        DchroVal(:,k) = (ChroValplus - ChroValminus) / StepValue(k);

        % restore sextupole strength to nominal value
        if strcmp(Family, 'S1') % S1 and S11 are linked
            fprintf('S11 Delta I = %f\n', 0.5*StepValue(k));
            stepsp('S11', 0.5*StepValue(k), Mode, Unit);
        end
        fprintf('%s Delta I = %f\n\n', Family, 0.5*StepValue(k));
        stepsp(Family, 0.5*StepValue(k), Mode, Unit); % come back to nominal value
    end
end

for k = 1:FamilyNumber,
    fprintf('%3s (%3.1f A): Dxix = % 1.2e Dxiz = % 1.2e\n', ...
        FamilyList{k}, StepValue(k), DchroVal(1,k)*StepValue(k), ...
        DchroVal(2,k)*StepValue(k));
end
