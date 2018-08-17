function plotmeasbeta(varargin)
%PLOTMEASBETA - plot quadrupole betatron function from measurement
%
%  INPUTS
%  None - Ask user to select a file
%  1. AO - output structure from measbeta programme
%
%  PlotSim:   1, compare measured beta functions to the simulated values
%             0, check the beta functions distortions between the family
%                members.
%
%  See Also measbeta

%
%  Written by Laurent S. Nadolski
%
%  Jianfeng Zhang @ LAL, 24/02/2014 
%    Add a plot flag to compare measured and simulated beta functions.


FileName = '';
PlotSim = 1;   % flag to plot the measured and simulated beta functions 


if isempty(varargin)
    if isempty(FileName)
        DirectoryName = getfamilydata('Directory', 'QUAD');
        DirStart = pwd;
        cd(DirectoryName);
        [FileName, DirectoryName] = uigetfile('*.mat', 'Select a Quad File');
        if FileName == 0 
            ArchiveFlag = 0;
            disp('   Quadrupole betatron plotting canceled.');
            return
        end
        FileName = [DirectoryName, FileName];
    end    
    % Load from file
    load(FileName);
    cd(DirStart);
else
    AO = varargin{1};
end

QuadFam = fieldnames(AO.FamilyName);
spos  = [];
betax = [];
betaz = [];



 
%% plot the simulated and measured beta functions 
for k = 1:length(QuadFam)
  
  if (PlotSim)
      % need to verify the measurement positions... by Zhang @ LAL,
      % 24/02/2014
    spos = [spos getspos(QuadFam{k},AO.FamilyName.(QuadFam{k}).DeviceList)];
    betax = [betax AO.FamilyName.(QuadFam{k}).beta(:,1)];
    betaz = [betaz AO.FamilyName.(QuadFam{k}).beta(:,2)];
   
        
  else
        
    betax = AO.FamilyName.(QuadFam{k}).beta(:,1);
    betaz = AO.FamilyName.(QuadFam{k}).beta(:,2);
    
    figure
    subplot(2,1,1)
    bar(betax)
    xlabel('Quadrupole number')
    ylabel('\beta_x [m]');
    title(sprintf('%s quadrupole family', QuadFam{k}))
    
    subplot(2,1,2)
    bar(betaz)
    xlabel('Quadrupole number')
    ylabel('\beta_z [m]');
    addlabel(1,0,sprintf('%s', datestr(AO.TimeStamp,0)));
  end
end

%% get the theorectical optical functions and compare to the 
%   the measuremend beta functions

global THERING;
[TD, Tune] = twissring(THERING, 0, 1:(length(THERING)+1));
Tune = Tune(:);

Twiss = cat(1,TD.beta);
TwissX = Twiss(:,1);
TwissY = Twiss(:,2);
YLabel1 = sprintf('\\beta_x [meters]');
YLabel2 = sprintf('\\beta_y [meters]');
% Longitudinal position
S = cat(1,TD.SPos);

clf reset
    h1 = subplot(5,1,[1 2]);
    % plot Twiss paramaters
    plot(S, TwissX, 'b-o');
    xlabel('Position [meters]');ylabel(YLabel1);
    xaxis([S(1) S(end)]);
    hold on;
    plot(reshape(spos,1,[]),reshape(betax,1,[]),'r*','MarkerSize',10);
    legend('Simulation','Measurement');
    
    % plot lattice
    h2 = subplot(5,1,3);
    drawlattice;
        
    h3 = subplot(5,1,[4 5]);
    % plot Twiss parmaters
    plot(S, TwissY, 'b-o');
      xlabel('Position [meters]');ylabel(YLabel2);
    xaxis([S(1) S(end)]);
    hold on;
    plot(reshape(spos,1,[]),reshape(betaz,1,[]),'r*','MarkerSize',10);
    legend('Simulation','Measurement');
    
    linkaxes([h1 h2 h3],'x')
    set([h1 h2 h3],'XGrid','On','YGrid','On');
    
    grid on;
    
