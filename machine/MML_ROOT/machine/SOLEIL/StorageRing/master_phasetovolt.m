function rf_volt = master_phasetovolt(varargin)
%MASTER_PHASETOVOLT - converts from degree to volt the RF-dsitribution pannel
%                  of the RF phase of the SOLEIL storage ring
%
%  INPUTS
%  1. phi - voltage to convert to degree
%
%  Optional Flags - Plot conversion for 0-400 Volts
%
%  OUTPUTS
%  1. rf_volt - RF phase in degrees
%
%  NOTES
%  1. the total RF variation is 400 degrees
%  2. zero is arbitrary
%
%  EXAMPLE
%  1. master_phasetovolt('Display') - Display full conversion
%
%  See also master_volttophase

%
%% Written by Laurent S. Nadolski and Koryun Manukyan

% Input parser for option

if nargin < 1
    error('Provide at least phase value \n')
end

[DISPLAYFLAG, rsrc] = getflag(varargin, 'Display');
if ~isempty(rsrc)
    phi = rsrc{1};
end

phase_min = -179.85;
phase_mid = 37.385;
phase_max = 177.4;

if DISPLAYFLAG
    x= phase_min:1:phase_max;
    figure;
    plot(x,master_phasetovolt(x));
    ylabel('Voltage (V)')
    xlabel('SR phase (degrees)');
    title('Storage ring RF-phase with respect ot the booster phase')
    return;
end


rf_volt = zeros(1,length(phi));

% Coefficient based on Experiment 27/08/2017
for i = 1:length(phi)
    if phi(i) >= phase_min && phi(i) <= phase_mid
        p1 = 1.2381e-07;
        p2 = -3.6807e-05;
        p3 = -0.037753;
        p4 = 1.4565;
        rf_phase_to_volt_coefs = [p1 p2 p3 p4];
        rf_volt(i) = polyval(rf_phase_to_volt_coefs,phi(i));
    elseif phi(i) > phase_mid && phi(i) <= phase_max
        p1 = -1.3177e-07;
        p2 = 5.1014e-05;
        p3 = -0.023745;
        p4 = 9.7898;
        rf_phase_to_volt_coefs = [p1 p2 p3 p4];
        rf_volt(i) = polyval(rf_phase_to_volt_coefs,phi(i));
    else
        error('Out of defined phase to volt conversion range. Known range [-180 180]');
    end
end