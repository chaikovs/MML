function get_RefOrbit_FOFB(hObject,callbackdata,handles)
% Get archived data avaraged over 1 min at the dataand time given by the
% user

%Choose SaveData FileBuffer 
SelFileBtn =questdlg('Choose in which File you want put FOFB RefOrbit?','Select File','File1','File2','File1');   
%
DataStruct=getappdata(handles.figure1);
FamName={DataStruct.SaveX.FamilyName; DataStruct.SaveY.FamilyName};
FamDevList={DataStruct.SaveX.DeviceList; DataStruct.SaveY.DeviceList};
if any(strcmp(FamName,'BPMx'))&&any(strcmp(FamName,'BPMz'))
for k=1:2
        Data=[];
        Date1=datestr(now);
        timestamp=datevec(now);
        switch SelFileBtn,
            case 'File1',
                set(handles.FileNameX,'String',strcat(SelFileBtn,'_FOFB-RefOrbit_',Date1));               
            case 'File2',
                set(handles.FileNameX2,'String',strcat(SelFileBtn,'_FOFB-RefOrbit_' ,Date1));
        end % switch
        
        %set devicename 
        fofbmanager='ANS/DG/FOFB-MANAGER';                
        %get family ? in plotfamily
        argin=family2tango(FamName{k},FamDevList{k});
       

        if k==1  % first axis
            %DataStruct.SaveX.Data=Data(:);
            %setappdata(handles.figure1,'SaveX',DataStruct.SaveX);
            Val=tango_read_attribute(fofbmanager,'xRefOrbit');
            Data=Val.value;
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
            Val=tango_read_attribute(fofbmanager,'zRefOrbit');
            Data=Val.value;
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
            
        end
       
end
else
    warndlg('plotfamily not use BPM family');
    
end

end
