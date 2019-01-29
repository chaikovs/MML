function [ ExpSim_Filters ] = bpm_tbt_filter_generation( varargin )
% bpm_tbt_filter_generation Generate experimental filters and simulated filter
%==========================================================================
%
% USE :
% -----
%
% This function will use the signals after 'Structure'/'FileName' to create
% experimental filters where the length is 'NumberOfPoints'. Then the
% function will generate a simulated signal that will generate a simulated
% filter, depending on the 'Padding'.
%
% IMPORTANT : The 'Structure'/'FileName' is the output of GETBPMRAWDATA function
%
%
% SYNTAX(general form) :
% -----------------------
%
% [ ExpSim_Filters ] = bpm_tbt_filter_generation(
%                                       'Structure', bpm_data, // 'FileName', bpm_data(.mat),
%                                       'NumberOfPoints', 10,
%                                       'Padding', 10,
%                                       'Display' // 'NoDisplay
%                                     )
%
% Next parameter after 'Structure', 'FileName', 'NumberOfPoints', 'Padding' has be the
% corresponding value.
%
%
% DEFAULT VALUES :
% ................
%
%   - FileName = �Imp_Resp_1_20.mat�
%   - NumberOfPoints = 5
%   - Padding = 5
%
%==========================================================================
%
% See also getbpmrawdata, bpm_tbt_demixing


% Written by  B. Beranger, Master 2013

%% Check input arguments

% Default values and flags
ProblemDetectionFlag = 0;
DisplayFlag   = 0;
StructureFlag = 0;
FileName = 'Imp_Resp_1_20.mat';
NumberOfPoints = 5;
Padding = 5;

% Checking varargin
for i = length(varargin):-1:1
    
    if strcmpi(varargin{i},'NumberOfPoints')
        if length(varargin) > i
            % Look for the number of points as the next input
            if isnumeric(varargin{i+1})
                NumberOfPoints = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'Padding')
        if length(varargin) > i
            % Look for the padding as the next input
            if isnumeric(varargin{i+1})
                Padding = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'Structure')
        if length(varargin) > i
            % Look for the structure as the next input
            if isstruct(varargin{i+1})
                Structure = varargin{i+1};
                StructureFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'FileName')
        if length(varargin) > i
            % Look for the file name as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                StructureFlag = 0;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
        
    end
    
end

if ~isempty(varargin)
    disp('Last parameter(s) not recognised :')
    disp(varargin)
    error('Unknown parameter(s) detected')
end


%% Echo of all parameters used

if ProblemDetectionFlag == 0;
    fprintf('\nNo parameter problem detected \n');
end

fprintf('\nParameters used : \n')
fprintf(' - Number Of Points : %d \n',NumberOfPoints)
fprintf(' - Padding          : %d \n',Padding);
if StructureFlag == 0
    fprintf(' - FileName         : %s \n',FileName);
elseif StructureFlag == 1
    fprintf(' - Structure        : Parameter of function \n');
end

if DisplayFlag == 0;
    DisplayText = 'Off';
elseif DisplayFlag == 1;
    DisplayText = 'On';
end
fprintf(' - Display          : %s \n', DisplayText);


%% Using the input structure OR loading a default .mat file

if StructureFlag == 0
    
    % --- Avoiding extension '.mat' problem in FileName argument ---
    if isscalar(regexp(FileName,'.mat')) == 1
        FileName = FileName(1:end-4);
    end
    
    % --- Loading the structure from the '.mat' file ---
    eval(['load ' FileName ';']);
    eval(['Structure = ' FileName ';']);
    
end

NumberOfBPM = size(Structure.Imp_Resp_1.Data.Sum,1);


% Initialisation of matrix containing the filters
Filter_exp = zeros(NumberOfBPM,2*NumberOfPoints+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% EssaiVector was spacialy adapted for Imp_Resp_1_20.mat because
% Imp_Resp_17 and Imp_Resp_18 inside are wrong

% Usually EssaiVector contains all essai number

%LSN TO  BE MODIFY Total a data set
EssaiVector = [1:11];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Generation of filters from the experimental responce

for Bpm = 1:NumberOfBPM
    
    S = 0;
    for j = EssaiVector
        S = S + Structure.(genvarname(['Imp_Resp_' num2str(j)])).Data.Sum(Bpm,:);
    end
    
    % --- Assignment for experimental impulse responce ---
    Filter_exp_tempo = S/length(EssaiVector);                                                  % Assignment of dynamic name from each BPM to the average of N signals
    Filter_exp_tempo = Cut_far_from_MAX( Filter_exp_tempo , NumberOfPoints );
    Filter_exp_tempo = Cut_far_from_MAX( Filter_exp_tempo , NumberOfPoints ); % Cut of signals
    
    
    % --- Vertical translation of the averaged signal  ---
    % Each averaged signals for the BPM will be transformed in order to have the start of the spike at zero
    [~,MAX_place] = max( Filter_exp_tempo );
    Filter_exp_tempo = Filter_exp_tempo - Filter_exp_tempo (MAX_place - 2);
    
    
    % --- FFT ---
    L = length( Filter_exp_tempo );                          % Number of point in the signal
    NFFT = 2^nextpow2(L);                                    % Next power of 2 from the signal length
    FFT_Filter_exp_tempo = fft( Filter_exp_tempo , NFFT )/L; % FFT
    
    
    % --- FFT normalisation ---
    FFT_Filter_exp_tempo  = FFT_Filter_exp_tempo /abs(FFT_Filter_exp_tempo(1));
    
    
    % --- Inverse of the normalised FFT ---
    inv_Filter_exp_tempo  = 1./FFT_Filter_exp_tempo ;
    
    
    % --- IFFT ---
    IFFT_Filter_exp_tempo = ifft(inv_Filter_exp_tempo );
    
    
    % --- Reducing the size of Filters ---
    % Using Cut_exp_filter means there is not enough points on the right of
    % the signal to obtain the same amount of points on both side of the maximum.
    Filter_Filter_exp_tempo = Cut_exp_filter( IFFT_Filter_exp_tempo , NumberOfPoints );
    
    
    % --- Gathering experimental filters ---
    Filter_exp(Bpm,:) = Filter_Filter_exp_tempo ;
    
    
end



%--------------------------------------------------------------------------
%% Generation of impulse responce depending of the fill and the offcet

IR = ddc_sim_SOLEIL(1/416,0.61);


%% Generation of filters depending on the padding

% Filling the IR depending on the padding
Filter_sim_tempo = [zeros(1,Padding) IR zeros(1,Padding)];


% --- FFT ---
L = length( Filter_sim_tempo );                         % Number of points of the signal
NFFT = 2^nextpow2(L);                                   % Next power of two from the signal points
FFT_Filter_sim_tempo =fft( Filter_sim_tempo , NFFT )/L; % FFT
F_ADC = 109*1e6;
f = F_ADC/2*linspace(0,1,NFFT/2+1);

% --- FFT normalisation ---
normalized_FFT_Filter_sim_tempo  = FFT_Filter_sim_tempo/abs(FFT_Filter_sim_tempo(1));


% --- Inverse of normalised FFT ---
inv_Filter_sim_tempo  = 1./normalized_FFT_Filter_sim_tempo ;


% --- IFFT ---
IFFT_Filter_sim_tempo = ifft( inv_Filter_sim_tempo );


% --- Reducing the size of Filters ---
Filter_Filter_sim_tempo  = Cut_far_from_MAX( IFFT_Filter_sim_tempo , NumberOfPoints );


% --- Gathering experimental filters ---
Filter_sim = Filter_Filter_sim_tempo ;



%% Plot

if DisplayFlag == 1
    
    LineWidth = 2;
    FontSize = 20;
    
    % Display of the Impulse Response of BPM electronic
    figure('Name','Imp_Resp Sum for one BPM','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot(Structure.(genvarname(['Imp_Resp_' num2str(j)])).Data.Sum(50,:),'LineWidth',LineWidth);
    xlabel('Turn','FontSize',FontSize)
    ylabel('Experimental Impulse Response','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    RemoveMarge
    axis tight
    xlim([0 15])
    
    % Display of the Simulated Impulse Response
    figure('Name','Imp_Resp Sum for one BPM','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot(Filter_sim_tempo,'LineWidth',LineWidth);
    xlabel('Turn','FontSize',FontSize)
    ylabel('Sumulated Impulse Response','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    RemoveMarge
    axis tight
    
    % Display of the FFT of Impulse Response
    figure('Name','FFT_Filter_sim_tempo','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot(f,2*abs(FFT_Filter_sim_tempo(1:NFFT/2+1)),'LineWidth',LineWidth);
    xlabel('Frequency (Hz)','FontSize',FontSize)
    ylabel('| FFT( RI ) |','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    RemoveMarge
    axis tight
    
    % Display of the Normalized FFT(RI)
    figure('Name','FFT_Filter_sim_tempo','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot(f,abs(normalized_FFT_Filter_sim_tempo(1:NFFT/2+1)),'LineWidth',LineWidth);
    xlabel('Frequency (Hz)','FontSize',FontSize)
    ylabel('Normalized | FFT( RI ) |','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    RemoveMarge
    axis tight
    
    % Display of the 1 / Normalized FFT(RI)
    figure('Name','FFT_Filter_sim_tempo','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot(f,abs(inv_Filter_sim_tempo(1:NFFT/2+1)),'LineWidth',LineWidth);
    xlabel('Frequency (Hz)','FontSize',FontSize)
    ylabel('1 / Normalized FFT(RI)','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    RemoveMarge
    axis tight
    
    % Display of experimental filters
    figure('Name','Experimental filter','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot(Filter_exp(50,:),'LineWidth',LineWidth);
    xlabel('Turn','FontSize',FontSize)
    ylabel('Experimental Filter = IFFT( 1 / Normalized FFT(RI) )','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    RemoveMarge
    axis tight
    
    % Display of simulated filter
    figure('Name','Simulated filter','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    plot(Filter_sim,'LineWidth',LineWidth)
    xlabel('Turn','FontSize',FontSize)
    ylabel('Simulated Filter','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    RemoveMarge
    axis tight
    
end


%% Exporting experimental and simulated filters in a structure


ExpSim_Filters = struct;
ExpSim_Filters.DeviceName = Structure.Imp_Resp_1.DeviceName;
ExpSim_Filters.DeviceList = Structure.Imp_Resp_1.DeviceList;
ExpSim_Filters.DeviceExperimentalFilters = Filter_exp;
ExpSim_Filters.SimulatedFilter = Filter_sim;
ExpSim_Filters.NumberOfPoints = NumberOfPoints;
ExpSim_Filters.Padding = Padding;
ExpSim_Filters.CreatedBy = mfilename;
ExpSim_Filters.TimeStamp = datestr(now);
ExpSim_Filters.DataDescriptor = 'Experimental filters (1 per BPM) and Simulated filters for TbT data';


%% End of function

fprintf('\n === Done === \n\n');

end





%%-------------------------------------------------------------------------
%% Other functions

% Used to cut the experimental filter from the end instead of the maximum.
% There is not enough points on the right of the signal to obtain the same
% amount of points on both side of the maximum.
function [ OutputFilter ] = Cut_exp_filter( InputFilter, NumberOfPoints )

if length(InputFilter) <= 2*NumberOfPoints
    error('There is not enough points on the raw filter to obtain cut filter which as the sime size than the original cut signal. Try to reduce NumberOfPoints.');
end

OutputFilter = InputFilter(end-(2*NumberOfPoints):end);

end

function [ OutputVector ] = Cut_far_from_MAX( InputVector, NumberOfPoints )

[~,MAX_place] = max(InputVector);

while (MAX_place - NumberOfPoints)<=0 || (MAX_place + NumberOfPoints)>length(InputVector)
    
    NumberOfPoints = NumberOfPoints - 1;
    %     disp('The number of points on both sides as been reduced to obtain a symetric filter.');
    
end

OutputVector = InputVector((MAX_place - NumberOfPoints):(MAX_place + NumberOfPoints));

end
