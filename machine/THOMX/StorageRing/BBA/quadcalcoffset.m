function [Offsetx Offsety] = quadcalcoffset(varargin)
% Compute final BBA offsets, especially for the 40 combined BPMs
%
%  INPUTS
%  Optional
%  1. 'Write', 'NoWrite' - Create file to be used for application onto Liberas
%  2. 'Display', 'NoDisplay' - plot computed final offset
%
%  See Also quadgetdat, quadplotAll


%
%  NOTES
%  1. Application
%     use /home/operateur/GrpDiagnostics/matlab/DserverBPM/Set_BBA_Offsets_planH.m and Set_BBA_Offsets_planV.m
%     use file tableBBAH.mat and tableBBAV
%     Set_BBA_Offsets_planH('ADD')
%     Set_BBA_Offsets_planV('ADD')
%

%
% Written by Laurent S. Nadolski

DebugFlag = 0;
DisplayFlag = 1;
WriteFlag = 0; % write results for applying to TANGO

for i = length(varargin):-1:1
    if ~isempty(varargin)
        if strcmpi(varargin{i}, 'Display')
            DisplayFlag = 1;
            varargin(i) = [];
        elseif strcmpi(varargin{i}, 'NoDisplay')
            DisplayFlag = 0;
            varargin(i) = [];
        elseif strcmpi(varargin{i}, 'Write')
            WriteFlag = 1;
            varargin(i) = [];
        elseif strcmpi(varargin{i}, 'NoWrite')
            WriteFlag = 0;
            varargin(i) = [];
        end
    end
end

Offsetx = [];
Offsety = [];

% List of BPM whose offset is determined by 2 quadrupoles
doubleBPMListQP4QP41 =[
    1     2    
    ];




doubleBPMList = [doubleBPMListQP4QP41];

% get data from BBA
[X, Y, BPMxFamily, QUADxFamily, BPMyFamily, QUADyFamily, DateMatX, DateMatY, QUADxDevList, QUADyDevList] = quadgetdata([], 0);


DIR0 = pwd;
cd(getfamilydata('Directory', 'BBAcurrent'));

% Maker saying if offset has been calculated
% -1 if not enough data
% -2 if too many files
%  1 if offset computed
if ~isempty(X)
    isDonex=zeros(size(X(:,1)));
end
if ~isempty(Y)

    isDoney=zeros(size(Y(:,1)));
end

if ~isempty(X)
    % look for double BPM in measdata in H-plane
    for k=1:size(X(:,1))
        %isdoubleBPM
        if isDonex(k) == 0 % offset to be determined
            if ~isempty(findrowindex(X(k,1:2), doubleBPMList))
                if DebugFlag
                    fprintf('BPMx(%d,%d) offset determined by 2 quadrupoles\n', X(k,1), X(k,2));
                end
                % look for the 2 set of data on meas data
                Idx = find(X(:,1) == X(k,1) & X(:,2) == X(k,2));
                NbOfData = length(Idx);
                if NbOfData < 2
                    fprintf('BPMx(%d,%d) only %d data %s(%d,%d): missing data\n', ...
                        X(k,1), X(k,2), NbOfData, QUADxFamily(k,:), QUADxDevList(k,:));
                    isDonex(k) = -1;
                elseif NbOfData > 2
                    fprintf('BPMx(%d,%d)  %d : too many data\n', X(k,1), X(k,2), NbOfData);
                    for ik=1:NbOfData,
                        fprintf('%s(%d,%d)\n', QUADxFamily(Idx(ik),:), QUADxDevList(Idx(ik),:));
                        str = sprintf(' bba%d%s%dh* ', QUADxDevList(Idx(ik),1), deblank(QUADxFamily(Idx(ik),:)), QUADxDevList(Idx(1),2));
                        system(['ls -C1 ' str]);

                    end
                    fprintf('\n')
                    isDonex(Idx) = -2;
                else % check data are well from 2 different quadrupoles
                    if diff(X(Idx,8)) == 0
                        fprintf('BPMx(%d,%d) not properly determined : same quad %s(%d,%d)\n', X(k,1), X(k,2), QuadxFamily(Idx), X(k,10:11));
                    else %Compute combined offset
                        Offsetx = [Offsetx; X(Idx(1),:)];
                        [tmpOffset tmpSigma]= getCombinedOffset(X(Idx,:), QUADxFamily(Idx,:), QUADxDevList(Idx,:), 1);
                        Offsetx(end, 3) = tmpOffset;
                        Offsetx(end, 4) = tmpSigma;
                        Offsetx(end, 6) = mean(X(Idx,6)); % Mean current
                        Offsetx(end, 8) = NaN;
                        Offsetx(end, 9) = NaN;
                        isDonex(Idx) = 1;
                    end
                end
            else % single BPM-quad offset
                % Check for too many data
                Idx = find(X(:,1) == X(k,1) & X(:,2) == X(k,2));
                NbOfData = length(Idx);
                if NbOfData > 1
                    fprintf('BPMx(%d,%d)  too many data (%d)\n', X(k,1), X(k,2), NbOfData);
                    str = sprintf(' bba%d%s%dh* ', QUADxDevList(Idx(1),1), deblank(QUADxFamily(Idx(1),:)), QUADxDevList(Idx(1),2));
                    system(['ls -C1 ' str]);
                    isDonex(Idx) = -2;
                else
                    isDonex(k) = 1; % do nothing since computation already done by quadgetdata
                    Offsetx = [Offsetx; X(k,:)];
                end
            end
        end
    end
end

% look for double BPM in measdata in H-plane
if ~isempty(Y)
    for k=1:size(Y(:,1))
        %isdoubleBPM
        if isDoney(k) == 0 % offset already determined
            if ~isempty(findrowindex(Y(k,1:2), doubleBPMList))
                if DebugFlag
                    fprintf('BPMz(%d,%d) offset determined by 2 quadrupoles\n', Y(k,1), Y(k,2));
                end
                % look for the 2 set of data on meas data
                Idx = find(Y(:,1) == Y(k,1) & Y(:,2) == Y(k,2));
                NbOfData = length(Idx);
                if NbOfData < 2
                    fprintf('BPMz(%d,%d) only %d data %s(%d,%d): missing data\n', ...
                        Y(k,1), Y(k,2), NbOfData, QUADyFamily(k,:), QUADyDevList(k,:));
                    isDoney(k) = -1;
                elseif NbOfData > 2
                    fprintf('BPMz(%d,%d)  %d: too many data\n', Y(k,1), Y(k,2), NbOfData);
                    for ik=1:NbOfData,
                        fprintf('%s(%d,%d)\n', QUADyFamily(Idx(ik),:), QUADyDevList(Idx(ik),:));
                        str = sprintf(' bba%d%s%dv* ', QUADyDevList(Idx(ik),1), deblank(QUADyFamily(Idx(ik),:)), QUADyDevList(Idx(1),2));
                        system(['ls -C1 ' str]);
                    end
                    
                    fprintf('\n')
                    isDoney(Idx) = -2;
                else % check data are well from 2 different quadrupoles
                    if diff(Y(Idx,8)) == 0
                        fprintf('BPMz(%d,%d) not properly determined: same quad %s(%d,%d)\n', Y(k,1), Y(k,2), QUADyFamily(Idx(1),:), QUADyDevList(Idx(1),:));
                    else %Compute combined offset
                        Offsety = [Offsety; Y(Idx(1),:)];
                        [tmpOffset tmpSigma]= getCombinedOffset(Y(Idx,:), QUADyFamily(Idx,:), QUADyDevList(Idx,:), 2);
                        Offsety(end, 3) = tmpOffset;
                        Offsety(end, 4) = tmpSigma;
                        Offsety(end, 6) = mean(Y(Idx,6)); % Mean current
                        Offsety(end, 8) = NaN;
                        Offsety(end, 9) = NaN;
                        isDoney(Idx) = 1;
                    end
                end
            else % single BPM-quad offset
                % Check for too many data
                Idx = find(Y(:,1) == Y(k,1) & Y(:,2) == Y(k,2));
                NbOfData = length(Idx);
                if NbOfData > 1
                    fprintf('BPMz(%d,%d)  too many data (%d)\n', Y(k,1), Y(k,2), NbOfData);
                    str = sprintf(' bba%d%s%dv* ', QUADyDevList(Idx(1),1), deblank(QUADyFamily(Idx(1),:)), QUADyDevList(Idx(1),2));
                    system(['ls -C1 ' str]);
                    isDoney(Idx) = -2;
                else
                    isDoney(k) = 1; % do nothing since computation already done by quadgetdata
                    Offsety = [Offsety; Y(k,:)];
                end
            end
        end
    end
end

if DisplayFlag
%     if isempty(Offsetx)
%         fprintf('Offsetx is empty\n')
%         return;
%     end
%     if isempty(Offsety)
%         fprintf('Offsety is empty\n')
%         return;
%     end
    % Plot data
    L = getcircumference;

    figure;
    subplot(2,1,1);
    if ~isempty(X)
        errorbar(Offsetx(:,5), Offsetx(:,3), Offsetx(:,4), '.b', 'Markersize', 13);
    end
    ylabel('Horizontal [mm]');
    xaxis([0 L]);
    title('BPM Offset with BPM determined by 2 quadrupoles');

    subplot(2,1,2);
    if ~isempty(Y)
        errorbar(Offsety(:,5), Offsety(:,3), Offsety(:,4), '.b', 'Markersize', 13);
    end
    xlabel('BPM Position [meters]');
    ylabel('Vertical [mm]');
    xaxis([0 L]);
    
end

% Write 2 files for applying BBA offsets to TANGO

if WriteFlag
    if isempty(Offsetx)
        fprintf('Offsetx is empty\n')
    else
        for ik=1:size(Offsetx,1),
            tableBBAH(ik,1) = dev2tangodev('BPMx', Offsetx(ik,1:2)); tableBBAH{ik,2} = num2str(Offsetx(ik,3), '%+.3f');
        end
        save('tableBBAH.mat','tableBBAH')
    end
    if isempty(Offsety)
        fprintf('Offsety is empty\n')
    else
        for ik=1:size(Offsety,1),
            tableBBAV(ik,1) = dev2tangodev('BPMz', Offsety(ik,1:2)); tableBBAV{ik,2} = num2str(Offsety(ik,3), '%+.3f');
        end
        save('tableBBAV.mat','tableBBAV')
    end

    % output result in text format
    fileName = 'BBAresult.txt';
    fid = fopen(fileName, 'wt');
    fprintf(fid, '*************************************************\n');
    fprintf(fid, '** BBA results:  %s **\n', datestr(now) );
    fprintf(fid, '*************************************************\n\n');
    fprintf(fid, '*************** H-plane ******************** \n');
    if ~isempty(Offsetx)
        for ih = 1:size(tableBBAH,1)
            fprintf(fid, '%s # %s  \n', tableBBAH{ih,1:2});
        end
    end
    if ~isempty(Offsety)
        fprintf(fid, '%s \n', ' ');
        fprintf(fid, '*************** V-plane ******************** \n');
        for iv = 1:size(tableBBAV,1)
            fprintf(fid, '%s # %s  \n', tableBBAV{iv,1:2});
        end
    end
    eval(['edit ' fileName])
end
cd(DIR0);

function [OffsetC SigmaC]= getCombinedOffset(data, Fam, devList, plane)
%Look for double BPM neigboring two quads
% plane = 1 H-plane
% plane = 2 V-plane

DebugFlag = 1;

w = zeros(2,2);
for k=1:2,
    w(k,:) = quadgetbetaKL(Fam(k,:), devList(k,:));
end

OffsetC = (data(1,3)*w(1,plane) + data(2,3)*w(2,plane))/(w(1,plane) + w(2,plane));
SigmaC = (data(1,4)*w(1,plane) + data(2,4)*w(2,plane))/(w(1,plane) + w(2,plane));

if DebugFlag
    if plane == 1
        fprintf('BPMx(%2d,%d) Combined offset: %+f  %s(%2d,%2d) offset: %+f  %s(%2d,%2d) offset: %+f\n', ...
            data(1,1), data(1,2), OffsetC, Fam(1,:), devList(1,:), data(1,3), Fam(2,:), devList(2,:), data(2,3));
    else
        fprintf('BPMz(%2d,%d) Combined offset: %+f  %s(%2d,%2d) offset: %+f  %s(%2d,%2d) offset: %+f\n', ...
            data(1,1), data(1,2), OffsetC, Fam(1,:), devList(1,:), data(1,3), Fam(2,:), devList(2,:), data(2,3));
    end
end

function lambda = getbetaKL(Family, DeviceList)

% Integrated gradient
KL = getkleff(Family, DeviceList);

lambda = zeros(2,length(KL));

% betax at entrance of magnet
[bx bz] = modelbeta(Family, DeviceList);

lambda(1,:) = abs(KL).*bx;
lambda(2,:) = abs(KL).*bz;
