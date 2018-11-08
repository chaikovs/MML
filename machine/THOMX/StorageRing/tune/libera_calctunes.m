function [Tune, Tune_Vec] = libera_calctunes(N,InfoFlag)


if nargin < 1
    N = 50;
end

if nargin < 2
    if nargout == 0
        InfoFlag = 1;
    else
        InfoFlag = 0;
    end
end

tic
%%

thomx_ring=ThomX_017_064_r56_02_chro00;
%%

Z0=[0.001 0.0 0.0001 0 0 0]';
Z1=[0.001 0 0.0001 0 0 0]';
Nturns = 1024;

[X1,lost_thomx]=ringpass(thomx_ring,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, X1, BPMindex);
BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
BPMy = reshape(X2(3,:), Nturns, length(BPMindex));

%% add noise

AM.Data.X = BPMx(:,1)+ 0.001*randn(size(BPMx(:,1))); 

AM.Data.Y = BPMy(:,1)+ 0.0001*randn(size(BPMy(:,1)));

for i = 1:N

    fx = 1e3*AM.Data.X;
    fy = 1e3*AM.Data.Y;
      
    %mfx = fx(21:400,1)-mean(fx(21:400,1));
    %mfy = fy(21:400,1)-mean(fy(21:400,1));
    
    mfx = fx-mean(fx);
    mfy = fy-mean(fy);

    fftx = abs(fft(mfx));
    ffty = abs(fft(mfy));
    
    figure(999);
    subplot(2,2,1);
    plot(fx(:,1));
    xlabel('turn #');
    ylabel('x [mm]');
    %xaxis([0 1024]);
    grid on;
    
    subplot(2,2,2);
    plot(fy(:,1));
    xlabel('turn #');
    ylabel('y [mm]');
    %xaxis([0 1024]);
    grid on;
    
    subplot(2,2,3);
    plot([1:length(fftx)]/length(fftx), fftx);
    xlabel('\nu_x');
    ylabel('fft(x)');
    %xaxis([0 0.5]);
    grid on;
    
    subplot(2,2,4);
    plot([1:length(ffty)]/length(ffty), ffty);
    xlabel('\nu_y');
    ylabel('fft(y)');
    %xaxis([0 0.5]);
    grid on;
    
    [nux] = calcnaff(mfx,zeros(length(mfx),1),1);
    [nuy] = calcnaff(mfy,zeros(length(mfy),1),1);
    
    nux = abs(nux)/(2*pi);
    nuy = abs(nuy)/(2*pi);
    
    Tune = [NaN;NaN];
    
    for n=1:length(nux)
        if nux(n) < 0.33
            Tune_Vec(1,i) = nux(n);
            break;
        end
    end
    
    for n=1:length(nuy)
        if (nuy(n) > 0.3) 
            Tune_Vec(2,i) = nuy(n);
            break;
        end
    end
    
    fprintf('   %d of %d acquisitions. Time %.1f\n', i, N, toc);
end

Tune = mean(Tune_Vec,2);

if InfoFlag
    fprintf('\n  Horizontal Tune = %f\n', 3+Tune(1));
    fprintf('    Vertical Tune =  %f\n\n', 1+Tune(2));
end