function [xDiffOrbit zDiffOrbit ErrorFlag] = getsnifferdifforbit(varargin)
%GETSNIFFERORBIT - read orbit on sniffer
%
%  OUPUTS
%  1.  xDiffOrbit - Horizontal orbit difference
%  2.  zDiffOrbit - Vertical orbit difference
%  3.  ErrorFlag  - 0 if OK
%
%  NOTES
%  the sniffer board gives the orbit difference
%  to get the orbit one needs to retrieve the golden orbit of the sniffer (FOFB)
%
%
%  See Also getsnifferoffset, getsnifferorbit

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

% sniffer device server
dev = 'ANS/DG/fofb-sniffer.2';

len = 1; %s average time on the sniffer board
% recording time
tango_write_attribute2(dev,'recordLengthInSecs',len);
% Start measurement
tango_command_inout2(dev,'StartRecording');

% pause to wait for measurements
pause(len+1);

% Check if measurement ready
isReady = tango_read_attribute(dev,'recordReady');

if isReady.value
    % read Delta orbit on sniffer board
    rep = tango_read_attribute2(dev, 'XPosMean');
    xDiffOrbit = rep.value(2:121)';
    rep = tango_read_attribute2(dev, 'ZPosMean');
    zDiffOrbit = rep.value(2:121)';
    fprintf('Data ready on sniffer board\n')

    if DisplayFlag
        figure
        spos = getspos('BPMx');
        plot(spos, xDiffOrbit*1e-6,'b'); hold on; grid on;
        plot(spos, zDiffOrbit*1e-6,'r');
        xlabel('s-position (m)');
        ylabel('Position (mm)');
        legend('H-plane', 'V-plane');
        title('Difference orbit read on orbit sniffer')        
    end
else
    disp('Not ready')
    xDiffOrbit = -1;
    zDiffOrbit = -1;
    ErrorFlag = -1;
end
