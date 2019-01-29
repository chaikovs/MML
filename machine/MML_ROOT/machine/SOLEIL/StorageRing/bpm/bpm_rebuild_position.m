function [AM, tout, DataTime, ErrorFlag] = bpm_rebuild_position( Potentials, X_start , Z_start , varargin )
%BPM_REBUILD_POSITION Compute the rebuilt position depending on the potentials and positions.
%
%  [AM, tout, DataTime, ErrorFlag] = bpm_rebuild_position( Potentials, X_start , Z_start , varargin )
%
%  INPUTS
%  1. Cell of the potentials from all points such as :
%  Potentials{i,j} = [ Va , Vb , Vc , Vd ]
%  2. X_start is a matrix of horizontal starting position
%  3. Z_start is a matrix of vertical starting position
%  4. varargin : 'MaxIteration', 50
%                'Tolerance', 1e-6
%                'Path'
%                'IterationEcho'
%                'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure
%
%  OUTPUTS
%  1. AM = structure containing the rebuilt position and diagnostics tools
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. size( Potentials ) = size( X_start ) = size( Z_start )
%  2. All inputs in varargin are optional
%  3. varargin : 'MaxIteration', 50                                  -> Maximum number of iteration for the algorithm
%                'Tolerance', 1e-6                                   -> Tolerance is the distance between each iterated point.
%                'Path'//'NoPath'                                    -> Enable // Disable saving each iteration for each point
%                'IterationEcho' // 'NoIterationEcho'                -> Enable // Disable printing echo of iteration for each point
%                'MeshStructure',bpm_vacuum_chamber_mesh_generation  -> Output (structure) of bpm_vacuum_chamber_mesh_generation function
%
% See also bpm_vacuum_chamber_mesh_generation, get_bpm_co_rebuilt,
% get_bpm_rebuilt_position_expert, bpm_approximate_beam_position

% Written by  B. Beranger, Master 2013


%% Start time

t0 = clock; % starting time for getting data


%% Input control

if nargin < 3
    error('Potenials, X_start and Z_start are required')
end

if ~iscell(Potentials)
    error('Potentials must be cell containing vectors of the 4 potentials as : Potentials{i,j} = [ Va , Vb , Vc , Vd ]')
end

if ~isnumeric(X_start)
    error('X_start must be a matrix of horizontal start poistion')
end

if ~isnumeric(Z_start)
    error('Z_start must be a matrix of horizontal start poistion')
end

if (size(Potentials,1) ~= size(X_start,1)) || (size(Potentials,1) ~= size(Z_start,1)) || (size(Potentials,2) ~= size(X_start,2)) || (size(Potentials,2) ~= size(Z_start,2))
    error('Potenials, X_start and Z_start must be the same size')
end


%% Get input flags in varargin

% Default values
MaxIteration = 50;
Tolerance = 1e-6;

LoopOnceFlag = 0; % If the function calls itself, it can only be once

% Flags
PathFlag = 0;
IterationEchoFlag = 0;
MeshFlag = 0;

for i = length(varargin):-1:1
    
    if strcmpi(varargin{i},'Path')
        PathFlag = 1;
        
    elseif strcmpi(varargin{i},'NoPath')
        PathFlag = 0;
        
    elseif strcmpi(varargin{i},'IterationEcho')
        IterationEchoFlag = 1;
        
    elseif strcmpi(varargin{i},'NoIterationEcho')
        IterationEchoFlag = 0;
        
        % --- MaxIteration ---
    elseif strcmpi(varargin{i},'MaxIteration')
        if length(varargin) > i
            % Look for the positive integer as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && varargin{i+1} == round(varargin{i+1})
                if varargin{i+1} < 10
                    warning('Warning:MaxIterationBellowThan10','Usually : MaxIteration > 10')
                end
                MaxIteration = varargin{i+1};
            else
                fprintf('# Problem detected after the field ''%s'' : Parameter must be a positive integer.\n',varargin{i});
            end
        else
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        
        % --- Tolerance ---
    elseif strcmpi(varargin{i},'Tolerance')
        if length(varargin) > i
            % Look for the positive as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0
                if varargin{i+1} > 1
                    warning('Warning:ToleranceBellowThanOne','Usually : Tolerance < 1')
                end
                Tolerance = varargin{i+1};
            else
                fprintf('# Problem detected after the field ''%s'' : Parameter must be positive.\n',varargin{i});
            end
        else
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        
    elseif strcmpi(varargin{i},'MeshStructure')
        if length(varargin) > i
            % Look for the structure as the next input
            if isstruct(varargin{i+1})
                MeshStructure = varargin{i+1};
                MeshFlag = 1;
            else
                fprintf('# Problem detected after the field ''%s'' : Patameter must be structure.\n',varargin{i});
            end
        else
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        
    elseif strcmpi(varargin{i},'LoopOnce')
        LoopOnceFlag = 1;
        
    end
    
end

if MeshFlag == 0
    MeshStructure = bpm_vacuum_chamber_mesh_generation();
end


%% Mesh shortcuts

FieldNames = fieldnames(MeshStructure);
for fieldNumber = 1:length(FieldNames)
    DynamicName = genvarname(FieldNames{fieldNumber});
    eval([DynamicName ' = MeshStructure. ' DynamicName ';']);
end


%% Preparation

X_rebuilt = zeros(size(X_start));
Z_rebuilt = zeros(size(X_start));
det_J =  nan(size(X_start));
Iteration = zeros(size(X_start)); % Number of iterations to converge

if(isscalar(X_start) && isscalar(X_start))
    OnePointFlag = 1;
else
    OnePointFlag = 0;
end

if OnePointFlag || PathFlag
    Xpath = cell(size(X_start)); % Path before correction
    Zpath = cell(size(X_start));
    Xpath_c = cell(size(X_start)); % Path after correction
    Zpath_c = cell(size(X_start));
end

%#ok<*UNRCH>

% --- Lob correction (specific to SOLEIL vacuum chamber geometry and mesh) ---
LobCorrectionFlag = 0;
if LobCorrectionFlag
    Z_Limit = 12.5;  % Z position of the boundary of the vacuum chamber
    X_Lob = 2.8; % X position of the lob's center
    Z_StartCorrection = 11; % Z start correction
    Z_IterationCorrection = 0.5; % Z correction at each iteration
    Z_CorrectionLimit = 22; % Z maximum correction
end

%% Computation of Newton's method

for i = 1:size(X_start,1)
    for j = 1:size(X_start,2)
        
        % --- Initialisation (start point) ---
        Xnew = X_start(i,j);
        Znew = Z_start(i,j);
         
        % --- The for loop will run until tolerance is reached (see below) or until MaxIteration is rached ---
        for iteration = 1:MaxIteration
            
            Xlast = Xnew;
            Zlast = Znew;
            
            % --- In case of NaN values, break the for loop (typically, filtered (unmixed) signals from 'DD' turn-by-turn data)) ---
            if isnan(Xlast) || isnan(Zlast)
                break
            end
            
            
            % --- Expression of the non linear function ---
            
            B = -0.5 * log( ( Xlast - X_middle_boundary ).^2 + ( Zlast - Z_middle_boundary ).^2 );
            Sigma = -iG*B;
            Qa = sum(Sigma(IndexA));
            Qb = sum(Sigma(IndexB));
            Qc = sum(Sigma(IndexC));
            Qd = sum(Sigma(IndexD));
            Sum_Q = Qa + Qb + Qc + Qd;
            Pa = Qa / Sum_Q;
            Pb = Qb / Sum_Q;
            Pc = Qc / Sum_Q;
            Pd = Qd / Sum_Q;
            
            % To sum up : f(x,z) = ( Qa/sum_Q   , Qb/sum_Q   , Qc/sum_Q   , Qd/sum(sum_Q   )
            %                            - ( Qa0/sum_Q0 , Qb0/sum_Q0 , Qc0/sum_Q0 , Qd0/sum_Q0 )
            f = [Pa Pb Pc Pd] ...
                - [Potentials{i,j}(1) Potentials{i,j}(2) Potentials{i,j}(3) Potentials{i,j}(4)]/sum(Potentials{i,j});
            
            
            % --- d(f)/dx  d(f)/dz ---
            
            %  d(f)/dx
            dB_x = - ( Xlast - X_middle_boundary ) ./...
                ( ( Xlast - X_middle_boundary ).^2 + ( Zlast - Z_middle_boundary ).^2 );
            dSigma_x = - iG * dB_x;
            dQa_x = sum(dSigma_x(IndexA));
            dQb_x = sum(dSigma_x(IndexB));
            dQc_x = sum(dSigma_x(IndexC));
            dQd_x = sum(dSigma_x(IndexD));
            Sum_dQ_x = dQa_x + dQb_x + dQc_x + dQd_x;
            dPa_x = ( dQa_x * Sum_Q - Qa * Sum_dQ_x) / Sum_Q^2;
            dPb_x = ( dQb_x * Sum_Q - Qb * Sum_dQ_x) / Sum_Q^2;
            dPc_x = ( dQc_x * Sum_Q - Qc * Sum_dQ_x) / Sum_Q^2;
            dPd_x = ( dQd_x * Sum_Q - Qd * Sum_dQ_x) / Sum_Q^2;
            
            % d(f)/dz
            dB_z = - ( Zlast - Z_middle_boundary ) ./...
                ( ( Xlast - X_middle_boundary ).^2 + ( Zlast - Z_middle_boundary ).^2 );
            dSigma_z = - iG * dB_z;
            dQa_z = sum(dSigma_z(IndexA));
            dQb_z = sum(dSigma_z(IndexB));
            dQc_z = sum(dSigma_z(IndexC));
            dQd_z = sum(dSigma_z(IndexD));
            Sum_dQ_z = dQa_z + dQb_z + dQc_z + dQd_z;
            dPa_z = ( dQa_z * Sum_Q - Qa * Sum_dQ_z) / Sum_Q^2;
            dPb_z = ( dQb_z * Sum_Q - Qb * Sum_dQ_z) / Sum_Q^2;
            dPc_z = ( dQc_z * Sum_Q - Qc * Sum_dQ_z) / Sum_Q^2;
            dPd_z = ( dQd_z * Sum_Q - Qd * Sum_dQ_z) / Sum_Q^2;
            
            % --- J(f) = [ d(f)/dx ; d(f)/dz ] ---
            df_x = [dPa_x dPb_x dPc_x dPd_x];
            df_z = [dPa_z dPb_z dPc_z dPd_z];
            J = [ df_x ; df_z ];
            
            % --- The jacobian matrix is not square, so it approximate the determinant ---
            det_J(i,j) = sqrt( det( J * J' ));
            
            % In case of the approximative determinant is null, the for loop is broken
            if det_J(i,j) == 0
                Xnew = NaN;
                Znew = NaN;
                break
            end
            
            Last = [ Xlast ; Zlast ];
            
            % --- [ Xnew ; Znew ] = [ Xlast ; Zlast ] - f / J(f) ---
            New = Last - ( f / J )';
            
            % Assigning new point
            Xnew = New(1);
            Znew = New(2);
            
            % --- Comparison between the vector defiend by the last point and the new point, and the tolerance ---
            if sqrt( (Xnew - Xlast)^2 + (Znew - Zlast)^2 ) < Tolerance
                break
            end
            
            % Path before correction
            if OnePointFlag || PathFlag
                Xpath{i,j}(iteration) = Xnew;
                Zpath{i,j}(iteration) = Znew;
                %                 display([Xpath{i,j}' Zpath{i,j}']);
            end
            
            % --- Inner algorithme used to converge in the divergent areas near each electrodes (lob) ---
            if LobCorrectionFlag
                if Znew >= Z_Limit && X_start(i,j)>0 % Upper left area
                    Xnew = X_Lob;
                    Znew = Z_StartCorrection - min(iteration*Z_IterationCorrection,Z_CorrectionLimit);
                elseif Znew >= Z_Limit && X_start(i,j)<0  % Upper right area
                    Xnew = -X_Lob;
                    Znew = Z_StartCorrection - min(iteration*Z_IterationCorrection,Z_CorrectionLimit);
                elseif Znew <= -Z_Limit && X_start(i,j)>0  % Lower left area
                    Xnew = X_Lob;
                    Znew = -Z_StartCorrection + min(iteration*Z_IterationCorrection,Z_CorrectionLimit);
                elseif Znew <= -Z_Limit && X_start(i,j)<0 % Lower right area
                    Xnew = -X_Lob;
                    Znew =  -Z_StartCorrection + min(iteration*Z_IterationCorrection,Z_CorrectionLimit);
                end
            end
            
            % Path after correction
            if OnePointFlag || PathFlag
                Xpath_c{i,j}(iteration) = Xnew;
                Zpath_c{i,j}(iteration) = Znew;
            end
            
        end
        
        % --- Saving points ---
        X_rebuilt(i,j) = Xnew;
        Z_rebuilt(i,j) = Znew;
        
        Iteration(i,j) = iteration;
        
        if OnePointFlag || PathFlag
            Xpath{i,j}(iteration) = Xnew;
            Zpath{i,j}(iteration) = Znew;
            Xpath_c{i,j}(iteration) = Xnew;
            Zpath_c{i,j}(iteration) = Znew;
        end
        
        if IterationEchoFlag
            fprintf('\nIteration = %d \t \n i = %d \t j = %d \n',iteration,i,j);
        end
        
        % --- In all cases, if det(j)=0, display a warning message ---
        if det_J(i,j) == 0
            fprintf('\ndet(J) = 0 ==> break at point (%d,%d) \n',i,j);
        end
        
        % --- In case MaxIteration is reached ---
        if (iteration==MaxIteration)
            fprintf('MaxIteration reached at point number ( %d , %d ) \n',i,j);
            X_rebuilt(i,j) = NaN;
            Z_rebuilt(i,j) = NaN;
        end
        
    end
    
end


%% Try to change the start point if determinant is null or if MaxIteration has been reached

if ~LoopOnceFlag % The function can loop on itself juste once
    
    % Collect points that did not converge
    StartPointNumber = 0;
    for i = 1:size(X_start,1)
        for j = 1:size(X_start,2)
            
            if Iteration(i,j) == MaxIteration || det_J(i,j) == 0
                
                StartPointNumber = StartPointNumber + 1;
                
                Bind_approximation(StartPointNumber,:) = [i j]; %#ok<*AGROW>
                Potentials_approximation{StartPointNumber} = Potentials{i,j};
                
            end
            
        end
    end
    
    % New start point of bpm_rebuild_position funchtion is the approximated beam position
    if StartPointNumber ~= 0
        
        NewStartingPoint = bpm_approximate_beam_position( Potentials_approximation );
        
        varargin{end+1} = 'LoopOnce';
        Rebuilt_approximation = bpm_rebuild_position( Potentials_approximation , NewStartingPoint.X_approximated , NewStartingPoint.Z_approximated , varargin{:} );
        
        % Remplace new rebuilt points
        for k = 1:StartPointNumber
            X_rebuilt(Bind_approximation(k,1),Bind_approximation(k,2)) = Rebuilt_approximation.X_rebuilt(k);
            Z_rebuilt(Bind_approximation(k,1),Bind_approximation(k,2)) = Rebuilt_approximation.Z_rebuilt(k);
            det_J(Bind_approximation(k,1),Bind_approximation(k,2)) = Rebuilt_approximation.det_J(k);
            Iteration(Bind_approximation(k,1),Bind_approximation(k,2)) = -Rebuilt_approximation.Iteration(k);
        end
        
    end
    
end

%% Output

DataTime = now;

AM = struct;
AM.DataDescriptor = 'Rebuilt position according to Newton''s inversion';
AM.CreatedBy = mfilename;
AM.TimeStampe = datestr(DataTime);
AM.Potentials = Potentials;
AM.X_start = X_start;
AM.Z_start = Z_start;
AM.MeshStructure = MeshStructure;
AM.Tolerance = Tolerance;
AM.MaxIteration = MaxIteration;
AM.det_J = det_J;
AM.Iteration = Iteration;
AM.X_rebuilt = X_rebuilt;
AM.Z_rebuilt = Z_rebuilt;

if OnePointFlag || PathFlag
    AM.Xpath = Xpath;
    AM.Zpath = Zpath;
    AM.Xpath_c = Xpath_c;
    AM.Zpath_c = Zpath_c;
    
end

ErrorFlag = 0;
tout = etime(clock, t0);

end