function outStruct = getRF_CAV_Infos
%  getRF_CAV_Infos - return cavity informations
%
%  OUTPUT
%  1. getRF_CAV_Infos with information about position of cavities 
%
%  NOTES
%  1. Machine specific
%
%  See Also drawlattice

%
%% Written by A. Bence

outStruct=struct([]);
outStruct(1).sectLenBwBPMs = 2.*3.14155; %(m) straight section length between BPMs
outStruct(1).cavCenPos = -0.735; %(m) center longitudinal position of the Cavity with respect to the straight section center
outStruct(1).cavLen = 1.470; %(m) CAV length
outStruct(1).indUpstrBPM = 15; %absolute index of BPM at the upstream edge of the straight section where the ID is located
outStruct(1).indRelBPMs = [3 1;3 2]; %relative indexes of upstream and downstream BPMs of the straight section where the CAV is located

outStruct(2).sectLenBwBPMs = 2.*3.14155; %(m) straight section length between BPMs
outStruct(2).cavCenPos = 0.735; %(m) center longitudinal position of the Cavity with respect to the straight section center
outStruct(2).cavLen = 1.470; %(m) CAV length
outStruct(2).indUpstrBPM = 15; %absolute index of BPM at the upstream edge of the straight section where the ID is located
outStruct(2).indRelBPMs = [3 1;3 2]; %relative indexes of upstream and downstream BPMs of the straight section where the CAV is located

outStruct(3).sectLenBwBPMs = 2.*3.14155; %(m) straight section length between BPMs
outStruct(3).cavCenPos = -0.735; %(m) center longitudinal position of the Cavity with respect to the straight section center
outStruct(3).cavLen = 1.470; %(m) CAV length
outStruct(3).indUpstrBPM = 7; %absolute index of BPM at the upstream edge of the straight section where the ID is located
outStruct(3).indRelBPMs = [2 1;2 2]; %relative indexes of upstream and downstream BPMs of the straight section where the CAV is located

outStruct(4).sectLenBwBPMs = 2.*3.14155; %(m) straight section length between BPMs
outStruct(4).cavCenPos = 0.735; %(m) center longitudinal position of the Cavity with respect to the straight section center
outStruct(4).cavLen = 1.470; %(m) CAV length
outStruct(4).indUpstrBPM = 7; %absolute index of BPM at the upstream edge of the straight section where the ID is located
outStruct(4).indRelBPMs = [2 1;2 2]; %relative indexes of upstream and downstream BPMs of the straight section where the CAV is located
end

