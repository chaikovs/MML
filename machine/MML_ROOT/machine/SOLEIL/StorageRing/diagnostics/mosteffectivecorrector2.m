function [delcm corr_orbit MEC orbit_reduction] = mosteffectivecorrector2(orbit,correctors,RF)
%MOSTEFFECTIVECORRECTOR - Correction using most effective corrector
%
%  INPUTS
%  1. plane of correction - 1 {Default} means Horizontal plane
%                           2 means vertical planes 
%
%  OUTPUTS
%  2. delcm - Corrector strengths from direct orbit correction
%
%  See Also setorbit

%
%  Written by Laurent S. Nadolski

CMFamily  = {'HCOR', 'VCOR'};


switch correctors
    case {'HCOR','FHCOR'}
        plane=1;
    case {'VCOR','FVCOR'}
        plane=2;
end
        

%%
switch correctors
    case {'FHCOR','FVCOR'}

        % Compute FOFB Response matrix
        R0 = getbpmresp('BPMx', 'BPMz','FHCOR', 'FVCOR',[getfamilydata('Directory','OpsData') getfamilydata('OpsData', 'BPMResp4FOFBFile')], 'Struct');
        %        R0 = getbpmresp4FOFB('Struct');

        R = R0(plane,plane).Data;
        CORlist = R0(plane,plane).Actuator.DeviceList;
        N_corr=size(CORlist,1);
    case {'HCOR','VCOR'}
        R0 = getbpmresp('Struct');

        R = R0(plane,plane).Data;
        CORlist = R0(plane,plane).Actuator.DeviceList;
        N_corr=size(CORlist,1);
end
%%
if RF
    switch correctors
        case{'FHCOR','HCOR'}
            Eta = modeldisp('BPMx', 'Hardware');
            RFWeight = 10 * mean(std(R)) / std(Eta);
            R = [R0(1,1).Data RFWeight*Eta];
            N_corr=N_corr+1
    end
end   
%%    
Rinv = pinv(R);



X0 = orbit;

X0std = std(X0);

delcm = Rinv*(X0);

X = X0(:,ones(N_corr,1));

% get index of most effective corrector and reduction factor
[val idx] = min(std(X-R*diag(delcm)));

efficiency=val/std(X0)*100;

orbit_diff=std(X-R*diag(delcm));
for i=1:N_corr
    if orbit_diff(i) >X0std
        orbit_reduction(i)=0;
    else
        orbit_reduction(i)=(1-(orbit_diff(i)./X0std))*100;
    end
end
efficiency_array=std(X-R*diag(delcm));

% if DisplayFlag
%     figure(2001)
%     subplot(2,1,1)
%     bar(delcm)
%     xlabel('Corrector number');
%     ylabel('Corrector Strength [A]');
%     title(sprintf('Most effective corrector using %s Family',CMFamily{plane}));
%     subplot(2,1,2)
%     plot(X0,'b'); hold on;
    theta = zeros(N_corr,1);
    theta(idx) = delcm(idx);
    corr_orbit=R*theta;
%     plot(corr_orbit,'r'); hold off;
%     xlabel('BPM number')
%     ylabel(' Close orbit [mm]')
%     legend('Before correction','Prediction')
% end

CORlist =  R0(plane,plane).Actuator.DeviceList;
%  fprintf('Most effective corrector is %s [%d %d] (%f A): orbit reduction by %f mm rms\n', ...
%     correctors, CORlist(idx,:), delcm(idx), X0std-val)
if RF && idx==N_corr && plane==1
    fprintf('Most effective corrector is %s RF (%f Hz): orbit reduction by %f percent\n', ...
        correctors, delcm(idx), orbit_reduction(idx))
    MEC='RF';
 
else
    fprintf('Most effective corrector is %s [%d %d] (%f A): orbit reduction by %f percent\n', ...
        correctors, CORlist(idx,:), delcm(idx), orbit_reduction(idx))
    MEC=CORlist(idx,:);
end

