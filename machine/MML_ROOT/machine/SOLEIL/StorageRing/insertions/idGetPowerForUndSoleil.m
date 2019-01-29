function  argout = idGetPowerForUndSoleil(varargin)
% INPUT
%  Optional You can set a Flag to 'Display' or 'NoDisplay' (Default)
%
%  OUTPUT
%  idGetPowerForUndSoleil - Returns a struct with (1xn)  array containing :
%  1. a structure
%       - undulator name for each insertion
%       - Bx  Horizontal magnetfield for each insertion
%       - Bz  Vertical magnetfield for each insertion
%       - P  radiated power for each insertion 
%       - Psum sum of all insertion power
% See Also idGetListOfInsertionDevices ; idGetGeomParamForUndSOLEIL;
% idGetUndDServer; idGetParamForUndSoleil

%
%% Written by A.Bence 03/10/2015

    DisplayFlag=0;
  %flatten cellarray if you give all argins in one variable
    for i = length(varargin):-1:1    
        if iscell(varargin{i})
            varargin=[varargin{:}];
        end    
    end  
    for i = length(varargin):-1:1    
        if strcmpi(varargin{i},'Display')
            DisplayFlag = 1;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'NoDisplay')
            DisplayFlag = 0;
            varargin(i) = [];
        end
    end    
    resp = idGetParamForUndSOLEIL('all');
    ID_Device = {resp.DServName}';
    argout.Name=[];
    argout.Bz=[];
    argout.Bx=[];
    argout.P =[];
    argout.Psum=0;
    
    X=[];
    %%
    for i=1:length(ID_Device)
       
        Bx=NaN;
        Bz=NaN;
        P=NaN;
        Name='';
        Name=resp(i).name;
        Bx=resp(i).Bx();
        Bz=resp(i).Bz();
        P=resp(i).P();
        PosBPM1=getspos('BPMx',resp(i).indRelBPMs(1,:));
        sectlen=resp(i).sectLenBwBPMs;
        CenPos=resp(i).idCenPos;
        X=[X; (PosBPM1+(sectlen/2)+CenPos)];
        argout.Name=[argout.Name; {Name}];
        argout.Bz=[argout.Bz; Bz];
        argout.Bx=[argout.Bx; Bx];
        argout.P=[argout.P; P];
       
    
    end
    
    argout.P(isnan(argout.P))=0; % replace NaN to 0; nansum is better but doesnt exist in R2009B
    argout.Psum=sum(argout.P);
    
   if DisplayFlag
    hfig=figure('units','normalized','outerposition',[0 0 0.9 0.9]);
    set(hfig,'numbertitle','off','name','Magnet field and radiated power by Insertions');
    %%
    subplot(3,1,1)
    ax=plotyy(X,argout.Bx,X,argout.Bz,'bar','bar');     
    xlim(ax(1),[0 getcircumference]);
    xlim(ax(2),[0 getcircumference]);
    title('Magnetic Field for each Insertion');    
    B1=get(ax(1));
    B2=get(ax(2));
    set(B1.Children, 'FaceColor','b');
    set(B1.YLabel,'Color','b'); 
    set(B2.Children, 'FaceColor',[0.6 0 0.6]);
    set(B2.YLabel,'Color',[0.6 0 0.6]); 
    ylabel(ax(1),'Bx Field[ T ]');
    ylabel(ax(2),'Bz Field[ T ]');
    xlabel('[m]');
    %%
    subplot(3,1,2);
    drawlattice();
    xlabel('[m]');
    %%
    subplot(3,1,3);
    %ax=plot(X,argout.P,'r');
    PBend=2.652*1e1*getenergy^3*getam('RMN')*getdcct*1e-3;
%     ax=bar(X,argout.P,'r');
%     hold on
%     bar(getspos('BEND'),ones(1,32)*PBend/32,'b');
%     xlim([0 getcircumference]);
%     ylabel('Power [ kW ]');
    ax=plotyy(X,argout.P,getspos('BEND'),ones(1,32)*PBend/32,'bar','bar');
    xlim(ax(1),[0 getcircumference]);
    xlim(ax(2),[0 getcircumference]);
    B1=get(ax(1));
    B2=get(ax(2));
    set(B1.Children, 'FaceColor','r');
    set(B1.YLabel,'Color','r'); 
    set(B2.Children, 'FaceColor',[0 0.6 0.5]);
    set(B2.YLabel,'Color',[0 0.6 0.5]); 
    ylabel(ax(1),'Undulator Power [ kW ]');
    ylabel(ax(2),'Bending Power [ kW ]');

    stitle=sprintf(['Radiated total power ',num2str(argout.Psum+PBend), ' kW','\n','Radiated power by bending magnet ',num2str(PBend), ' kW','\n','Radiated power by undulator ',num2str(argout.Psum), ' kW' ]);
    title(stitle);
    
    xlabel('[m]');
   end
     





