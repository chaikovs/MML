function tracy_plotnudx(file1, file2,varagin)
% tracy_plotnudxT(file) - plot tuneshift with amplitude from tracy output file
%
%  INPUTS
%  1. file: filename to read

if nargin == 0
    data = tracy_readnudx;
else
    data = tracy_readnudx(file1, file2);
end

%% amplitude
x = data.x;
z = data.z;

%% fractional tunes
nux1 = data.nuxx;
nuz1 = data.nuzx;

nux2 = data.nuxz;
nuz2 = data.nuzz;

%% Set default properties
set(0,'DefaultAxesXgrid','on');
set(0,'DefaultAxesYgrid','on');

%% Plot
figure(43)
clf('reset');
subplot(2,2,1)
plot(x,nux1,'k.')
xlabel('Horizontal amplitude (mm)')
ylabel('Horizontal  tune')
% ylabel('$\nu_x$','Interpreter','latex')

subplot(2,2,3)
plot(x,nuz1,'k.')
xlabel('Horizontal amplitude (mm)')
% ylabel('$\nu_z$','Interpreter','latex')
ylabel('Vertical  tune')

subplot(2,2,2)
plot(z,nux2,'k.')
xlabel('Vertical amplitude (mm)')
ylabel('Horizontal  tune')

subplot(2,2,4)
plot(z,nuz2,'k.')
xlabel('Vertical amplitude (mm)')
ylabel('Vertical  tune')

addlabel(0,0,datestr(now))
