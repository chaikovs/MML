function [Tau, I0, t, DCCT, chi2n] = measlifetime(varargin) 
%MEASLIFETIME - Measures the lifetime using an exponential or linear least squares fit to beam current
%  [Tau, I0, t, DCCT] = measlifetime(t, DCCT)
%  [Tau, I0, t, DCCT] = measlifetime(t)
%  [Tau, I0, t, DCCT] = measlifetime
%
%  INPUTS #1 - t is a vector or positive scalar
%  1. t    = a.  If vector, time [seconds] (vector input)
%            b.  If scalar and t > 0, length of time in seconds to measure current
%                Default sample period is .5 seconds.
%  2. DCCT = current vector [mAmps]
%            if the DCCT vector is empty then this function will
%            get the current using getdcct at the times defined in t
%  3. Method - 'Exponential' for exponential least square fit
%            - 'Linear' for linear least square fit 
%
%     or
%
%  [Tau, I0, t, DCCT] = measlifetime(DCCT_Drop, Tmax, Tmin, Nmin)
%
%  INPUTS #2 - "t" is negative
%  1. DCCT_Drop - If DCCT_Drop is scalar and DCCT_Drop <= 0, then the beam current will be
%                 monitored until the current is DCCT_Drop.  Default sample period is .5 seconds.
%                 Default:  Monitor the beam current until current drops 60 uA
%                           (At Spear sigma(DCCT) = 0.001 mA)
%  2. Tmax - Maximum time to measure DCCT {Default: inf}
%  3. Tmin - Minimum time to measure DCCT {Default: 0}
%  4. Nmin - Minimum number of unique data points when monitoring DCCT drop {Default: 6}
%  
%     The goal is to measure the current until a current drop of DCCT_Drop is achived.  However, the
%     time that takes will never goes above Tmax.  And if DCCT_Drop is achived then the measurement will
%     continue until Tmin or Nmin points is achieved (but not exceeding Tmax).
%
%
%  OUTPUTS
%  DCCTfit = I0 * exp(-t/Tau); Exponential
%  DCCTfit = I0 * (1-t/Tau);   Linear
%  1. Tau  - Computed lifetime   [hours]
%  2. I0   - Computed            [mAmps]
%  3. DCCT - Beam current vector [mAmps]
%  4. t    - Actual time         [Seconds]
%  5. chi2n - normalized chi2
%
%
%  NOTES
%  1. If no output exists, the beam current and fit will be plotted to the screen
%     as well as the residual of the DCCT.
%  2. DCCT is assumed to be in mAmps

%
%  Written by Gregory S. Portmann
%  Modified by Amor Nadji, May 2005
%  Adapted by Laurent S. Nadolski, 23/01/06
%  Added covariance calculation
%  Modif Alex : remove write

% Default method if not user given
MethodFlag = 'Exponential';
sigma = 0.2e-6; % Error in dcct measure in Amps for 7 read per second config

% Parser for method
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Linear')
        MethodFlag = 'Linear';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Exponential')
        MethodFlag = 'Exponential';
        varargin(i) = [];
    end
end

T_Seconds = .5;     % Default sample period [Seconds]
TmaxDefault = inf;  % Maximum time 
TminDefault = 0;    % Minimum time 
NminDefault = 6;    % Minimum number of data points


% Input parsing
Tmax = [];
if length(varargin) == 0
    MonitorFlag = 2;
    deltaDCCT = 60 * 0.001;
    Tmin = TminDefault;
    Tmax = TmaxDefault;
    Nmin = NminDefault;
    
elseif length(varargin) >= 1
    t = varargin{1};
    if all(size(t)==[1 1])
        if t > 0
            MonitorFlag = 1;
            t = 0:T_Seconds:t;
            Tmax = TmaxDefault;
        else
            MonitorFlag = 2;
            deltaDCCT = abs(t);
            if length(varargin) >= 2
                Tmax = DCCT;
            else
                Tmax = [];
            end
        end
        if length(varargin) < 3
            Tmin = [];
        end
        if length(varargin) < 4
            Nmin = [];
        end
        if isempty(Tmax)
            Tmax = TmaxDefault;
        end
        if isempty(Tmin)
            Tmin = TminDefault;
        end
        if isempty(Nmin)
            Nmin = NminDefault;
        end
    else
        % Time vector input
        if length(varargin) < 2
            MonitorFlag = 1;
        else
            MonitorFlag = 0;
        end
    end
end


if MonitorFlag == 1
    
    % Get DCCT data at a fix interval determined by the input vector t
    %disp(['   Monitoring beam current for ', num2str(t(length(t))), ' seconds.']);    
    t0 = gettime;
    for j = 1:length(t)
        T = t(j) - (gettime-t0);
        if T > 0
            pause(T);
        end
        tout(j,1) = gettime - t0;    
        DCCT(j,1) = getdcct;
    end
    
elseif MonitorFlag == 2
    
    % Monitor for a fixed DCCT drop
    %disp(['   Monitoring beam current until current drops by more than ', num2str(deltaDCCT), ' mA.']);    
    j = 1;
    n = 1;
    tout(n,1) = 0;
    DCCT(n,1) = getdcct;
    t0 = gettime;
    t0_Display = 0;
    while ((abs(DCCT(end,1)-DCCT(1,1)) < deltaDCCT) & (DCCT(end,1) > 0.1)) | ...
            n < Nmin | (gettime-t0) < Tmin
        j = j+1;
        T = (j-1)*T_Seconds - (gettime-t0);
        if T > 0
            pause(T);
        end
        DCCTnew = getdcct;
        if DCCTnew ~= DCCT(n)
            n = n + 1;
            tout(n,1) = gettime - t0;
            DCCT(n,1) = DCCTnew;
        end
        if gettime-t0 > Tmax
            break;
        end
        if gettime-t0_Display > 10    
            fprintf('   Monitoring DCCT for lifetime measurement (%s)\n', ...
                datestr(clock,0));
            t0_Display = gettime;
        end
    end
    t = tout;
end

% Column vectors
DCCT = DCCT(:);
t = t(:);


% Lookfor identical data in DCCT.  Some machine don't update at T_Sample and
% having the same reading twice is probably not so good for the LS fit.
iExtra = find(diff(DCCT)==0);
DCCT(iExtra) = [];
t(iExtra) = [];

if length(DCCT) < 2
    Tau = NaN;
    I0 = NaN;
    fprintf('   Only 1 unique DCCT reading, hence Tau is set to NaN.\n');
    %error('There must be at least 2 unique point to fit a lifetime.');
    return
end
    
    
% LS fit
if strcmpi(MethodFlag,'Exponential')
    y = log(DCCT);
else
    y = DCCT;
end

X = [ones(size(t)) t];

% Linear Least square fit
invXX = inv(X'*X);
B = invXX*X'*y  ;   

if strcmpi(MethodFlag,'Exponential')
    % yfit = exp(B(1))*exp(B(2)*tfit);
    I0 = exp(B(1));
    Tau = -1/B(2)/3600;    % In hours
    yfit = exp(B(1))*exp(B(2)*t);
    stitle = 'Least Squares Fit : I0*exp(-t/tau)';
else
    % yfit = B(1) + B(2)*tfit;
    I0 = B(1) ;
    Tau = -B(1)/B(2)/60/60;    % In hours
    yfit = B(1) + B(2)*t;
    stitle = 'Least Squares Fit : I0*(1 - t/tau)';
end

%% Erreur
%chi2 = 1/(sigma*sigma)*sum(power(DCCT - yfit,2));
chi2 = 1/(sigma*sigma)*sum(power(y - B(1)-B(2)*t,2));
% Normalized chi2
chi2n = chi2/(length(t)-length(B));
% Covariance matrix
Mcovariance = chi2n*invXX;

if strcmpi(MethodFlag,'Exponential')
    dtau = sqrt(Mcovariance(2,2)/B(2)/B(2))/3600;
else
    dtau = sqrt(Mcovariance(1,1)/B(2)/B(2) + ...
        power(B(1)/B(2)/B(2),2)*Mcovariance(2,2) - ...
        2*B(1)/power(B(2),3)*Mcovariance(2,1));
end

% if isnan(Tau) || chi2n > 5
%     fprintf('   Life time measurement is inaccurate!\n');
% end

if nargout == 0    
        
    clf reset
    subplot(2,1,1)
    plot(t,DCCT,'o-b', t,yfit,'--r'); hold on;
    % errorbar(t,DCCT,sigma*ones(size(DCCT)),'.b'); hold off
    title(sprintf('Beam Current vs Time: Lifetime= %2.2f +/- %2.2f (h) with chi2n = %2.2g', Tau, dtau, chi2n))
%    title(sprintf('Beam Current vs Time: Lifetime= %2.2f (h) with chi2n = %2.2g', Tau, chi2n))
    xlabel('Time [seconds]'); 
    ylabel('Beam Current [mA]');
    legend('Measured Beam Current',stitle,0);
    grid on;
    xlim([t(1) t(end)]);

    subplot(2,1,2)
    plot(t,DCCT-yfit);
    title(['Residual Error (RMS = ' num2str(std(DCCT-yfit),'%.2g') ' mA)']);
    xlabel('Time [seconds]'); 
    ylabel('Lifetime Corrected Beam Current Variation');
    grid on;
    
    addlabel(1,0, datestr(clock,0));
end
