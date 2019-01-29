function Result=TestCorrectionRF_LV_Unipolar(SESSION,File,temp)
% Indicate the location of the Device Servers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idDevServMainPS1=['ans-c05/ei/l-hu640_PS1'];
idDevServMainPS2=['ans-c05/ei/l-hu640_PS2'];
idDevServMainPS3=['ans-c05/ei/l-hu640_PS3'];
idDevServCHE=['ans-c05/ei/l-hu640_corr2'];
idDevServCHS=['ans-c05/ei/l-hu640_corr1'];
idDevServCVE=['ans-c05/ei/l-hu640_corr4'];
idDevServCVS=['ans-c05/ei/l-hu640_corr3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PathAndDataLVPolarCurrents=['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/' File];
fident=fopen(PathAndDataCircPolarCurrents,'r');
A=fscanf(fident,'%g %g %g %g %g %g',[6 inf]);
N=length(A);
for i=1:N
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',A(1,i),1E6*A(2,i),A(3,i),A(4,i),A(5,i),A(6,i));
    idSetCurrentSync(idDevServMainPS1, A(1,i), 0.1);
    if abs(A(2,i))<20e-6
    stepRF(A(2,i));
    end
    idSetCurrentSync(idDevServCHE, A(3,i), 0.002);
    idSetCurrentSync(idDevServCHS, A(4,i), 0.002);
    idSetCurrentSync(idDevServCVE, A(5,i), 0.002);
    idSetCurrentSync(idDevServCVS, A(6,i), 0.002);
    pause(temp)
end
