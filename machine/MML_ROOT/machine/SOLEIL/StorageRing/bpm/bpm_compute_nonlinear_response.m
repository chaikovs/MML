function [AM, tout, DataTime, ErrorFlag] = bpm_compute_nonlinear_response( X_beam , Z_beam , MeshStructure )
%BPM_COMPUTE_NONLINEAR_RESPONSE Compute BPM response according to the vacuum chamber and beam position.
%
%  [AM, tout, DataTime, ErrorFlag] = bpm_compute_nonlinear_response( X_beam , Z_beam , MeshStructure )
%
%  INPUTS
%  1. X_beam is the horizontal position of the beam. Can work with getx.
%  2. Z_beam is the vertical position of the beam. Can work with getz.
%  3. MeshStructure is the output of the function bpm_vacuum_chamber_mesh_generation (optional)
%
%  OUTPUTS
%  1. AM = structure containing the response of BPM
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. X_beam and Z_beam must be the same size.
%  2. Unit is millimeter (mm)
%  3. get_bpm_nonlinear_response_expert uses this computation function to plot figures
%  4. get_bpm_nonlinear_response uses this function co compute the response of BPM
%  given by the Orbit in the SIMULATOR.
%
% See also get_bpm_nonlinear_response, bpm_vacuum_chamber_mesh_generation, get_bpm_nonlinear_response_expert

% Written by  B. Beranger, Master 2013

%% Start time

t0 = clock; % starting time for getting data


%% Input control

if nargin < 3
    MeshStructure = bpm_vacuum_chamber_mesh_generation();
end

if nargin < 2
    error('At least X_beam and Z_beam are required')
end

if ~isnumeric(X_beam)
    error('X_beam must be a matrix of horizontal beam poistion')
end

if ~isnumeric(Z_beam)
    error('Z_beam must be a matrix of horizontal beam poistion')
end


if (size(X_beam,1) ~= size(Z_beam,1)) || (size(X_beam,2) ~= size(Z_beam,2))
    error('X_beam and Z_beam must be the same size')
end


%% Shortcuts definition

IndexA = MeshStructure.IndexA;
IndexB = MeshStructure.IndexB;
IndexC = MeshStructure.IndexC;
IndexD = MeshStructure.IndexD;
X_middle_boundary = MeshStructure.X_middle_boundary;
Z_middle_boundary = MeshStructure.Z_middle_boundary;
iG = MeshStructure.iG;


%% Initialization

B = cell(size(X_beam,1),size(X_beam,2));

Sigma = cell(size(X_beam,1),size(X_beam,2));

Qa_ = zeros(size(X_beam,1),size(X_beam,2));
Qb_ = zeros(size(X_beam,1),size(X_beam,2));
Qc_ = zeros(size(X_beam,1),size(X_beam,2));
Qd_ = zeros(size(X_beam,1),size(X_beam,2));

Qa = zeros(size(X_beam,1),size(X_beam,2));
Qb = zeros(size(X_beam,1),size(X_beam,2));
Qc = zeros(size(X_beam,1),size(X_beam,2));
Qd = zeros(size(X_beam,1),size(X_beam,2));

% Kx=11.603074; % Simulated by get_bpm_nonlinear_response_expert : precision = 1 µm to compute
% Kz=11.432151;

Kx=11.4; % Applied in the Libera
Kz=11.4;

X_read = zeros(size(X_beam,1),size(X_beam,2));
Z_read = zeros(size(X_beam,1),size(X_beam,2));

PoissonError = zeros(size(X_beam,1),size(X_beam,2));
NormalisedPoissonError = zeros(size(X_beam,1),size(X_beam,2));


%% Computation of B, Sigma, Q(i), X_readead and Z_readead

for i = 1:size(X_beam,1)
    for j = 1:size(X_beam,2)
        
        % --- In case of NaN values, continue the for loop ---
        if isnan(X_beam(i,j)) || isnan(Z_beam(i,j))
            Qa(i,j) = NaN; %#ok<*FNDSB>
            Qb(i,j) = NaN;
            Qc(i,j) = NaN;
            Qd(i,j) = NaN;
            X_read(i,j) = NaN;
            Z_read(i,j) = NaN;
            PoissonError(i,j) = NaN;
            NormalisedPoissonError(i,j) = NaN;
            continue
        end
        
        % B matrix only depends on the beam position [X_beam,Z_beam] and the vacuum
        % chamber geometry (here, position of middles of segments mesh).
        B{i,j} = -0.5 * log( ( X_beam(i,j) - X_middle_boundary ).^2 + ( Z_beam(i,j) - Z_middle_boundary ).^2 );
        
        % Sigma is a vector containing the charge density over each midles
        % of segments mesh
        Sigma{i,j} = -iG*B{i,j};
        
        % Q(i) corresponds the charge density over each electrode (i)
        Qa_(i,j) = sum(Sigma{i,j}(IndexA)); %#ok<*FNDSB>
        Qb_(i,j) = sum(Sigma{i,j}(IndexB));
        Qc_(i,j) = sum(Sigma{i,j}(IndexC));
        Qd_(i,j) = sum(Sigma{i,j}(IndexD));
        
        % Normalization of potentials
        Qa(i,j) = Qa_(i,j)/(Qa_(i,j) + Qb_(i,j) + Qc_(i,j) + Qd_(i,j));
        Qb(i,j) = Qb_(i,j)/(Qa_(i,j) + Qb_(i,j) + Qc_(i,j) + Qd_(i,j));
        Qc(i,j) = Qc_(i,j)/(Qa_(i,j) + Qb_(i,j) + Qc_(i,j) + Qd_(i,j));
        Qd(i,j) = Qd_(i,j)/(Qa_(i,j) + Qb_(i,j) + Qc_(i,j) + Qd_(i,j));
        
        % [X_read,Z_read] is the position read by the BPM as :
        X_read(i,j) = Kx*( Qa(i,j) + Qd(i,j) - Qb(i,j) - Qc(i,j) )...
            /( Qa(i,j) + Qb(i,j) + Qc(i,j) + Qd(i,j) ); % X_read = Kx * (Va + Vd - Vb - Vc)/(Va + Vb + Vc + Vd)
        Z_read(i,j) = Kz*( Qa(i,j) + Qb(i,j) - Qc(i,j) - Qd(i,j) )...
            /( Qa(i,j) + Qb(i,j) + Qc(i,j) + Qd(i,j) ); % Z_read = Kz * (Va + Vb - Vc - Vd)/(Va + Vb + Vc + Vd)
        
        % PoissonError is the distance between the beam position [X_beam,Z_beam]
        % and the read position [X_read,Z_read]
        PoissonError(i,j) = sqrt( ( X_read(i,j) - X_beam(i,j) ).^2 + ( Z_read(i,j) - Z_beam(i,j) ).^2 );
        
        % NormalisedPoissonError is the normalised (in percentage) distance
        % between the beam position [X_beam,Z_beam] and the read position [X_read,Z_read]
        NormalisedPoissonError(i,j) = PoissonError(i,j)/sqrt( X_beam(i,j).^2 + Z_beam(i,j).^2 )*100;
%         NormalisedPoissonError(i,j) = sqrt( ( ( X_read(i,j) - X_beam(i,j) ) / X_beam(i,j) )^2 + ( ( Z_read(i,j) - Z_beam(i,j) ) / Z_beam(i,j) )^2 ) * 100;
        
    end
end


%% Output

DataTime = now;

AM = struct;
AM.DataDescriptor = 'Degraded response of BPM';
AM.CreatedBy = mfilename;
AM.TimeStampe = datestr(DataTime);
AM.MeshStructure = MeshStructure;
AM.X_beam = X_beam;
AM.Z_beam = Z_beam;
AM.Qa = Qa;
AM.Qb = Qb;
AM.Qc = Qc;
AM.Qd = Qd;
AM.Kx = Kx;
AM.Kz = Kz;
AM.X_read = X_read;
AM.Z_read = Z_read;
AM.PoissonError = PoissonError;
AM.NormalisedPoissonError = NormalisedPoissonError;


ErrorFlag = 0;
tout = etime(clock, t0);

end