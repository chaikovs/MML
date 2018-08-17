function naff_getvtuneshiftAmplitude(ay, ny, filename)

if nargin < 3,
    filename = appendtimestamp('vtuneshift');
end

Txmin = 1e-3;   % mm minimum vertical coordinates
Tymin = 1e-3;   % mm minimum vertical coordinates
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
T = ringpass(THERING,[0;0;0;0;0;0],1);

ampx = Txmin; % mm V-amplitude

if LinearFlag
    ampy = ay*((1:ny)-1)/(ny-1);
else
    ampy = ay*sqrt(((1:ny)-1)/(ny-1));
end
%Add first point instead of zero
ampy(1) = Tymin;
delta = 0; % energy offset 

nux = nan*ones(1,ny);
nuy = nan*ones(1,ny);

for i1=1:ny, % loop over H-plane
    fprintf('%d/%d: amp_x=%g mm, amp_y=%g mm\n', i1, ny, ampx, ampy(i1));
    
    X0=[ampx/1000; 0; ampy(i1)/1000; 0; delta; 0]; % Initial tracking coordinates in SI units
    
    % tracking
    cpustart=cputime;
    [T LOSSFLAG] = ringpass(THERING,X0,NT, 'reuse');
    cpustop=cputime;
    fprintf('track time for %d turns : %g s\n', NT, cpustop-cpustart);
    
    if LOSSFLAG
        fprintf('Particle Lost\n')
        break;
    end
    
    % new variables with tracking coordinates
    Tx = T(1,:); Txp = T(2,:); Ty = T(3,:); Typ = T(4,:);

    % Tymax usefulness
    if (length(Ty)==NT) && (~any(isnan(Ty))) && (LOSSFLAG==0)
        
        % NAFF part
        cpustart=cputime;
        tmpnux1=abs(calcnaff(Tx(1:NT),Txp(1:NT),1)/TWOPI);
        tmpnuy1=abs(calcnaff(Ty(1:NT),Typ(1:NT),1)/TWOPI);
        cpustop=cputime;
        fprintf('NAFF CPU time (%d turns) : %g s\n',NT, cpustop-cpustart);
       
        
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
    
    save(filename, 'nux',  'nuy',  'ampx', 'ampy');    
end
%%
figure
subplot(2,1,1)
plot(ampy,nux,'k+-')
xlabel('V-amplitude (mm)')
ylabel('H-tune')

subplot(2,1,2)
plot(ampy,nuy,'k+-')
xlabel('V-amplitude (mm)')
ylabel('V-tune')
