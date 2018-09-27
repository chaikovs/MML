function [MachineList, SubMachineList] = getmachinelist(varargin)
%GETMACHINELIST - Returns a cell array list of accelerators available to the Accelerator Control Toolbox (ACT)
%  [MachineList, SubMachineList] = getmachinelist
%
%  Written by Greg Portmann


MMLROOT = [getmmlroot, 'machine'];

DirStart = pwd;
cd(MMLROOT)

DirStruct = dir;

MachineList = {};
for i = 3:length(DirStruct)
    MachineList{i-2,1} = DirStruct(i).name;
end

if ismac
    % Remove .DS_Store Directory
    MachineList = findkeyword(MachineList, '.DS_Store');
end


%if nargout >= 2
    SubMachineList = {};
    for i = 1:length(MachineList)
        cd(MachineList{i});
        DirStruct = dir;
        k = 0;
        for j = 3:length(DirStruct)
            if     length(DirStruct(j).name) >=  7 && strcmpi(DirStruct(j).name(end-6:end),  'OpsData')
            elseif length(DirStruct(j).name) >=  4 && strcmpi(DirStruct(j).name(end-3:end),  'Data')
            elseif length(DirStruct(j).name) >= 11 && strcmpi(DirStruct(j).name(end-10:end), 'Application')
            elseif length(DirStruct(j).name) >= 12 && strcmpi(DirStruct(j).name(end-11:end), 'Applications')
            elseif length(DirStruct(j).name) >=  6 && strcmpi(DirStruct(j).name(end-5:end),  'common')
            elseif length(DirStruct(j).name) >=  8 && strcmpi(DirStruct(j).name(end-7:end),  'doc_html')
            elseif length(DirStruct(j).name) >=  4 && strcmpi(DirStruct(j).name(end-3:end),  'docs')
            elseif length(DirStruct(j).name) >=  3 && strcmpi(DirStruct(j).name(end-2:end),  'doc')
            elseif length(DirStruct(j).name) >=  6 && strcmpi(DirStruct(j).name(end-5:end),  'Sussix')
            else
                k = k + 1;
                SubMachineList{i}{k} = DirStruct(j).name;
            end
        end
        cd ..
    end
%end

% Remove machines that do not have a SubMachine list
for i = length(MachineList):-1:1
    if isempty(SubMachineList{i})
        MachineList(i) = [];
        SubMachineList(i) = [];
    end
end


cd(DirStart);