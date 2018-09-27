function [bufferX bufferZ RMSX RMSZ]=monbpmFA(record_length)

%%TODO input parameter to be mapped as for monbpm (choice BPM etc ...)

if record_length > 15
    warning('Record length too long. Maximumvalue 15 s');    
    record_length = 15;
end
dev='ANS/DG/fofb-sniffer.2';

Nbpm=size(family2tangodev('BPMx'),1);
h1=waitbar(0,'Recording on sniffer, please wait...');
tango_write_attribute2(dev,'recordLengthInSecs',record_length)
pause(1)
record_length=tango_read_attribute2(dev,'recordLengthInSecs');
for i=1:(record_length.value(1)+2)
    pause(1)
    waitbar(i/record_length.value(1),h1);
end
close(h1)

h2=waitbar(0,'Reading on sniffer, please wait...');

for j=1:1:Nbpm
    bufferX(j,:)=double(tango_command_inout2(dev,'GetXPosData',uint16(j)))./10^3;
    bufferZ(j,:)=double(tango_command_inout2(dev,'GetZPosData',uint16(j)))./10^3;
    waitbar(j/Nbpm,h2)
end
RMSX=std(bufferX');
RMSZ=std(bufferZ');
close(h2)

%% plot
figure
subplot(2,2,1)
plot(bufferX(:,1:100:end)')
xlabel('FA samples @ 10 kHz')
ylabel('µm')
title('Position X')
subplot(2,2,2)
plot(RMSX')
xlabel('BPM number')
ylabel('µm rms')
title('Horizontal noise')
subplot(2,2,3)
plot(bufferZ(:,1:100:end)')
xlabel('FA samples @ 10 kHz')
ylabel('µm')
title('Position Z')
subplot(2,2,4)
plot(RMSZ')
xlabel('BPM number')
ylabel('µm rms')
title('Vertical noise')

%% plot fit of the dispersion in the H-plane
figure
spos = getspos('BPMx',family2dev('BPMx'));
etax = modeldisp('BPMx',family2dev('BPMx'));
% y = disp*delta + y0
x = lsqr([etax ones(size(RMSX'))], RMSX'*1e-6);
plot(spos, RMSX); hold on
plot(spos,(etax*x(1)+x(2))*1e6,'r'); hold on
legend('Data', 'fit')
title(sprintf('Noise in H-plane: Delta = %.2e %% (x0 = %.2e um)', x(1)*100, x(2)*1e6));
xlabel('s-position (m)')
ylabel('RMS x (um)')


