close all; clear; clc;

%% Init

% Mesh
MeshStructure = bpm_vacuum_chamber_mesh_generation(...
    'NoEcho',...
    'NoDisplay',...
    'ObliqueMesh',30,...
    'VerticalMesh',5,...
    'HorizontalMesh',65);

%% Map of points organization

map_tStart = tic;

% Point generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
step = 0.1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RawMap = get_bpm_nonlinear_response_expert(...
    'MeshStructure',MeshStructure,...
    'BeamPosition',...
    {'Space', 1,'VerticalStepSize', step,'HorizontalStepSize', step,'NoEcho'},...
    'NoEcho',...
    'NoDisplay');

% Assingning shortcuts
FieldNames = fieldnames(RawMap);
for fieldNumber = 1:length(FieldNames)
    DynamicName = genvarname(FieldNames{fieldNumber});
    eval([DynamicName ' = RawMap. ' DynamicName ';']);
end

Q_map = zeros((size(X_beam,1)+1)/2*(size(X_beam,2)+1)/2,4); % Mapping the closer quarter from B electrode
Pos_map = zeros((size(X_beam,1)+1)/2*(size(X_beam,2)+1)/2,2); % Mapping the closer quarter from B electrode
Sum_map = zeros((size(X_beam,1)+1)/2*(size(X_beam,2)+1)/2,1); % Mapping the closer quarter from B electrode

% Map generation
k = 0;
for i = 1:size(X_beam,1)/2+0.5 % Mapping the closer quarter from B electrode 
    for j = 1:size(X_beam,2)/2+0.5 % Mapping the closer quarter from B electrode
        
        k = k + 1;
        
        if isnan(X_beam(i,j)) || isnan(Z_beam(i,j))
            
            Sum_map(k) = [];
            Q_map(k,:) = [];
            Pos_map(k,:) = [];
            
            k = k - 1;
            
        else

            Sum_map(k) = Qa(i,j) + Qb(i,j) + Qc(i,j) + Qd(i,j);
            Q_map(k,:) = [ Qa(i,j) Qb(i,j) Qc(i,j) Qd(i,j) ] / Sum_map(k);
            Pos_map(k,:) = [ X_beam(i,j) Z_beam(i,j) ];
            
        end
        
    end
end

N = length(Sum_map);


%% End

map_tEnd = toc(map_tStart);
display(map_tEnd)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('Map_For_Convergence_01','Pos_map','Q_map','N')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%