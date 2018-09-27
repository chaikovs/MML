function [Xlu Zlu abcdn] = bpm_normalizedbuttonsignals(BPMdata, idata, S, Xoffs, Zoffs, varargin)
%
% INPUTS
% 1. datafile - file of data
% 2. idatax (idatay) - data number in both plane if 2D
% 3. Xoffs - horizontal offset
% 4. Zoffs - vertical offset
% 5. DeviceList - BPM device List
% 
% OUPUTS
% 1. Xlu - Horizontal amplitude read on BPM
% 2. Zlu - Vertical amplitude read on BPM
% 3. abcdn - Normalized vector potential [Va Vb Vc Vd]
%
% NOTES
% 1. Remove Kx and Kz
% 2. Flag to be handled

%
%% Written by Laurent S. Nadolski

BuildRawsignalFlag = 0;
DisplayFlag = 0;

% Extracting data into variables
X  = BPMdata.X(idata);
Z  = BPMdata.Z(idata);
Va = BPMdata.Va(idata);
Vb = BPMdata.Vb(idata);
Vc = BPMdata.Vc(idata);
Vd = BPMdata.Vd(idata);

% Sum signal
Sum = Va + Vb + Vc + Vd;

abcdn = [Va./Sum Vb./Sum Vc./Sum Vd./Sum];

Kx = S.Kx;
Kz = S.Ky;

if BuildRawsignalFlag
    Xlu = Kx*(Va+Vd-Vb-Vc)./Sum  - Xoffs;
    Zlu = Kz*(Va+Vb-Vc-Vd)./Sum  - Zoffs;
else
    Xlu = X;
    Zlu = Z;
end

if BuildRawsignalFlag && DisplayFlag
    fprintf('X BPM <% f mm>  X reconstruit <% f mm >\n', [X, Xlu]')
    fprintf('Z BPM <% f mm > Z reconstruit <% f mm >\n', [Z, Zlu]')
    figure;
    dx = Xlu - X ;
    dz = Zlu - Z ;
    subplot(2,1,1)
    plot(dx); hold all;
    ylabel('Horizontal amplitude (mm)')
    subplot(2,1,2)
    plot(dz);
    ylabel('Vertical amplitude (mm)')
    Title('Reconstruction error TANGO/Matlab')    
end