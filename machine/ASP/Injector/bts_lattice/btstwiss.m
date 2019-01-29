function varargout = btstwiss(TDinit,varargin)
% TDout = BTSTWISS(TDinit) - returns the Twiss parameters at the end of the
% BTS for the given initial twiss parameters where:
%
%         TDinit - a 6-vector column [betax alphax betay alphay etax etay]'
%         TDout - struct containing the optical parameters.
%
%   Example:
%      TD = btstwiss([4.5 0 3.3 0 0.2 0]');
%
% Eugene 21-08-2006: Modification to use global variable BTS as well as
%                    using machine_at which returns the data in a more
%                    usable format.

% Change the THERING to the BTS
getam('BTS_BEND','Model');

global THERING
TDin = getpvmodel('TwissData');

% Parse input
if exist('TDinit','var') && ~isempty(TDinit)
    TDin.beta  = [TDinit(1) TDinit(3)];
    TDin.alpha = [TDinit(2) TDinit(4)];
    TDin.Dispersion = [TDinit(5) 0 TDinit(6) 0]';
end

% calculate the Twiss parameters and return
if nargout == 1
    varargout{1} = machine_at(THERING,TDin,'line');
end