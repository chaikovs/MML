function tracy_plotDA(file)
% tracy_plotDA - Plot DA computed in Tracy (B&W)
DisplayFlag = 1;

if nargin < 1
    file ='fmapn.out';
end

try
    [header data] = hdrload(file);
catch ErrRecord
    error('Error while opening filename %s',file)
end


%% amplitudes
Hamp = data(:,1)*1e3;
Vamp = data(:,2)*1e3;
Hamp(data(:,3)==0)=NaN;
Vamp(data(:,3)==0)=NaN;


if DisplayFlag
    %% Set default properties
    set(0,'DefaultAxesXgrid','on');
    set(0,'DefaultAxesYgrid','on');

    %% Plot
    figure
    plot(Hamp,Vamp,'k.', 'MarkerSize', 2.0, 'k')
    xlabel('Horizontal amplitude (mm)')
    ylabel('Vertical amplitude (mm)')

    addlabel(0,0,datestr(now))
end
