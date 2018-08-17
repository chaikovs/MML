function [nux,nuy, delta]=fmap_nudp(ndp,deltamax)
% fmap_nudp(ndp,deltamax) - Compute tuneshift with energy
%
% Routine's out of Andrei Terebilos ATtoolbox and
% Jacques Laskars NAFF algorithm
% (calcnaff.mex or calcnaff.dll)
%
% INPUTS
% 1. ndp	    	number of horizontal amplitudes
% 2. deltmax		number of vertical amplitudes
%
% OUTPUTS
% 1. nux		horizontal betatron tune
% 2. nuy		vertical betatron tune
% 3. delta      energy offset

%
% Laurent Nadolski, ALS 09/01/02
% Revised, April 22, 2011                   

DisplayFlag =1;
global THERING

radiationoff;
cavityoff;

%plotbeta;

%fprintf('Type any key to continue ...\n');
%pause;

NT = 1026;

T = ringpass(THERING,[0;0;0;0;0;0],1);

delta = (-ndp:1:ndp)*deltamax/ndp;

for i=1:(2*ndp+1)
    %fprintf('amp_x=%g mm, amp_y=%g mm\n',ampx,ampy);
    cod = getcod(THERING,delta(i));
    X0=[1e-6 0 1e-6 0 delta(i) 0]' + [cod(:,1); 0; 0] ;

    cpustart=cputime;
    [T LOSSFLAG] = ringpass(THERING,X0,NT,'reuse');
    cpustop=cputime;
    fprintf('track time for %d turns : %g s\n', NT, cpustop-cpustart);

    Tx = T(1,:);  Txp = T(2,:);
    Ty = T(3,:);  Typ = T(4,:);
    TE = T(5,:);  Tphi = T(6,:);

    if (length(Ty)==NT) & (all(Ty<0.004)) ...
            & (~any(isnan(Ty))) & (LOSSFLAG==0)

        cpustart = cputime;
        tmpnux1 = calcnaff(Tx(1:NT),Txp(1:NT),1);
        tmpnux1 = abs(tmpnux1/(2*pi));
        tmpnuy1 = calcnaff(Ty(1:NT),Typ(1:NT),1);
        tmpnuy1 = abs(tmpnuy1/(2*pi));

        cpustop=cputime;
        fprintf('NAFF CPU time (4*512 turns) : %g s\n',cpustop-cpustart);

        nux(i)=NaN; nuy(i) = NaN;
        
        if abs(tmpnux1(1)) > 1e-6
            nux(i) = tmpnux1(1);
        else
            nux(i) = tmpnux1(2);
        end

        if abs(tmpnuy1(1)) > 1e-6
            nuy(i) = tmpnuy1(1);
        else
            nuy(i) = tmpnuy1(2);
        end
    end
end

%%
if DisplayFlag
  figure
  plot(delta*100, nux, 'b.'); 
  hold on;
  plot(delta*100, nuy, 'r.'); 
  ylabel('Fractional tune');
  legend('H-tune', 'V-tune');
  xlabel('Energy offset %)');
end
