function [R0 FileName] = measbpmresp4FB(varargin)
% MEASBPMRESP4FB - Measures the BPM to one of two  familly corrector response matrix
%
%
%
%  Do Not Use at this time
%  OUPUTS
%  1. R0 - Response matrix
%  2. FileName - saved filename if Archive flag is asked
%
%
%   ex: measbpmresp4FB('Fast')
%   ex: measbpmresp4FB('Slow','PBPMz')
%   ex: measbpmresp4FB('Slow','PBPMz','Archive')
%
%  NOTES
%  1. Mainly an alias to measbpmresp
%  2. Will note work with ZBPM if IDBPM asked
%  3. Not felxible if device list is changed
%
%  ex: [Rmat Filename] = measbpmresp4FB('Slow','PBPMz','Simulator')
%  See Also getidbpmlist, measbpmresp

%
%% Written by Aurélien Bence

% Default
BPMtype = 'AllBPM'; % 'IDBPMonly';
BPMxFamily = 'BPMx';
BPMyFamily = 'BPMz';

% Corrector Families %set defaults to SlowCor
HCMFamily  = 'HCOR';
VCMFamily  = 'VCOR';
varargin2 = {};

%flag for make additionnal file without XBPM
RMXBPM=0;

for k = length(varargin):-1:1
    if strcmpi(varargin{k},'IDBPMonly')
        BPMtype = 'IDBPMonly';
        varargin(k) = [];
    elseif strcmpi(varargin{k},'AllBPM')
        BPMtype = 'AllBPM';
        varargin(k) = [];
    elseif strcmpi(varargin{k},'Fast')
        HCMFamily  = 'FHCOR';
        VCMFamily  = 'FVCOR';
    elseif strcmpi(varargin{k},'Slow')
        HCMFamily  = 'HCOR';
        VCMFamily  = 'VCOR';    
    elseif strcmpi(varargin{k},'PBPMz')
        BPMyFamily = 'PBPMz';
    elseif strcmpi(varargin{k},'XBPM')
        BPMyFamily = 'PBPMz';
        BPMtype = 'XBPM';
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
    end    
    
end

switch BPMtype
    case 'IDBPMonly'
        IDBPMx = getidbpmlist;
    case 'AllBPM';
        IDBPMx = family2dev(BPMxFamily);
        IDBPMy = family2dev(BPMyFamily);
    case 'XBPM'
        [TF,Bpmind]=ismember(family2tango('BPMz'),family2tango('PBPMz'));
        XBPMind= [1:1:length(family2tango('PBPMz'))];
        IDBPMy=setxor(Bpmind,XBPMind);%get only the element present in PBPMz family and not present in BPMz family (XBPM)
        IDBPMy=elem2dev(BPMyFamily,IDBPMy);
        IDBPMx=[1 1];%need at least one element in both plane to measure
        
        
end

[R0 FileName] = measbpmresp(BPMxFamily,IDBPMx, BPMyFamily, IDBPMy, HCMFamily, VCMFamily,varargin2{:});
