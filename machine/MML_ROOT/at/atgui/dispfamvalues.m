function values = dispfamvalues(FAMNAME,FIELD,varargin)
%DISPFAMVALUES displays values of a scalar field 'FIELD'
% for all elements in the 'FAMNAME' family using the MATLAB bar plot
% DISPFAMVALUES('FAMNAME','FIELD')
% DISPFAMVALUES('FAMNAME','FIELD',BASELINE)
 

global THERING
findex = findcells(THERING,'FamName',FAMNAME);
values = getcellstruct(THERING,FIELD,findex');
if (nargin>2)
	bar(values-varargin{1});
else
	bar(values);
end
	