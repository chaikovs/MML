function plotquad(varargin)

MeanFlag = 1;
MonitorFlag = 1;
Field = 'Monitor';

% Flag factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Mean')
        MeanFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoMean')
        MeanFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Setpoint')
        Field = 'Setpoint';
    elseif strcmpi(varargin{i},'Offset1')
        Field = 'Offset1';
    end
end

Q1 = getpv('Q1', Field);
Q1c = Q1-mean(Q1);
Q2 = getpv('Q2',Field);
Q2c = Q2-mean(Q2);
Q3 = getpv('Q3',Field);
Q3c = Q3-mean(Q3);
Q4 = getpv('Q4', Field);
Q4c = Q4-mean(Q4);
Q5 = getpv('Q5', Field);
Q5c = Q5-mean(Q5);
Q6 = getpv('Q6', Field);
Q6c = Q6-mean(Q6);
Q7 = getpv('Q7', Field);
Q7c = Q7-mean(Q7);
Q8 = getpv('Q8', Field);
Q8c = Q8-mean(Q8);
Q9 = getpv('Q9', Field);
Q9c = Q9-mean(Q9);
Q10 = getpv('Q10', Field);
Q10c = Q10-mean(Q10);


figure
if MeanFlag
    subplot(5,2,1)
    bar(Q1c)
    ylabel('Q1')

    subplot(5,2,2)
    bar(Q2c)
    ylabel('Q2')

    subplot(5,2,3)
    bar(Q3c)
    ylabel('Q3')

    subplot(5,2,4)

    bar(Q4c)
    ylabel('Q4')

    subplot(5,2,5)
    bar(Q5c)
    ylabel('Q5')

    subplot(5,2,6)
    bar(Q6c)
    ylabel('Q6')

    subplot(5,2,7)
    bar(Q7c)
    ylabel('Q7')

    subplot(5,2,8)
    bar(Q8c)
    ylabel('Q8')

    subplot(5,2,9)
    bar(Q9c)
    ylabel('Q9')

    subplot(5,2,10)
    bar(Q10c)
    ylabel('Q10')

    suptitle(sprintf('Quadrupole %s values around average value for all families', Field))
else

    subplot(5,2,1)
    bar(Q1)
    ylabel('Q1')

    subplot(5,2,2)
    bar(Q2)
    ylabel('Q2')

    subplot(5,2,3)
    bar(Q3)
    ylabel('Q3')

    subplot(5,2,4)
    bar(Q4)
    ylabel('Q4')

    subplot(5,2,5)
    bar(Q5)
    ylabel('Q5')

    subplot(5,2,6)
    bar(Q6)
    ylabel('Q6')

    subplot(5,2,7)
    bar(Q7)
    ylabel('Q7')

    subplot(5,2,8)
    bar(Q8)
    ylabel('Q8')

    subplot(5,2,9)
    bar(Q9)
    ylabel('Q9')

    subplot(5,2,10)
    bar(Q10)
    ylabel('Q10')

    suptitle(sprintf('Quadrupole %s values for all families', Field))
end