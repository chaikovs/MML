function BPM_RespMat_split_merge(Flags,varargin)
%   INPUTS
%   1. Flags:Split or Merge respMatFile / Split DispFile
%   2. Filenames: you can leave this empty or give RespFile Name
%   for Merge Flags if you give the FileNames please respect this order
%           1.BPMRespMat 2.XBPMRespMat
%
%  EXAMPLES
%  ex:  BPM_RespMat_split_merge('Split')
%  ex:  BPM_RespMat_split_merge('Merge')
%  ex:  BPM_RespMat_split_merge('Split','BPMRespMat_2014-10-30_08-33-22_PBPMz.mat')
%  ex:  BPM_RespMat_split_merge('Merge','BPMRespMat_2014-10-30_08-33-22_BPM.mat','XBPMRespMat.mat')
%  See Also  measbpmresp

%% Written by A. Bence
%

%Variables initialisation
Filename  = ''; % filename for Rmat with BPMs and XBPMs for split and BPMs only for merge
Filename2 = ''; % Output filename with onlyBPM for Split / Input filename for Rmat with only XBPMs for merge
Filename3 = ''; % Output filename with onlyXBPM for Split

SPLITFLAG = 1;

if ~isempty(varargin) && length(varargin)>2
    error('Wrong Number of inputs argument');
end
if strcmpi(Flags,'Split')
    SPLITFLAG =1; % use SPLITFLAG
    if ~isempty(varargin)
        Filename = varargin{1}
    end
elseif strcmpi(Flags,'Merge')
    SPLITFLAG = 0;
    if length(varargin)==2
        Filename = varargin{1}
        Filename2= varargin{2}
    end
end



%% split RespMatfile
if SPLITFLAG
    try
        % get Location of XBPM and BPM in PBPMz
        [TF,Bpmind]=ismember(family2tango('BPMz'),family2tango('PBPMz'));
        XBPMind= [1:1:length(family2tango('PBPMz'))];
        XBPMind=setxor(Bpmind,XBPMind);
        
        %load(Filename,'MachineConfig' ,'Rmat');
        if isempty(Filename)
            Filename=uigetfile('*.mat','Choose RespMatFile To Split');
        end
        vars =whos('-file',Filename);
        
        if ismember('Rmat',{vars.name}) % verify if it's BPMrmatFile
            load(Filename,'MachineConfig' ,'Rmat');
                    %save initial Rmat into two variables
            RmatBPM=Rmat;
            RmatXBPM=Rmat;
            ind=XBPMind;

            %remove (XBPM) data for given index
            for i=1:2
                RmatBPM(2,i).Data(ind,:)=[];
                RmatBPM(2,i).Monitor.Data(ind)=[];
                RmatBPM(2,i).Monitor.FamilyName='BPMz';
                RmatBPM(2,i).Monitor.DeviceList(ind,:)=[];
                RmatBPM(2,i).Monitor.Status(ind)=[];
                if isfield(RmatBPM(2,i),'Monitor1')% no present anytime you need to check 
                    RmatBPM(2,i).Monitor1(ind,:)=[];
                end
                if isfield(RmatBPM(2,i),'Monitor2')    
                    RmatBPM(2,i).Monitor2(ind,:)=[];
                end    
            end


            %RmatXBPM= RmatXBPM(2,:);
            ind=Bpmind;
            %remove (BPM) data for given index   
            for i=1:2        
                RmatXBPM(1,i).Data(:,:)=[];
                RmatXBPM(1,i).Monitor.Data(:)=[];
                RmatXBPM(1,i).Monitor.FamilyName='BPMx';
                RmatXBPM(1,i).Monitor.DeviceList(:,:)=[];
                RmatXBPM(1,i).Monitor.Status(:)=[];
                if isfield(RmatXBPM(1,i),'Monitor1')
                    RmatXBPM(1,i).Monitor1(:,:)=[];
                end
                if isfield(RmatXBPM(1,i),'Monitor2')
                    RmatXBPM(1,i).Monitor2(:,:)=[];
                end

                RmatXBPM(2,i).Data(ind,:)=[];
                RmatXBPM(2,i).Monitor.Data(ind)=[];
                RmatXBPM(2,i).Monitor.FamilyName='PBPMz';
                RmatXBPM(2,i).Monitor.DeviceList(ind,:)=[];
                RmatXBPM(2,i).Monitor.Status(ind)=[];
                if isfield(RmatXBPM(2,i),'Monitor1')
                    RmatXBPM(2,i).Monitor1(ind,:)=[];
                end
                if isfield(RmatXBPM(2,i),'Monitor2')    
                    RmatXBPM(2,i).Monitor2(ind,:)=[];
                end    

            end
            [pathstr,name,ext]=fileparts(Filename);
            name=strcat(name,'_BPMonly',ext);
            Filename2=uiputfile(name,'Save Rmat with Only BPM');
            %Filename2=fullfile(pathstr,name);
            Rmat=RmatBPM;
            save(Filename2, 'MachineConfig' , 'Rmat' );

            [pathstr,name,ext]=fileparts(Filename);
            name=strcat(name,'_XBPMonly',ext);
            Filename3=uiputfile(name,'Save Rmat with Only XBPM');
            %Filename3=fullfile(pathstr,name);
            Rmat=RmatXBPM;
            save(Filename3, 'MachineConfig' , 'Rmat' );
        elseif ismember('BPMxDisp',{vars.name}) % verify if it's DispFile 
            load(Filename,'BPMxDisp' ,'BPMyDisp');
            XBPMyDisp=BPMyDisp;
            %remove XBPM
            ind=XBPMind;
            BPMyDisp.Data(ind)=[];
            BPMyDisp.Monitor1(ind)=[];
            BPMyDisp.Monitor2(ind)=[];
            BPMyDisp.Monitor.Data(ind)=[];
            BPMyDisp.Monitor.Status(ind)=[];
            BPMyDisp.Monitor.DeviceList(ind,:)=[];
            BPMyDisp.Monitor.FamilyName='BPMz';
            %remove BPM
            ind=Bpmind;
            XBPMyDisp.Data(ind)=[];
            XBPMyDisp.Monitor1(ind)=[];
            XBPMyDisp.Monitor2(ind)=[];
            XBPMyDisp.Monitor.Data(ind)=[];
            XBPMyDisp.Monitor.Status(ind)=[];
            XBPMyDisp.Monitor.DeviceList(ind,:)=[];
            
            [pathstr,name,ext]=fileparts(Filename);
            name=strcat(name,'_BPMonly',ext);
            Filename2=uiputfile(name,'Save Disp with Only BPM');
            %Filename2=fullfile(pathstr,name);
            save(Filename2, 'BPMxDisp' ,'BPMyDisp');

            [pathstr,name,ext]=fileparts(Filename);
            name=strcat(name,'_XBPMonly',ext);
            Filename3=uiputfile(name,'Save Disp with Only XBPM');
            %Filename3=fullfile(pathstr,name);
            BPMyDisp=XBPMyDisp;
            save(Filename3, 'BPMyDisp' );
            
        else
            warndlg('the don''t contains searched field')
        return
        end    



        

    %error catch
    catch ME
        switch ME.identifier
            case 'MATLAB:subsdeldimmismatch'
                warndlg('check the file you try to split , it seems not be a respmatfile wit XBPM');
            otherwise
                rethrow(ME);
        end       
    end    
    
    %% merge RespMatfile
else
    
    if isempty(Filename)
        Filename = uigetfile('*.mat','Load Rmat with only BPMs');
        Filename2= uigetfile('*.mat','Load Rmat with only XBPM');
    end
    
    load(Filename,'MachineConfig' ,'Rmat');
    Rmatrebuild=Rmat;
    
    load(Filename2,'MachineConfig' ,'Rmat');
    RmatXbpm=Rmat;
    if ~strcmpi(Rmat(2,1).Monitor.FamilyName, 'PBPMz')
        warndlg('FamilyName is not PBPMz');
        return
    end    
    % get Location of XBPM
    [TF,Bpmind]=ismember(family2tango('BPMz'),family2tango('PBPMz'));
    XBPMind= [1:1:length(family2tango('PBPMz'))];
    XBPMind=setxor(Bpmind,XBPMind);
    %shift indice for concmat function
    for i=1:length(XBPMind)
        XBPMind(i)=XBPMind(i)-i;
    end
    
    for i=1:2
        Rmatrebuild(2,i).Data=ConcMat(Rmatrebuild(2,i).Data,RmatXbpm(2,i).Data,XBPMind);
        Rmatrebuild(2,i).Monitor.Data=ConcMat(Rmatrebuild(2,i).Monitor.Data,RmatXbpm(2,i).Monitor.Data,XBPMind);
        Rmatrebuild(2,i).Monitor.DeviceList=ConcMat(Rmatrebuild(2,i).Monitor.DeviceList,RmatXbpm(2,i).Monitor.DeviceList,XBPMind);
        Rmatrebuild(2,i).Monitor.Status=ConcMat(Rmatrebuild(2,i).Monitor.Status,RmatXbpm(2,i).Monitor.Status,XBPMind);
        if isfield(Rmatrebuild(2,i),'Monitor1') && isfield(RmatXbpm(2,i),'Monitor1')
         Rmatrebuild(2,i).Monitor1=ConcMat(Rmatrebuild(2,i).Monitor1,RmatXbpm(2,i).Monitor1,XBPMind);   
        end    
        if isfield(Rmatrebuild(2,i),'Monitor2') && isfield(RmatXbpm(2,i),'Monitor2')
         Rmatrebuild(2,i).Monitor2=ConcMat(Rmatrebuild(2,i).Monitor2,RmatXbpm(2,i).Monitor2,XBPMind);   
        end    
        Rmatrebuild(2,i).Monitor.FamilyName='PBPMz';
    end
    
    [pathstr,name,ext]=fileparts(Filename);
    name=strcat(name,'_Rebuild',ext);
    Filename3=uiputfile(name,'Save Rmat ReCombined');
    %Filename4=fullfile(pathstr,name);
    Rmat=Rmatrebuild;
    save(Filename3, 'MachineConfig' , 'Rmat' );
    
end
end

function C=ConcMat(A,B,Ind)
% 1. concatenate matrices
C = [A ; B] ;
sa = size(A);
% 2. sort the respective indices, the first output of sort is ignored (by
% giving it the same name as the second output, one avoids an extra
% large variable in memory)
[abi,abi] = sort([[1:sa(1)].' ; Ind(:)]) ;
% 3. reshuffle the large matrix
C = C(abi,:) ;

end
