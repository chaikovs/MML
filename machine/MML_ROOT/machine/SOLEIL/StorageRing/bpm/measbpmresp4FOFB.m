function [R0 FileName] = measbpmresp4FOFB(varargin)
% MEASBPMRESP4FOFB - Measures the BPM to fast corrector response matrix
%
%
%
%
%  OUPUTS
%  1. R0 - Response matrix
%  2. FileName - saved filenamed if Archive flag is asked
%
%  NOTES
%  1. Mainly an alias to measbpmresp
%  2. Will note work with ZBPM if IDBPM asked
%  3. Not felxible if device list is changed
%
%  See Also getidbpmlist, measbpmresp

%
%% Written by Laurent S. Nadolski

% Default
BPMtype = 'AllBPM'; % 'IDBPMonly';
BPMxFamily = 'BPMx';
BPMyFamily = 'BPMz';

% Corrector Families
HCMFamily  = 'FHCOR';
VCMFamily  = 'FVCOR';
varargin2 = {};

for k = length(varargin):-1:1
    if strcmpi(varargin{k},'IDBPMonly')
        BPMtype = 'IDBPMonly';
        varargin(k) = [];
    elseif strcmpi(varargin{k},'AllBPM')
        BPMtype = 'AllBPM';
        varargin(k) = [];
    elseif strcmpi(varargin{k},'PBPMz')
        BPMyFamily = 'PBPMz';
    elseif strcmpi(varargin{k},'Model')
        varargin2 = [varargin2 varargin(k)];
        varargin(k) = [];
    elseif strcmpi(varargin{k},'Online')
        varargin2 = [varargin2 varargin(k)];
        varargin(k) = [];
    elseif strcmpi(varargin{k},'Simulator')
        varargin2 = [varargin2 varargin(k)];
        varargin(k) = [];
    elseif strcmpi(varargin{k},'Physics')
        varargin2 = [varargin2 varargin(k)];
        varargin(k) = [];
    elseif strcmpi(varargin{k},'Hardware')
        varargin2 =[varargin2 varargin(k)];
        varargin(k) = [];
    elseif strcmpi(varargin{k},'Archive')
        varargin2 =[varargin2 varargin(k)];
        varargin(k) = [];
    elseif strcmpi(varargin{k},'NoArchive')
        varargin2 =[varargin2 varargin(k)];
        varargin(k) = [];
    elseif strcmpi(varargin{k},'Struct')
        varargin2 =[varargin2 varargin(k)];
        varargin(k) = [];
    end
end

switch BPMtype
    case 'IDBPMonly'
        IDBPMx = getidbpmlist;
    case 'AllBPM';
        IDBPMx = family2dev(BPMxFamily);
        IDBPMy = family2dev(BPMyFamily);
end

[R0 FileName] = measbpmresp(BPMxFamily,IDBPMx, BPMyFamily, IDBPMy, HCMFamily, VCMFamily,varargin2{:});
