function monrates
%MONRATES - Tests the analog monitor data rate for BPMs and corrector magnets
%
%  Tests the analog monitor data rate for BPMs and corrector magnets 
%  This test will only work if the AM value is very noisy.  (But it 
%  always is, if the BPMs are calibrated.)

%
% Written by Gregory J. Portmann, ALS
%
% TODO: adaptation for SOLEIL

alsglobe


% BPM Sample Rates
%StanRate = input('  What is the Stanford timer rate [Hz] = ');
List = getlist('BPMx');
if strcmp(computer, 'PCWIN')
   [BPMxrate, HCMn] = getrate('BPMx', List, 4);
else
   [BPMxrate, HCMn] = getrate('BPMx', List, 10);
end
disp('  ');

figure; clf
subplot(4,1,1);
sector = 1+((1:96)-1)/8 + 1/16;
bar(sector(BPMelem), BPMxrate);
set(gca,'XTick',1:12)
xaxis([1 13]);
%title(['BPM Sample Rates (Stanford Timer at ', num2str(StanRate),' Hz)', ' ', date]);
title(['BPM Data Rates']);
xlabel('Sector Number');
ylabel('Data Rate [Hz]');


% IDBPM Sample Rates
List = getlist('IDBPMx');
if strcmp(computer, 'PCWIN')
   [IDBPMxrate, HCMn] = getrate('IDBPMx', List, 4);
else
   [IDBPMxrate, HCMn] = getrate('IDBPMx', List, 10);
end
disp('  ');

subplot(4,1,2);
sector = 1+(IDBPMelem-1)/2 + 1/4;
bar(sector,IDBPMxrate);
set(gca,'XTick',1:12)
xaxis([1 13]);
title(['IDBPM Data Rates']);
xlabel('Sector');
ylabel('Data Rate [Hz]');


% HCM sample rates
[HCMrate, HCMn] = getrate('HCM', HCMlist, 4);
disp('  ');

subplot(4,1,3);
sector = 1+((1:96)-1)/8 + 1/16;
bar(sector(HCMelem), HCMrate);
set(gca,'XTick',1:12)
xaxis([1 13]);
title(['Horizontal Corrector Magnet Analog Monitor Data Rate']);
xlabel('Sector');
ylabel('Data Rate [Hz]');


% VCM sample rates
[VCMrate, VCMn] = getrate('VCM', VCMlist, 4);
disp('  ');

subplot(4,1,4);
sector = 1+((1:96)-1)/8 + 1/16;
bar(sector(VCMelem), VCMrate);
set(gca,'XTick',1:12)
xaxis([1 13]);
title(['Vertical Corrector Magnet Analog Monitor Data Rates']);
xlabel('Sector');
ylabel('Data Rate [Hz]');


addlabel(sprintf('%.1f GeV, %s', GLOBAL_SR_GEV, date));
orient tall