function [J,phi,phi2]=aavari(y1,y2,beta1,beta2)
%function [J,phi,phi2]=aavari(y1,y2,beta1,beta2)
%given oscillation at y1, y2, get 
%action-angle variables, J, phi, phi2
%where J is action, phi is phase of y1, phi2 is phase of phi2
%y1,y2 are 1D vector, y1=sqrt(2 beta1 J) .* cos(phi), y2=sqrt(2 beta2 J) .* cos(phi2)
%beta1, beta2 are scalar
%The phase is adjusted so that it increases about 2*pi*tune each turn
%

ny1=y1/sqrt(beta1*2);
ny2=y2/sqrt(beta2*2);
ny1 = ny1 - mean(ny1);
ny2 = ny2 - mean(ny2);

if length(ny1) ~= length(ny2)
	disp('un-equal size of y1 and y2')
	J=[]; phi=[];dphi=[];
	return ;
end

[J, phi,phi2] = calcJphi_2(ny1,ny2);

function [J, phi, phi2] = calcJphi_2(ny1, ny2)
%apprxomate by square sum of y1, y2
%This one behaves correctly
%the action is obtained by considering the DC part of ny1^2 + ny^2
%the phase angle is obtained by predicting the correct phase according to 
%the tune, and then choose how phase should be chosen by adding 
%multiples of 2pi to acos() or 2pi-acos(). If it is still incorrect, simply
%replace it by the predicted phase
%

[cof,tune,dat] = ipfa(ny1); %tune is from 0 to 0.5
dtune_tol = 0.05;

sqtJ = ny1.^2 + ny2.^2;
y1dy2 = sum(ny1.*ny2); %y1.*y2' = cos(phi2-phi1)*sum(J)/2
dphi = acos(y1dy2/sum(sqtJ)/2.)/2./pi;

usemedian = 1; % nonzero, use median, 0 use fitting
cnt_correct = 0;
for i=1:length(ny1)
	wid = [max(1, i-5):min(length(ny1),i+5)];
	
	if usemedian
		J(i) = median(sqtJ(wid));
	else %use fitting
		[tJ(i), dphi] = fit4Jdphi(ny1(wid),ny2(wid));
		J(i) = tJ(i);	
	end
	offset = 0.0;
	if (ny1(i)-offset) > sqrt(J(i))
		tphi1 = 0;
	elseif (ny1(i)-offset) < -sqrt(J(i))
		tphi1 = 0.5;
	else
		tphi1 = acos((ny1(i)-offset)/sqrt(J(i))/1.025)/2./pi;  
		%devide by 1.02 because tJ is not the real amplitude, only close to it.	
	end
	if (ny2(i)-offset) > sqrt(J(i))
		tphi2 = 0;
	elseif (ny2(i)-offset) < -sqrt(J(i))
		tphi2 = 0.5;
	else
		tphi2 = acos((ny2(i)-offset)/sqrt(J(i))/1.025)/2./pi;
		%devide by 1.02 because tJ is not the real amplitude, only close to it.	
	end
		
	if i==1
		phi(i) = tphi1;
		phi2(i) = tphi2;
	else 
		pr_phi = phi(i-1) + tune; %predicting phi at i
		fp_phi = pr_phi-floor(pr_phi); %fractional part of pr_phi(i)
		if fp_phi < 0.5 % [0, pi)
			phi(i) = floor(phi(i-1)) + tphi1;
			if phi(i)<phi(i-1)
				phi(i) = phi(i) + 1.0;
			end
		else % [pi, 2pi)
			phi(i) = floor(phi(i-1)) + 1.0 - tphi1;
		end
		if phi(i) > pr_phi+0.25 | phi(i) < pr_phi-0.25
			cnt_correct = cnt_correct + 1;
			%disp('warning: corrected once')
			phi(i) = pr_phi;	
		end
	
		pr_phi2 = phi2(i-1) + tune; %predicting phi at i
		fp_phi2 = pr_phi2 -floor(pr_phi2 ); %fractional part of pr_phi(i)
		if fp_phi2 < 0.5 % [0, pi)
			phi2(i) = floor(phi2(i-1)) + tphi2;
			if phi2(i)<phi2(i-1)
				phi2(i) = phi2(i) + 1.0;
			end
		else % [pi, 2pi)
			phi2(i) = floor(phi2(i-1)) + 1.0 - tphi2;
		end
		if phi2(i) > pr_phi2+0.25 | phi2(i) < pr_phi2-0.25
			%disp('warning: corrected once, phi 2')
			phi2(i) = pr_phi2;	
		end
	
	end %end if i=1
end
phi2 = 2*pi*phi2 ;%- phi;
phi = 2*pi*phi;
disp(['corrected phase ' num2str(cnt_correct)]);

for ii=1:length(ny1)
		wid = [max(1, ii-5):min(length(ny1),ii+5)];
		J(ii) = mean(J(wid));
		phi(ii) = mean(phi(wid));
end

%save tmp J tJ phi phi_fit



%************************************************************
%calcJphi_1 is a failure, DO NOT USE IT!
%************************************************************
function [J, phi, phi2] = calcJphi_1(ny1, ny2)
%approxmate by maxima and minima
%This one is not very successful, because 
%1. the action J is very sensitive to noise
%2. the phase angle phi, phi2 don't behave correctly, jumping by 2pi unexpectedly
%
[cof,tune,dat] = ipfa(ny1); %tune is from 0 to 0.5
dtune_tol = 0.05;

for i=1:length(ny1)
	wid = [max(1, i-5):min(length(ny1),i+5)];
	
	if 1 %, 
		tmp(1) = max(ny1(wid))-min(ny1(wid)); 
		tmp(2) = max(ny2(wid))-min(ny2(wid));
		tJ = mean(tmp)/2.0; offset = 0.0;
		if (ny1(i)-offset) > tJ
			tphi1 = 0;
		elseif (ny1(i)-offset) < -tJ
			tphi1 = 0.5;
		else
			tphi1 = acos((ny1(i)-offset)/tJ/1.025)/2./pi;  
			%devide by 1.02 because tJ is not the real amplitude, only close to it.	
		end
		if (ny2(i)-offset) > tJ
			tphi2 = 0;
		elseif (ny2(i)-offset) < -tJ
			tphi2 = 0.5;
		else
			tphi2 = acos((ny2(i)-offset)/tJ/1.025)/2./pi;
			%devide by 1.02 because tJ is not the real amplitude, only close to it.	
		end
		
		%tmp = [ny1(wid),ny2(wid)];
		%tJ = (max( max(tmp)) - min( min( tmp ))  )/2.;
		%offset = (max( max(tmp)) + min( min( tmp )))/2;
		%tphi1 = acos((ny1(i)-offset)/tJ/1.02)/2./pi;   %devide by 1.02 because tJ is not the real amplitude, only close to it.
		%tphi2 = acos((ny2(i)-offset)/tJ/1.02)/2./pi;	
		
		J(i)=tJ^2;
	else
			
	end	
	
	if i==1
		phi(i) = tphi1;
		phi2(i) = tphi2;
	else 
		tp_phi = phi(i-1)-floor(phi(i-1)); %fractional part of phi(i-1)
		if tp_phi < 0.5 
			if (tphi1-tp_phi) <= tune + dtune_tol & (tphi1-tp_phi) >= tune - dtune_tol
				phi(i) = floor(phi(i-1)) + tphi1;	
			else
				phi(i) = floor(phi(i-1)) + 1.0- tphi1;
			end
			
		else
			if (1.0-tphi1-tp_phi) <= tune + dtune_tol & (1.0-tphi1-tp_phi) >= tune - dtune_tol
				phi(i) = floor(phi(i-1)) + 1.0 - tphi1;	
			else
				phi(i) = floor(phi(i-1)) + 1.0 + tphi1;
			end
		end
		
		tp_phi = phi2(i-1)-floor(phi2(i-1)); %fractional part of phi(i-1)
		if tp_phi < 0.5 
			if (tphi2-tp_phi) <= tune + dtune_tol & (tphi2-tp_phi) >= tune - dtune_tol
				phi2(i) = floor(phi2(i-1)) + tphi2;	
			else
				phi2(i) = floor(phi2(i-1)) + 1.0- tphi2;
			end
			
		else
			if (1.0-tphi2-tp_phi) <= tune + dtune_tol & (1.0-tphi2-tp_phi) >= tune - dtune_tol
				phi2(i) = floor(phi2(i-1)) + 1.0 - tphi2;	
			else
				phi2(i) = floor(phi2(i-1)) + 1.0 + tphi2;
			end
		end
		
	end %end if i=1
end %end for
phi2 = 2*pi*phi2 ;%- phi;
phi = 2*pi*phi;

