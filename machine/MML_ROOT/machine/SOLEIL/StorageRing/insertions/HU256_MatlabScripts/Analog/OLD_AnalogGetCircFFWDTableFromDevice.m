function [CVE, CHE, CVS, CHS]=AnalogGetCircFFWDTableFromDevice(HU256Cell, Corrector, PlotType)
    BXCurrents=0:25:275;
    for i=1:length(BXCurrents)  % BX0, BX25, etc...
        BXCurrent=BXCurrents(i);
        if (i==1)
            [TempFFWDTable, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, num2str(BXCurrent));
        else
            TempFFWDTable=AnalogGetFFWDTableFromDevice(HU256Cell, num2str(BXCurrent));
        end
        if (i==1)
            CVE=ones(length(BXCurrents),size(TempFFWDTable, 2));
            CHE=ones(length(BXCurrents),size(TempFFWDTable, 2));
            CVS=ones(length(BXCurrents),size(TempFFWDTable, 2));
            CHS=ones(length(BXCurrents),size(TempFFWDTable, 2));
            CVE(:, :)=nan;
            CHE(:, :)=nan;
            CVS(:, :)=nan;
            CHS(:, :)=nan;
            if (strcmp(PlotType, 'Current'))
                xVect=TempFFWDTable(1, :);
            elseif (strcmp(PlotType, 'Point'))
                xVect=1:size(TempFFWDTable, 2);
            end
        end
        for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
            TempName=PowerSupplies{j};
            if (strncmp(TempName, 'CVE', 3))
                CVE(i, :)=TempFFWDTable(j, :);
            elseif (strncmp(TempName, 'CHE', 3))
                CHE(i, :)=TempFFWDTable(j, :);
            elseif (strncmp(TempName, 'CVS', 3))
                CVS(i, :)=TempFFWDTable(j, :);
            elseif (strncmp(TempName, 'CHS', 3))
                CHS(i, :)=TempFFWDTable(j, :);
            end
        end
    end
    if (~isempty(Corrector))
        if (strncmp(Corrector, 'CVE', 3))
           Corrector=CVE;
        elseif (strncmp(Corrector, 'CHE', 3))
           Corrector=CHE;
        elseif (strncmp(Corrector, 'CVS', 3))
           Corrector=CVS;
        elseif (strncmp(Corrector, 'CHS', 3))
           Corrector=CHS;
        end
        yVect=BXCurrents;
        %[yVect, xVect]=meshgrid(yVect, xVect);
        [xVect, yVect]=meshgrid(xVect, yVect);
        surfl(xVect,yVect,Corrector)
    end
    return
end