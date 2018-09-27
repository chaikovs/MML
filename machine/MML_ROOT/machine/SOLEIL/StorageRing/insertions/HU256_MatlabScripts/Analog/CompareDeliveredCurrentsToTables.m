function [BX1, BX2, BZP, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab]=CompareDeliveredCurrentsToTables(HU256Cell, Mode, UpOrDown, Display)
%% Description
% 1) Reads currents delivered by power supplies
% 2) Gets currents from tables according to inputs
% 3) Summarises Values of currents from tables and those measured from power
% supplies.
% INPUTS : 
% HU256Cell : 4, 12 or 15
% Mode : 'LH', 'LV', 'AH', 'AV', 'Circ' or 'CircBX' (respectively BZP or
% BX1 for main power supply)
% UpOrDown : -1, 0 or 1 (Down, not moving, Up of main power supply). If
% zero => a down movement is searched.
% Display : 0 or 1
%% Read currents delivered by power supplies
    Structure=GetDeliveredCurrents(HU256Cell);
    Currents=Structure.Currents;
    Names=Structure.Names;
%     ModeStr=Structure.Mode;
    for i=1:length(Currents)
        Value=Currents(i);
        Name=Names(i);
        if strcmp(Name, 'BX1')
            BX1=Value;
        elseif strcmp(Name, 'BX2')
            BX2=Value;
        elseif strcmp(Name, 'BZP')
            BZP=Value;
        elseif strcmp(Name, 'CVE')
            CVE=Value;
        elseif strcmp(Name, 'CHE')
            CHE=Value;
        elseif strcmp(Name, 'CVS')
            CVS=Value;
        elseif strcmp(Name, 'CHS')
            CHS=Value;
        end
    end

%% Check mode and UpOrDown
    if ~strcmp(Mode, 'LH')&&~strcmp(Mode, 'LV')&&~strcmp(Mode, 'AH')&&~strcmp(Mode, 'AV')&&~strncmp(Mode, 'Circ', 4)
        fprintf ('CompareDeliveredCurrentsToTables : ''%s'' is not a valide mode.\n', Mode)
        return
    end
    if UpOrDown==1
        UpOrDownString='U';
    elseif UpOrDown==-1
        UpOrDownString='D';
    else
        UpOrDownString='?';
        UpOrDown=-1;
    end
    if strncmp(Mode, 'Circ', 4)
        if strcmp(Mode, 'Circ')
            BZPCurrent=BZP;
            BX1UpOrDown=0;
            BZPUpOrDown=UpOrDown;
        elseif strcmp(Mode, 'CircBX')
            Mode='Circ';
            BZPCurrent='BX';
            BX1UpOrDown=0;
            BZPUpOrDown=UpOrDown;
        else
            fprintf ('CompareDeliveredCurrentsToTables : ''%s'' is not a valide mode.\n', Mode)
            return
        end
    else
        BZPCurrent=BZP;
        if strcmp(Mode, 'LH')||strcmp(Mode, 'AH')
            BX1UpOrDown=0;
            BZPUpOrDown=UpOrDown;
        elseif strcmp(Mode, 'LV')||strcmp(Mode, 'AV')
            BX1UpOrDown=UpOrDown;
            BZPUpOrDown=0;
        end
    end
    
%% Get currents from tables
    [CVE_tab, CHE_tab, CVS_tab, CHS_tab]=AnalogGetCurrentsFromDevice(HU256Cell, BX1, BZPCurrent, UpOrDown, Mode);
%     Cell=cell(5, 5);
    Table=[CVE_tab, CHE_tab, CVS_tab, CHS_tab];
    
%% Compare delivered and theoric currents
    Meas=[CVE, CHE, CVS, CHS];
    Delta=abs(Meas)-abs(Table);
    DeltaRel=Delta./abs(Table)*100;

%     Cell={'Name:', 'CVE', 'CHE', 'CVS', 'CHS'; 'Table:', CVE_tab, CHE_tab, CVS_tab, CHS_tab; 'Meas:', CVE, CHE, CVS, CHS; 'Delta', 0, 0, 0, 0; 'DeltaRel', 0, 0, 0, 0};
%     for i=1:4
%         Cell{4, i+1}=Delta(i);
%     end
%     for i=1:4
%         Cell{5, i+1}=DeltaRel(i);
%     end
    DeltaRel(DeltaRel>100)=Inf;
    
    
%     res.Cell=Cell;
%     res.Text='';
    
%     MainPsString=sprintf('BX1 : %3.3f\nBZP : %3.3f (%s)\n', BX1, BZP,
%     BZPUpOrDownString)
    if BX1UpOrDown==-1
        BX1UpOrDownString='D';
    elseif BX1UpOrDown==1
        BX1UpOrDownString='U';
    elseif BX1UpOrDown==0
        BX1UpOrDownString='?';
    end
    if BZPUpOrDown==-1
        BZPUpOrDownString='D';
    elseif BZPUpOrDown==1
        BZPUpOrDownString='U';
    elseif BZPUpOrDown==0
        BZPUpOrDownString='?';
    end
    
%% Display text 
    if Display
        fprintf ('\n=====================================\n')
        fprintf ('BX1 : %3.3f (%s)\nBZP : %3.3f (%s)\n', BX1, BX1UpOrDownString, BZP, BZPUpOrDownString)
        fprintf ('\t\t  CVE  \t  CHE  \t  CVS  \t  CHS  \n')
        fprintf ('Tables:\t\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', CVE_tab, CHE_tab, CVS_tab, CHS_tab)
        fprintf ('Mesures:\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', Meas(:))
        fprintf ('Deltas:\t\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', Delta(:))
        fprintf ('Err(%%):\t\t%7.1f\t%7.1f\t%7.1f\t%7.1f\n', DeltaRel(:))

    end
    %disp(Cell);
    return
end