function settags(fname,taglist)
%SETTAGS assigns individual string tags to elements in lattice THERING
% 
% SETTAGS(FNAME,TAGLIST) finds the family with name FNAME
% For each element in THERING, that belongs to this family,
% SETTAGS crates a new field 'Tag' and initializes 
% it to the corresponding string in the cell array TAGLIST
% TAGLIST must have the same number of elements as the 
% NumKids in this family

global THERING

match = findcells(THERING,'FamName',fname);
if length(match) == 0
   error(['Family ''',fname,''' is not found']);  
end

% check number of names in the NAMELIST
m = match(1);
if length(match) == length(taglist)
   for i = 1:length(match)
      THERING{match(i)}.Tag = taglist{i};
   end;
else
   % Think of a clearer message
   error('The number of elements in TAGLIST must match the number of elements in the family FNAME')
end

   

      
   