function [Dx_PHC1 Dz_PHC1 Dx_PHC3 Dz_PHC3] = measdisp4phc

% get starting point
%DeltaRF = [-4 -3 -2 -1 0 1 2 3 4]*getfamilydata('DeltaRFDisp')*0.5*2;
DeltaRF = [ -2 -1 0 1 2 ]*getfamilydata('DeltaRFDisp')*0.5;
%DeltaRF = [-4 -3 -2 -1 0 1 2 3 4]*getfamilydata('DeltaRFDisp')*0.5*2; %
%Beamlost C07 BPM6 for I>20 mA, reaches 0.8 mm in H-plane SDC

BPMpause  = 5; %seconds

orbitData1 = zeros(length(DeltaRF),2);
orbitData2 = zeros(length(DeltaRF),2);

rf0 = getrf;
fprintf('%s\n Starting measurement RF-frequency %f \n',datestr(now), rf0);

for ik=1:length(DeltaRF),
    fprintf('New RF-frequency value %f MHz\n',rf0+DeltaRF(ik));
    setrf(rf0+DeltaRF(ik));
    pause(BPMpause);
    [orbitData1(ik,1) orbitData1(ik,2)] = getcentroid4phc1;
    [orbitData2(ik,1) orbitData2(ik,2)] = getcentroid4phc2;
    [orbitData3(ik,1) orbitData3(ik,2)] = getcentroid4phc3;
end
    
% set back RF frequency
setrf(rf0);
fprintf('New RF-frequency value %f MHz\n end of measurement \n\n',rf0);

MCF = getmcf;

orbitData1 = orbitData1 *1e-6; % convert in meters
orbitData2 = orbitData2 *1e-6; % convert in meters
orbitData3 = orbitData3 *1e-6; % convert in meters

dp = -DeltaRF / (rf0 * MCF);
dp = dp';

%% PHC1 

% 
devName         = 'ANS-C02/DG/' ;
dev1            = [devName 'PHC-VG'];
devAna1         = [devName 'PHC-IMAGEANALYZER'];
devatt1         = [devName 'PHC-ATT'];
devemit1        = [devName 'PHC-EMIT'];
devMatt1        = [devName 'PHC-M.ATT'];
tmp             = tango_get_property(devemit1,'DistPinholeH2Convert')	; %5.730
tmp2 = tmp.value{1} ; D2 = str2num(tmp2);
tmp             = tango_get_property(devemit1,'DistSource2PinholeH')	; %	4.338
tmp2 = tmp.value{1} ; D1 = str2num(tmp2);
factor = 1/(D2/D1); % conversion from PHC convertor to optics

% analysis of the data, fit a straight line
p = polyfit(dp, orbitData1(:,1), 2);      % 2nd order polynomial fit to data
c.PolyFit(1,:) = p;
c.Data(1,1) = p(2);
c.UnitsString = getfamilydata('BPMx','Monitor','HWUnits');

% Horizontal plane
figure;
subplot(2,1,1)
plot(dp,orbitData1(:,1),'s');
hold on;
plot(dp,polyval(c.PolyFit(1,:), dp));
xlabel('Momentum Shift, dp/p [%]')
title([num2str(p(1)),' (dp/p)^2  + ',num2str(p(2)*factor),' dp/p  + ',num2str(p(3))]);
ylabel('Horizontal centroid PHC1 (m)');

p = polyfit(dp, orbitData1(:,2), 2);      % 2nd order polynomial fit to data
c.PolyFit(2,:) = p;
c.Data(2,2) = p(2);
c.UnitsString = getfamilydata('BPMx','Monitor','HWUnits');


% Vertical plane
subplot(2,1,2)
plot(dp,orbitData1(:,2),'s');
hold on;
plot(dp,polyval(c.PolyFit(2,:), dp));
xlabel('Momentum Shift, dp/p [%]')
title([num2str(p(1)),' (dp/p)^2  + ',num2str(p(2)*factor),' dp/p  + ',num2str(p(3))]);
ylabel('Vertical centroid PHC1 (m)');
suptitle('Dispersion at PINHOLE CAMERA 1')

Dx_PHC1 = c.Data(1,1)*factor ;
Dz_PHC1 = c.Data(2,2)*factor ;

%% PHC3 

%
devName         = 'ANS-C16/DG/' ;
dev2            = [devName 'PHC-VG'];
devAna2         = [devName 'PHC-IMAGEANALYZER'];
devatt2         = [devName 'PHC-ATT'];
devemit2        = [devName 'PHC-EMIT'];
devMatt2        = [devName 'PHC-M.ATT'];
tmp             = tango_get_property(devemit2,'DistPinholeH2Convert')	; % 5.716
tmp2 = tmp.value{1} ; D2 = str2num(tmp2);
tmp             = tango_get_property(devemit2,'DistSource2PinholeH')	; %	4.335
tmp2 = tmp.value{1} ; D1 = str2num(tmp2);
factor = 1/(D2/D1); % conversion from PHC convertor to optics

% analysis of the data, fit a straight line
dp = -dp; % Sign erro not understood
p = polyfit(dp, orbitData3(:,1), 2);      % 2nd order polynomial fit to data
c.PolyFit(1,:) = p;
c.Data(1,1) = p(2);
c.UnitsString = getfamilydata('BPMx','Monitor','HWUnits');

% Horizontal plane
figure;
subplot(2,1,1)
plot(dp,orbitData3(:,1),'s');
hold on;
plot(dp,polyval(c.PolyFit(1,:), dp));
xlabel('Momentum Shift, dp/p [%]')
title([num2str(p(1)),' (dp/p)^2  + ',num2str(p(2)*factor),' dp/p  + ',num2str(p(3))]);
ylabel('Horizontal centroid PHC3 (m)');

p = polyfit(dp, orbitData3(:,2), 2);      % 2nd order polynomial fit to data
c.PolyFit(2,:) = p;
c.Data(2,2) = p(2);
c.UnitsString = getfamilydata('BPMx','Monitor','HWUnits');

% Vertical plane
subplot(2,1,2)
plot(dp,orbitData3(:,2),'s');
hold on;
plot(dp,polyval(c.PolyFit(2,:), dp));
xlabel('Momentum Shift, dp/p [%]')
title([num2str(p(1)),' (dp/p)^2  + ',num2str(p(2)*factor),' dp/p  + ',num2str(p(3))]);
ylabel('Vertical centroid PHC3 (m)');
suptitle('Dispersion at PINHOLE CAMERA 3')

% if DisplayFlag
%     fprintf('   Chromaticity = %f [%s]\n', c.Data(1), c.UnitsString);
%     fprintf('   Chromaticity = %f [%s]\n', c.Data(2), c.UnitsString);
% end

Dx_PHC3 = c.Data(1,1)*factor ;
Dz_PHC3 = c.Data(2,2)*factor ;


%% PHC2 
% % analysis of the data, fit a straight line
% dp = -dp; % Sign erro not understood
% p = polyfit(dp, orbitData2(:,1), 2);      % 2nd order polynomial fit to data
% c.PolyFit(1,:) = p;
% c.Data(1,1) = p(2);
% c.UnitsString = getfamilydata('BPMx','Monitor','HWUnits');
% 
% % Horizontal plane
% figure;
% subplot(2,1,1)
% plot(dp,orbitData2(:,1),'s');
% hold on;
% plot(dp,polyval(c.PolyFit(1,:), dp));
% xlabel('Momentum Shift, dp/p [%]')
% title([num2str(p(1)),' (dp/p)^2  + ',num2str(p(2)*factor),' dp/p  + ',num2str(p(3))]);
% ylabel('Horizontal centroid PHC2 (m)');
% 
% p = polyfit(dp, orbitData2(:,2), 2);      % 2nd order polynomial fit to data
% c.PolyFit(2,:) = p;
% c.Data(2,2) = p(2);
% c.UnitsString = getfamilydata('BPMx','Monitor','HWUnits');
% 
% % Vertical plane
% subplot(2,1,2)
% plot(dp,orbitData2(:,2),'s');
% hold on;
% plot(dp,polyval(c.PolyFit(2,:), dp));
% xlabel('Momentum Shift, dp/p [%]')
% title([num2str(p(1)),' (dp/p)^2  + ',num2str(p(2)*factor),' dp/p  + ',num2str(p(3))]);
% ylabel('Vertical centroid PHC2 (m)');
% suptitle('Dispersion at PINHOLE CAMERA 2')

% if DisplayFlag
%     fprintf('   Chromaticity = %f [%s]\n', c.Data(1), c.UnitsString);
%     fprintf('   Chromaticity = %f [%s]\n', c.Data(2), c.UnitsString);
% end
