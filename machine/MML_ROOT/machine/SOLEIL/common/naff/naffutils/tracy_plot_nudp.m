function tracy_plot_nudp(file)
% function tracy_plot_nudp(file)
% plot tune shift with energy from tracy output file

if nargin < 1
    file ='nudp.out';
end

try
    [~, data] = hdrload(file);
catch errRecord
    error('Error while opening filename %s',file)
end

%% energy in percent
dp = data(:,1)*100;

%% fractional tunes
nux = data(:,2);
nuz = data(:,3);
nux(nux==0)=NaN;
nuz(nuz==0)=NaN;

%% closed orbit
hcod = data(:,4)*1e3;
vcod = data(:,5)*1e3;

%% Set default properties
set(0,'DefaultAxesXgrid','on');
set(0,'DefaultAxesYgrid','on');

%% Plot

pwd0 = pwd;
[pathName DirName] = fileparts (pwd0);

figure(44)
subplot(1,2,1)
plot(dp,nux,'k.')
xlabel('Energy offset (%)')
ylabel('Horizontal tune')

subplot(1,2,2)
plot(dp,nuz,'k.')
xlabel('Energy offset (%)')
ylabel('Vertical tune')

suptitle('Tune shift with energy')

addlabel(0,0, DirName);
h=figure(45);
pos=get(h,'Position');
set(h,'Position', [pos(1:2)  900 380]);
subplot(1,2,1)
plot(dp,hcod,'k.')
xlabel('Energy offset (%)')
ylabel('Horizontal closed orbit (mm)')

subplot(1,2,2)
plot(dp,vcod,'k.')
xlabel('Energy offset (%)')
ylabel('Vertical closed orbit (mm)')
suptitle('Closed orbit variation with energy offset')
addlabel(0,0, DirName);

figure(441); 
clf('reset'); % clear all including textlabel
plot(dp,nux,'-b');hold on
plot(dp,nuz,'-r');
legend('Horizontal tune', 'Vertical tune', 'Location', 'Best');
xlabel('Energy offset (%)')
ylabel('Betatron tune')
addlabel(0,0, DirName);
