function [DX DY] = getshift(ELEMINDEX, varargin)
%GETSHIFT gets the misalignment for elements
%
% GETSHIFT(ELEMINDEX) gets the entrance and exit misalignment vectors
%  of one element or a group of elements in the globally defined lattice THERING.
%  
%  DX, DY are displacements of the ELEMENT 
%  The elements to be modified are given by ELEMINDEX  
%	Previous stored values are overwritten. 
%
% See also SETSHIFT

%
%% Written by Laurent S. Nadolski

DisplayFlag = 0;

if ~isempty(varargin)
    if strcmpi(varargin{1}, 'Display')
        DisplayFlag = 1;
    elseif strcmpi(varargin{1}, 'NoDisplay')
        DisplayFlag = 0;
    end    
end

global THERING
numelems = length(ELEMINDEX);

DX = zeros(numelems,1);
DY = zeros(numelems,1);

for i = 1:length(ELEMINDEX)
   V = THERING{ELEMINDEX(i)}.T2;
   DX(i) = V(1);
   DY(i) = V(3);
end

if DisplayFlag
    figure
    subplot(2,1,1)
    plot(DX*1e3,'.'); grid on;
    ylabel('Horizontal (mm)')
    subplot(2,1,2)
    plot(DY*1e3,'.'); grid on;
    ylabel('Vertical (mm)')
    suptitle('Transverse displacement of quadrupoles')
    xlabel('Quadrupole number')
end
