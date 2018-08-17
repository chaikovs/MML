function [ SIGMA, erreur ] = analyse_image(input)

file=[input '/*.bmp']
liste = dir(file);
SIGMA_tot=zeros(length(liste),2)

for i=1: length(liste)
   imag=imread(liste(i).name);
   figure, imagesc(imag);
   roi=imcrop(imag);
   ay=mean(roi,1);
   ay=ay';
   ay=ay-min(ay);
   az=mean(roi,2);
   az=az-min(az);
   by=1:1:length(ay);
   bz=1:1:length(az);
   SIGMA_tot(i,:)=[sqrt(var(by,ay)) sqrt(var(bz,az))] ;
  
end

SIGMA=mean(SIGMA_tot);
erreur=std(SIGMA_tot);
close all,