function get_Data_Archived(hObject,callbackdata,handles)
% Get archived data avaraged over 1 min at the dataand time given by the
% user

%Choose SaveData FileBuffer 
SelFileBtn =questdlg('Choose in which File you want put archived Data?','Select File','File1','File2','File1');   
%
DataStruct=getappdata(handles.figure1);
FamName={DataStruct.SaveX.FamilyName; DataStruct.SaveY.FamilyName};
FamDevList={DataStruct.SaveX.DeviceList; DataStruct.SaveY.DeviceList};
selectedDate=uigetdate();
timestamp=datevec(selectedDate);
% if ~isempty(selectedDate)
%     msgbox('Data retrieving, please wait ~30s');
% end
for k=1:2
    if ~isempty(selectedDate)
        
        %BuilDate for calling TangoExtractor with 1minute of difference between 2
        
        Data=[];
        
        Date1=datestr(selectedDate,'dd-mm-yyyy HH:MM:SS');
        % data2 = data1 + 1min
        Date2=datestr(selectedDate+1/(24*60),'dd-mm-yyyy HH:MM:SS');
        Date={Date1;Date2};
        
        switch SelFileBtn,
            case 'File1',
                set(handles.FileNameX,'String',strcat(SelFileBtn,'_Archived_',Date1));
                %set(handles.FileNameY,'String',strcat(SelFileBtn,'_Archived_',Date1)); 
            case 'File2',
                set(handles.FileNameX2,'String',strcat(SelFileBtn,'_Archived_' ,Date1));
                %set(handles.FileNameY2,'String',strcat(SelFileBtn,'_Archived_' ,Date1));
        end % switch
        
        %set(handles.SaveTime,'String',Date1);
        
        
                
        %set devicename and timeout
        archivingmanager='archiving/archivingmanager/1';
        extractor='archiving/hdbextractor/1';
        tango_set_timeout(archivingmanager,30000);
        tango_set_timeout(extractor,30000);
        
        %get family ? in plotfamily
        argin=family2tango(FamName{k},FamDevList{k});
        
        argin=argin.';
        %for checking isArchived or Not
        list = tango_command_inout2(archivingmanager,'IsArchivedHdb',argin)';

        h = waitbar(0,sprintf('Family%d: Data retrieving, please wait',k));

        if all(list)
            %The attribute's name, the beginning date (DD-MM-YYYY HH24:MI:SS)
            %and the ending date
            len = length(argin);i_ = 0;          
            for l_=argin
                i_ = i_ +1;
                argin2=[l_;Date].';
                Data=[Data tango_command_inout2(extractor,'GetAttDataAvgBetweenDates',argin2)];
                waitbar(i_/len,h);
            end
            delete(h);
        else
            msgbox('at least one device of family has no archived');
            Data=[];
        end
        if k==1  % first axis
            %DataStruct.SaveX.Data=Data(:);
            %setappdata(handles.figure1,'SaveX',DataStruct.SaveX);
            switch SelFileBtn,
                case 'File1',
                    DataStruct.FileX.Data=Data(:);
                    DataStruct.FileX.CreatedBy=mfilename;
                    DataStruct.FileX.TimeStamp=timestamp;
                    setappdata(handles.figure1,'FileX',DataStruct.FileX);
                    
                case 'File2',
                    DataStruct.FileX2.Data=Data(:);
                    DataStruct.FileX2.CreatedBy=mfilename;
                    DataStruct.FileX2.TimeStamp=timestamp;
                    setappdata(handles.figure1,'FileX2',DataStruct.FileX2);
            end       
        else
            switch SelFileBtn,
                case 'File1',
                    DataStruct.FileY.Data=Data(:);
                    DataStruct.FileY.CreatedBy=mfilename;
                    DataStruct.FileY.TimeStamp=timestamp;
                    setappdata(handles.figure1,'FileY',DataStruct.FileY);
                case 'File2',
                    DataStruct.FileY2.Data=Data(:);
                    DataStruct.FileY2.CreatedBy=mfilename;
                    DataStruct.FileY2.TimeStamp=timestamp;
                    setappdata(handles.figure1,'FileY2',DataStruct.FileY2);
            end     
            %DataStruct.FileY.Data=Data(:);
            %setappdata(handles.figure1,'FileY',DataStruct.FileY);
            %DataStruct.SaveY.Data=Data(:);
            %setappdata(handles.figure1,'SaveY',DataStruct.SaveY);
        end
    else
        Data=[];
        %set(handles.SaveTime,'String','Not Saved');
    end
    % Put Data in savedData buffer
    
end

end
