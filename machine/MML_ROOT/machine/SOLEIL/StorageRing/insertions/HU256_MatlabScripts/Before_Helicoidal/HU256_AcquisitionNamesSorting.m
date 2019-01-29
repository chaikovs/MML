function HU256_AcquisitionNamesSorting(MeasDir)
        
    StructureOfMeasurements=dir([MeasDir filesep '*.mat']);
    NumberOfMeasurements=size(StructureOfMeasurements, 1);
    
    MaxLength=0;
    %toto=getfield(StructureOfMeasurements, {1}, 'name');
    for i=1:NumberOfMeasurements
        InstantLength=length(getfield(StructureOfMeasurements, {i}, 'name'));
    %    ArrayOfMeasurements(i)=getfield(StructureOfMeasurements, {1}, 'name');
        if InstantLength>MaxLength
            MaxLength=InstantLength;
        end
    end

    ArrayOfXMeasurements=[];
    ArrayOfZMeasurements=[];
    %ArrayOfMeasurements=zeros(NumberOfMeasurements, 1);     %MaxLength+1);
    %ArrayTemp=zeros(NumberOfMeasurements, 1);
    for i=1:NumberOfMeasurements
        InstantString=getfield(StructureOfMeasurements, {i}, 'name');
        InstantLength=length(InstantString);
        InstantString=InstantString(1, 1:InstantLength-4);
        InstantSuffix='';
        for j=0:MaxLength-InstantLength-4
            InstantSuffix=[InstantSuffix ' '];
        end
        InstantString=[InstantString InstantSuffix];
        %ArrayTemp(i)=length(InstantString);
        if strncmp(InstantString, 'HU256_CASSIOPEE_BZP', 19)
            ArrayOfZMeasurements=strvcat(ArrayOfZMeasurements, InstantString);
        elseif strncmp(InstantString, 'HU256_CASSIOPEE_BX', 18)
            ArrayOfXMeasurements=strvcat(ArrayOfXMeasurements, InstantString);
        end
    %BzCycleDown=[   'HU256_CASSIOPEE_BZP_0A_2006-10-13_12-04-38  ';
    %                'HU256_CASSIOPEE_BZP_m20A_2006-10-13_12-05-47']
    end
    MaxLength;
    %ArrayTemp;
    ArrayOfXMeasurements
    ArrayOfZMeasurements
end