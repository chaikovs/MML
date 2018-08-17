function [datax,datay] = icaloaddata1(sel)
%[datax,datay] = icaloaddata1(sel)
%read tbt data according to option sel
%load data to be analyzed by ICA routines
%datax,     mxN   matrix
%datay,     mxN   matrix
%

global ICAROOT;
ICAROOT = 'J:\Rdrive\xiahuang\USPAS\ICA';

if ispc
    rawbasedir = '.';
else
    rawbasedir = '.';
end

switch lower(sel)
    
    case {'aps_2003'}
        [datax,datay] = readAPSdata ;
    case {'rhic_2005'}
        [datax,datay] = readRHICdata;
        
    case {'pt2kv_a2','pt2kv_a10','pt78kv_a2','pt78kv_a10','track'}
        [datax,datay] = readSPEAR3data(lower(sel)) ;
        
    case {'data1'}
        dir = [ICAROOT filesep 'icadata'];
        filename = 'tbt99840r.mat';
        [datax,datay] = readbstTBT(dir, filename);
    case {'sp3_orbitdata'}
        dire = 'J:\Rdrive\xiahuang\SPEAR\Operation\orbit\2014-1-30';
        filename = 'bpm_data_all.mat';
        load([dire filesep filename],'bpmv_all','bpmh_all');
        for ii=1:57
            bpmv_all(:,ii) = bpmv_all(:,ii) - mean(bpmv_all(:,ii));
            bpmh_all(:,ii) = bpmh_all(:,ii) - mean(bpmh_all(:,ii));
        end
        datax = bpmh_all';
        datay = bpmv_all';
    
    case {'nsls2_data1','nsls2_data2','nsls2_data3'}
        %dire = 'J:\Rdrive\xiahuang\NSLS2_loco\2014\TBT';
        dire = 'C:\xiahuang\work2014\NSLS2\TBT_data\20140707';
        if strcmp(lower(sel),'nsls2_data1')
            filename = 'SRdata.mat';
        else
            filename = 'SRdata_C.mat';
        end
        
        if strcmp(lower(sel),'nsls2_data3');
            dire = 'C:\xiahuang\work2015\ICA_optics';
            filename = 'SRdata.mat';
        end
        
        load([dire filesep filename],'x0','y0');
        datax = x0(:,1:1250);
        datay = y0(:,1:1250);
        
    case {'nsls2_case1','nsls2_case2','nsls2_case3'}
        dire = 'C:\xiahuang\work2015\ICA_optics\fitNSLS2_sim\sim_data';
        load([dire filesep 'data_track_' lower(sel(7:end)) '.mat'],'xa', 'ya','exa','eya');
        datax = xa+exa;
        datay = ya+eya;
        
    case {'spear_case1','spear_case2','spear_case3'}
%         dire = 'C:\xiahuang\work2014\NSLS2\TBT_sim';
        dire = 'C:\xiahuang\work2015\ICA_optics\fitSPEAR3_sim\sim_data';
        load([dire filesep 'data_track_' lower(sel(7:end)) '.mat'],'xa', 'ya','exa','eya');
        datax = xa+exa;
        datay = ya+eya;
        
    otherwise
        disp('no such data set');
        datax=[];
        datay=[];
end


function [x0,y0] = readAPSdata
%
global ICAROOT;
load(fullfile(ICAROOT,'icadata','argontbt4.mat'),'x0')
x0 = x0/1000.;
y0=[];
return

function [xa,ya] = readSPEAR3data(sel)
global ICAROOT;
if strcmp(sel,'track')
    load(fullfile(ICAROOT,'tbtdata',['data_track.mat']),'xa','ya')
else
    load(fullfile(ICAROOT,'tbtdata',['data_K1_' sel '.mat']),'xa','ya')
end
function [datax,datay] = readRHICdata
%
global ICAROOT;
load(fullfile(ICAROOT,'icadata','rhicdata.mat'))
datay(26:27,:) = [];
sy(26:27) = [];
namey(26:27,:) = [];


function [datax,datay] = readbstTBT(dir, filename)
%
%	dir = ['..' filesep 'rawdata'];
xmat = 'xreading';
ymat = 'yreading';
[datax,datay] = loadtbtmat(dir, filename, xmat,ymat);
datax = datax(:,1690+(1:1024));
datay = datay(:,1690+(1:1024));
disp(sprintf('load x0,y0 from %s',[dir filesep filename]));

function [x,y] = loadtbtmat(dir, filename, xmat,ymat)
%
eval(['load ' dir filesep filename ' ' xmat ' ' ymat]);
x=[];
y=[];
if ~isempty(xmat)
    eval(['x = ' xmat ';']);
end
size(x)
if ~isempty(ymat)
    eval(['y = ' ymat ';']);
end
size(y)
return

