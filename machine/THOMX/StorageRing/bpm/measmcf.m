function measmcf
%
%  Measure synchrotron tune in function of RF frequency
%  
%
%  See Also getnus

RF0 = getrf;

% RF frequency variation in MHz !!!
dFRF = 2*[-3 -2 -1 0 1 2 3]*1e-6;

kmax = length(dFRF);
nusVect =zeros(1,kmax);
freqVect=zeros(1,kmax);

for k=1:kmax,
   fprintf('%d - RF frequency shifted by %f Hz\n', k, dFRF(k)*1e6); 
   setrf(RF0 + dFRF(k))
   fprintf('Next measurement press a key ...\n');
   pause(5)
   fsVect(k) = getnus;
   freqVect(k) = getrf;
end

% Restore RF frequency
setrf(RF0);

% Plot Data
%%
RFVoltage = 3e3; % [kV]
Energy = getenergy;
rho = 0.352;  % [m]
cosPhis= cos(physics_synchronousphase(RFVoltage, Energy,rho));
fs_norm = fsVect/(RF0*1e6*sqrt(RFVoltage/getharmonicnumber*cosPhis/2/pi/Energy*1e-6));
power(fs_norm,2)
figure
plot(dFRF/RF0,power(fs_norm,4)) 
xlabel('DFRF/RF0')
ylabel('Normalized synchrotron frequency')

% print data
[fsVect' dFRF'*1e6]