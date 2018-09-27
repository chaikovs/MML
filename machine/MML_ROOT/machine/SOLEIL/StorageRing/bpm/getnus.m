function nus = getnus
%  Function getnus computes synchroton tune from XBPM
%
%  OUTPUTS
%  1. nus in Hz
%
%
%  Note: LOCUM bandwidth is 2.5 kHz,
%  So it is not possible to measure the nominal synchrotron tune
%
%  See Also measmcf

%%

DisplayFlag = 1;
XBPMFlag = 1;

if XBPMFlag
    % Try with first XBPM of PX1 BL
    deviceName = 'TDL-I10-C/DG/DAQ.1';


    rep = tango_read_attributes2(deviceName, {'channel0', 'channel1', 'channel2', 'channel3'});

    % Build up X signal
    Xsignal = 1.4*((rep(1).value+rep(4).value)-(rep(2).value+rep(3).value))./ ...
        (rep(1).value+rep(2).value + rep(3).value+rep(4).value);

    %mean(Xsignal)

    XFFT = abs(fft(Xsignal));

    % Build Z signal
    Zsignal = 1.385*((rep(1).value+rep(2).value)-(rep(3).value+rep(4).value))./ ...
        (rep(1).value+rep(2).value + rep(3).value+rep(4).value);

    %mean(Zsignal)

    ZFFT = abs(fft(Zsignal));

    % Sampling rate is 10 kHz
    xval = (0:length(ZFFT)-1); %

    if DisplayFlag
        figure(44)
        clf
        subplot(2,1,1)
        plot(Xsignal)
        ylabel('H value')
        subplot(2,1,2)
        semilogy(xval, XFFT)
        ylabel('Amplitude (a.u.)')
        xlabel('Frequency Hz');
        ylim([0 max(XFFT(10:end))])
        xlim([0 length(Xsignal)/2-1])
    end

    % look for synchrotron tune
    % should be maximum amplitude (discarding low frequency data)

    skip = 100;
    [val, idx] = max(XFFT(skip:end-7500)); idx = idx + skip-1;
    hold on;
    nus = xval(idx);
    plot(xval(idx), XFFT(idx), '*r');

    fprintf('Max frequency is: %f Hz \n', nus);
    title(sprintf('Synchrotron tune: %5.2f Hz',nus))

else
    % Try with first BPMtest
    deviceName = 'ANS-C09/DG/BPMTEST.1';


    rep = tango_read_attributes2(deviceName, {'XPosDD', 'ZPosDD'})

    % Build up X signal
    Xsignal = rep(1).value;

    %mean(Xsignal)

    XFFT = abs(fft(Xsignal));

    % Build Z signal
    Zsignal = rep(2).value;

    %mean(Zsignal)

    ZFFT = abs(fft(Zsignal));

    % Sampling rate is 10 kHz
    xval = (0:length(ZFFT)-1); %

    if DisplayFlag
        figure(44)
        clf
        subplot(2,1,1)
        plot(Xsignal)
        ylabel('H value')
        subplot(2,1,2)
        semilogy(xval, XFFT)
        ylabel('Amplitude (a.u.)')
        xlabel('Frequency Hz');
        ylim([0 max(XFFT(10:end))])
        xlim([0 length(Xsignal)/2-1])
    end

    % look for synchrotron tune
    % should be maximum amplitude (discarding low frequency data)

    [val, idx] = max(XFFT(1000:end)); idx = idx + 999;
    hold on;
    nus = xval(idx);
    plot(xval(idx), XFFT(idx), '*r');

    fprintf('Max frequency is: %f Hz \n', nus);
end