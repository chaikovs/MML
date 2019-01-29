function [xfftamp,zfftamp,xfftphase,zfftphase,f_bpm]=fft_amp_phase_calcul(bufferX,bufferZ,fech)

Nbpm=size(bufferX,1);
Nsamples=size(bufferX,2);
f_bpm=(1:Nsamples)*fech/Nsamples;

% xfft(1:Nbpm,1:Nsamples)=0;
% zfft(1:Nbpm,1:Nsamples)=0; 

% tic
% for j=1:1:Nbpm
%     xfft(j,:)=fft(double(bufferX(j,:)))/Nsamples;
%     zfft(j,:)=fft(double(bufferZ(j,:)))/Nsamples;
%     xfftamp(j,:)=abs(xfft(j,:));
%     zfftamp(j,:)=abs(zfft(j,:));
%     xfftphase(j,:)=angle(xfft(j,:));
%     zfftphase(j,:)=angle(zfft(j,:));
%     
% end
% toc

    xfft2=fft(double(bufferX'))/Nsamples;
    zfft2=fft(double(bufferZ'))/Nsamples;
    xfftamp2=abs(xfft2);
    zfftamp2=abs(zfft2);
    xfftphase2=angle(xfft2);
    zfftphase2=angle(zfft2);

xfftamp=xfftamp2(2:int32(Nsamples/2),:)';
zfftamp=zfftamp2(2:int32(Nsamples/2),:)';
xfftphase=xfftphase2(2:int32(Nsamples/2),:)';
zfftphase=zfftphase2(2:int32(Nsamples/2),:)';
    
% xfftamp=xfftamp(:,2:int32(Nsamples/2));
% zfftamp=zfftamp(:,2:int32(Nsamples/2));
% xfftphase=xfftphase(:,2:int32(Nsamples/2));
% zfftphase=zfftphase(:,2:int32(Nsamples/2));
f_bpm=f_bpm(2:int32(Nsamples/2));

  