function [volt, phase] = master_PhaseCalibration
% MASTER_PhaseCalibration - Calibration phase - voltage
%
%  OUTPUTS
%  1. volt  - voltage values
%  2. phase - phase values
%
%  NOTES 
%  1. RFcavities should be switch off during measurements
%  2. add a test if too fast, get same value

%
%% Written by K. Manukyan and L. Nadolski

PAUSE_VALUE = 1; % instead of 2

%v_start=0; v_end=5.354; steps=50;
voltage_start=0; voltage_end=10; nsteps=200; % voltage in Volts
EPS = 0.2; % phase error reading
nreading = 3;

step_size=(voltage_end-voltage_start)/nsteps;
SRRFPhaseWrite ='ANS/RF/MAO-DISTRI_RF/channel5';
SRRFPhaseRead  ='ANS/RF/DISTRI_RF/phi_RF_Anneau';

% save initial value
voltage0 = readattribute(SRRFPhaseWrite);
phase0 = readattribute(SRRFPhaseRead);
fprintf('Initial value is %.3f V (%.3f degrees)\n', voltage0, phase0);

answer = questdlg(sprintf('Are RF-cavities swiched OFF?\nIs the phase remotely controlled'), 'PhaseCalibration', 'Yes', 'No', 'Yes');

switch answer
    case 'No'
        error('Measure stop, first switched off cavities');
    otherwise
        % this is safe
end
    

% initialize vectors
volt  = zeros(nsteps+1,1);
phase = zeros(nsteps+1,nreading);

for i=1:nsteps+1
    voltage = voltage_start+(i-1)*step_size;
    writeattribute(SRRFPhaseWrite,voltage);
    pause(PAUSE_VALUE);
    
    %% extra pause for first point
    previous_phase=readattribute(SRRFPhaseRead);
   if i == 1
        while abs(readattribute(SRRFPhaseRead)-previous_phase) > 3*EPS
             fprintf('Retry\n');
             pause(PAUSE_VALUE)   
             previous_phase =readattribute(SRRFPhaseRead); 
        end
    end
        
    while abs(readattribute(SRRFPhaseRead)-previous_phase) > 2*EPS
        pause(PAUSE_VALUE)
        fprintf('Retry\n');
        previous_phase =readattribute(SRRFPhaseRead);
    end
    
    volt(i) = voltage;
    for k=1:nreading
        while abs(readattribute(SRRFPhaseRead)-previous_phase) > 2*EPS 
            pause(PAUSE_VALUE)
            fprintf('Retry\n');
            previous_phase =readattribute(SRRFPhaseRead);
        end
        val = readattribute(SRRFPhaseRead);
        pause(PAUSE_VALUE)
        phase(i,k)= val;
    end
end

% restored initial value
writeattribute(SRRFPhaseWrite, voltage0);

% %%
% figure
% plot(volt(1,:),phase(1,:),'r*-'); hold on;
% plot(volt(2,:),phase(2,:),'b*-');

save(appendtimestamp('volt_and_phase'), 'volt','phase');