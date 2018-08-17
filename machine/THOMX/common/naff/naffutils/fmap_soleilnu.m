function [nux,nuy,diffu]=fmap_soleilnu(nx,ny,ax,ay)
% fmap_soleilnu - simulates a frequency map using the tracking
%
% simulates a frequency map using the tracking
% routine's out of Andrei Terebilo's ATtoolbox and
% Jacques Laskars NAFF algorithm
% (calcnaff.mex or calcnaff.dll)
%
% INPUTS
% 1. nx		number of horizontal amplitudes
% 2. ny		number of vertical amplitudes
% 3. ax		maximum horizontal amplitude [mm]
% 4. ay		maximum vertical amplitude [mm]
%
% OUTPUTS
% 1. nux    H-betatron tune value
% 2. nuy 	V-betatron tune value
% 3. diffu	Diffusion rate

%
% Laurent Nadolski, SOLEIL 16/05/11

global THERING

Tymax = 1e-2;   % maximum vertical coordinates
tunesep = 1e-3; % tune separation for h/v tunes
TWOPI = 2*pi;

%% Initialization part
% Frequencies
nux = zeros(nx,ny);
nuy = zeros(nx,ny);

% Amplitudes
pampx = ones(nx,ny)*NaN;
pampy = ones(nx,ny)*NaN;

%% load lattice
refreshthering;

[BetaX, BetaY, Sx, Sy, Tune] = modelbeta;
HtuneIntegerPart = floor(Tune(1));
VtuneIntegerPart = floor(Tune(2));

%% set 4D tracking
setcavity('off');
setradiation('off');

% Tracking number of turns
NT = 2*516; % multiple of 6 for NAFF efficiency

% First call for next 'reuse' flag
% Do not remove
T = ringpass(THERING,[0;0;0;0;0;0],1);

%% tracking over the set of initial conditions
for i=1:nx, % loop over H-plane
    ampx = ax*sqrt(i/nx); % H-amplitude
    
    for j=1:ny % loop over V-plane

        ampy = ay*sqrt(j/ny); % V-amplitude
               
        fprintf('amp_x=%g mm, amp_y=%g mm\n',ampx,ampy);
        
        X0=[ampx/1000 0 ampy/1000 0 0 0]'; % Initial tracking coordinates in SI units
        
        % tracking
        cpustart=cputime;
        %[T LOSSFLAG] = ringpass(THERING,X0,NT,'reuse');
        [T LOSSFLAG] = ringpass(THERING,X0,NT);
        cpustop=cputime;
        fprintf('track time for 2*%d turns : %g s\n', NT/2, cpustop-cpustart);
        
        % new varaibles with tracking coordinates
        Tx = T(1,:); Txp = T(2,:); Ty = T(3,:); Typ = T(4,:);
        
        % Tymax usefulness
        if (length(Ty)==NT) & (all(Ty<Tymax)) ...
                & (~any(isnan(Ty))) & (LOSSFLAG==0)
            
            % NAFF part
            cpustart=cputime;
            tmpnux1=abs(calcnaff(Tx(1:NT/2),Txp(1:NT/2),1)/TWOPI);
            tmpnuy1=abs(calcnaff(Ty(1:NT/2),Typ(1:NT/2),1)/TWOPI);
            tmpnux2=abs(calcnaff(Tx(NT/2+1:NT),Txp(NT/2+1:NT),1)/TWOPI);
            tmpnuy2=abs(calcnaff(Ty(NT/2+1:NT),Typ(NT/2+1:NT),1)/TWOPI);
            cpustop=cputime;
            fprintf('NAFF CPU time (4*%d turns) : %g s\n',NT/2, cpustop-cpustart);
            
            % Particle amplitudes
            pampy(i,j)=ampx;
            pampy(i,j)=ampy;
            
            % build frequency vectors  for NT/2 first turns                      
            if ((abs(tmpnuy1(1))>tunesep) && (abs(tmpnuy1(1)-tmpnux1(1))>tunesep))
                nuy(i,j)=tmpnuy1(1);
            else
                nuy(i,j)=tmpnuy1(2);
            end
            
            % avoid misidentification nux=nuy
            if (abs(tmpnux1(1))>tunesep)
                nux(i,j)=tmpnux1(1);
            else
                nux(i,j)=tmpnux1(2);
            end
            
            % build frequency vectors  for NT/2 last turns                      
            if ((abs(tmpnuy2(1))>tunesep) && (abs(tmpnuy2(1)-tmpnux2(1))>tunesep))
                nuy2=tmpnuy2(1);
            else
                nuy2=tmpnuy2(2);
            end
            
            if (abs(tmpnux2(1))>tunesep)
                nux2=tmpnux2(1);
            else
                nux2=tmpnux2(2);
            end
            
            
            if (length(nux2)==1) && (length(nuy2)==1) && ...
                    (length(nux(i,j))==1) && (length(nuy(i,j))==1)
                diffu(i,j)=log10(sqrt((nux2-nux(i,j))^2+(nuy2-nuy(i,j))^2)/NT*2);
            else
                diffu(i,j) = -3;
            end
            
            if (diffu(i,j) < -10)
                diffu(i,j) = -10;
            end
            
            taxi = ax*sqrt(i/nx);
            taxii = ax*sqrt((i-1)/nx);
            tayj = ay*sqrt(j/ny);
            tayjj = ay*sqrt((j-1)/ny);
            
            if (i>1) && (j>1)
                xpos(:,(i-1)*(ny)+j) = [taxii;taxii;taxi;taxi];
                ypos(:,(i-1)*(ny)+j) = [tayjj;tayj;tayj;tayjj];
            elseif (i>1)
                xpos(:,(i-1)*(ny)+j) = [taxii;taxii;taxi;taxi];
                ypos(:,(i-1)*(ny)+j) = [0;tayj;tayj;0];
            elseif (j>1)
                xpos(:,(i-1)*(ny)+j) = [0;0;taxi;taxi];
                ypos(:,(i-1)*(ny)+j) = [tayjj;tayj;tayj;tayjj];
            else
                xpos(:,(i-1)*(ny)+j) = [0;0;taxi;taxi];
                ypos(:,(i-1)*(ny)+j) = [0;tayj;tayj;0];
            end
            
            nuxpos(:,(i-1)*(ny)+j) = ...
                [nux(i,j)-.0001;nux(i,j)-.0001;nux(i,j)+.0001;nux(i,j)+.0001];
            nuypos(:,(i-1)*(ny)+j) = ...
                [nuy(i,j)-.0006;nuy(i,j)+.0006;nuy(i,j)+.0006;nuy(i,j)-.0006];
            
            diffuvec(1:4,(i-1)*(ny)+j) = diffu(i,j);
            
            
        else %particle unstable
            nux(i,j)=0.0; nuy(i,j)=0.0;
            pampy(i,j)=-1;pampy(i,j)=-1;
            xpos(:,(i-1)*(ny)+j) = [0;0;0;0];
            ypos(:,(i-1)*(ny)+j) = [0;0;0;0];
            nuxpos(:,(i-1)*(ny)+j) = [0;0;0;0];
            nuypos(:,(i-1)*(ny)+j) = [0;0;0;0];
            diffu(i,j)=-10;
            diffuvec(1:4,(i-1)*(ny)+j) = [-10;-10;-10;-10];
        end
        
        if nux(i,j) && nuy(i,j)
            fprintf('nu_x=%g, nu_y=%g\n',HtuneIntegerPart+nux(i,j),VtuneIntegerPart+nuy(i,j));
        else
            fprintf('particle lost\n');
        end
        
    end
    
    save 'freqmap_new' nux nuy diffu nuxpos nuypos xpos ypos diffuvec pampy pampy
    
end

%% PLOTS

f1=figure;
plot(HtuneIntegerPart+nux,VtuneIntegerPart+nuy,'b.');
axis([18.2 18.5 10.0 10.5]);
title('SOLEIL lattice, calculated frequency map (NAFF)');
xlabel('\nu_x');
ylabel('\nu_y');
pause(0.1);

%% Plot diffusion
if min(size(diffu)) > 1
    
    figure;
    fill(xpos,ypos,diffuvec);
    axis([0 ax 0 ay]);
    caxis([-10 -3]);
    hold on;
    shading flat;
    colormap('jet');
    colorbar;
    title('SOLEIL lattice, calculated frequency map (NAFF)');
    xlabel('x position (mm) (injection straight)');
    ylabel('z position (mm)');
    hold off;
    
    figure;
    fill(HtuneIntegerPart+nuxpos,VtuneIntegerPart+nuypos,diffuvec);
    axis([18.2 18.5 10.0 10.5]);
    caxis([-10 -3]);
    hold on;
    shading flat;
    colormap('jet');
    colorbar;
    title('SOLEIL lattice, calculated frequency map (NAFF)');
    xlabel('\nu_x');
    ylabel('\nu_z');
    hold off;
    
end
