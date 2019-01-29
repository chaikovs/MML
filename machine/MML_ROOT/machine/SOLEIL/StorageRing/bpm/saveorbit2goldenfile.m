function saveorbit2goldenfile(varargin)
%SAVEORBIT2GOLDENFILE - Get orbit from different source 'Actual,Golden,File,Workspace'
% and save to a file in Golden Folder with possibility to link or not to the Default Golden file.
%
%  INPUTS
%  Optional
%  1. XBPM - Flag for Save XBPM Buffer into GoldenXBPMFile 
%  2. BPM - Flag for Save BPM Buffer into GoldenBPMFile
%
%  3. Actual - Flag to get data from actualOrbit 
%  4. File - Flag to get data from File 
%  5. Workspace - Flag to get data from variable in matlab Workspace
%  6. Edit - Flag to edit data before 
%
%  EXAMPLES
%  ex: saveorbit2goldenfile('XBPM','BPM')
%  ex: saveorbit2goldenfile if no argin the function asks you 'Which Golden File you want create?'
%
%  See Also saveoffsetorbit, getgolden, getoffset, plotgoldenorbit,
%  plotoffsetorbit, savegoldenorbit

%
%  Written by A. Bence


XBPMFlag=0;
BPMFlag=1;
ActualFlag=0;
FileFlag=0;
WorkspaceFlag=0;
EditFlag=0;
IsConfFile=0;
QuestFlag=1; %if True ask question ....

NumIteration=0;

%set Default Family BPM
BPMxFamily = gethbpmfamily;
BPMzFamily = getvbpmfamily;

%set Default FileName
FileName='GoldenBPM';
%% Input parsing
    for i = length(varargin):-1:1
        if isstruct(varargin{i})
            % Ignor structures
        elseif iscell(varargin{i})
            % Ignor cells
        elseif strcmpi(varargin{i},'struct')
            % Just remove
            varargin(i) = [];
        elseif strcmpi(varargin{i},'numeric')
            % Just remove
            varargin(i) = [];
        elseif strcmpi(varargin{i},'BPM')
            BPMFlag=1;
            QuestFlag=0;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'XBPM')
            XBPMFlag = 1;
            QuestFlag=0;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'Actual')
            ActualFlag=1;
            FileFlag=0;
            WorkspaceFlag=0;
            QuestFlag=0;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'File')
            ActualFlag=0;
            FileFlag=1;
            WorkspaceFlag=0;
            QuestFlag=0;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'Workspace')
            ActualFlag=0;
            FileFlag=0;
            WorkspaceFlag=1;
            QuestFlag=0;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'Edit')
            EditFlag=1;
            QuestFlag=0;
            varargin(i) = [];     
        end
    end    

%%
    if QuestFlag
        switch questdlg('Which Golden File you want create?','Question','BPM', 'XBPM', 'BPM and XBPM', 'BPM');
            case 'BPM'
              XBPMFlag = 0;
              BPMFlag=1;
            case 'XBPM'
              XBPMFlag = 1;
              BPMFlag=0;
            case 'BPM and XBPM'
              XBPMFlag = 1;
              BPMFlag=1;             
        end
        selectedButton= uigetpref('graphic','savefigurebeforeclosing','Question','Do you want get the orbit from the actual orbit, the Golden File, a File or the workspace?',{'actual','golden', 'file','Workspace';'Actual','Golden', 'File','Workspace'},'DefaultButton','Actual');
        switch selectedButton
            case 'actual'
              FileFlag=0;
              WorkspaceFlag=0;
              ActualFlag=1;
            case 'file'
              FileFlag=1;
              WorkspaceFlag=0;
              ActualFlag=0;
            case 'workspace'
              FileFlag=0;
              WorkspaceFlag=1;
              ActualFlag=0;
            case  'golden'
              FileFlag=0;
              WorkspaceFlag=0;
              ActualFlag=0; 
        end
        switch questdlg('Do you want to edit values before saving the data?','Question: editing choice?','Edit', 'No', 'No');
            case 'Edit'
              EditFlag=1;
            case 'No'
              EditFlag=0;       
            
        end        
    end
%%    
NumIteration=BPMFlag+XBPMFlag ;   
for k=1:NumIteration    
        if BPMFlag %get data from golden
            Family='BPM';
            FileNameRef='GoldenBPM';    
            Xgolden = getgolden(gethbpmfamily, 'Struct');
            Ygolden = getgolden(getvbpmfamily, 'Struct');
        elseif XBPMFlag
            Family='XBPM';
            FileNameRef='GoldenXBPM';           
            [TF,Bpmind]=ismember(family2tango('BPMz'),family2tango('PBPMz'));% get Location and DevList of XBPM in PBPMz
            XBPMind= [1:1:length(family2tango('PBPMz'))];
            XBPMind=setxor(Bpmind,XBPMind);
            XBPM_DevList=family2dev('PBPMz');
            XBPM_DevList=XBPM_DevList(XBPMind,:);        

            Xgolden = getgolden('PBPMz',XBPM_DevList, 'Struct');
            Ygolden = getgolden('PBPMz',XBPM_DevList, 'Struct');    
        end
        
        if FileFlag %get data from file
            switch questdlg('Directory name to get file?','directory selection','GoldenFolder', 'BPMFolder', 'GoldenFolder');
            case 'GoldenFolder'
                [filename, pathname]=uigetfile([getfamilydata('Directory', 'BPMGolden'),filesep]);
                IsConfFile=1;
            case 'BPMFolder'
                [filename, pathname]=uigetfile([getfamilydata('Directory', 'BPMData'),filesep]);
            end
            if filename == 0 %manage cancel
                filename = '';
                warning('Cancel-->exit');
                return
            end
            FileData =load(fullfile(pathname,filename),'Data1','Data2');
            Xgolden.Data=FileData.Data1.Data;
            Ygolden.Data=FileData.Data2.Data;
        elseif WorkspaceFlag %get variable from base workspace
            variable=[];
            variablew=evalin('base','who');
            for i=1:length(variablew)  
                v=evalin('base',variablew{i});
                if isa(v, 'struct')
                    if isfield(v,'FamilyName')
                        if ~isempty(strfind(v.FamilyName, 'BPM')) 
                           variable=strvcat(variable, variablew{i}) ;
                        end
                    end    
                end    
            end
            if isempty(variable)
                warndlg('No variable of type struct with pattern like getx(''struct'') found  in workspace');
                return
            else
                warndlg('the variable struture take priority to your previous answer');
                variable=editlist(variable,' ',zeros(size(variable)));
                if isempty(variable)
                    warndlg('No variable selected');
                    return
                end    
            end
            
            %LData=evalin('base',variable);
            for i=1:length(variable(:,1))               
                LData=evalin('base',variable(i,:));
                switch LData.FamilyName
                    case 'BPMx'
                        Xgolden=LData;
                        BPMFlag=1;
                        Family='BPM';
                        FileNameRef='GoldenBPM';
                    case 'BPMz'
                        Ygolden=LData;
                        BPMFlag=1;
                        Family='BPM';
                        FileNameRef='GoldenBPM';
                    case 'PBPMz' 
                        [TF,Bpmind]=ismember(family2tango('BPMz'),family2tango('PBPMz'));% get Location and DevList of XBPM in PBPMz
                        XBPMind= [1:1:length(family2tango('PBPMz'))];
                        XBPMind=setxor(Bpmind,XBPMind);
                        if BPMFlag
                           LData.Data(XBPMind)=[];
                           LData.DeviceList(XBPMind,:)=[];
                           LData.Status(XBPMind)=[];
                           LData.FamilyName='BPMz';
                           Ygolden=LData;
                        else
                          
                           LData.Data=LData.Data(XBPMind);
                           LData.DeviceList=LData.DeviceList(XBPMind,:);
                           LData.Status=LData.Status(XBPMind);
                           Xgolden=LData;
                           Ygolden=LData;
                        end    
                end    
            end    
%             switch questdlg('in which plan you want set this vector ?','Question','H','V','H');
%             case 'H'
%                  if size(LData,1)==size(Xgolden.Data,1) && isa(LData, 'double')
%                        Xgolden.Data=LData;
%                  else
%                      error('different size of variable');
%                  end
%             case 'V'
%                  if size(LData,1)==size(Ygolden.Data,1) && isa(LData, 'double')
%                        Ygolden.Data=LData;
%                  else
%                      error('different size of variable');
%                  end
%             end  
        elseif ActualFlag %get data from actual orbit
            if BPMFlag
                Xgolden.Data=getx;
                Ygolden.Data=gety;
            elseif XBPMFlag
                Xgolden.Data=getam('PBPMz',XBPM_DevList); %% not use actually but XBPMGolden is set with X value
                Xgolden.DeviceList=XBPM_DevList;
                Xgolden.Status=getfamilydata('PBPMz','Status',XBPM_DevList);
                Ygolden.Data=getam('PBPMz',XBPM_DevList);
                Ygolden.DeviceList=XBPM_DevList;
                Ygolden.Status=getfamilydata('PBPMz','Status',XBPM_DevList);
            end    
            Xgolden.TimeStamp=clock;
            Ygolden.TimeStamp=clock;
            Xgolden.CreatedBy=mfilename;       
            Ygolden.CreatedBy=mfilename;
        end
        
        Data1=Xgolden;
        Data2=Ygolden;
        
        if EditFlag %edit vector
            Data1.Data = editvector(Data1.DeviceList, Data1.FamilyName, Data1.Data);
            Data2.Data = editvector(Data2.DeviceList, Data2.FamilyName, Data2.Data);            
        end
        
        %writeData
        switch questdlg(strcat('Do you want to change locally the golden ', Family, ' values for this session of matlab ?'),'Question: ','Yes', 'No', 'No');
        case 'Yes'
            setgolden(Data1);
            setgolden(Data2);
            if BPMFlag
                switch questdlg('Do you want make additionnal setGolden to PBPMz','Question','Yes', 'No', 'No');
                case 'Yes'
                    tempDataFnam=Data2.FamilyName;
                    Data2.FamilyName='PBPMz';
                    setgolden(Data2);
                    Data2.FamilyName=tempDataFnam;
                end
            end    
        end  

        FileName = appendtimestamp(FileNameRef, clock);
        DirectoryName = getfamilydata('Directory', 'BPMGolden');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM', filesep];
        end

        % Make sure default directory exists
        DirStart = pwd;
        [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
        cd(DirStart);         
        if IsConfFile
            FileName=filename; % not create new file
        else    
            [FileName, DirectoryName] = uiputfile('*.mat', strcat('Save Golden ',Family,' File to ...'), [DirectoryName FileName]);
            if FileName == 0
                FileName = '';
                return
            end
        end
        FileName = [DirectoryName, FileName];
        save(FileName, 'Data1', 'Data2');
        switch questdlg(strcat('Do you want to make this file the Default Golden ', Family,' File for the current setoperational mode? (if Yes: a symbolic link will be updated and valid for all Matlab Sessions)'),'Question','Yes', 'No', 'No');
        case 'Yes'                    
            CurrentDir = pwd;
            GoldenName=[FileNameRef,'.mat'];
            cd(DirectoryName);
            VersionName = FileName;
            if isempty(VersionName)
                 cd(CurrentDir);
                 error('Abort: No File')
            end
            [tmp File2deploy ext] = fileparts(VersionName);
            system(sprintf('rm -v %s', GoldenName));
            system(sprintf('ln -s -v %s %s', [File2deploy ext], GoldenName));
            
            d=date;
            fid=fopen('HistoryOfChanges.txt', 'a');
            fprintf(fid,sprintf('\n%s : %s -->%s \n',d,[File2deploy ext], GoldenName));
            fclose(fid);
            
            cd(CurrentDir);
        end
        % for Manage XBPMFLAG if both Flag are set to 1
        BPMFlag=0;
 
        
end
 
