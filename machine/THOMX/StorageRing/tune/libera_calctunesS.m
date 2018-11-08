function [Tune, Tune_Vec] = libera_calctunesS(AM,InfoFlag)



if nargin < 2
    if nargout == 0
        InfoFlag = 1;
    else
        InfoFlag = 0;
    end
end

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
            Tune_Vec(1,1) = nux(n);
            break;
        end
    end
    
    for n=1:length(nuy)
        if (nuy(n) > 0.45) 
            Tune_Vec(2,1) = nuy(n);
            break;
        end
    end
    Tune = mean(Tune_Vec,2);

if InfoFlag
    fprintf('\n  Horizontal Tune = %f\n', 3+Tune(1));
    fprintf('    Vertical Tune =  %f\n\n', 1+Tune(2));
end
    
end

