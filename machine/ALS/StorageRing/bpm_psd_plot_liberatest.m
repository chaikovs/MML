function varargout = bpm_psd_plot(varargin)
% function varargout = bpm_psd_plot(varargin)
%
% Plot FFB data
% Christoph Steier, 2004-09-2


% Needed for standalone, if using MML functions that require the AO,AD setup or setting up LabCA
checkforao;


if ispc
    pathname = '\\Als-filer\physdata\matlab\srdata\orbitfeedback_fast\log\';
    %filename2 = '\\Als-filer\physdata\matlab\srdata\orbitfeedback_fast\log\SR09ctl.log';
    %ImageDir = '\\Als-filer\als2\www\htdoc\dynamic_pages\incoming\portmann\';
	ImageDir = '\\Als-filer\alswebdata\portmann\';   % The above path was writable until 2011-11-15 (GJP)
else
    pathname = '/home/als/physdata/matlab/srdata/orbitfeedback_fast/log/';
    %filename2 = '/home/als/physdata/matlab/srdata/orbitfeedback_fast/log/SR09ctl.log';
    ImageDir = '/home/als2/www/htdoc/dynamic_pages/incoming/portmann/';
end

%try
PauseBetweenUpdates = 5;
f1 = figure;
h1 = f1;
f2 = figure;
h2 = f2;

labelstr = 'ALS Libera BPM [3 5]';
dt = 64/1.5233e6;
[b,a]=butter(2,0.01);

bpmx=zeros(3*50000,1);
bpmx=zeros(3*50000,1);

while 1

    for loop = 1:3
        tic;
        data = getlibera('DD1',[3 5],0);
        fprintf('%d.   Delta_t = %.2f\n',loop,toc);
        bpmx((1+(loop-1)*50000):loop*50000)=data.DD_X_MONITOR(1:end)/1e6*sqrt(13.65/4);
        bpmy((1+(loop-1)*50000):loop*50000)=data.DD_Y_MONITOR(1:end)/1e6*sqrt(4/22);
    end
    
    [Pdd, f, Drms, Pdd_int, h] = ibpm_psd(filter(b,a,bpmx-mean(bpmx))+mean(bpmx), dt, 'b', h1);
%    set(h(7), 'String', [labelstr '      ' datestr(now)]);
    drawnow;
    
    
    [Pdd, f, Drms, Pdd_int, h] = ibpm_psd(filter(b,a,bpmy-mean(bpmy))+mean(bpmy), dt, 'r', h2);
%    set(h(7), 'String', [labelstr '      ' datestr(now)]);
    drawnow;
    
    % Pause for a bit
    fprintf('   Pausing %.1f seconds ... ', PauseBetweenUpdates);
    pause(PauseBetweenUpdates);
    fprintf('   Done\n');
    
    
end

% catch
%    disp('Exiting ...');
%    return
% end


function [Pdd, f, Drms, Pdd_int, h] = ibpm_psd(data, T, LineColor, h)
%BPM_PSD - Computes the power spectral density of orbit data
%  [Pdd, f, Drms, Pdd_int] = bpm_psd(Data, LineColor)
%
%  INPUTS
%  1. Data - 1.111 kHz data
%  2. LineColor - {Default: 'b'}
%     If input 2 exists or no output exists, then data will be plotted to the screen
%
%  OUTPUTS
%  1. Pdd     - Displacement power spectrum  [(m)^2/Hz]
%  2. f       - Frequency vector [Hz]
%  3. Drms    - RMS deplacement [m]
%  4. Pdd_int - Integrated RMS deplacement squared [m^2]
%
%  NOTES
%  1. If the hanning function exists, then a hanning window will be used
%
%  Written by Greg Portmann

if nargin==0 
    error('This function requires one input arguement (FileName).')
elseif nargin==1
    LineColor = 'b';
end

if nargout == 0
    PlotFlag = 1;
else
    PlotFlag = 0;
end
if nargin <= 2
    T = 1/1111;
end
if nargin >= 3
    PlotFlag = 1;
end

N = length(data);
if rem(N,2) ~= 0
    N = N - 1;
    data = data(1:end-1);
end
deltaX = T;   % seconds


T  = deltaX*N;
T1 = deltaX;
f0 = 1/(N*T1);
f  = f0*(0:N/2)';

iNaN = find(isnan(data));
if length(iNaN) > 0
    fprintf('   WARNING: %d NaN replaced with 0\n', length(iNaN));
    data(iNaN) = 0;
end

a  = data / 1000;  % meters  
%a = a-mean(a);
%a = detrend(a);
Drms_data = sqrt(sum((a-mean(a)).^2)/length((a-mean(a))));


% POWER SPECTRUM
if exist('hanning','file')
    w = hanning(N);    % hanning window
else
    w = ones(N,1);     % no window
end
w = w(:);
a = a(:);
a_w = a .* w;
A = fft(a_w);
Pdd = A.*conj(A)/N;

%Pdd = zeros(1,N/2+1);
%Drms = 0;
%Pdd_int = cumsum(Pdd);
%return;


U = sum(w.^2)/N;              % approximately .375 for hanning
U2 = ((norm(w)/sum(w))^2);    % used to normalize plots (p. 1-68, matlab DSP toolbox)
Pdd=Pdd/U;
Pdd(N/2+2:N) = [];
Pdd(2:N/2+1)=2*Pdd(2:N/2+1);


% PSD using matlab functions (NOTE: matlab function detrend by default)
%PddS = spectrum(a,N,0,w,f0); PddS = 2*PddS(:,1); PddS(1)=PddS(1)/2;
%PddPSD=2*psd(a,N); PddPSD(1)=PddPSD(1)/2;


% Paa(0) is the DC term, and the first few data points are questionable in an FFT
Pdd(1) = 0;   % not sure if the DC term is correct
Pdd1 = Pdd;
m = 2;
for i=1:m
    Pdd1(i) = 0;
end

% Parseval's Thm
Drms  = sqrt(sum(Pdd1)/N);
Pdd_int = cumsum(Pdd1)/N;

% Make PSD units meters^2/Hz
Pdd = T1*Pdd;


if PlotFlag
    % Output
    %fprintf('\nRMS Displacement: %g meters   (Time series data, %d points, mean removed)\n', Drms_data, N);
    %fprintf('RMS Displacement: %g meters   (PSD, Parseval''s Thm, first %d frequencies removed)\n', Drms, m);
    
    % Plot the power spectrum
    if isempty(h) || length(h)==1      
        if isempty(h)
            figure;
        else
            figure(h);
            clf reset
        end
        
        subplot(3,1,1);
        h(1) = loglog(f(m+1:N/2),1e12*Pdd(m+1:N/2),LineColor); 
        grid on;
        h(2) = title(['BPM POWER SPECTRUM (',num2str(N), ' points)']);
        xlabel('Frequency [Hz]');
        ylabel('PSD [\mum^2/Hz]');
        legend off;
        axis([1 500 1e-6 10]);
        % aa=axis;
        % axis([1 f(N/2) aa(3) aa(4)]);
        
        % Position spectrum
        subplot(3,1,2);
        h(3) = semilogx(f(m:N/2),1e12*Pdd_int(m:N/2), LineColor); 
        grid on;
        %semilogx(f(m:N/2),sqrt(Pdd_int(m:N/2)), LineColor); grid on;
        h(4) = title(['BPM INTEGRATED DISPLACEMENT POWER SPECTRUM (RMS=',num2str(1e6*Drms),' \mum)']);
        xlabel('Frequency [Hz]');
        ylabel('Mean Square Displacement [\mum^2]');
        legend off;
        xaxis([1 500]);
        % aa=axis;
        % axis([1 f(N/2) aa(3) aa(4)]);
        
        subplot(3,1,3);
        h(5) = plot(0:deltaX:deltaX*(N-1),1e6*detrend(a),LineColor); 
        grid on;
        h(6) = title(['BPM DATA (mean removed) (RMS=',num2str(1e6*Drms_data),' \mum)']);
        xlabel('Time [seconds]');
        ylabel('Displacement [\mum]');
        xaxis([0 deltaX*(N-1)]);
        legend off;
        
        h(7) = addlabel(datestr(now));
        set(h(7), 'Interpreter','None');
        
        orient tall
        
    else
        set(h(1), 'XData', f(m+1:N/2), 'YData', 1e12*Pdd(m+1:N/2));
        set(h(2), 'String', ['BPM POWER SPECTRUM (',num2str(N), ' points)']);

        set(h(3), 'XData', f(m:N/2), 'YData', 1e12*Pdd_int(m:N/2));
        set(h(4), 'String', ['BPM INTEGRATED DISPLACEMENT POWER SPECTRUM (RMS=',num2str(1e6*Drms),' \mum)']);

        set(h(5), 'XData', 0:deltaX:deltaX*(N-1), 'YData', 1e6*detrend(a));
        set(h(6), 'String', ['BPM DATA (mean removed) (RMS=',num2str(1e6*Drms_data),' \mum)']);
        
        set(h(7), 'String', datestr(now));
    end
end



function cellOut = split(string, delimiter)
%SPLIT rip string apart using strtok
i = 1;
[cellOut{i}, string] = strtok(string, delimiter);
while ~isempty(string)
    i = i + 1;
    [cellOut{i}, string] = strtok(string, delimiter);
end


