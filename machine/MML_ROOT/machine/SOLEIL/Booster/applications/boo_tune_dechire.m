% plot tune along ramp when beam dechire
% FFT every ilong turns
istart=14;
ilong =1024;

% Read BPM
Dev_name='boo-c01/dg/bpm.01';
% Dev_name='boo-c03/dg/bpm.02';
Dev_name='boo-c03/dg/bpm.03';
%Dev_name='boo-c16/dg/bpm.16';
Attr_name={'XPosDD'};
temp = tango_read_attributes2(Dev_name,Attr_name);
Xdata = temp.value;
% Reshape for table of n times ilong for FFT
Xdata(1:istart) = [];
Xlen=length(Xdata);
imax=floor(Xlen/ilong)*ilong;
Xdata=Xdata(1:imax);
XX=reshape(Xdata,ilong,floor(imax/ilong));

% Do fFFT
Xval=XX;
Xfft     = fft(Xval);
PXfft    = Xfft.* conj(Xfft)/imax;
PXfft(1,:) = 0; 

%Get max on first half
[MXfft, nux]=max(PXfft(1:floor(ilong/2),:)); % 
nux=nux/ilong;

figure(1), plot(Xdata)
xlabel('Turn'), ylabel('Amplitude')

figure(2), plot(MXfft)
xlabel('Turn'), ylabel('Tune Amplitude')

figure(3), plot(nux)
xlabel('Turn'), ylabel('Nu')

figure(4)
imagesc(log(PXfft(1:500,:)))