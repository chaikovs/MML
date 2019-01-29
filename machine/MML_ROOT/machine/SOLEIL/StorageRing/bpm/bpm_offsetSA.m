function [Hoffset Voffset] = bpm_offsetSA(offsetfile, varargin)
% bpm_offsetSA - Give offset for BPMs based of an offsetfile (TANGO/SOLEIL)

% INPUTS
% 1. iBPM - BPM devicelist
% 2. deviceList - Device List
%
% OUPUTS
% 1. Hoffset - Horizontal offset
% 2. Voofset - Vertical offset
%
% NOTES
% 1. use 11.4 fixed value for the BPM calibration factor
%    TO be set elsewhere / use Finite element solution

%
%% Written by Laurent S. Nadolski

TangoCoeff =0;

% Flagfactory
for i = length(varargin):-1:1
    if strcmpi(varargin{i}, 'TANGO')
        TangoCoeff = 1;
        varargin(i) = [];    
    elseif strcmpi(varargin{i}, 'noTANGO')
        TangoCoeff = 0;
        varargin(i) = [];
    end
end


% Build up device list and convert to BPM tango name
if length(varargin) < 1
    % take all BPMs
    deviceName = family2tangodev('BPMx');
else
    deviceName = family2tangodev('BPMx', varargin{1});
end

% Calibration factors in TANGO device
if TangoCoeff
    Kh = 11.4;
    Kv = 11.4;
else
    Kh = 11.580881;
    Kv = 11.480389;
end
    

%% Read offsetfile
load(offsetfile);

deviceNameInFile = {OffsetStruct.Data.devName}';

%% reconstruction des donnees
% offsets BPM 1

% Block offset building up
%    Block_Ka= OffsetStruct.Data(iBPM).block_offset(3);
%    Block_Kb= OffsetStruct.Data(iBPM).block_offset(4);
%    Block_Kc= OffsetStruct.Data(iBPM).block_offset(5);
%    Block_Kd= OffsetStruct.Data(iBPM).block_offset(6);
%block_offset(1)=Kh*(1/Block_Ka+1/Block_Kd-1/Block_Kb-1/Block_Kc)/(1/Block_Ka+1/Block_Kb+1/Block_Kc+1/Block_Kd);
%block_offset(2)=Kv*(1/Block_Ka+1/Block_Kb-1/Block_Kc-1/Block_Kd)/(1/Block_Ka+1/Block_Kb+1/Block_Kc+1/Block_Kd);

iBPM = findrowindex(cell2mat(deviceName), cell2mat(deviceNameInFile));

% Extract block offsets
Block = cell2mat(cellfun(@(x) x(3:6),{OffsetStruct.Data(iBPM).block_offset}', 'uni', false));
iKa = 1; iKb = 2; iKc = 3; iKd = 4;
SumK = 1./Block(:,iKa)+1./Block(:,iKb)+1./Block(:,iKc)+1./Block(:,iKd);
blockOffset(:,1) = Kh*(1./Block(:,iKa)+1./Block(:,iKd)-1./Block(:,iKb)-1./Block(:,iKc))./SumK;
blockOffset(:,2) = Kv*(1./Block(:,iKa)+1./Block(:,iKb)-1./Block(:,iKc)-1./Block(:,iKd))./SumK;

% Extract Alignment offsets
SurveyOffset = cell2mat(cellfun(@(x) x,{OffsetStruct.Data(iBPM).survey_offset}', 'uni', false));

%Extract BBA offsets
BBAOffset    = cell2mat(cellfun(@(x) x,{OffsetStruct.Data(iBPM).BBA_offset}', 'uni', false));

% Full offset
Hoffset = blockOffset(:,1) + SurveyOffset(:,1) + BBAOffset(:,1);
Voffset = blockOffset(:,2) + SurveyOffset(:,2) + BBAOffset(:,2);
