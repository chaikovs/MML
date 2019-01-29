function rf_phi = master_volttophase(varargin)
%MASTER_VOLTTOPHASE - converts from volt to degree the RF-dsitribution pannel
%                  of the RF phase of the SOLEIL storage ring
%
%  INPUTS
%  1. volt - voltage to convert to degree
%
%  Optional Flags - Plot conversion for 0-400 Volts
%
%  OUTPUTS
%  1. rf_phi - RF phase in degrees
%
%  NOTES
%  1. the total RF variation is 400 degrees
%  2. zero is arbitrary
%
%  EXAMPLE
%  1. master_volttophase('Display') - Display full conversion
%
%  See also master_phasetovolt

%
%% Written by Laurent S. Nadolski and Koryun Manukyan

% Input parser for option

if nargin < 1
    error('Provide at least voltage value \n')
end

[DISPLAYFLAG, rsrc] = getflag(varargin, 'Display');
if ~isempty(rsrc)
    volt = rsrc{1};
end

voltage_360 = 6.4; % 360°
voltage_max = 8.95; % Volts

if DISPLAYFLAG
    x= 0:.1:voltage_max;
    figure;
    plot(x,master_volttophase(x));
    xlabel('Voltage (V)')
    ylabel('SR phase (degrees)');
    title('Storage ring RF-phase with respect ot the booster phase')
    return;
end

rf_phi = zeros(1,length(volt));

% Coefficient based on Experiment 27/08/2017
for i = 1:length(volt)
    if volt(i) >= 0 && volt(i) <= voltage_360
        p1 =  -0.46886;
        p2 =   2.3352;
        p3 = -29.959;
        p4 =  39.245;
        rf_volt_to_phase_coefs = [p1 p2 p3 p4];
        rf_phi(i) = polyval(rf_volt_to_phase_coefs,volt(i));
    elseif volt(i) > voltage_360 && volt(i) <= voltage_max
        p1 =   1.2106;
        p2 = -26.439;
        p3 = 134.33;
        p4 =  85.901;
        rf_volt_to_phase_coefs = [p1 p2 p3 p4];
        rf_phi(i) = polyval(rf_volt_to_phase_coefs,volt(i));
    else
        error('Out of defined voltage to phase conversion range. Known range [0 8.95]');
    end
end