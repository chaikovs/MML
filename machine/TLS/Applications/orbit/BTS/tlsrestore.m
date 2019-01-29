%system parameter save file
%timestamp: 18-Jan-2002 08:08:08
%comment: Save System
ad=getad;
filetype         = 'RESTORE';      %check to see if correct file type
sys.machine      = 'BTS';          %machine for control
sys.mode         = 'SIMULATOR';       %online or simulator
sys.datamode     = 'REAL';         %raw or real (for real: (1)response matrix multiplied by bpm gains, (2) BPM reads have gain, offset
sys.bpmode       = 'Liberia';      %BPM system mode
sys.bpmslp       = 3.0;            %BPM sleep time in sec
sys.plane        = 1;              %plane (1=horizontal 2=vertical)
sys.algo         = 'SVD';          %fitting algorithm
sys.pbpm         = 0;              %use of photon BPMs
sys.filpath      = ad.Directory.Orbit;       %file path in MATLAB
sys.respfiledir  = ad.Directory.OpsData;                                           %response matrix directory
sys.respfilename = ad.OpsData.BPMRespFile; 
sys.dispfiledir  = ad.Directory.OpsData;                                           %dispersion directory
sys.dispfilename = ad.OpsData.DispFile;                                            %dispersion file
sys.mxs          = 69.716460;            %maximum ring circumference
sys.xlimax       = 69.716460;            %abcissa plot limit
sys.mxphi(1)     = 14;             %maximum horizontal phase advance
sys.mxphi(2)     = 6;              %maximum vertical phase advance
sys.xscale       = 'meter';        %abcissa plotting mode (meter or phase)
 
%*=== HORIZONTAL DATA ===*
bpm(1).dev      = 7;              %maximum orbit deviation
bpm(1).drf      = 0;               %dispersion component zero
bpm(1).id       = 1;               %BPM selection
bpm(1).scalemode= 1;               %BPM scale mode 0=manual mode, 1=autoscale
bpm(1).ylim     = 0.5;             %BPM vertical axis scale
cor(1).fract    = 1.0;             %fraction of correctors
cor(1).id       = 1;               %COR selection
cor(1).scalemode= 1;               %COR scale mode 0=manual mode, 1=autoscale
cor(1).ylim     = 30;              %COR horizontal axis scale (amp)
rsp(1).disp     = 'off';           %mode for matrix column display
rsp(1).eig      = 'off';           %mode for eigenvector display
rsp(1).fit      = 0;               %valid fit flag
rsp(1).rfflag   = 0;               %rf fitting flag
rsp(1).rfcorflag= 0;               %fitting flag for rf component in correctors
rsp(1).savflag  = 0;               %save solution flag
rsp(1).nsvd     = 3;              %number of singular values
rsp(1).svdtol   =  0;               %svd tolerance (0 uses number of singular values)
rsp(1).nsvdmx   = 7;              %default maximum number of singular values
 
%Note: only fit and weight for fitting will be used in orbit program from this array
%      Name and index are loaded from middleware
etaxwt=0.0;
%     name       index  fit (0/1) weight etaweight
bpmx={
{    '1BPMx1    '     1      1      1.000   etaxwt     }
{    '1BPMx2    '     2      1      1.000   etaxwt     }
{    '1BPMx3    '     3      1      1.000   etaxwt     }
{    '1BPMx4    '     4      1      1.000   etaxwt     }
{    '1BPMx5    '     5      1      1.000   etaxwt     }
{    '1BPMx6    '     6      1      1.000   etaxwt     }
{    '1BPMx7    '     7      1      1.000   etaxwt     }
};
 
%Note: only fit, weight for fitting will be used in orbit program from this array
%      Name and index are loaded from middleware
% name    index fit (0/1)  weight
corx={
{'THC1    '  1   1   1.0    }
{'THC1A   '  2   1   1.0    }
{'TTHC2   '  3   1   1.0    }
{'THC2    '  4   1   1.0    }
{'THC3    '  5   1   1.0    }
{'THC3A   '  6   1   1.0    }
{'TTHC7   '  7   1   1.0    }
}; 
 
%*===   VERTICAL DATA ===*
bpm(2).dev       = 7;     %maximum orbit deviation
bpm(2).drf       =  0;     %dispersion component zero
bpm(2).id        =  1;     %BPMx selection
bpm(2).scalemode =  1;     %BPMx scale mode 0=manual mode, 1=autoscale
bpm(2).ylim      =  0.25;  %BPMx vertical axis scale
cor(2).fract     =  1.0;   %fraction of correctors
cor(2).id        =  1;     %COR selection
cor(2).scalemode =  1;     %COR scale mode 0=manual mode, 1=autoscale
cor(2).ylim      = 30;     %COR vertical axis scale (amp)
rsp(2).disp      = 'off';  %mode for matrix column display
rsp(2).eig       = 'off';  %mode for eigenvector display
rsp(2).fit       =  0;     %valid fit flag
rsp(2).rfflag    =  0;     %rf fitting flag
rsp(2).rfcorflag =  0;     %fitting flag for rf component in correctors
rsp(2).savflag   =  0;     %save solution flag
rsp(2).nsvd      = 3;     %number of singular values
rsp(2).svdtol    =  0;     %svd tolerance (0 uses number of singular values)
rsp(2).nsvdmx    = 6;     %default maximum number of singular values
 
etaywt=50;  %nominal response ~0.25 peak, 5kHz difference ~0.0025 peak (factor 100)
%     name       index  fit (0/1) weight   etaweight
bpmy={
{    '1BPMy1    '     1      1      1.000   etaxwt     }
{    '1BPMy2    '     2      1      1.000   etaxwt     }
{    '1BPMy3    '     3      1      1.000   etaxwt     }
{    '1BPMy4    '     4      1      1.000   etaxwt     }
{    '1BPMy5    '     5      1      1.000   etaxwt     }
{    '1BPMy6    '     6      1      1.000   etaxwt     }
{    '1BPMy7    '     7      1      1.000   etaxwt     }
}; 
% name    index fit (0/1)  weight
cory={
{'TVC1    '  1   1   1.0    }
{'TVC1A   '  2   1   1.0    }
{'TVC2    '  3   1   1.0    }
{'TVC3    '  4   1   1.0    }
{'TVC4    '  5   1   1.0    }
{'TTVC4   '  6   1   1.0    }
{'TTVC5   '  7   1   1.0    }
{'TVC4A   '  8   1   1.0    }
{'TVC5    '  9   1   1.0    }
}; 
%Note: only fit and weight for fitting will be used in orbit program from this array
%      Name and index are loaded from middleware
%    name    index fit (0/1)  weight
bly={
{     'BL1 '     1     0    100.000 }
{     'BL2 '     2     0    100.000 }
{     'BL3 '     3     0    100.000 }
{     'BL4 '     4     0    100.000 }
{     'BL5 '     5     0    100.000 }
{     'BL6 '     6     0    100.000 }
{     'BL7 '     7     0    100.000 }
{     'BL8 '     8     0    100.000 }
{     'BL9 '     9     0    100.000 }
{     'BL10'    10     0    100.000 }
{     'BL11'    11     0    100.000 }
};
 