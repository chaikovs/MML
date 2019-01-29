function [DtuneVal DchroVal QuadRmcf1 QuadRmcf2 SextuRmcf2] = modelalpharesponsemat(FileName)
% Modelalpharesponsemat - save matrices in Operation directory
%
% TODO Confirmation message if file already existe
%      Merge latttice_prep ?

if nargin <1
    FileName = 'Rmatrix_alpha'; 
end
    
[DKx DKz DtuneVal]   = modeltunesensitivity;
[DSx DSz DchroVal]   = modelchrosensitivity;
[QuadRmcf1 QuadRmcf2]= modelmcfsensitivity('Quad');
[SextuRmcf1 SextuRmcf2]=modelmcfsensitivity('Sextu');

DirectoryName = getfamilydata('Directory', 'OpsData');

DirStart = pwd;
[DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
if ErrorFlag
    fprintf('\n   There was a problem getting to the proper directory!\n\n');
end
save(FileName, 'DtuneVal', 'DchroVal', 'QuadRmcf1', 'QuadRmcf2', 'SextuRmcf1', 'SextuRmcf2');

cd(DirStart);
