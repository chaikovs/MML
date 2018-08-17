function naff_gethtuneshiftEnergy(emax, nx, filename)
%
%
%
%  NOTES
%   1. GLOBVAL.verbosity = 1 to see verbose information 

%
%% Written by Laurent S. Nadolski
if nargin < 3,
    filename = appendtimestamp('etuneshift');
end

Txmin = 1e-3;   % mm minimum vertical amplitude
Tymin = 1e-3;   % mm minimum vertical amplitude
tunesep = 1e-3; % tune separation for h/v tunes
TWOPI = 2*pi;

LinearFlag = 1;

%% set 4D tracking
setcavity('off');
setradiation('off');

global THERING


[BetaX, BetaY, Sx, Sy, Tune] = modelbeta;
HtuneIntegerPart = floor(Tune(1));
VtuneIntegerPart = floor(Tune(2));

%HtuneFractionalPart =
%VtuneFractionalPart =

% Tracking number of turns
NT = 516; % multiple of 6 for NAFF efficiency

% First call for next 'reuse' flag
% Do not remove
Rout = ringpass(THERING,[0;0;0;0;0;0],1);

ampy = Tymin; % mm V-amplitude

if LinearFlag
    eAmp = [ -emax*((nx:-1:2)-1)/(nx-1) 0 emax*((2:nx)-1)/(nx-1)];
else
    eAmp = emax*sqrt(((1:nx)-1)/(nx-1));
end

%Add first point (working point) instead of zero
ampx = Txmin;
delta   = 0; % energy offset 


len = length(eAmp);
nux = nan*ones(1,len);
nuy = nan*ones(1,len);


for i1=1:len, % loop over H-plane
    %atdisplay(1, sprintf('%d/%d: delta=%g %%\n', i1, len, eAmp(i1)*100));
    
    X0=[ampx/1000; 0; ampy/1000; 0; eAmp(i1); 0]; % Initial tracking coordinates in SI units
    
    % tracking
    cpustart=cputime;
    [Rout, LOSSFLAG] = ringpass(THERING,X0,NT);
    cpustop=cputime;
     %atdisplay(1, sprintf('track time for %d turns : %g s\n', NT, cpustop-cpustart));
    
    if LOSSFLAG
        fprintf('Particle Lost\n')
        %break;
    end
    
    % new variables with tracking coordinates
    Tx = Rout(1,:); Txp = Rout(2,:); Ty = Rout(3,:); Typ = Rout(4,:);

    % Tymax usefulness
    if (length(Ty)==NT) && (~any(isnan(Ty))) && (LOSSFLAG==0)
        
        % NAFF part
        cpustart=cputime;
        tmpnux1=abs(calcnaff(Tx(1:NT),Txp(1:NT),1)/TWOPI);
        tmpnuy1=abs(calcnaff(Ty(1:NT),Typ(1:NT),1)/TWOPI);
        cpustop=cputime;
        %atdisplay(1, sprintf('NAFF CPU time (%d turns) : %g s\n',NT, cpustop-cpustart));
        
        
        % build frequency vectors  for NT first turns
        if ((abs(tmpnuy1(1))>tunesep) && (abs(tmpnuy1(1)-tmpnux1(1))>tunesep))
            nuy(i1)=tmpnuy1(1);
        else
            nuy(i1)=tmpnuy1(2);
        end
        
        % avoid misidentification nux=nuy
        if (abs(tmpnux1(1))>tunesep)
            nux(i1)=tmpnux1(1);
        else
            nux(i1)=tmpnux1(2);
        end
   
    end
    
     save(filename, 'nux',  'nuy',  'eAmp');       
end
%%

figure
subplot(2,1,1)
plot(eAmp*100,nux,'k.-')
xlabel('Energy offset (%)')
ylabel('H-tune')

subplot(2,1,2)
plot(eAmp*100,nuy,'k.-')
xlabel('Energy offset (%)')
ylabel('V-tune')

addlabel(getlatticename)