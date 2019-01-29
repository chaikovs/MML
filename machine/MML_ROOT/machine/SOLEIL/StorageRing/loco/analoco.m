function analoco(varargin)

FileName = {};
PathName='';

if ~isempty(varargin)
    FileName = varargin{1}
end

if isempty(FileName)
    [FileName, PathName] = uigetfile('*.mat', 'Select A LOCO File (cancel to stop)', [getfamilydata('Directory','DataRoot'), 'LOCO', filesep]);
    drawnow;
    if ~ischar(FileName)
        if iFile == 1
            return;
        end
    else
        FileName = [PathName, FileName];
    end
end

load(FileName)

if isempty(PathName)
    dirName = pwd;
else
    dirName = PathName
    [a FileName] = fileparts(FileName)
end
ind = findstr(dirName,'LOCO');
dirName(1:ind+4) = [];
    
%%
figure
hold on;
grid on;
slegend = {};
for k=2:length(FitParameters),
    % dKoK in percent
    dKoK = (FitParameters(k).Values(1:160) - FitParameters(1).Values(1:160))./ FitParameters(1).Values(1:160) *100;
    plot(dKoK,'Color',nxtcolor)
    slegend = {slegend{:}, ['Iteration #' num2str(k-1)]};
end
legend(slegend);

xaxis([0 length(dKoK)+1]); grid on; hold on;
a = axis;
plot([9 9], [-8 8],'r-.')
plot([17 17], [-8 8],'r-.')
plot([25 25], [-8 8],'r-.')
plot([41 41], [-8 8],'r-.')
plot([57 57], [-8 8],'r-.')
plot([81 81], [-8 8],'r-.')
plot([105 105], [-8 8],'r-.')
plot([129 129], [-8 8],'r-.')
plot([145 145], [-8 8],'r-.')

axis(a);

xlabel('Quadrupole number');
ylabel('dKoK [%]');

title(['Relative quadrupole variations for file ', dirName, filesep, FileName], 'interpreter', 'none');

%%
figure

% quadrupoles sorted in machine order
quadpos = [getspos('Q1'); getspos('Q2') ; getspos('Q3') ; getspos('Q4'); ...
    getspos('Q5') ; getspos('Q6') ; getspos('Q7') ; getspos('Q8'); ...
    getspos('Q9'); getspos('Q10')];

[y id] = sort(quadpos);
bar(y,dKoK(id)); grid on
ylabel('dKoK [%]');
xlabel('s-position [m]');
title(['Relative quadrupole variations: ', dirName, filesep, FileName], 'interpreter', 'none');

%%
figure
hold;
grid on;
slegend = {};

if length(FitParameters(1).Values) > 160
    for k=2:length(FitParameters),
        % dKoK in percent
        dKoK = FitParameters(k).Values(161:end)*1e-8;
        plot(dKoK,'Color',nxtcolor)
        slegend = {slegend{:}, ['Iteration #' num2str(k-1)]};
    end
    legend(slegend);

    xlabel('Skew Quadrupole number');
    ylabel('QT [T.m]');

    title(['QT variations for file ', dirName, filesep, FileName], 'interpreter', 'none');
end

