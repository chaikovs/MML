function [AM, tout, DataTime, ErrorFlag] = bpm_approximate_beam_position( Potentials )
%BPM_APPROXIMATE_BEAM_POSITION Approximate the position of beam depending on
%  the potentials in the cell.
%  Each element of the cell is a vector of the four potentials read on BPM.
%  Potentials can be real or simulated : they will be normalized.
%  WARNING : When the supposed beam position is too closed from Z = 0, the
%  algorithm can converge to a wrong point.
%
%  [AM, tout, DataTime, ErrorFlag] = bpm_approximate_beam_position( Potentials )
%
%  INPUTS
%  1. Cell of the potentials from all points such as : 
%  Potentials{i,j} = [ Va , Vb , Vc , Vd ]
%
%  OUTPUTS
%  1. AM = structure containing approximated beam position
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. Each element of the cell is a vector of the four potentials read on BPM
%  2. Potentials can be real or simulated : they will be normalized
%  3. WARNING : When the supposed beam position is too closed from Z = 0, the
%  algorithm can converge to a wrong point.
%
% See also bpm_rebuild_position, get_bpm_co_rebuilt,
% get_bpm_rebuilt_position_expert

% Written by  B. Beranger, Master 2013

%% Start time

t0 = clock; % starting time for getting data


%% Input control

if nargin < 1
    error('bpm_approximate_beam_position:NoInputArgument','No input argument')
elseif nargin > 1
    error('bpm_approximate_beam_position:TooManyInputArguments','Too many input arguments')
end

if ~iscell(Potentials)
    error('Potentials must be cell containing vectors of the 4 potentials as : Potentials{i,j} = [ Va , Vb , Vc , Vd ]')
end


%% Load map of points

% "_01" in "Map_For_Convergence_01" means the distance betwwen each points
% of the map is 0.10 mm
load Map_For_Convergence_01.mat


%% Initialisation

Normalized_potentials = cell(size(Potentials));
X_approximated = zeros(size(Potentials));
Z_approximated = zeros(size(Potentials));
Projected_potentials = cell(size(Potentials));


%% Computation

for i = 1:size(Potentials,1)
    for j = 1:size(Potentials,2)
        
        % Check if there is 4 potentials in this element
        if length(Potentials{i,j}) ~= 4
            error('bpm_approximate_beam_position:CellElementSize','The vector in Potentials{%d,%d} must contain 4 potentials : Potentials{%d,%d} = [Va Vb Vc Vd]',i,j)
        end
        
        % Normalise potentials
        Normalized_potentials{i,j} = [Potentials{i,j}(1) Potentials{i,j}(2) Potentials{i,j}(3) Potentials{i,j}(4)]/sum(Potentials{i,j});

        % Projection of random points on the map
        Norm_map = zeros(N,1);
        
        if isnan(Potentials{i,j}) % If NaN in the element,
            X_approximated(i,j) = NaN;
            Z_approximated(i,j) = NaN;
            
        else
            % Swap flags : Using the symetry of BPM, the map only exixst in the quarter closed from B
            % electrode to reduce computation time.
            Swap_A_Flag = 0;
            Swap_C_Flag = 0;
            Swap_D_Flag = 0;
            
            % Shortcuts (used in cas of no swap)
            Q_a = Normalized_potentials{i,j}(1);
            Q_b = Normalized_potentials{i,j}(2);
            Q_c = Normalized_potentials{i,j}(3);
            Q_d = Normalized_potentials{i,j}(4);
            
            
            if Q_a >= Q_b  && Q_a >= Q_d % Swap if X > 0 and Z > 0
                Swap_A_Flag = 1;
                Q_a = Normalized_potentials{i,j}(2);
                Q_b = Normalized_potentials{i,j}(1);
                Q_c = Normalized_potentials{i,j}(4);
                Q_d = Normalized_potentials{i,j}(3);
                
            elseif Q_c >= Q_b && Q_c >= Q_d % Swap if X < 0 and Z < 0
                Swap_C_Flag = 1;
                Q_a = Normalized_potentials{i,j}(4);
                Q_b = Normalized_potentials{i,j}(3);
                Q_c = Normalized_potentials{i,j}(2);
                Q_d = Normalized_potentials{i,j}(1);
                
            elseif Q_d >= Q_a && Q_d >= Q_c % Swap if X > 0 and Z < 0
                Swap_D_Flag = 1;
                Q_a = Normalized_potentials{i,j}(3);
                Q_b = Normalized_potentials{i,j}(4);
                Q_c = Normalized_potentials{i,j}(1);
                Q_d = Normalized_potentials{i,j}(2);
                
            end
            
            % Distance between the the potentials ion input and all the
            % potentials in the map
            for k = 1:N
                Norm_map(k) = norm(Q_map(k,:)- [Q_a Q_b Q_c Q_d]); %#ok<*NODEF>
            end
            
            % Take the minimum distance
            [~,Pos_index] = min( Norm_map(:) );
            
            % Inverse the swap
            if Swap_A_Flag
                X_proj = -Pos_map(Pos_index,1);
                Z_proj = Pos_map(Pos_index,2);
                Projected_potentials{i,j}(1) = Q_map(Pos_index,2);
                Projected_potentials{i,j}(2) = Q_map(Pos_index,1);
                Projected_potentials{i,j}(3) = Q_map(Pos_index,4);
                Projected_potentials{i,j}(4) = Q_map(Pos_index,3);
                
            elseif Swap_C_Flag
                X_proj = Pos_map(Pos_index,1);
                Z_proj = -Pos_map(Pos_index,2);
                Projected_potentials{i,j}(1) = Q_map(Pos_index,4);
                Projected_potentials{i,j}(2) = Q_map(Pos_index,3);
                Projected_potentials{i,j}(3) = Q_map(Pos_index,2);
                Projected_potentials{i,j}(4) = Q_map(Pos_index,1);
                
            elseif Swap_D_Flag
                X_proj = -Pos_map(Pos_index,1);
                Z_proj = -Pos_map(Pos_index,2);
                Projected_potentials{i,j}(1) = Q_map(Pos_index,3);
                Projected_potentials{i,j}(2) = Q_map(Pos_index,4);
                Projected_potentials{i,j}(3) = Q_map(Pos_index,1);
                Projected_potentials{i,j}(4) = Q_map(Pos_index,2);
                
            else
                X_proj = Pos_map(Pos_index,1);
                Z_proj = Pos_map(Pos_index,2);
                Projected_potentials{i,j}(1) = Q_map(Pos_index,1);
                Projected_potentials{i,j}(2) = Q_map(Pos_index,2);
                Projected_potentials{i,j}(3) = Q_map(Pos_index,3);
                Projected_potentials{i,j}(4) = Q_map(Pos_index,4);
                
            end
            
            X_approximated(i,j) = X_proj;
            Z_approximated(i,j) = Z_proj;
            
        end
        
    end
end


%% Output

DataTime = now;

AM = struct;
AM.DataDescriptor = 'Approximation of beam position';
AM.CreatedBy = mfilename;
AM.TimeStampe = datestr(DataTime);

AM.Potentials = Potentials;
AM.Normalized_potentials = Normalized_potentials;
AM.Projected_potentials = Projected_potentials;
AM.X_approximated = X_approximated;
AM.Z_approximated = Z_approximated;


ErrorFlag = 0;
tout = etime(clock, t0);

end

