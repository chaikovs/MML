filename='/home/operateur/GrpPhysiqueMachine/commun/2011-11-21/ReponseImpusionnelle_2011-11-21_09-03-33.mat';
load(filename);
pic_index=7; % index of impulse response maximum value
ir_width=3; % numbre of points at each side of max value taken for filter computation
padding=0; % for zero padding
gain=1
Nbpm=size(FirstTurn.DeviceList,1); % Number of BPM in impulse response file
demix_filter=zeros(Nbpm,2*ir_width+1+2*padding);
% for each BPM iterate and compute filter 
for bpm=1:Nbpm
    ir=FirstTurn.Data.Sum(bpm,pic_index-ir_width:pic_index+ir_width)./sum(FirstTurn.Data.Sum(bpm,pic_index-ir_width:pic_index+ir_width));
    %ir=[zeros(1,padding) ir zeros(1,padding)];
    IR=abs(fft(ir))
    %IR=IR(1:9)
    ir_inverse=real(ifft(1./IR))
    pic_index2=(size(IR,2)+1)/2;
    filter_coeff=circshift(ir_inverse,[1 -pic_index2]);
    demix_filter(bpm,:)=filter_coeff.*gain;
end

figure
subplot(2,2,1)
plot(ir); grid on;
subplot(2,2,2)
plot(abs(IR(1:pic_index2))); grid on; xlim([1 pic_index2]);
subplot(2,2,4)
plot(1./abs(IR(1:pic_index2))); grid on; xlim([1 pic_index2]);
subplot(2,2,3)
plot(filter_coeff); grid on;

figure
plot(demix_filter')
grid on
title('demix filters')
index=regexp(filename,'ReponseImpusionnelle_');
filter_filename=['/home/operateur/GrpPhysiqueMachine/commun/2011-11-21/demix_filter_',filename(index+21:size(filename,2))];
save(filter_filename,'demix_filter');
