setpaththomx('TL_SL')
global THERING
TwissData.alpha=[-4.24,-4.34];TwissData.beta=[34.46,33.94];TwissData.ClosedOrbit=[0;0;0;0;];TwissData.mu=[0,0];TwissData.M44=[0,0,0,0];
TD1=twissline(THERING,0,TwissData,1:17); mat=cat(1,TD1.M44)
mat(end-3:end,:)