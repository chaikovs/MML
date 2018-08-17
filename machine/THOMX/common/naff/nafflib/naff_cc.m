function naff_cc
% naff_cc - Compile nafflibrary for Matlab
%

% Modified by Laurent S. Nadolski
% April 6th, 2007

cd_old = pwd;
cd(fileparts(which('naff_cc')))

disp(['Compiling NAFF routines on ', computer,'.'])

% Object files
disp('Compiling: modnaff.c');
mex LDFLAGS='-pthread -shared -m64' -I/usr/local/matlab/extern/include -O -c modnaff.c

disp('Compiling: example.c');
mex LDFLAGS='-pthread -shared -m64' -I/usr/local/matlab/extern/include -O -c complexe.c

disp('Compiling: nafflib.c');

internal_cc('nafflib.c modnaff.o complexe.o');

cd(cd_old);

function internal_cc(fn)
% cc(filename)
%
% MAC 64 bits 
% TODO WINDOWS

disp(['Compiling: ',fn]);

switch computer
    case {'MACI64', 'GLNX86', 'GLNX64', 'PCWIN', 'PCWIN64'}
        cmdstr = [ 'mex -I' matlabroot '/extern/include -O ', fn ];
    otherwise
        error('Architecture not defined')
end
disp(cmdstr);
eval(cmdstr);
