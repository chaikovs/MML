function showcavitystatus
% showcavity- Get information about cavity

Voltage = getam('CM');
Pi = getpv('CM', 'Pi');
Pr = getpv('CM', 'Pr');
Phase = getpv('CM', 'Phase');
fprintf('%%---------------------- RF Cavities --------------------%%\n');
fprintf(' Parameter    Cavity 1   Cavity 2  Cavity 3   Cavity 4 \n');
fprintf(' Voltage (V) %8.3f   %8.3f  %8.3f   %8.3f \n', Voltage);
fprintf(' Phase (°)   %8.3f   %8.3f  %8.3f   %8.3f \n', Phase);
fprintf(' Pi (kW)     %8.3f   %8.3f  %8.3f   %8.3f \n', Pi);
fprintf(' Pr (kW)     %8.3f   %8.3f  %8.3f   %8.3f \n\n', Pr);
