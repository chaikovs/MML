function [phases, injeff,  mean_val, spread_val] = master_phase_scan(varargin)
%rf_phase_scan - injection efficiency with respect to rf phase
% [injeff, stdeff] = rf_phase_scan(init_ph, fin_ph, steps, n_points) calculate
% dependency of injection efficency from rf phase for each point.
%
%  The beam is kicked before each set of measurements for a given phase
%  value
% 
%  INPUTS
%  1. init_ph - initial phase
%  2. fin_ph - final phase
%  3. steps - number of steps (default 1)
%  4. n_points - number of data points per step (default 5)
%  
%  OUTPUTS
%  1. phases - phase vector
%  2. injeff - injection efficiency vector
%  3. mean_val - mean value over n_points
%  4. spread_val - std over n_points
%
%  NOTES:
%  1. injeff need a faster 3 Hz measurement of injection efficiency
%  2. Beam conditions: injection in LPM mode, RF switch should be activated
%
%  TODO
%  1. need to make convertion voltage/phase
%  2. dedicated saved phase directory
%
%  EXAMPLES
%  1. master_phase_scan(0,8.95,20)
%
%  See also master_volttophase, master_phasetovolt

%% Written by K. Manukyan and L. Nadolski

tstart  = tic;
SRRFPhaseRead  = 'ANS/RF/DISTRI_RF/phi_RF_Anneau';
SRRFPhaseWrite = 'ANS/RF/MAO-DISTRI_RF/channel5';
INJ_eff        = 'ans/dg/pub-fillingmode/rendement_ANS_LPM';

phaseWritePause          = 3; % seconds
killbeamPause            = 0.5; % seconds
InjectionEfficiencyPause = 5; % seconds

% Input check
DisplayFlag = 1;
init_ph = readattribute(SRRFPhaseRead);
fin_ph  = readattribute(SRRFPhaseRead);
init_ph = 1;
fin_ph = 8; 
steps = 40;
n_points = 2;

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end
end

if nargin >= 1
    init_ph = varargin{1};
end
if nargin >= 2
    fin_ph = varargin{2};
end
if nargin >=3
    steps = varargin{3};
end
if nargin >= 4
    n_points = varargin{4};
end

% intialized data
phases     = init_ph:(fin_ph-init_ph)/steps:fin_ph;
injeff     = zeros(length(phases),n_points);
storedBeam = zeros(length(phases),n_points);

for i = 1:steps+1
    kill_beam;
    pause(killbeamPause);
    
    % write need RF phase on the RF-dsitribution pannel
    writeattribute(SRRFPhaseWrite,phases(i));
    pause(phaseWritePause);
    save('DA_FMA_Data_onGoingMeas','phases', 'injeff', 'storedBeam');
    fprintf('phase %f (final value is %f)\n', phases(i), phases(end));
    
    for j = 1:n_points
        burst_trigger % a normal injection
        pause(InjectionEfficiencyPause); 
        %wait to measurent injection efficiency
        injeff(i,j) = readattribute(INJ_eff);
        %stored beam current
        storedBeam(i,j) = getdcct;
    end
end

spread_val = std(injeff,0,2);
mean_val   = mean(injeff,2);

save(appendtimestamp('DA_FMA_Data'), 'phases', 'injeff', 'storedBeam')

if DisplayFlag
    figure
    errorbar(phases,mean_val,spread_val,'x-b')
    xlabel('Voltage (V)')
    ylabel('LPM Injection Effiency (%)')
    addlabel(1,0,sprintf('%s', datestr(now,0)));   
end

toc(tstart);
tango_giveInformationMessage('Fin de mesure ');

function kill_beam
% kill the beam by trigeering the first injection kicker

% record initial configuration
val = tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent');
% switch to 3 Hz
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent', int32(4));
pause(1)
% switch back to initial event configuration
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent', int32(val.value(1)));
%tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent');
fprintf('Beam killed!')
