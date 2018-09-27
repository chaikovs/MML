%%

figure(2);
clf
for n=1:4
    if n==1
        name='CHE';
    elseif n==2
        name='CHS';
    elseif n==3
        name='CVE';
    elseif n==4
        name='CVS';
    end
    h=subplot(2, 2, n);
    %h=n+1;
    for i=0:25:275
        %h=AnalogPlotFFWDTable(12, num2str(i), 'Point', (i~=0)*h, 'CVE', '', '', '');
        %AnalogPlotFFWDTable(12, num2str(i), 'Point', h, 'CVE', '', '', '');
        AnalogPlotFFWDTable(12, num2str(i), 'Point', '', name, '', '', '');
    end
end
%%
AnalogPlotFFWDTable(12, '0', 'Point', 0, 'CHS', '', '', '');
AnalogPlotFFWDTable(12, '25', 'Point', 1, 'CHS', '', '', '');
AnalogPlotFFWDTable(12, '50', 'Point', 1, 'CHS', '', '', '');
AnalogPlotFFWDTable(12, '75', 'Point', 1, 'CHS', '', '', '');
AnalogPlotFFWDTable(12, '100', 'Point', 1, 'CHS', '', '', '');