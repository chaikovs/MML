%%
rep = tango_read_attribute2('ANS-C01/DG/BPM.5','XPosDD');
N = length(rep.value);

for k =1:1000,
    Xvalue = zeros(1,N);
    for ik =1:3, % averaging
        rep = tango_read_attribute2('ANS-C01/DG/BPM.5','XPosDD');
        Xvalue = Xvalue + rep.value;
        pause(0.3)
    end

    Xvalue = Xvalue/3;

    frev = getrf/416;
    figure(23);
    plot((1:N)/N*frev*1e6/64,abs(fft(Xvalue)))
    xaxis([300 1200]); yaxis([0 0.5e3])
    grid on
    xlabel('Frequency Hz')
    %pause(1)
    %[a ind] = max(abs(fft(rep.value)))
end

%%
rep = tango_read_attribute2('ANS-C05/DG/BPM.5','SumDD');

figure(41)
subplot(2,1,1)
plot(rep.value)

rep = tango_read_attribute2('ANS-C05/DG/BPM.5','XPosDD');

subplot(2,1,2)
plot(rep.value)

