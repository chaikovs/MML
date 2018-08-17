function Set_BBA_Offsets_planV(offsets_array, varargin)
%function Set_BBA_Offsets_planV - Apply V-plane BBA offsets to liberas
%
%  INPUTS
%  1. offsets_array - 'ZERO', 'ADD'
%  Optional
%  2. filename to be read
%
%  See also Set_BBA_Offsets_planH

% 6 October 2009 Modification L. Nadolski. Add option input for BBA filename to be read

if ~isempty(varargin)
    fileName = varargin{1};
    if exist(fileName, 'file') ~=2
        warndlg('File not found');
        return;
    else
        load(fileName);
    end
else
    load([getfamilydata('Directory', 'BBA'),'/2010-01-22/tableBBAV.mat']);
end


Correspondance=tango_get_db_property('BPM','DeviceParameters');
block_table=tango_get_db_property('BPM','BlockParameters');

%for k=1:1:3;
for k=1:1:size(tableBBAV,1);
    k

    Device_name=char(tableBBAV(k,1))
    for i=1:1:size(Correspondance,2)
        index=regexpi(Correspondance{i},Device_name);
        if isempty(index)==0
            separ=regexpi(Correspondance{i},':');
            block_name=Correspondance{i}(separ(1)+1:separ(2)-1);
            for j=1:1:size(block_table,2)
                index3=regexpi(block_table{j},[block_name,':']);
                if isempty(index3)==0
                    separator=regexpi(block_table{j},':');
                    X_offset_BBA=block_table{j}(separator(8)+1:separator(9)-1);
                    Z_offset_BBA=block_table{j}(separator(10)+1:separator(11)-1);
                    New_offset_X=str2num(X_offset_BBA);
                    switch offsets_array
                        case 'ZERO'
                            New_offset_Z=0;
                        case 'ADD'
                            New_offset_Z=str2num(Z_offset_BBA)+str2num(char(tableBBAV(k,2)));
                        otherwise
                            display ('input argument must be ZERO or ADD');
                            return;
                    end;
                    first_part=block_table{j}(1:separator(8));
                    scd_part=block_table{j}(separator(9):separator(10));
                    third_part=block_table{j}(separator(11):size(block_table{j},2));
                    New_line=[first_part,num2str(New_offset_X),scd_part,num2str(New_offset_Z),third_part];
                    block_table{j}=New_line;

                end
            end
        end
    end
end
heure=clock;
heure_string=[num2str(heure(1)),'_',num2str(heure(2)),'_',num2str(heure(3)),'_',num2str(heure(4)),'h',num2str(heure(5)),'mn']
%get BBA default directory and make filepath with it 
BBA_Block_Table_file_Path=fullfile(getfamilydata('Directory', 'BBA'),'Block_table/');
%Create Folder if BBApath has been moved 
if exist(BBA_Block_Table_file_Path)~= 7 
    [s,mess,messid] = mkdir(BBA_Block_Table_file_Path);
end
fichier_destination=fopen([BBA_Block_Table_file_Path,'BlockParameters',heure_string],'w');
fichier_backup=fopen([BBA_Block_Table_file_Path,'BlockParameters_backup',heure_string],'w');

%changed to fullfile(getfamilydata('Directory', 'BBA'),'Block_table/');
%fichier_destination=fopen(['/home/operateur/GrpDiagnostics/matlab/DserverBPM/Block_table/BlockParameters',heure_string],'w');
%fichier_backup=fopen(['/home/operateur/GrpDiagnostics/matlab/DserverBPM/Block_table/BlockParameters_backup',heure_string],'w');

%get 'BPM','BlockParameters' to make backup
block_table_backup=tango_get_db_property('BPM','BlockParameters');
for i=1:1:size(block_table,2)
    fprintf(fichier_destination,block_table{i});
    fprintf(fichier_destination,'\n');
    fprintf(fichier_backup,block_table_backup{i});
    fprintf(fichier_backup,'\n');
end
fclose(fichier_destination);
fclose(fichier_backup);
edit([BBA_Block_Table_file_Path,'BlockParameters',heure_string]);

