function makedoc_html(varargin)
%MAKEDOC_HTML - Generate new MML, SOLEIL and AT HTML help files
%  makedoc_html

%
%  Written by Gregory J Portmann
%  Modifed by Laurent S. Nadolski

% Options = {'htmldir','doc_html', 'recursive','off', 'graph','Off', ...
%     'todo', 'on', 'template', 'frame', 'index', 'menu', 'search', 'on'};
Options = {'htmldir','doc_html', 'recursive','off', 'graph','Off', ...
    'todo', 'on', 'search', 'on'};

if isempty(varargin)
    ListName = {'AT', 'MML', 'SOLEIL'};
else
    ListName = {};
end

for i = length(varargin):-1:1,
    if strcmpi(varargin{i},'All')
        ListName = {'AT', 'MML', 'SOLEIL'};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'AT')
        ListName = [ListName, 'AT'];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'MML')
        ListName = [ListName, 'MML'];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'SOLEIL')
        ListName = [ListName, 'SOLEIL'];
        varargin(i) = [];
    else
        varargin(i) = [];
    end
end

DirectoryStart = pwd;

%[DirectoryName, FileName, ExtentionName] = fileparts(mfilename('fullpath'));
%cd(DirectoryName);

cd(getmmlroot);

for k=1:length(ListName)
    switch ListName{k}
        case 'MML'
            cd mml

            % Delete old directory first
            try
                if isdir('doc_html')
                    rmdir('doc_html', 's');
                end
            catch
                disp('Delete error');
            end
            cd ..

            try
                if isdir('doc_html')
                    rmdir('doc_html', 's');
                end
            catch
                disp('rmdir error')
            end


            MMLDirectory = {...
                'mml', ...
                fullfile('mml','at'), ...
                fullfile('mml','links','tango') ...
                };

            m2html('mfiles', MMLDirectory, Options{:});

            % Move doc_html directory to MML
            movefile('doc_html', 'mml');

            cd applications

            % Delete old directory first
            try
                if isdir('doc_html')
                    rmdir('doc_html', 's');
                end
            catch
                disp('Delete error');
            end

            cd ..

            try
                if isdir('doc_html')
                    rmdir('doc_html', 's');
                end
            catch
                disp('rmdir error')
            end


            MMLDirectory = {...
                fullfile('applications','common'), ...
                fullfile('applications','loco'), ...
                fullfile('applications', 'database', 'mysql'), ...
                fullfile('applications','mmlviewer'), ...
                fullfile('applications','orbit')
                };

            m2html('mfiles', MMLDirectory, Options{:});

            % Move doc_html directory to MML
            movefile('doc_html', 'applications');

        case 'AT'

            % Make AT HTML help
            cd at
            try
                if isdir('doc_html')
                    rmdir('doc_html','s');
                end
            catch
                disp('rmdir error')
            end

            cd ..
            try
                if isdir('doc_html')
                    rmdir('doc_html','s');
                end
            catch
                disp('rmdir error')
            end

            MMLDirectory = {...
                'at', ...
                fullfile('at','atdemos'), ...
                fullfile('at','atgui'), ...
                fullfile('at','atphysics'), ...
                fullfile('at','lattice'), ...
                fullfile('at','simulator','element'), ...
                fullfile('at','simulator','element','user'), ...
                fullfile('at','simulator','track'), ...
                };

            m2html('mfiles', MMLDirectory, Options{:});

            % Move doc_html directory to AT
            movefile('doc_html', 'at');

        case 'SOLEIL'
            cd(fullfile('machine','Soleil'))

            % Delete old directory first
            try
                if isdir('doc_html')
                    rmdir('doc_html', 's');
                end
            catch
                disp('Delete error');
            end

            cd(fullfile('..', '..'));

            try
                if isdir('doc_html')
                    rmdir('doc_html', 's');
                end
            catch
                disp('rmdir error')
            end

            MMLDirectory = {...
                fullfile('machine','Soleil','LT1'), ...
                fullfile('machine','Soleil','Booster'), ...
                fullfile('machine','Soleil','LT2'), ...
                fullfile('machine','Soleil','StorageRing'), ...
                fullfile('machine', 'Soleil', 'common'), ...
                fullfile('machine', 'Soleil', 'common', 'naff', 'naffutils'), ...
                fullfile('machine', 'Soleil', 'common', 'naff', 'naffutils', 'touscheklifetime'), ...
                fullfile('machine', 'Soleil', 'common', 'naff', 'nafflib'), ...
                fullfile('machine', 'Soleil', 'common', 'archiving'), ...
                fullfile('machine', 'Soleil', 'common', 'database'), ...
                fullfile('machine', 'Soleil', 'common', 'synchro'), ...
                fullfile('machine', 'Soleil', 'common', 'plotfamily'), ...
                fullfile('machine', 'Soleil', 'common', 'configurations'), ...
                fullfile('machine', 'Soleil', 'common', 'cycling')...
                %fullfile('machine', 'Soleil', 'common', 'diag', 'DserverBPM') ...
                %fullfile('mml', 'plotfamily')); % greg version
                };

            m2html('mfiles', MMLDirectory, Options{:});

            % Move doc_html directory to MML
            movefile('doc_html', fullfile('machine','Soleil'));
            cd ..
    end
end

cd(DirectoryStart);
