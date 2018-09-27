function [DKx DKz DtuneVal]=modeltunesensitivity(varargin)
%TUNESENSITIVITY - Computes quadrupole change for a given tune step
%
%  INPUTS
%  1. dnux - horizontal tune change
%  2. dnuz - vertical tune change
%
%  OUTPUTS
%  1. DKx - gradient change to get dnux
%  2. DKz - gradient change to get dnuz
%
%  See Also modeltunesensitivity

% TODO
% Analytic model.
% Improvements
%  1. Compute beta by tracking through the quad
%  2. Fit everything by tracking

%
%  Written by Laurent S. Nadolski

NumericFlag = 1;

if isempty(varargin)
    dnux = 1e-2;
    dnuz = 1e-2;
elseif nvargin == 1
    dnux = vararing{1};
    dnuz = dnux;
else
    dnux = vararing{1};
    dnuz = vararing{2};
end

global GLOBVAL;

fprintf('   ******** Summary for ''%s'' ********\n', GLOBVAL.LatticeFile);

%fprintf('Quadrupole change for dnux of %f and dnuz = %f \n',dnux,dnuz);

a = findmemberof('QUAD');
% remove nanoscopium
a(12) = [];
a(11) = [];

FamNb= length(a);
DKx = zeros(1,FamNb);
DKz = zeros(1,FamNb);

if ~NumericFlag
    for k = 1:FamNb,

        Family = a{k};

        [betax betaz]= modeltwiss('beta',Family);
        bx = (betax(1)+betax(2))/2;
        bz = (betaz(1)+betaz(2))/2;

        L = getleff(Family);
        NQ = length(getspos(Family));

        DKx(k) = 4*pi*dnux/bx/NQ/L(1);
        DKz(k) = 4*pi*dnuz/bz/NQ/L(1);

        fprintf('%s : DKx = %1.2e DKz = %1.2e betax = %2.2f m betaz = %2.2f m  NQ = %2.0f  L= %1.2f m \n', ...
            Family, DKx(k), DKz(k), bx, bz, NQ, L(1));
    end
else
    DtuneVal  = zeros(2,FamNb)*NaN;

    % Quadrupole variation in Ampere
    StepValue = ones(1,FamNb)*0.1; % A

    fprintf('Quadrupole change for a change of 0.1 A \n');

    for k = 1:FamNb,

        Family = a{k};

        stepsp(Family, 0.5*StepValue(k), 'Model'); % plus delta
        TuneValplus = modeltune;

        stepsp(Family, -StepValue(k), 'Model'); % minus delta
        TuneValminus = modeltune;

        stepsp(Family, 0.5*StepValue(k), 'Model'); % come back to nominal value

        DtuneVal(:,k) = (TuneValplus - TuneValminus) / StepValue(k);

        fprintf('%3s : Dnux = % 1.2e Dnuz = % 1.2e\n', ...
            Family, DtuneVal(1,k), DtuneVal(2,k));
    end
end