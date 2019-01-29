function [Xnew, Ynew, BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily, DateMatX, DateMatY] = quadplotall(DirName, PlotFlag)
%QUADPLOTALL - Collect the date from a quadrupole center run.
%              When all the quadrupole center data files are stored in a directory this function
%              will go through all the files and pull out and plot some of the important information.
%              Note: if more than one quadrupole center file for the same quadrupole is in the directory
%                    then only the latter file will be returned.  Use quadgetdata to get all the data.
%
%  [X, Y, BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily, XfileDate, YfilesDate] = quadplotall(DirName, PlotFlag)
%
%  INPUTS
%  1. DirName - Directory name to look for quadrupole center files
%               [] to browse {Default}
%  2. PlotFlag - 0 to just get data without plotting results, else, plot results
%
%  OUTPUTS
%  1. X - Horizontal output matrix (format below)
%  2. Y - Vertical output matrix (format below)
%
%             1&2     3       4        5     6       7         8         9      10       11      12       13
%  Output = [BPMDev Center CenterSTD BPMpos DCCT BPMATIndex Quadpos QuadATIndex BPMBeta BPMPhi QuadBeta QuadPhi]
%
%  3-6. BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily - Family name for each center measurement
%  7-8. XfileDate, YfilesDate - Date string for the file name

%
%  Written by Greg Portmann
%  Modified by Laurent S. Nadolski


if nargin == 0
    DirName = '';
end

if nargin < 2
    PlotFlag = 1;
end


[X, Y, BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily, DateMatX, DateMatY] = quadgetdata(DirName, PlotFlag);


if ~isempty(X)
    dx = family2dev('BPMx',0);
    Xnew = NaN * ones(size(dx,1),size(X,2));
    Xnew(:,1:2) = dx;
    i = findrowindex(X(:,1:2), dx);
    Xnew(i,:) = X;
end

if ~isempty(Y)
    dy = family2dev('BPMz',0);
    Ynew = NaN * ones(size(dy,1),size(Y,2));
    Ynew(:,1:2) = dy;
    j = findrowindex(Y(:,1:2), dy);
    Ynew(j,:) = Y;
end

% Add to quadgetdata output


% Get the average Beta and Phi at all AT indicies
[BetaX, BetaY] = modeltwiss('Beta');
BetaX = [(BetaX(1:end-1)+BetaX(2:end))/2; BetaX(end)];
BetaY = [(BetaY(1:end-1)+BetaY(2:end))/2; BetaY(end)];

[PhiX,  PhiY]  = modeltwiss('Phase');
PhiX = [(PhiX(1:end-1)+PhiX(2:end))/2; PhiX(end)];
PhiY = [(PhiY(1:end-1)+PhiY(2:end))/2; PhiY(end)];

if ~isempty(X)
    i = findrowindex(X(:,1:2), dx);
    Xnew = [Xnew NaN*ones(size(Xnew,1),4)];
    Xnew(i,end-3:end) = [BetaX(Xnew(i,7)) PhiX(Xnew(i,7)) BetaX(Xnew(i,9)) PhiX(Xnew(i,9))];
end

if ~isempty(Y)
    j = findrowindex(Y(:,1:2), dy);
    Ynew = [Ynew NaN*ones(size(Ynew,1),4)];
    Ynew(j,end-3:end) = [BetaY(Ynew(j,7)) PhiY(Ynew(j,7)) BetaY(Ynew(j,9)) PhiY(Ynew(j,9))];
end


if PlotFlag
    L = getfamilydata('Circumference');

    if ~isempty(X)
        XOffset = getoffset('BPMx', Xnew(:,1:2));
    end

    if ~isempty(Y)
        YOffset = getoffset('BPMy', Ynew(:,1:2));
    end

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(Xnew(:,5), Xnew(:,3)-XOffset, '.b'); hold on;
        plot([0 L], [50 50]*1e-3, 'g-')
        plot([0 L], -[50 50]*1e-3, 'g-')
        plot([0 L], [100 100]*1e-3, 'c-')
        plot([0 L], -[100 100]*1e-3, 'c-')
        plot([0 L], [200 200]*1e-3, 'r-')
        plot([0 L], -[200 200]*1e-3, 'r-')
    end
    ylabel('Horizontal [mm]');
    xaxis([0 L]);
    title('New BPM Offsets Relative to the Present Offset Orbit');
    
    subplot(2,1,2);
    if ~isempty(Y)
        plot(Ynew(:,5), Ynew(:,3)-YOffset, '.b'); hold on;
        plot([0 L], [50 50]*1e-3, 'g-')
        plot([0 L], -[50 50]*1e-3, 'g-')
        plot([0 L], [100 100]*1e-3, 'c-')
        plot([0 L], -[100 100]*1e-3, 'c-')
        plot([0 L], [200 200]*1e-3, 'r-')
        plot([0 L], -[200 200]*1e-3, 'r-')
    end
    xlabel('BPM Position [meters]');
    ylabel('Vertical [mm]');
    xaxis([0 L]);


    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(Xnew(:,5),360*(Xnew(:,11)-Xnew(:,13))/2/pi,'.r');
    end
    xaxis([0 L]);
    ylabel('Horizontal [degrees]');
    title('Phase Advance Between the BPM and Quadrupole');

    subplot(2,1,2);
    if ~isempty(Y)
        plot(Ynew(:,5),360*(Ynew(:,11)-Ynew(:,13))/2/pi,'.r');
    end
    xaxis([0 L]);
    xlabel('BPM Position [meters]');
    ylabel('Vertical [degrees]');


    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(Xnew(:,5),Xnew(:,10),'.b', Xnew(:,8),Xnew(:,12),'.r');
    end
    xaxis([0 L]);
    ylabel('Horizontal [meters]');
    legend('BPM', 'Quadrupole');
    title('Beta Function at the BPM and Quadrupole');

    subplot(2,1,2);
    if ~isempty(Y)
        plot(Ynew(:,5),Ynew(:,10),'.b', Ynew(:,8),Ynew(:,12),'.r');
    end
    xaxis([0 L]);
    xlabel('Position [meters]');
    ylabel('Vertical [meters]');
    legend('BPM', 'Quadrupole');


    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(Xnew(:,5),Xnew(:,6),'.');
    end
    xaxis([0 L]);
    xlabel('Position [meters]');
    ylabel('DCCT [mamps]');
    title('Beam Current During the Horizontal Measurement');

    subplot(2,1,2);
    if ~isempty(Y)
        plot(Ynew(:,5),Ynew(:,6),'.');
    end
    xaxis([0 L]);
    xlabel('Position [meters]');
    ylabel('DCCT [mamps]');
    title('Beam Current During the Vertical Measurement');


    % Only return the measure centers
    if ~isempty(X)
        i = find(~isnan(Xnew(:,3)));
        Xnew = Xnew(i,:);
    end

    if ~isempty(Y)
        i = find(~isnan(Ynew(:,3)));
        Ynew = Ynew(i,:);
    end
end