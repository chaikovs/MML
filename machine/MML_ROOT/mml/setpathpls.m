function [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathnpls(LinkFlag)
%SETPATHPLS - Initializes the Matlab Middle Layer (MML) for PLS
%  [MachineName, SubMachineName, OnlineLinkMethod, MMLROOT] = setpathpls(OnlineLinkMethod)
%
%  INPUTS
%  1. OnlineLinkMethod - 'MCA', 'LabCA', SCA
%
%  Written by Greg Portmann


Machine = 'PLS';


% Input parsing
if nargin < 1
    LinkFlag = '';
end
if isempty(LinkFlag)
    if strncmp(computer,'PC',2)
        LinkFlag = 'mca';
    elseif isunix
        LinkFlag = 'labca';
    else
        LinkFlag = 'mca';
    end
end

[MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'StorageRing', 'StorageRing', LinkFlag);



