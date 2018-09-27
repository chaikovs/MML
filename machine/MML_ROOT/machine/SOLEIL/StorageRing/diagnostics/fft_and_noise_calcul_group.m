function [pxfft,pzfft,Xintegrale_bpm,Zintegrale_bpm,f_bpm]=fft_and_noise_calcul_group(bufferX,bufferZ,fech)

Nbpm=size(bufferX,1);
Nsamples=size(bufferX,2);
f_bpm=(1:Nsamples-1)*fech/Nsamples;

xfft(1:Nbpm,1:Nsamples)=0;
zfft(1:Nbpm,1:Nsamples)=0; 
pxfft(1:Nbpm,1:Nsamples)=0;
pzfft(1:Nbpm,1:Nsamples)=0; 
%pxfftaff(1:Nbpm,1:Nsamples)=0;
%pzfftaff(1:Nbpm,1:Nsamples)=0; 
%PXintegrale_bpm(1:Nbpm,1:Nsamples)=0;
%PZintegrale_bpm(1:Nbpm,1:Nsamples)=0;
Xintegrale_bpm(1:Nbpm,1:Nsamples)=0;
Zintegrale_bpm(1:Nbpm,1:Nsamples)=0;


xfft=fft(double(bufferX)./1000,[],2)/Nsamples;
zfft=fft(double(bufferZ)./1000,[],2)/Nsamples;
%xfft=fft(double(bufferX),[],2)/Nsamples;
%zfft=fft(double(bufferZ),[],2)/Nsamples;



pxfft=2*xfft.*conj(xfft);
pzfft=2*zfft.*conj(zfft);



%on normalise pour afficher la dsp en µm^2/Hz et non pas en µm^2/largeur de bande entre 2 échantillons
%pxfftaff(j,:)=sqrt(pxfft(j,:)*Nsamples/fech);
%pzfftaff(j,:)=sqrt(pzfft(j,:)*Nsamples/fech);
%pxfftaff=sqrt(pxfft);
%pzfftaff=sqrt(pzfft);



for step=2:Nsamples
    Xintegrale_bpm(:,step)=Xintegrale_bpm(:,step-1) + pxfft(:,step);
    Zintegrale_bpm(:,step)=Zintegrale_bpm(:,step-1) + pzfft(:,step);
end



pxfft=sqrt(pxfft);
pzfft=sqrt(pzfft);
Xintegrale_bpm=sqrt((Xintegrale_bpm));
Zintegrale_bpm=sqrt((Zintegrale_bpm));



