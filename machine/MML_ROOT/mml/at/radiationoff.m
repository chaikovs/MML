function radiationoff(varargin)
%RADIATIONOFF - Turns classical radiation off in the model
%  Switch all magnets currently set to use pass-methods
%  'BndMPoleSymplectic4RadPass' and  'StrMPoleSymplectic4RadPass'
%  to their equivalents without radiation
%  'BndMPoleSymplectic4Pass' and  'StrMPoleSymplectic4Pass'
%	
%   See also RADIATIONON, CAVITYON, CAVITYOFF

if ~evalin('base','~isempty(whos(''global'',''THERING''))')
   error('Global variable THERING could not be found');
end

global THERING

localindex = findcells(THERING,'PassMethod','StrMPoleSymplectic4RadPass');
THERING = setcellstruct(THERING,'PassMethod',localindex, 'StrMPoleSymplectic4Pass');
totalswitched = length(localindex);

localindex = findcells(THERING,'PassMethod','BndMPoleSymplectic4RadPass');
THERING = setcellstruct(THERING,'PassMethod',localindex, 'BndMPoleSymplectic4Pass');
totalswitched = totalswitched + length(localindex);

disp(['PassMethod was changed to NOT include radiation in ',num2str(totalswitched),  ' elements'])     
clear localindex