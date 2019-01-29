function Result=idGetListOfOrbitsWithNaN(Directory, CoreFileName, GetAllFileNames)
% Written by F. Briquez 03/11/2011
% CoreFileName should contain an '*' character. If not, the '*' character
% is added at the end of CoreFileName, assuming the constant part of the
% name is its begining.
% Prints names of .mat files in which X or Z orbits contain at least one NaN
% GetAllFileNames=1 => reminds also the name of a file not containing NaN
    
    AsteriskPosition=findstr(CoreFileName, '*');
    if (isempty(AsteriskPosition)==1)
        CoreFileName=[CoreFileName, '*'];
    end
    if (size(CoreFileName, 2)>4)
        EndOfName=CoreFileName(size(CoreFileName,2)-4:size(CoreFileName, 2));
        if (strcmp(EndOfName, '.mat')==0)
            CoreFileName=[CoreFileName, '.mat'];
        end
    else
        CoreFileName=[CoreFileName, '.mat'];
    end
    ListOfFiles=dir([Directory, filesep, CoreFileName]);
    NumberOfFiles=size(ListOfFiles, 1);
       
    for i=1:NumberOfFiles
%     i=1;
        File=ListOfFiles(i);
        FileName=File.name;
        FullFileName=[Directory, filesep, FileName];
        Structure=load(FullFileName);
        if (isstruct(Structure))
            if (isfield(Structure, 'X')&&isfield(Structure, 'Z'))
                OrbitX=Structure.X;
                OrbitZ=Structure.Z;
                if (sum(isnan(OrbitX))~=0)
                    fprintf('File %s : Orbit X\n', FileName)
                else
                    if (GetAllFileNames)
                        fprintf('NO PROBLEM WITH File %s : Orbit X\n', FileName)
                    end
                end
                if (sum(isnan(OrbitZ))~=0)
                    fprintf('File %s : Orbit Z\n', FileName)
                else
                    if (GetAllFileNames)
                        fprintf('NO PROBLEM WITH File %s : Orbit Z\n', FileName)
                    end
                end
            end
        end
    end
    return
end
        