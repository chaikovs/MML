function Rmat = getbpmresp4FOFB(varargin)
%  GETBPMRESP4FOFB - Gets the orbit response matrice for the fast orbit feedback
%
%  INPUTS
%
%  OUTPUTS
%
%  See Also getbpmresp

%
%%  Written by Laurent S. Nadolski

% Default
BPMtype  = 'IDBPMonly'; % 'AllBPM';
fileName = 'BPMRespMat4FOFB_96x96.mat';

for k = length(varargin):-1:1
    if strcmpi(varargin{k},'IDBPMonly')
        BPMtype = 'IDBPMonly';
        varargin(k) = [];
    elseif strcmpi(varargin{k},'AllBPM')
        BPMtype = 'AllBPM';
        varargin(k) = [];
    elseif strcmpi(varargin{k},'')
        fileName = '';
        varargin(k) = [];
    end
end

switch BPMtype
    case 'IDBPMonly'
        BPMdev = getidbpmlist;
        fileName = 'BPMRespMat4FOFB_96x96.mat';
    case 'AllBPM';
        BPMdev = family2dev('BPMx');
        fileName = 'BPMRespMat4FOFB_240x96.mat';
end

if ~strcmp('', fileName)
    switch BPMtype
        case 'IDBPMonly'
            fileName = 'BPMRespMat4FOFB_96x96.mat';
            % Add fullpath to the filename
            fileName = [getfamilydata('Directory','BPMResponse') fileName];
        case 'AllBPM';
            fileName = 'BPMRespMat4FOFB_240x96.mat';
            % Add fullpath to the filename
            fileName = [getfamilydata('Directory','BPMResponse') fileName];
    end
end

if isempty(varargin) 
    Rmat = getbpmresp('BPMx', BPMdev, 'BPMz', BPMdev, 'FHCOR', 'FVCOR', fileName,'Struct');
else
    Rmat = getbpmresp(varargin{:}, fileName);
end
end
