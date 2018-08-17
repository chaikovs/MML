function analoco_thomx(varargin)

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
% figure
% hold on;
% grid on;
% slegend = {};
% for k=2:length(FitParameters),
%     % dKoK in percent
%     dKoK = (FitParameters(k).Values(1:24) - FitParameters(1).Values(1:24))./ FitParameters(1).Values(1:24) *100;
%     plot(dKoK,'Color',nxtcolor)
%     slegend = {slegend{:}, ['Iteration #' num2str(k-1)]};
% end
% legend(slegend);
% 
% xaxis([0 length(dKoK)+1]); grid on; hold on;
% a = axis;
% plot([4 4], [-10 10],'r-.')
% plot([8 8], [-10 10],'r-.')
% plot([12 12], [-10 10],'r-.')
% plot([16 16], [-10 10],'r-.')
% plot([20 20], [-10 10],'r-.')
% plot([24 24], [-10 10],'r-.')
% 
% 
% axis(a);
% 
% xlabel('Quadrupole number');
% ylabel('dKoK [%]');
% 
% title(['Relative quadrupole variations for file ', dirName, filesep, FileName], 'interpreter', 'none');

%%
% figure
% 
% % quadrupoles sorted in machine order
% quadpos = [getspos('QP1'); getspos('QP2') ; getspos('QP3') ; getspos('QP4'); ...
%     getspos('QP31') ; getspos('QP41') ];
% 
% [y id] = sort(quadpos);
% bar(y,dKoK(id)); grid on
% ylabel('dKoK [%]');
% xlabel('s-position [m]');
% title(['Relative quadrupole variations: ', dirName, filesep, FileName], 'interpreter', 'none');


%%
figure
hold;
grid on;
slegend = {};

    for k=2:length(FitParameters),
        % dKoK in percent
%         dKoK = FitParameters(k).Values(1:end);
dKoK = FitParameters(1).Values(1:end)./FitParameters(k).Values(1:end);
        plot(dKoK,'Color',nxtcolor)
        slegend = {slegend{:}, ['Iteration #' num2str(k-1)]};
    end
    legend(slegend);

    xlabel('Quadrupole number');
    ylabel('QP [T.m]');

    title(['QP variations for file ', dirName, filesep, FileName], 'interpreter', 'none');

%%
figure
hold;
grid on;
slegend = {};

%if length(FitParameters(1).Values) > 24
    for k=2:length(FitParameters),
        % dKoK in percent
%         dKoK = FitParameters(k).Values(24:end)*1e-8;
dKoK = FitParameters(k).Values(1:end);
        plot(dKoK,'Color',nxtcolor)
        slegend = {slegend{:}, ['Iteration #' num2str(k-1)]};
 end
    legend(slegend);

    %xlabel('Skew Quadrupole number');
    xlabel('Quadrupole number');
    ylabel('QT [T.m]');

    title(['QP values for file ', dirName, filesep, FileName], 'interpreter', 'none');

end

