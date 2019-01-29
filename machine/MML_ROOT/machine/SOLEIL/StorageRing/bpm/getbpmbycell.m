function devlist = getbpmbycell(argin)
%GETBPMBYCELL - Return devicelist of BPM in a given cell
%
%  OUTPUT
%  1. cell number 
%
%  Example:
%  1. getbpmbycell(4) - Get bpm from cell 4
%  2. getbpmbycell((1:4)) - Get bpms from cell 1 to 4
%  3. getbpmbycell([1 5 9 13]) - Get bpms from cell 1 to 4
%
%  See Also getbpmbyrack

%
%  Written by Laurent S. Nadolski

cellNumber = argin;

BPMDevList = family2dev('BPMx');

devlist = [];
for k = 1:length(cellNumber),
    Idx = (BPMDevList(:,1) == cellNumber(k));
    devlist = [devlist; BPMDevList(Idx,:)];
end
