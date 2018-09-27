function [hoffset voffset ErrorFlag] = getsnifferoffset
%GETSNIFFEROFFSET - Give offset between 10 Hz data and sniffer data
%
%  OUTPUTS
%  1. hoffset - offset in H-plane
%  2. voffset - offset in V-plane
%
%  NOTES
%  1. sniffer data are corrected by the BBA offsets
%
%  See Also getsnifferorbit, getsnifferorbit, getsnifferorbit

%
%% Written by Laurent S. Nadolski

DisplayFlag = 1;
ErrorFlag = 0;

% orbite du sniffer

[Xsniffer Zsniffer ErrorFlag] = getsnifferorbit;

if ErrorFlag
    ErrorFlag = -1;
    hoffset = -1;
    voffset = -1;
    return;
end

% Load recorded offset between 10 Hz data and data build up from sniffer
data = load('/home/operateur/GrpPhysiqueMachine/Laurent/matlab/FOFB/offset_sniffer_10Hz', 'hoffset', 'voffset');

hoffset = Xsniffer - getx;
voffset = Zsniffer - getz;

% Display part
if DisplayFlag
    spos = getspos('BPMx');

    figure
    subplot(2,1,1)
    plot(spos, hoffset*1e3,'k');
    grid on; hold on;
    plot(spos, data.hoffset'*1e3,'r');
    ylabel('H-orbit (micrometer)')
    subplot(2,1,2)
    plot(spos, voffset*1e3,'k')
    grid on; hold on;
    plot(spos, data.voffset'*1e3,'r');
    ylabel('V-orbit (micrometer)')
    xlabel('s-position (m)');
    suptitle('Offset orbit: reference in red, actual data in black');
end

%% Save new set of data
% hoffset = Xsniffer  - getx;
% voffset = Zsniffer  - getz;
% save('offset_sniffer_10Hz', 'hoffset', 'voffset');
