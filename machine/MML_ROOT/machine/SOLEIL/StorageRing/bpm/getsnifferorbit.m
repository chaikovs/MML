function [xOrbit zOrbit ErrorFlag] = getsnifferorbit(varargin)
%GETSNIFFERORBIT - read orbit on sniffer and retrieve sniffer golden orbit
%
%  OUPUTS
%  1.  xOrbit - Horizontal orbit 
%  2.  zOrbit - Vertical orbit 
%  3.  ErrorFlag  - 0 if OK
%
%  NOTES
%  the sniffer board gives the orbit difference
%  to get the orbit one needs to retrieve the golden orbit of the sniffer (FOFB)
%
%
%  See Also getsnifferoffset, getsnifferoffset

%  TODO
%  DisplayFlag

%
%% Written by Laurent S. Nadolski

ErrorFlag = 0;
DisplayFlag = 0;

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end
end
[xDiffOrbit zDiffOrbit ErrorFlag] = getsnifferdifforbit;

if ~ErrorFlag
    % Load last golden orbit used by the sniffer board and the FOFB
    dirName = '/home/operateur/GrpDiagnostics/matlab/FOFB/GUI/golden/';
    fileName = 'last_golden';
    A = load([dirName fileName]);

    % Orbit read on the sniffer board expressed in mm without BBA offsets
    xOrbit = (xDiffOrbit + A.last_goldenX')*1e-6;
    zOrbit = (zDiffOrbit + A.last_goldenZ')*1e-6;

    if DisplayFlag
        figure
        spos = getspos('BPMx');
        plot(spos,xOrbit,'b'); hold on; grid on;
        plot(spos,zOrbit,'r');
        xlabel('s-position (m)');
        ylabel('Position (mm)');
        legend('H-plane', 'V-plane');
        title('Orbit read on orbit sniffer')

    end
else
    xOrbit = -1;
    zOrbit = -1;
    ErrorFlag = 1;
end
