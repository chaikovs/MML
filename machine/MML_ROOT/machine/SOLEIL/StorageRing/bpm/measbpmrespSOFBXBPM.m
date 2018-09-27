function [R0 FileName] = measbpmrespSOFBXBPM(varargin)
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
%
%  See Also getidbpmlist, measbpmresp

%
%% Written by Laurent S. Nadolski

% Default

[R0 FileName] = measbpmresp('BPMx',family2dev('BPMx'), 'PBPMz', family2dev('PBPMz'), 'HCOR', 'VCOR',varargin{:});
