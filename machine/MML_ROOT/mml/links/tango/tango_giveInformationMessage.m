function tango_giveInformationMessage(varargin)
% tango_giveInformationMessage give a message on th control room load
% spearkers
%
%  1. devSpeakerName (Optional) - Texttalker name
%  2. message - message to speak

%
%% Written by Laurent S. Nadolski

if nargin < 2,
    devSpeakerName = getfamilydata('TANGO', 'TEXTTALKERS');
    message = varargin{1};
else
    devSpeakerName = varargin{1};
    message = varargin{2};
end

for k=1:size(devSpeakerName,2),
    tango_command_inout2(devSpeakerName{k},'DevTalk',message);
end
