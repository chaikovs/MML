function  [position angle T] = getdipolesourcepoint(varargin)
%GETDIPOLESOURCEPOINT - Computes beam position and angle at the entrance of a dipole
%                       knowing beam position in upstream and downstream BPMs
%
%  INPUTS
%  1. BeamLine - 'ODE', 'DIFFABS', 'SAMBA', 'ROCK'
%  FLAGS
%  'Physics', 'Hardware'
%  'Display'
%  'Table' - generates tables for TANGO device
%
%  OUTPUTS
%  1. position - H and V beam position in mm {Default} at Dipole entrance
%  2. angle - H and V beam divergence in mrad {Default} at dipole entrance
%  3. T - matrix for computing position [µm] and angle [µrad]
%
%  ALGORITHM
%  Use transfert matrix formalism
%  indices : 1 upstream BPM, 2 downstream BPM
%            (x,x') wanted quantities
%  x   = R11*x1 + R12*x1'
%  x'  = R21*x1 + R22*x1'
%  x2  = U11*x  + R12*x'
%  x2' = U21*x  + R22*x'
%
%
%  NOTES
%  1. Results depends on the corrector strength in between the BPMs and the dipole
%     Firsts estimation shows this can be neglected as a first guess
%  2. Results are expressed at the entrance of the dipole (as a reference) and not
%     at exactly the photon exit port.
% 
%  TODO
%  1. Does not work with split dipole
%

%
%  Written by Laurent S. Nadolski

UnitsFlag = 'Hardware';
DisplayFlag = 0;
BeamLine = {};
TableFlag = 0;

FullList = {'ODE', 'SMIS', 'AILES', 'MARS', 'DISCO', 'METRO','SAMBA', 'ROCK', 'DIFFABS'};
CompleteList = {'ODE', 'SMIS', 'AILES', 'MARS', 'DISCO', 'METRO','SAMBA', 'ROCK', 'DIFFABS'...
    ,'DIP-C15-D2','DIP-C16-D1'};

if isempty(varargin)
    BeamLine = FullList
end

for i = length(varargin):-1:1
    if iscell(varargin{i})
        BeamLine =  varargin{i};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Physics')
        UnitsFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Hardware')
        UnitsFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Table')
        TableFlag = 1;
        varargin(i) = [];
    elseif any(strcmpi(varargin{i},CompleteList))
        BeamLine =  [BeamLine, varargin{i}];
        varargin(i) = [];
    elseif strcmpi(varargin{i}, 'All')
        BeamLine =  FullList;
        varargin(i) = [];
    end
end

global THERING

%%
% ODE     second dipole of cell 01 exit port 1°
% SMIS    first dipole of cell 02
% AILES   first dipole of cell 03
% MARS    first dipole of cell 03
% DISCO   second dipole of cell 04 exit port 1°
% METRO   second dipole of cell 05 exit port 1°
% SAMBA   second dipole of cell 09 exit port 1°
% ROCK   second dipole of cell 12 exit port 1°
% DIFFABS second dipole of cell 13 exit port 1°

% Dipole
DipoleAtindex = family2atindex('BEND');

for k1 = 1: length(BeamLine),
    switch BeamLine{k1}
        case 'DIP-C01-D1'
            BPMDeviceList = [1 3; 1 4];
            PortIdx = DipoleAtindex(1);
        case 'ODE'
            BPMDeviceList = [1 6; 1 7];
            PortIdx = DipoleAtindex(2);
        case 'SMIS'
            BPMDeviceList = [2 3; 2 4];
            PortIdx = DipoleAtindex(3);
        case 'DIP-C02-D2'
            BPMDeviceList = [2 7; 2 8];
            PortIdx = DipoleAtindex(4);
        case 'MARS'
            BPMDeviceList = [3 3; 3 4];
            PortIdx = DipoleAtindex(5);
        case 'AILES'
            BPMDeviceList = [3 3; 3 4];
            PortIdx = DipoleAtindex(5);
        case 'DIP-C03-D2'
            BPMDeviceList = [3 7; 3 8];
            PortIdx = DipoleAtindex(6);
        case 'DIP-C04-D1'
            BPMDeviceList = [4 3; 4 4];
            PortIdx = DipoleAtindex(7);
        case 'DISCO'
            BPMDeviceList = [4 6; 4 7];
            PortIdx = DipoleAtindex(8);
        case 'DIP-C05-D1'
            BPMDeviceList = [5 3; 5 4];
            PortIdx = DipoleAtindex(9);
        case 'METRO'
            BPMDeviceList = [5 6; 5 7];
            PortIdx = DipoleAtindex(10);
        case 'DIP-C06-D1'
            BPMDeviceList = [6 3; 6 4];
            PortIdx = DipoleAtindex(11);
        case 'DIP-C06-D2'
            BPMDeviceList = [6 7; 6 8];
            PortIdx = DipoleAtindex(12);
        case 'DIP-C07-D1'
            BPMDeviceList = [7 3; 7 4];
            PortIdx = DipoleAtindex(13);
        case 'DIP-C07-D2'
            BPMDeviceList = [7 7; 7 8];
            PortIdx = DipoleAtindex(14);
        case 'DIP-C08-D1'
            BPMDeviceList = [8 3; 8 4];
            PortIdx = DipoleAtindex(15);
        case 'DIP-C08-D2'
            BPMDeviceList = [8 6; 8 7];
            PortIdx = DipoleAtindex(16);
        case 'DIP-C09-D1'
            BPMDeviceList = [9 3; 9 4];
            PortIdx = DipoleAtindex(17);
        case 'SAMBA'
            BPMDeviceList = [9 6; 9 7];
            PortIdx = DipoleAtindex(18);
        case 'DIP-C10-D1'
            BPMDeviceList = [10 3; 14 4];
            PortIdx = DipoleAtindex(19);
        case 'DIP-C10-D2'
            BPMDeviceList = [14 7; 14 8];
            PortIdx = DipoleAtindex(20);
        case 'DIP-C11-D1'
            BPMDeviceList = [11 3; 11 4];
            PortIdx = DipoleAtindex(21);
        case 'DIP-C11-D2'
            BPMDeviceList = [11 7; 11 8];
            PortIdx = DipoleAtindex(22);
        case 'DIP-C12-D1'
            BPMDeviceList = [12 3; 12 4];
            PortIdx = DipoleAtindex(23);
        case 'ROCK'
            BPMDeviceList = [12 6; 12 7];
            PortIdx = DipoleAtindex(24);
        case 'DIP-C13-D1'
            BPMDeviceList = [13 3; 13 4];
            PortIdx = DipoleAtindex(25);
        case 'DIFFABS'
            BPMDeviceList = [13 6; 13 7];
            PortIdx = DipoleAtindex(26);
        case 'DIP-C14-D1'
            BPMDeviceList = [14 3; 14 4];
            PortIdx = DipoleAtindex(27);
        case 'DIP-C14-D2'
            BPMDeviceList = [14 7; 14 8];
            PortIdx = DipoleAtindex(28);
        case 'DIP-C15-D1'
            BPMDeviceList = [15 3; 15 4];
            PortIdx = DipoleAtindex(29);
        case 'DIP-C15-D2'
            BPMDeviceList = [15 7; 15 8];
            PortIdx = DipoleAtindex(30);
        case 'DIP-C16-D1'
            BPMDeviceList = [16 3;16 4];
            PortIdx = DipoleAtindex(31);
        case 'DIP-C16-D2'
            BPMDeviceList = [16 6;16 7];
            PortIdx = DipoleAtindex(32);
        otherwise
            error('Beamline not known')
    end

    BPMIdx = family2atindex('BPMx', BPMDeviceList);

    % save and zero corrector in the model
    hcm0 = getsp('HCOR', 'Model');
    vcm0 = getsp('VCOR', 'Model');

    setsp('HCOR', 0, 'Model');
    setsp('VCOR', 0, 'Model');

    % Computes Transfer matrix between first BPM and exit port
    M44full = eye(4);
    for k = BPMIdx(1):PortIdx-1,
        R = findelemm44(THERING{k},THERING{k}.PassMethod,[0 0 0 0 0 0]');
        M44full = R*M44full;
    end
    R = M44full;

    % Computes Transfer matrix between both BPMs
    M44full = eye(4);
    for k = BPMIdx(1):BPMIdx(2),
        U = findelemm44(THERING{k},THERING{k}.PassMethod,[0 0 0 0 0 0]');
        M44full = U*M44full;
    end
    U = M44full;


    % restore corrector in the model
    setsp('HCOR', hcm0, 'Model');
    setsp('VCOR', vcm0, 'Model');

    % Computes Matrix to get position and angle at exit port knowing Position at upstream and downstream BPMs
    T = eye(4);
    T(1,1) = (R(1,1) - R(1,2)*U(1,1)/U(1,2));
    T(3,3) = (R(3,3) - R(3,4)*U(3,3)/U(3,4));
    T(1,2) = R(1,2)/U(1,2);
    T(3,4) = R(3,4)/U(3,4);
    T(2,1) = (R(2,1) - R(2,2)*U(1,1)/U(1,2));
    T(4,3) = (R(4,3) - R(4,4)*U(3,3)/U(3,4));
    T(2,2) = R(2,2)/U(1,2);
    T(4,4) = R(4,4)/U(3,4);

    %
    PosAngle = T*[getam('BPMx', BPMDeviceList,'Physics'); getam('BPMz', BPMDeviceList,'Physics')];

    % convert back to Physics units per defaults
    if ~strcmpi(UnitsFlag,'Physics')
        position(k1, :) = physics2hw('BPMx', 'Monitor', PosAngle([1 3]), BPMDeviceList);
        angle(k1, :)    = physics2hw('BPMx', 'Monitor', PosAngle([2 4]), BPMDeviceList);
    end

    % Tables to put into TANGO
    if TableFlag
        fprintf('%s Tij  %s and %s \n', BeamLine{k1}, cell2mat(family2tango('BPMx',BPMDeviceList(1,:))), cell2mat(family2tango('BPMx',BPMDeviceList(2,:))));
        fprintf('T11 = % f T12 = % f\n',   T(1,1)*1e3, T(1,2)*1e3);
        fprintf('T21 = % f T22 = % f\n',   T(2,1)*1e3, T(2,2)*1e3);
        fprintf('%s Tij  %s and %s \n', BeamLine{k1}, cell2mat(family2tango('BPMz',BPMDeviceList(1,:))), cell2mat(family2tango('BPMz',BPMDeviceList(2,:))));
        fprintf('T33 = % f T34 = % f\n',   T(3,3)*1e3, T(3,4)*1e3);
        fprintf('T43 = % f T44 = % f\n\n', T(4,3)*1e3, T(4,4)*1e3);
    end

    if DisplayFlag
        Orbit1 = findorbit4(THERING, 0, BPMIdx(1));
        Orbit2 = findorbit4(THERING, 0, BPMIdx(2));

        PosAngle = T*[Orbit1(1);  Orbit2(1); Orbit1(3); Orbit2(3)]
        Orbit    = findorbit4(THERING, 0, PortIdx)
    end
end



end

function validate


BPMIdx = family2atindex('BPMx',[1 6; 1 7]);

% get transfer matrix, T, for a given element
% T = findelemm44(THERING{15},THERING{15}.PassMethod,[0 0 0 0 0 0]')

% from BPM to BPM
M44full = eye(4);

for k = BPMIdx(1):BPMIdx(2),
    T = findelemm44(THERING{k},THERING{k}.PassMethod,[0 0 0 0 0 0]');
    M44full = T*M44full;
end

%%
% analytique solution
[betx betz] = modelbeta('BPMx', [1 6; 1 7]);
[alpx alpz] = modeltwiss('alpha', 'BPMx', [1 6; 1 7]);
[phix phiz] = modelphase('BPMx', [1 6; 1 7]);

M44fullana = eye(4);

M44fullana(1,1) =  sqrt(betx(2)/betx(1))*(cos(phix(2)-phix(1)) + alpx(1)*sin(phix(2)-phix(1)));
M44fullana(1,2) =  sqrt(betx(2)*betx(1))*sin(phix(2)-phix(1));
M44fullana(2,1) =  -((1+alpx(1)*alpx(2)) * sin(phix(2)-phix(1)) + (alpx(2) - alpx(1))*cos(phix(2)-phix(1)))/sqrt(betx(2)*betx(1));
M44fullana(2,2) =  (cos(phix(2)-phix(1)) - alpx(2) * sin(phix(2)-phix(1)))/sqrt(betx(2)/betx(1));

M44fullana(3,3) =  sqrt(betz(2)/betz(1))*(cos(phiz(2)-phiz(1)) + alpz(1)*sin(phiz(2)-phiz(1)));
M44fullana(3,4) =  sqrt(betz(2)*betz(1))*sin(phiz(2)-phiz(1));
M44fullana(4,3) =  -((1+alpz(1)*alpz(2)) * sin(phiz(2)-phiz(1)) + (alpz(2) - alpz(1))*cos(phiz(2)-phiz(1)))/sqrt(betz(2)*betz(1));
M44fullana(4,4) =  (cos(phiz(2)-phiz(1)) - alpz(2) * sin(phiz(2)-phiz(1)))/sqrt(betz(2)/betz(1));

det(M44fullana)

%%

M44full
M44fullana

%%
Orbit = findorbit4(THERING, 0, PortIdx)

%%
Orbit = findorbit4(THERING, 0, BPMIdx(1));
R*Orbit(1:4)
Orbit = findorbit4(THERING, 0, PortIdx)

%%
Orbit = findorbit4(THERING, 0, PortIdx);
U*Orbit(1:4)
Orbit = findorbit4(THERING, 0, BPMIdx(2))

%%
Orbit = findorbit4(THERING, 0, BPMIdx(1));
U*R*Orbit(1:4)
Orbit = findorbit4(THERING, 0, BPMIdx(2))

%%
Orbit1 = findorbit4(THERING, 0, BPMIdx(1));
Orbit2 = findorbit4(THERING, 0, BPMIdx(2));
PosAngle = T*[Orbit1(1);  Orbit2(1); Orbit1(3); Orbit2(3)]
Orbit = findorbit4(THERING, 0, PortIdx)
end
