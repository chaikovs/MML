%plotgirderesp is a MATLAB script that reads in
%qxmat and qymat binary files generated by qresp script.
%girder responses gx/ymat are formed by grouping elements on girders
%cell responses cx/ymat are formed by grouping girders within a cell
%note that gx/ymat and cx/ymat are NOT saved
%this forces all data to be generated from source qresp, files qx/ymat
clear all;
indx=1:90;
spear3quadresp;
ibpm  = FINDCELLS(THERING, 'FamName', 'BPM');
spos=findspos(THERING,ibpm);

dwell=1;
x0=60; dx=170; y0=50; dy=120;
delx=200; dely=150;


load qxmat;
qxmat=1000*qxmat;
load qymat;
qymat=1000*qymat;

%locate order of magnets in response matrix
iqf  = FINDCELLS(magindx, 'FamName', 'QF');
iqd  = FINDCELLS(magindx, 'FamName', 'QD');
iqfc = FINDCELLS(magindx, 'FamName', 'QFC');
iqdx = FINDCELLS(magindx, 'FamName', 'QDX');
iqfx = FINDCELLS(magindx, 'FamName', 'QFX');
iqdy = FINDCELLS(magindx, 'FamName', 'QDY');
iqfy = FINDCELLS(magindx, 'FamName', 'QFY');
iqdz = FINDCELLS(magindx, 'FamName', 'QDZ');
iqfz = FINDCELLS(magindx, 'FamName', 'QFZ');
ibnd = FINDCELLS(magindx, 'FamName', 'BND');
ib34 = FINDCELLS(magindx, 'FamName', 'B34');

%use famindx to indicate starting column for each family
%magindx contains information for each family
famindx(1)=1;
for ii=1:length(magindx)-1
famindx(ii+1)=famindx(ii)+magindx{ii}.NumKids;
end

%matching cell #1
%note on matching cells must skip 3 indices for dipoles
g1=[famindx(iqdx) famindx(iqfx) famindx(iqdy) famindx(ib34) ];  %qdx/qfx/qdy/b34
g2=[famindx(iqfy)];                                     %match #1  
g3=[famindx(ib34)+1 famindx(iqdz) famindx(iqfz)];

g4=[famindx(iqf) famindx(iqd) famindx(ibnd)];           %standard #1
g5=[famindx(iqfc)];
                                   g6=reverse(g4)+1;
g7=reverse(g6)+1;     g8=g5+1;     g9=reverse(g7)+1;    %standard #2
g10=reverse(g9)+1;    g11=g8+1;    g12=reverse(g10)+1;  %standard #3
g13=reverse(g12)+1;   g14=g11+1;   g15=reverse(g13)+1;  %standard #4
g16=reverse(g15)+1;   g17=g14+1;   g18=reverse(g16)+1;  %standard #5
g19=reverse(g18)+1;   g20=g17+1;   g21=reverse(g19)+1;  %standard #6
g22=reverse(g21)+1;   g23=g20+1;   g24=reverse(g22)+1;  %standard #7

g25=reverse(g3)+1;   g26=g2+1;   g27=reverse(g1)+[3 1 1 1] ;     %match #2
g28=reverse(g27)+1;  g29=g26+1;  g30=reverse(g25)+[3 1 1];       %match #3

g31=reverse(g24)+1;   g32=g23+1;   g33=reverse(g31)+1;  %standard #8
g34=reverse(g33)+1;   g35=g32+1;   g36=reverse(g34)+1;  %standard #9
g37=reverse(g36)+1;   g38=g35+1;   g39=reverse(g37)+1;  %standard #10
g40=reverse(g39)+1;   g41=g38+1;   g42=reverse(g40)+1;  %standard #11
g43=reverse(g42)+1;   g44=g41+1;   g45=reverse(g43)+1;  %standard #12
g46=reverse(g45)+1;   g47=g44+1;   g48=reverse(g46)+1;  %standard #13
g49=reverse(g48)+1;   g50=g47+1;   g51=reverse(g49)+1;  %standard #14

g52=reverse(g30)+1;   g53=g29+1;   g54=reverse(g28)+[3 1 1 1];  %match #4
g{1} =g1;   g{2} =g2;   g{3} =g3;   g{4} =g4;    g{5} =g5;
g{6} =g6;   g{7} =g7;   g{8} =g8;   g{9} =g9;    g{10}=g10;
g{11}=g11;  g{12}=g12;  g{13}=g13;  g{14}=g14;   g{15}=g15;
g{16}=g16;  g{17}=g17;  g{18}=g18;  g{19}=g19;   g{20}=g20;
g{21}=g21;  g{22}=g22;  g{23}=g23;  g{24}=g24;   g{25}=g25;
g{26}=g26;  g{27}=g27;  g{28}=g28;  g{29}=g29;   g{30}=g30;
g{31}=g31;  g{32}=g32;  g{33}=g33;  g{34}=g34;   g{35}=g35;
g{36}=g36;  g{37}=g37;  g{38}=g38;  g{39}=g39;   g{40}=g40;
g{41}=g41;  g{42}=g42;  g{43}=g43;  g{44}=g44;   g{45}=g45;
g{46}=g46;  g{47}=g47;  g{48}=g48;  g{49}=g49;   g{50}=g50;
g{51}=g51;  g{52}=g52;  g{53}=g53;  g{54}=g54;

c1= [g1  g2  g3];
c2= [g4  g5  g6];
c3= [g7  g8  g9];
c4= [g10 g11 g12];
c5= [g13 g14 g15];
c6= [g16 g17 g18];
c7= [g19 g20 g21];
c8= [g22 g23 g24];
c9= [g25 g26 g27];
c10=[g28 g29 g30];
c11=[g31 g32 g33];
c12=[g34 g35 g36];
c13=[g37 g38 g39];
c14=[g40 g41 g42];
c15=[g43 g44 g45];
c16=[g46 g47 g48];
c17=[g49 g50 g51];
c18=[g52 g53 g54];

c{1} =c1;   c{2} =c2;   c{3} =c3;   c{4} =c4;    c{5} =c5;
c{6} =c6;   c{7} =c7;   c{8} =c8;   c{9} =c9;    c{10}=c10;
c{11}=c11;  c{12}=c12;  c{13}=c13;  c{14}=c14;   c{15}=c15;
c{16}=c16;  c{17}=c17;  c{18}=c18;


%indices of magnet location in response matrix
ring=[c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 c16 c17 c18];
%check sequencing of ring
%for ii=1:length(ring)         %go around ring
%ielem=ring(ii);               %location in response matrix
%search famlist to find element location in response matrix
%if ~isempty(find(ielem==famindx));
%disp([num2str(magindx{find(ielem==famindx)}.FamName) '  ' num2str(ielem)]);
%end
%end

%make horizontal girder alignment matrices (gxmat)
gxmat=[];
for ii=1:54   %54 girders
  xorb=zeros(length(qxmat(:,1)),1); %zero out orbit
  for jj=1:length(g{ii})
  xorb=xorb+qxmat(:,g{ii}(jj));   %add up 'quad' elements jj on girder ii
  end
  gxmat=[gxmat xorb];
end

%make horizontal cell alignment matrix
cxmat=[];
for ii=1:18   %18 cells
  xorb=zeros(length(qxmat(:,1)),1);  %zero out orbit
  for jj=1:length(c{ii})
  xorb=xorb+qxmat(:,c{ii}(jj));   %add up 'quad' elements jj on cell ii
  end
  cxmat=[cxmat xorb];
end
%==================================================
% =========  PLOT HORIZONTAL Girder COD ===========
%==================================================
%only first six (3 match + 3 standard)
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Horizontal Plane: First Girders',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:2         %index on rows
for jj=1:3         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
	'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);
set(hh,'YLim',[-10,10],'XLim',[0 235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
plotindx=(ii-1)*3+jj;
line('XData',spos,'YData',gxmat(:,matindx),'Color','r');
matindx=matindx+1;    %magindx{plotindx}.NumKids
%pause(dwell);
end    %end jj
end    %end ii

pause;
%========================================
% RMS gains with all girders - HORIZONTAL
%========================================
%plot RMS orbit distortion when all girders move with same sigma
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Total girder gains - horizontal',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:1         %index on rows
for jj=1:1         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
			'Position',[x0 y0 580 400]);

set(hh,'YLim',[0,50],'Xlim',[0,235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
line('XData',spos,'YData',...
sqrt(diag(gxmat*gxmat') ),'Color','r');
end    %end jj
end    %end ii
	%'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);

pause;


%=======================================================
% =========  PLOT HORIZONTAL Cell ALIGNMENTS ===========
%=======================================================
%only first six (2 match + 4 standard)
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Horizontal Plane: First Cells',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:2         %index on rows
for jj=1:3         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
	'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);
set(hh,'YLim',[-10,10],'Xlim',[0,235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
plotindx=(ii-1)*3+jj;
line('XData',spos,'YData',cxmat(:,matindx),'Color','r');
matindx=matindx+1;    %magindx{plotindx}.NumKids
%pause(dwell);
end    %end jj
end    %end ii

pause;
%========================================
% RMS gains with all cells - HORIZONTAL
%========================================
%plot RMS orbit distortion when all cells move with same sigma
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Total cell gains - horizontal',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:1         %index on rows
for jj=1:1         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);
set(hh,'YLim',[0,50],'Xlim',[0,235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
line('XData',spos,'YData',...
sqrt(diag(cxmat*cxmat') ),'Color','r');
end    %end jj
end    %end ii

pause;

%==================================================
%   ===============   VERTICAL ====================
%==================================================
%make vertical girder alignment matrices (gymat)
gymat=[];
for ii=1:54   %54 girders
  yorb=zeros(length(qymat(:,1)),1); %zero out orbit
  for jj=1:length(g{ii})
  yorb=yorb+qymat(:,g{ii}(jj));   %add up 'quad' elements jj on girder ii
  end
  gymat=[gymat yorb];
end

%make vertical cell alignment matrix
cymat=[];
for ii=1:18   %18 cells
  yorb=zeros(length(qymat(:,1)),1);  %zero out orbit
  for jj=1:length(c{ii})
  yorb=yorb+qymat(:,c{ii}(jj));   %add up 'quad' elements jj on cell ii
  end
  cymat=[cymat yorb];
end

%=======================================================
% =========  PLOT VERTICAL Girder ALIGNMENTS ===========
%=======================================================
%only first six (3 match + 3 standard)
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Vertical Plane: First Girders',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:2         %index on rows
for jj=1:3         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
	'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);
set(hh,'YLim',[-10,10],'Xlim',[0,235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
plotindx=(ii-1)*3+jj;
line('XData',spos,'YData',gymat(:,matindx),'Color','r');
matindx=matindx+1;    %magindx{plotindx}.NumKids
%pause(dwell);
end    %end jj
end    %end ii

pause;

%========================================
% RMS gains with all girders - VERTICAL
%========================================
%plot RMS orbit distortion when all girders move with same sigma
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Total girder gains - vertical',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:1         %index on rows
for jj=1:1         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
		'Position',[x0 y0 580 400]);
set(hh,'YLim',[0,50],'Xlim',[0,235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
line('XData',spos,'YData',...
sqrt(diag(gymat*gymat') ),'Color','r');
end    %end jj
end    %end ii
%'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);

pause;
%=====================================================
% =========  PLOT VERTICAL Cell ALIGNMENTS ===========
%=====================================================
%only first six (2 match + 4 standard)
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Vertical Plane: First Cells',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:2         %index on rows
for jj=1:3         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
	'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);
set(hh,'YLim',[-10,10],'Xlim',[0,235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
plotindx=(ii-1)*3+jj;
line('XData',spos,'YData',cymat(:,matindx),'Color','r');
matindx=matindx+1;    %magindx{plotindx}.NumKids
%pause(dwell);
end    %end jj
end    %end ii

pause;
%========================================
% RMS gains with all cells - VERTICAL
%========================================
%plot RMS orbit distortion when all cells move with same sigma
clf;;
uicontrol('Style','pushbutton',...	
   'Position',[100 300 500 100],...
   'BackgroundColor',[1 1 1],...
   'String','Total cell gains - vertical',...
   'FontSize',20,'FontWeight','demi');
pause;
clf;

matindx=1;
for ii=1:1         %index on rows
for jj=1:1         %index on columns
hh=axes('Units','pixels',...
	'Color', [1 1 1],'Box','on','NextPlot','add',...
	'Position',[x0+(jj-1)*delx y0+(3-ii)*dely dx dy]);
set(hh,'YLim',[0,50],'Xlim',[0,235],...
'Color',[1 1 1],'NextPlot','add','Visible','on',...
'FontSize',6);
line('XData',spos,'YData',...
sqrt(diag(cymat*cymat') ),'Color','r');
end    %end jj
end    %end ii
pause;
