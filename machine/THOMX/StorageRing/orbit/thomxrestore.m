%function [sys,bpmx,bpmz,bpm,corx,corz,cor,rsp,bly]=soleilrestore
%system parameter save file
%timestamp: done by hand
%comment: Save System

%
% Modified by Laurent S. Nadolski

%% This file is part of the definition of the interface
%% Do not edit without mastering the contents.
%% TODO LAURENT : WARNING QUICK FIX just for a try !!!!!

AD = getad;
filetype         = 'Restore';      %check to see if correct file type
sys.machine      = 'Ring';         %machine for control
% sys.bpmode       = 'slowacquisition'; %BPM system mode
sys.bpmslp       = 0.1;            %BPM sleep time in sec
sys.globalperiod = 2.0;            %BPM sleep time in sec
% sys.silverperiod = 2.0;            %BPM sleep time in sec
sys.plane        = 1;              %plane (1=horizontal 2=vertical)
sys.algo         = 'SVD';          %fitting algorithm
sys.filepath     = AD.Directory.Orbit;       %file path in MATLAB
% sys.reffile      = [sys.filepath 'soleilsilver.dat']; %reference orbit file
sys.respfiledir  = AD.Directory.OpsData;             %response matrix directory
sys.respfilename = AD.OpsData.BPMRespFile;           %response matrix file
sys.etafile      = AD.Directory.DispData;            %dispersion file
sys.relative     = 1;              %relative or absolute BPM plot 1=absolute, 2=relative
% sys.fdbk         = 0;              %no feedback
% sys.abort        = 0;              %reset abort flag
sys.maxs          = AD.Circumference; %maximum ring circumference
sys.xlimax       = sys.maxs;        %abcissa plot limit
sys.maxphi(1)     = 10;             %maximum horizontal phase ADvance
sys.maxphi(2)     = 8;              %maximum vertical phase ADvance
sys.xscale       = 'meter';        %abcissa plotting mode (meter or phase)
sys.drf          = 0;              %RF in HW units correction if required 
%*=== HORIZONTAL DATA ===*
% bpm(1).dev      = 10;              %maximum orbit deviation
bpm(1).id       = 1;               %BPM selection
bpm(1).scalemode= 1;               %BPM scale mode 0=manual mode, 1=autoscale
bpm(1).ylim     = 5;               %BPM vertical axis scale
bpm(1).units    = '1000xHardware'; %Display Units
bpm(1).scale    = 1000;            %Scaling factor
cor(1).fract    = 1.0;             %fraction of correctors
cor(1).id       = 1;               %COR selection
cor(1).scalemode= 0;               %COR scale mode 0=manual mode, 1=autoscale
cor(1).ylim     = maxn(getfamilydata(cor(1).AOFamily,'Setpoint','Range'));  %COR horizontal axis scale (amp)
cor(1).units    = 'Hardware';      %Display Units
cor(1).hw2physics = hw2physics(cor(1).AOFamily,'Setpoint',1,1)*1e3; % mrAD
rsp(1).disp     = 'off';           %mode for matrix column display
rsp(1).eig      = 'off';           %mode for eigenvector display
rsp(1).fit      = 0;               %valid fit flag
rsp(1).rfflag   = 0;               %rf fitting flag
rsp(1).etaflag  = 1;               %dispersion fitting flag
rsp(1).savflag  = 0;               %save solution flag
rsp(1).nsvd     = 12;              %number of singular values
rsp(1).svdtol   = 0;               %svd tolerance (0 uses number of singular values)
rsp(1).nsvdmax  = 1;               %default maximum number of singular values
 
%Note: only fit and weight for fitting will be used in orbit program from this array
%      Name and index are loADed from middleware
%     name       index  fit (0/1) weight etaweight
% bpmx={
% {    '1BPM1    '     1      1      1.000   0.000     }

%%% TO DO ERASE for automatic way if no previous file exist

% A1 = family2common('BPMx');
% A2 = (1:120)';
% A3 = ones(120,1);
% A4 = ones(120,1);
% A5 = zeros(120,1);
% 
% for k = 1:120
%     bpmx{k} = {A1(k,:),A2(k),A3(k),A4(k),A5(k)};
% end
% bpmx = bpmx';

%BPM data: name, index, fit,  weight
bpmx={
{  'BPMx001'     1     1      1.000    0.000 }
{  'BPMx002'     2     2      1.000    0.000 }
{  'BPMx003'     3     3      1.000    0.000 }
{  'BPMx004'     4     4      1.000    0.000 }
{  'BPMx005'     5     5      1.000    0.000 }
{  'BPMx006'     6     6      1.000    0.000 }
{  'BPMx007'     7     7      1.000    0.000 }
{  'BPMx008'     8     8      1.000    0.000 }
{  'BPMx009'     9     9      1.000    0.000 }
{  'BPMx010'    10    10      1.000    0.000 }
{  'BPMx011'    11    11      1.000    0.000 }
{  'BPMx012'    12    12      1.000    0.000 }
};


%Note: only fit, weight for fitting will be used in orbit program from this array
%      Name and index are loADed from middleware
% name    index fit (0/1)  weight
% corx={
% {'1CX1    '  1   1   1.0    }

%%% TO DO ERASE for automatic way if no previous file exist
% family = 'HCOR';
% good   = getfamilydata(family,'Status');
% DeviceList = family2dev(family,0);
% A1 = family2common(family,DeviceList,0);
% nb = length(good);
% A2 = (1:nb)';
% A3 = ones(nb,1).*good;
% A4 = ones(nb,1);
% 
% for k = 1:nb
%     corx{k} = {A1(k,:),A2(k),A3(k),A4(k)};
% end
% corx = corx';

%COR data: name, index, fit,  weight,   limit,      ebpm,      pbpm

corx={
{  'HCOR001'     1     1      1.000     10.000      0.250  }
{  'HCOR002'     2     2      1.000     10.000      0.250  }
{  'HCOR003'     3     3      1.000     10.000      0.250  }
{  'HCOR004'     4     4      1.000     10.000      0.250  }
{  'HCOR005'     5     5      1.000     10.000      0.250  }
{  'HCOR006'     6     6      1.000     10.000      0.250  }
{  'HCOR007'     7     7      1.000     10.000      0.250  }
{  'HCOR008'     8     8      1.000     10.000      0.250  }
{  'HCOR009'     9     7      1.000     10.000      0.250  }
{  'HCOR010'    10    10      1.000     10.000      0.250  }
{  'HCOR011'    11    11      1.000     10.000      0.250  }
{  'HCOR012'    12    12      1.000     10.000      0.250  }
};

%*===   VERTICAL DATA ===*
% bpm(2).dev      = 10;              %maximum orbit deviation
bpm(2).id       = 1;               %BPM selection
bpm(2).scalemode= 1;               %BPM scale mode 0=manual mode, 1=autoscale
bpm(2).ylim     = 5;               %BPM vertical axis scale
bpm(2).units    = '1000xHardware'; %Display units
bpm(1).scale    = 1000;            %Scaling factor
cor(2).fract    = 1.0;             %fraction of correctors
cor(2).id       = 1;               %COR selection
cor(2).scalemode= 0;               %COR scale mode 0=manual mode, 1=autoscale
cor(2).ylim     = maxn(getfamilydata(cor(2).AOFamily,'Setpoint','Range'));  %COR horizontal axis scale (amp)
cor(2).units    = 'Hardware';      %Display Units
cor(2).hw2physics = hw2physics(cor(2).AOFamily,'Setpoint',1,1)*1e3; % mrAD
rsp(2).disp     = 'off';           %mode for matrix column display
rsp(2).eig      = 'off';           %mode for eigenvector display
rsp(2).fit      = 0;               %valid fit flag
rsp(2).rfflag   = 0;               %rf fitting flag
rsp(2).etaflag  = 0;               %dispersion fitting flag
rsp(2).savflag  = 0;               %save solution flag
rsp(2).nsvd     = 12;              %number of singular values
rsp(2).svdtol   = 0;               %svd tolerance (0 uses number of singular values)
rsp(2).nsvdmax  = 1;               %default maximum number of singular values

%%% TO DO ERASE for automatic way if no previous file exist
% 
% %     name       index  fit (0/1) weight   etaweight
% % bpmz={
% % {    '1BPM1    '     1      1      1.000     0.000     }
% bpmz = bpmx;

%BPM data: name, index, fit,  weight
bpmz={
{  'BPMz001'     1     1      1.000    0.000 }
{  'BPMz002'     2     2      1.000    0.000 }
{  'BPMz003'     3     3      1.000    0.000 }
{  'BPMz004'     4     4      1.000    0.000 }
{  'BPMz005'     5     5      1.000    0.000 }
{  'BPMz006'     6     6      1.000    0.000 }
{  'BPMz007'     7     7      1.000    0.000 }
{  'BPMz008'     8     8      1.000    0.000 }
{  'BPMz009'     9     9      1.000    0.000 }
{  'BPMz010'    10    10      1.000    0.000 }
{  'BPMz011'    11    11      1.000    0.000 }
{  'BPMz012'    12    12      1.000    0.000 }
};

%%% TO DO ERASE for automatic way if no previous file exist

% % name    index fit (0/1)  weight
% % corz={
% % {'1CY1    '  1   1   1.0    }
% family = 'VCOR';% good = getfamilydata(family,'Status');
% nb = length(good);
% DeviceList = family2dev(family,0);
% A1 = family2common(family,DeviceList,0);
% A2 = (1:nb)';
% A3 = ones(nb,1).*good;
% A4 = ones(nb,1);
% 
% for k = 1:nb
%     corz{k} = {A1(k,:),A2(k),A3(k),A4(k)};
% end
% corz = corz';

%COR data: name, index, fit,  weight,   limit,      ebpm,      pbpm

corz={
{  'VCOR001'     1     1      1.000     10.000      0.500  }
{  'VCOR002'     2     2      1.000     10.000      0.500  }
{  'VCOR003'     3     3      1.000     10.000      0.500  }
{  'VCOR004'     4     4      1.000     10.000      0.500  }
{  'VCOR005'     5     5      1.000     10.000      0.500  }
{  'VCOR006'     6     6      1.000     10.000      0.500  }
{  'VCOR007'     7     7      1.000     10.000      0.500  }
{  'VCOR008'     8     8      1.000     10.000      0.500  }
{  'VCOR009'     9     9      1.000     10.000      0.500  }
{  'VCOR010'    10    10      1.000     10.000      0.500  }
{  'VCOR011'    11    11      1.000     10.000      0.500  }
{  'VCOR012'    12    12      1.000     10.000      0.500  }
};
