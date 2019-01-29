%ATMEXALL builds all AT platform deendent mex-files from C-sources
% On UNIX platform, the GNU gcc compiler must be installed and
% properly configured.
% On Windows, Microsoft Visual C++ is required

% Modification by Laurent S. Nadolski, April 6th, 2007
% For Linux platform -ldl is need (personal laptop)
% PLATFORMOPTION = ['-ldl -D',computer,' '];

StartDir = pwd;
ATROOT = atroot;

% Navigate to the directory that contains pass-methods
cd(ATROOT)
cd simulator
cd element
PASSMETHODDIR = pwd;
disp(['Current directory: ',PASSMETHODDIR]);
mexpassmethod('all');


% User passmethods
cd user
disp(['Current directory: ', pwd]);
%mexuserpassmethod('all');
%mexpassmethod({'DriftPass','BendLinearPass'})


% Navigate to the directory that contains tracking functions
cd(ATROOT)
cd simulator
cd track

disp(['Current directory:', pwd]);

switch computer
    case 'SOL2'
        PLATFORMOPTION = ['-D',computer,' '];
    case 'GLNX86'
        PLATFORMOPTION = ['-ldl -D',computer,' ']; % added by Laurent April 6th, 2007
    case 'GLNXA64'
        PLATFORMOPTION = ['-ldl -D',computer,' ']; % added by Laurent April 6th, 2007
    case  'PCWIN64'
        PLATFORMOPTION = ['-D',computer,' '];
    case  'PCWIN'
        PLATFORMOPTION = ['-D',computer,' '];
    case  'MACI64'
        %PLATFORMOPTION = ['-D',computer,' LDFLAGS=''-pthread -shared -m64'' '];
        PLATFORMOPTION = ['-D',computer,' LDFLAGS='' -shared -m64'' '];
    otherwise
        error('Platform not defined');
end

MEXCOMMAND = ['mex ',PLATFORMOPTION,'atpass.c'];
disp(MEXCOMMAND);
eval(MEXCOMMAND);

% Navigate to the directory that contains some accelerator physics functions
cd(ATROOT)
cd atphysics
disp(['Current directory:', pwd]);

% findmpoleraddiffmatrix.c
disp(['mex ', PLATFORMOPTION, ' findmpoleraddiffmatrix.c -I''',PASSMETHODDIR,'''']);

%eval(['mex findmpoleraddiffmatrix.c -I''',PASSMETHODDIR,'''']);
eval(['mex ', PLATFORMOPTION, ' findmpoleraddiffmatrix.c -I''',PASSMETHODDIR,'''']);

% ADD 'MEXING' instructions for other C files
disp('ALL mex-files created successfully')
clear ATROOT PASSMETHODDIR WARNMSG PLATFORMOPTION MEXCOMMAND
cd(StartDir);
