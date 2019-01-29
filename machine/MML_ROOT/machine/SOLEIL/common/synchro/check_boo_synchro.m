function [flag]=check_boo_synchro
% Estime amplitude sur tune synchro
ampmax=180; % sur fft
%ampmax=3; % sur max x en mm

temp=tango_read_attribute2('BOO-C03/DG/BPM.03','XPosDD');
X = temp.value;

istart   = 20;
nbpoints = 256;
iend     = istart + nbpoints-1;
Xval(1:nbpoints) = X(istart:iend);

% % fft
Xfft     = fft(Xval,nbpoints);
PXfft    = Xfft.* conj(Xfft) / nbpoints;
PXfft([1 2 nbpoints]) = 0; %% ???
amp=max(PXfft(1:20));
ampf=amp;

% max X
% Xval=Xval-mean(Xval);
% amp=max(abs(Xval));

%fprintf('%8.3f    %8.3f \n',ampf, amp)

if amp>ampmax
    flag=1;
else
    flag=0;
end
