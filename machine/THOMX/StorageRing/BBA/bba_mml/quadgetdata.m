function [X, Y, BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily, DateMatX, DateMatY QUADxDevList QUADyDevList] = quadgetdata(DirName, PlotFlag)
%QUADGETDATA - Collect the date from a quadrupole center run.
%              When all the quadrupole center data files are stored in a directory this function
%              will go through all the files and pull out some of the important information.
%
%  [X, Y, BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily, XfileDate, YfilesDate] = quadgetdata(DirName)
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
%             1&2     3       4        5     6       7         8         9
%  Output = [BPMDev Center CenterSTD BPMpos DCCT BPMATIndex Quadpos QuadATIndex]
%
%  3-6. BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily - Family name for each center measurement
%  7-8. XfileDate, YfilesDate - Date string for the file name
%  9-10 QUADxDevList, QUADyDevList - device list of quad
%
%  See Also quadplotall

%
%%  Written by Greg Portmann


if nargin == 0
    DirName = '';
end

if nargin < 2
    PlotFlag = 1;
end

if isempty(DirName)
    DirName = [getfamilydata('Directory', 'DataRoot'),'QMS\'];
    DirName = uigetdir(DirName, 'Select directory where the QMS data are located');
    if ~ischar(DirName)
        fprintf('Cancel \n');
        return;
    end
end

StartDir = pwd;
cd(DirName);

Files = dir;

X = [];
Y = [];
BPMxFamily = [];
QUADxFamily = [];
BPMyFamily = [];
QUADyFamily = [];
QUADxDevList = [];
QUADyDevList = [];
DateMatX = [];
DateMatY = [];
GoodIndexX = [];
CorrDeltaX = [];
QuadDeltaX = [];
GoodIndexY = [];
CorrDeltaY = [];
QuadDeltaY = [];
OutlierFactorX = [];
OutlierFactorY = [];
MaxCorrOrbitVariationX = [];
MaxQuadOrbitVariationX = [];
MaxCorrOrbitVariationY = [];
MaxQuadOrbitVariationY = [];
MaxTuneY = [];
MaxTuneX = [];
MaxHysteresisY = [];
MaxHysteresisX = [];

% do not forget sorting part !!!


for i = 1:length(Files)
    if exist(Files(i).name) == 2
        clear QMS DelHCM DelVCM
        try
            load(Files(i).name)

            %Files(i).name

            % Old middle layer
            if exist('DelHCM', 'var')
                clear q
                [q.Center, q.CenterSTD, ErrorString] = quadhplt(Files(i).name);
                q.BPMFamily = 'BPMx';
                q.BPMDev = BPMnum + [0 1];
                q.DCCT = NaN;
                [q.QuadFamily, q.QuadDev] = bpm2quad(q.BPMFamily, q.BPMDev);

                X = [X; q.BPMDev q.Center q.CenterSTD getspos(q.BPMFamily, q.BPMDev) min(q.DCCT) family2atindex(q.BPMFamily, q.BPMDev) getspos(q.QuadFamily, q.QuadDev) family2atindex(q.QuadFamily, q.QuadDev)];
                BPMxFamily = strvcat(BPMxFamily, q.BPMFamily);
                QUADxFamily = strvcat(QUADxFamily, q.QuadFamily);
                DateMatX = [DateMatX; Files(i).date];
                
            elseif exist('DelVCM', 'var')
                clear q
                [q.Center, q.CenterSTD, ErrorString] = quadvplt(Files(i).name);
                q.BPMFamily = 'BPMy';
                q.BPMDev = BPMnum + [0 1];
                q.DCCT = NaN;
                [q.QuadFamily, q.QuadDev] = bpm2quad(q.BPMFamily, q.BPMDev);

                Y = [Y; q.BPMDev q.Center q.CenterSTD getspos(q.BPMFamily, q.BPMDev) min(q.DCCT) family2atindex(q.BPMFamily, q.BPMDev) getspos(q.QuadFamily, q.QuadDev) family2atindex(q.QuadFamily, q.QuadDev)];
                BPMyFamily = strvcat(BPMyFamily, q.BPMFamily);
                QUADyFamily = strvcat(QUADyFamily, q.QuadFamily);
                DateMatY = [DateMatY; Files(i).date];

            else

                % New middle layer
                q = QMS;

                %fprintf('   %d.  %s(%d,%d)\n', i, q.QuadFamily, q.QuadDev);

                if q.QuadPlane == 1 % H-plane
                    X = [X; q.BPMDev q.Center q.CenterSTD getspos(q.BPMFamily, q.BPMDev) min(q.DCCT) family2atindex(q.BPMFamily, q.BPMDev) getspos(q.QuadFamily, q.QuadDev) family2atindex(q.QuadFamily, q.QuadDev)];
                    BPMxFamily = strvcat(BPMxFamily, q.BPMFamily);
                    QUADxFamily = strvcat(QUADxFamily, q.QuadFamily);
                    QUADxDevList = [QUADxDevList; q.QuadDev];
                    DateMatX = [DateMatX; Files(i).date];
                    GoodIndexX = [ GoodIndexX; size(q.GoodIndex,1)];
                    CorrDeltaX = [ CorrDeltaX; q.CorrDelta];
                    QuadDeltaX = [ QuadDeltaX; q.QuadDelta];
                    OutlierFactorX = [OutlierFactorX; q.OutlierFactor];
                    [BPMelem1, iNotFound] = findrowindex(q.BPMDev, q.BPMDevList);
                    MaxCorrOrbitVariationX = [MaxCorrOrbitVariationX; max((q.x2(BPMelem1,:)+q.x1(BPMelem1,:))/2) - min((q.x2(BPMelem1,:)+q.x1(BPMelem1,:))/2)];
                    MaxQuadOrbitVariationX = [MaxQuadOrbitVariationX; max(max(q.x2-q.x1, [], 2))-min(max(q.x2-q.x1, [], 2))];
                    MaxTuneX = [MaxTuneX; max(abs(q.Tune1 - q.Tune2), [], 2)'];
                    
                    
                else % V-plane
                    Y = [Y; q.BPMDev q.Center q.CenterSTD getspos(q.BPMFamily, q.BPMDev) min(q.DCCT) family2atindex(q.BPMFamily, q.BPMDev) getspos(q.QuadFamily, q.QuadDev) family2atindex(q.QuadFamily, q.QuadDev)];
                    BPMyFamily = strvcat(BPMyFamily, q.BPMFamily);
                    QUADyFamily = strvcat(QUADyFamily, q.QuadFamily);
                    QUADyDevList = [QUADyDevList; q.QuadDev];
                    DateMatY = [DateMatY; Files(i).date];
                    GoodIndexY = [ GoodIndexY; size(q.GoodIndex,1)];
                    CorrDeltaY = [ CorrDeltaY; q.CorrDelta];
                    QuadDeltaY = [ QuadDeltaY; q.QuadDelta];
                    OutlierFactorY= [OutlierFactorY; q.OutlierFactor];
                    [BPMelem1, iNotFound] = findrowindex(q.BPMDev, q.BPMDevList);
                    MaxCorrOrbitVariationY = [MaxCorrOrbitVariationY; max((q.y2(BPMelem1,:)+q.y1(BPMelem1,:))/2) - min((q.y2(BPMelem1,:)+q.y1(BPMelem1,:))/2)];
                    MaxQuadOrbitVariationY = [MaxQuadOrbitVariationY; max(max(q.y2-q.y1, [], 2))-min(max(q.y2-q.y1, [], 2))];
                    MaxTuneY = [MaxTuneY; max(abs(q.Tune1 - q.Tune2), [], 2)'];
                end
                if any(q.DCCT<5)
                    fprintf('   %s(%d,%d) (%s) shows a beam less than 5 mamps during the experiment!\n', q.BPMFamily, q.BPMDev, Files(i).name);
                end
            end
        catch
            % not a bba file
        end
    end
end

[DateMatX, iX] = sortrows(DateMatX);
[DateMatY, iY] = sortrows(DateMatY);
X = X(iX,:);
Y = Y(iY,:);
BPMxFamily = BPMxFamily(iX,:);
BPMyFamily = BPMyFamily(iY,:);
QUADxFamily = QUADxFamily(iX,:);
QUADyFamily = QUADyFamily(iY,:);
QUADxDevList = QUADxDevList(iX,:);
QUADyDevList = QUADyDevList(iY,:);

DateMatX = DateMatX(iX,:);
DateMatY = DateMatY(iY,:);
GoodIndexX = GoodIndexX(iX,:);
CorrDeltaX = CorrDeltaX(iX,:);
QuadDeltaX = QuadDeltaX(iX,:);
GoodIndexY = GoodIndexY(iY,:);
CorrDeltaY = CorrDeltaY(iY,:);
QuadDeltaY = QuadDeltaY(iY,:);
OutlierFactorX = OutlierFactorX(iX,:);
OutlierFactorY = OutlierFactorY(iY,:);
MaxCorrOrbitVariationX = MaxCorrOrbitVariationX(iX,:);
MaxQuadOrbitVariationX = MaxQuadOrbitVariationX(iX,:);
MaxCorrOrbitVariationY = MaxCorrOrbitVariationY(iY,:);
MaxQuadOrbitVariationY = MaxQuadOrbitVariationY(iY,:);
MaxTuneY = MaxTuneY(iY,:);
MaxTuneX = MaxTuneX(iX,:);
% MaxHysteresisY = MaxHysteresisY(iY,:);
% MaxHysteresisX = MaxHysteresisX(iX,:);



cd(StartDir);


valGoodX = 30;
SelectIdx = find(GoodIndexX<valGoodX);

fprintf('%3d BPMx with less than %d good BPMs\n', length(SelectIdx), valGoodX);
for k =1:length(SelectIdx),
    fprintf('%3s(%2d,%2d): %3d (Center = %+.4f +/- %.4f OutlierFactor=%2d, Dquad= %.3f Dorb=%+.3f Dcorr = %+.3f Dorb =%+.3f |Dnux| = %+.4f |Dnuy| = %+.4f)\n', ...
        QUADxFamily(SelectIdx(k),:), ...
        QUADxDevList(SelectIdx(k),:), GoodIndexX(SelectIdx(k)), ...
        X(SelectIdx(k),3), X(SelectIdx(k),4), OutlierFactorX(SelectIdx(k)), ...
        QuadDeltaX(SelectIdx(k)), MaxQuadOrbitVariationX(SelectIdx(k)), ...,
        CorrDeltaX(SelectIdx(k)), MaxCorrOrbitVariationX(SelectIdx(k)), ...
        MaxTuneX(SelectIdx(k),:));
end

% BIZARRE 2 April 2011
%valGoodX = 3e-3;
SelectIdx = find(X(:,4)>valGoodX);

fprintf('%3d BPMx offsets determined within more than %d mm\n', length(SelectIdx), valGoodX);
for k =1:length(SelectIdx),
    fprintf('%3s(%2d,%2d): %3d (Center = %+.4f +/- %.4f OutlierFactor=%2d, Dquad= %.3f Dorb=%+.3f Dcorr = %.3f Dorb =%+.3f |Dnux| = %+.4f |Dnuy| = %+.4f)\n', ...
        QUADxFamily(SelectIdx(k),:), ...
        QUADxDevList(SelectIdx(k),:), GoodIndexX(SelectIdx(k)), ...
        X(SelectIdx(k),3), X(SelectIdx(k),4), OutlierFactorX(SelectIdx(k)), ...
        QuadDeltaX(SelectIdx(k)), MaxQuadOrbitVariationX(SelectIdx(k)), ...,
        CorrDeltaX(SelectIdx(k)), MaxCorrOrbitVariationX(SelectIdx(k)), ...
        MaxTuneX(SelectIdx(k),:));
end



valGoodY = 30;
SelectIdx = find(GoodIndexY<valGoodY);


fprintf('%3d BPMy with less than %d good BPMs\n', length(SelectIdx), valGoodY);
for k =1:length(SelectIdx),
    fprintf('%3s(%2d,%2d): %3d (Center = %+.4f +/- %.4f OutlierFactor=%2d, Dquad= %.3f Dorb=%+.3f Dcorr = %.3f Dorb =%+.3f |Dnux| = %+.4f |Dnuy| = %+.4f)\n', ...
        QUADyFamily(SelectIdx(k),:), QUADyDevList(SelectIdx(k),:), GoodIndexY(SelectIdx(k)), ...
        Y(SelectIdx(k),3), Y(SelectIdx(k),4), OutlierFactorY(SelectIdx(k)), ...
        QuadDeltaY(SelectIdx(k)), MaxQuadOrbitVariationY(SelectIdx(k)), ...
        CorrDeltaY(SelectIdx(k)), MaxCorrOrbitVariationY(SelectIdx(k)), ...
        MaxTuneY(SelectIdx(k),:));
end

valGoodY = 3e-3;
SelectIdx = find(Y(:,4)>valGoodY);

fprintf('%3d BPMy offset determined within more than %d mm\n', length(SelectIdx), valGoodY);

for k =1:length(SelectIdx),
    fprintf('%3s(%2d,%2d): %3d (Center = %+.4f +/- %.4f OutlierFactor=%2d, Dquad= %.3f Dorb=%+.3f Dcorr = %.3f Dorb =%+.3f |Dnux| = %+.4f |Dnuy| = %+.4f)\n', ...
        QUADyFamily(SelectIdx(k),:), QUADyDevList(SelectIdx(k),:), GoodIndexY(SelectIdx(k)), ...
        Y(SelectIdx(k),3), Y(SelectIdx(k),4), OutlierFactorY(SelectIdx(k)), ...
        QuadDeltaY(SelectIdx(k)), MaxQuadOrbitVariationY(SelectIdx(k)), ...
        CorrDeltaY(SelectIdx(k)), MaxCorrOrbitVariationY(SelectIdx(k)), ...
        MaxTuneY(SelectIdx(k),:));
end

if PlotFlag

    % Plot data
    L = getfamilydata('Circumference');

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        errorbar(X(:,5), X(:,3), X(:,4), '.b');
    end
    ylabel('Horizontal [mm]');
    xaxis([0 L]);
    title('BPM Offset');

    subplot(2,1,2);
    if ~isempty(Y)
        errorbar(Y(:,5), Y(:,3), Y(:,4), '.b');
    end
    xlabel('BPM Position [meters]');
    ylabel('Vertical [mm]');
    xaxis([0 L]);

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(X(:,5), GoodIndexX,'.');
    end
    ylabel('Horizontal Good Index');
    xaxis([0 L]);
    title('Good index');

    subplot(2,1,2);
    if ~isempty(Y)
        plot(Y(:,5), GoodIndexY,'.');
    end
    xlabel('BPM Position [meters]');
    ylabel('Vertical Good Index');
    xaxis([0 L]);

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(X(:,5), CorrDeltaX,'.');
    end
    ylabel('Horizontal corrector current (A)');
    xaxis([0 L]);
    title('Corrector strength');

    subplot(2,1,2);
    if ~isempty(Y)
        plot(Y(:,5), CorrDeltaY,'.');
    end
    xlabel('BPM Position [meters]');
    ylabel('Vertical corrector current (A)');
    xaxis([0 L]);

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(X(:,5), QuadDeltaX,'.');
    end
    ylabel('Horizontal corrector current (A)');
    xaxis([0 L]);
    title('Quadrupole strength');

    subplot(2,1,2);
    if ~isempty(Y)
        plot(Y(:,5), QuadDeltaY,'.');
    end
    xlabel('BPM Position [meters]');
    ylabel('Vertical corrector current (A)');
    xaxis([0 L]);

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(X(:,5), OutlierFactorX,'.');
    end
    ylabel('Horizontal OutlierFactor');
    xaxis([0 L]);
    title('OutlierFactor');

    subplot(2,1,2);
    if ~isempty(Y)
        plot(Y(:,5), OutlierFactorY,'.');
    end
    xlabel('BPM Position [meters]');
    ylabel('Vertical OutlierFactor');
    xaxis([0 L]);
    
    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(X(:,5), MaxTuneX,'.');
    end
    ylabel('H-BBA: tuneshifts');
    xaxis([0 L]);
    title('Tune shifts');
    legend('Dnux', 'Dnuz')
    
    subplot(2,1,2);
    if ~isempty(Y)
        plot(Y(:,5), MaxTuneY,'.');
    end
    xlabel('BPM Position [meters]');
    ylabel('V-BBA: tuneshifts');
    xaxis([0 L]);
    legend('Dnux', 'Dnuz')

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(X(:,5), MaxQuadOrbitVariationX,'.');
    end
    ylabel('H-BBA: X (mm)');
    xaxis([0 L]);
    title('Orbit shift due to quads');
    
    subplot(2,1,2);
    if ~isempty(Y)
        plot(Y(:,5), MaxQuadOrbitVariationY,'.');
    end
    xlabel('BPM Position [meters]');
    ylabel('V-BBA: : Z (mm)');
    xaxis([0 L]);

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        plot(X(:,5), MaxCorrOrbitVariationX,'.');
    end
    ylabel('H-BBA: X (mm)');
    xaxis([0 L]);
    title('Orbit shift due to correctors');
    
    subplot(2,1,2);
    if ~isempty(Y)
        plot(Y(:,5), MaxCorrOrbitVariationY,'.');
    end
    xlabel('BPM Position [meters]');
    ylabel('V-BBA: : Z (mm)');
    xaxis([0 L]);
end
