function get_Data_Archived(hObject,callbackdata,handles)
% Get archived data avaraged over 1 min at the dataand time given by the
% user

%Choose SaveData FileBuffer 
SelFileBtn =questdlg('Choose in which File you want put archived Data?','Select File','File1','File2','File1');   
%
DataStruct=getappdata(handles.figure1);


        
        Data=[]; 
        
        %get family ? in plotfamily        
            switch SelFileBtn,
                case 'File1',                    
                    %axe1
                    Data1=DataStruct.FileX;
                    %axe2
                    Data2=DataStruct.FileY;                    
                case 'File2',
                    
                    %axe1
                    Data1=DataStruct.FileX2;
                    %axe2
                    Data2=DataStruct.FileY2;                    
            end
   
   Str_date=datestr(datenum(Data1.TimeStamp),'yyyy-mm-dd_HH-MM-SS');
   pathname=getfamilydata('Directory','BeamUser');
   filename=[Data1.FamilyName,'_',Data2.FamilyName,'_', Str_date, '.mat'];
   [filename, pathname] = uiputfile(fullfile(pathname,filename), 'Save Data as');
   
   if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       disp(['User selected ', fullfile(pathname, filename)])
       filename=fullfile(pathname, filename);
       save(filename, 'Data1', 'Data2');
   end
     

end
