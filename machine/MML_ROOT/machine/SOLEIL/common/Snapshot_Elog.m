function Snapshot_Elog(hObject,callbackdata,handles,schedule)
% Make Snapshot_of current figure and put png file in ELOG Folder

%if schedule
%    fig=hObject;
%else
    fig=handles.figure1;
%end    

namefig=get(fig,'Name'); % get figure name
namefig=namefig(find(~isspace(namefig)));%remove space char
namefig(regexp(namefig,'[,,:,(,)]'))=[];
ElogPath='/home/data/FC/Elog/Photo Elog'; %define where to save snapshot

FormatOut='dd-mm-yy'; %specify format date of folder
FormatOut2='HHhMM_'; %specify format date of file

DateDay=datestr(now,FormatOut); 
w=weeknum(datenum(datestr(now,'dd-mmm-yyyy')));
DirToSnap=fullfile(ElogPath,['Semaine ' num2str(w,'%.2d')],DateDay);
[s,mess,messid]=mkdir(DirToSnap);
FileToSnap=fullfile(DirToSnap,[datestr(now,FormatOut2) namefig '.png' ]);

set(fig,'InvertHardCopy','off');%keepbackgroundColor
set(fig,'PaperPositionMode','auto');%set goodsize and reolution for saveas
set(fig,'PaperUnits','centimeters');
set(fig,'PaperPosition',[0 0 21 14]);
%print('ScreenSizeFigure','-dpng','-r0');
if schedule
    dtevec=clock;
    if (dtevec(4)==7 | dtevec(4)==15 |dtevec(4)==23)& dtevec(5)==0
            if ~exist(FileToSnap)
                saveas(fig,FileToSnap);
            end
    end
else
    saveas(fig,FileToSnap);
end






function w = weeknum(daynums)
% WEEKNUM returns vector W containg the weeknumber corresponding to the
% dates in input vector DAYNUMS. Week 1 is the first 4-day week of the year
% NB! Using Monday as first day of the week.

%% 
daynums = daynums(:);
dayvec = datevec(daynums);
newyearvec = [dayvec(:,1) ones(size(dayvec,1),2) dayvec(:,4:6)];    % January 1st of same year
newyearnums = datenum(newyearvec);
newyeardays = rem(5 + weekday(newyearnums),7) + 1;  % Making Monday=1 (instead of Sunday=1 as returned by built-in function weekday). 

aux = zeros(size(newyeardays));
decind = find(newyeardays<5);                       % Week one starts in December (or Jan 1st)
janind = find(newyeardays>4);                       % Week one starts in January
aux(decind) = newyeardays(decind)-1;                % Week one starts in December: {0,1,2,3} days added to year
aux(janind) = newyeardays(janind)-8;                % Week one starts in January: {1,2,3} days subtracted from year

w = floor((daynums-newyearnums+aux)/7)+1;           % Number of full weeks since monday of week one.
%% Removing misclassified week 53
ind53 = find(w==53);
lastdec = [dayvec(ind53,1) repmat([12 31],size(ind53,1),1) dayvec(ind53,4:6)];
wrong53 = find(ismember(weekday(datenum(lastdec)),[1:4 7]));    % Dec 31 classified as week 53 must be a Thursday or a Friday.

w(ind53(wrong53)) = 1;
%% January days belonging to the last week of previous year.
ind0 = find(w==0);
if ~isempty(ind0)
    w(ind0) = weeknum(daynums(ind0)-7) + 1;         % Adding 1 to weeknum of the previous week
end
end
end