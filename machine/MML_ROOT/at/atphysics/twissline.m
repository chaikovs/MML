function [TD, varargout] = twissline(LINE,DP,TWISSDATAIN,varargin);
%TWISSLINE calculates linear optics functions for an UNCOUPLED transport line
% 
% TwissData  = TWISSLINE(LATTICE,DP,TWISSDATAIN) propagates twiss
%    parameters and closed orbit coordinates from the LINE entrance
%    given by TWISSDATAIN assuming constant energy deviation DP.
%    TWISSDATAIN is a 1-by-1 structure with the same field names
%    as the return argument. (See below)
%    !!! IMPORTANT: Since  TWISSLINE does not search for closed orbit
%    its value at the entrance must be supplied in the 
%    ClosedOrbit field of TWISSDATAIN structure. 
%
% TwissData  = TWISSLINE(LATTICE,DP,TWISSDATAIN,REFPTS) calculates Twiss parameters
%    and closed orbit coordinates at specified reference points REFPTS
%
%    Note: REFPTS is an array of increasing indexes that  
%    select elements from range 1 to length(LATTICE)+1. 
%    See further explanation of REFPTS in the 'help' for FINDSPOS 
%
% TwissData  = TWISSLINE(...,'chrom', DDP) also calculates
%    linear dispersion. Dispersion is returned as one 
%    of the fields in TwissData.
%    !!! Last argument DDP is a momentum deviation on top
%    of DP (the second argument) used to calculate and normalize
%    dispersion. If not supplied
%    the default value of 1e-8 is used.
%
% TwisData is a 1-by-REFPTS (1-by-1 if no REFPTS specified) structure array with fields:
%       ElemIndex   - integer (element number) in the LINE 
%       SPos        - longitudinal position [m]
%       ClosedOrbit - closed orbit column vector with 
%                     components x, px, y, py (momentums, NOT angles)						
%       Dispersion  - dispersion orbit position 4-by-1 vector with 
%                     components [eta_x, eta_prime_x, eta_y, eta_prime_y]'
%                     calculated with respect to the closed orbit with 
%                     momentum deviation DP
%       M44         - 4x4 transfer matrix M from the beginning of LINE
%                     to the entrance of the element for specified DP [2]
%       beta        - [betax, betay] horizontal and vertical Twiss parameter beta
%       alpha       - [alphax, alphay] horizontal and vertical Twiss parameter alpha
%       mu          - [mux, muy] horizontal and vertical betatron phase
%                     !!! NOT 2*PI normalized
% 
% Use CAT to get the data from fields of TwissData into MATLAB arrays.
%     Example: 
%     >> twissdatain.ElemIndex=1;
%     >> twissdatain.SPos=0;
%     >> twissdatain.ClosedOrbit=zeros(4,1);
%     >> twissdatain.M44=eye(4);
%     >> twissdatain.beta= [8.1 8.1];
%     >> twissdatain.alpha= [0 0];
%     >> twissdatain.mu= [0 0];
%     >> TD=twissline(THERING,0.0,twissdatain,1:length(THERING));
%     >> BETA = cat(1,TD.beta);
%     >> S = cat(1,TD.SPos);
%     >> plot(S,BETA(:,1))
%  
% See also TWISSRING, LINOPT, TUNECHROM.

% Laurent S. Nadolski, July, 9th 2004
% Correction bug dipersion computation

DDP_default = 1e-8;
NE = length(LINE); % Number of elements

% Process input arguments
switch nargin
case 3
    REFPTS = NE+1;
    CHROMFLAG = 0;
case 4 
    if isnumeric(varargin{1})
        REFPTS    = varargin{1};
        CHROMFLAG = 0;
    elseif ischar(varargin{1}) & strncmp(lower(varargin{1}),'chrom',5)
        CHROMFLAG = 1;
        REFPTS    = NE+1;
        DDP       = DDP_default;
    else
        error('Third argument must be a numeric array or string');
    end
case 5
    if isnumeric(varargin{1})
        REFPTS = varargin{1};
        if ischar(varargin{2}) & strncmp(lower(varargin{2}),'chrom',5)
            CHROMFLAG = 1;
            DDP       = DDP_default;
        else
            error('Fourth argument - wrong type');
        end
    elseif ischar(varargin{1}) & strncmp(lower(varargin{1}),'chrom',5)
        CHROMFLAG = 1;
        REFPTS = NE+1;
        if isnumeric(varargin{2})
            DDP = varargin{2};
        else
            error('Fourth argument - wrong type');
        end
    end
case 6
    if isnumeric(varargin{1})
        REFPTS = varargin{1};
    else
        error('Fourth argument - wrong type');
    end
    if ischar(varargin{2}) & strncmp(lower(varargin{2}),'chrom',5)
         CHROMFLAG = 1;
    else
         error('Fifth argument - wrong type');
    end
    if isnumeric(varargin{3})
        DDP = varargin{3};
    else
        error('Sixth argument - wrong type');
    end
otherwise
    error('Wrong number of arguments');
end

%% retrieve twiss function at the line entrance
if isfield(TWISSDATAIN,'alpha')
    ax = TWISSDATAIN(end).alpha(1);
    ay = TWISSDATAIN(end).alpha(2);
else
    error('TWISSDATAIN structure does not have field ''alpha''');
end

if isfield(TWISSDATAIN,'beta')
    bx = TWISSDATAIN(end).beta(1);
    by = TWISSDATAIN(end).beta(2);
else
    error('TWISSDATAIN structure does not have field ''beta''');
end

if isfield(TWISSDATAIN,'mu')
    mux = TWISSDATAIN(end).mu(1);
    muy = TWISSDATAIN(end).mu(2);
else
    error('TWISSDATAIN structure does not have field ''mu''');
end

%% Starting orbit is the user defined closed orbit at the line entrance
R0 = [TWISSDATAIN(end).ClosedOrbit;DP;0];

[M44, MS, orb] = findm44(LINE,DP,REFPTS,R0);

%% Betafunction
BX = squeeze((MS(1,1,:)*bx-MS(1,2,:)*ax).^2 + MS(1,2,:).^2)/bx;
BY = squeeze((MS(3,3,:)*by-MS(3,4,:)*ay).^2 + MS(3,4,:).^2)/by;

%% Alpha functions
AX = -squeeze((MS(1,1,:)*bx-MS(1,2,:)*ax).*(MS(2,1,:)*bx-MS(2,2,:)*ax) + ...
    MS(1,2,:).*MS(2,2,:))/bx;
AY = -squeeze((MS(3,3,:)*by-MS(3,4,:)*ay).*(MS(4,3,:)*by-MS(4,4,:)*ay) + ...
    MS(3,4,:).*MS(4,4,:))/by;

%% Phase advance function
MX = atan(squeeze(MS(1,2,:)./(MS(1,1,:)*bx-MS(1,2,:)*ax)));
MY = atan(squeeze(MS(3,4,:)./(MS(3,3,:)*by-MS(3,4,:)*ay)));

MX = BetatronPhaseUnwrap(MX);
MY = BetatronPhaseUnwrap(MY);

TD = struct('ElemIndex',num2cell(REFPTS),...
    'SPos',num2cell(findspos(LINE,REFPTS)),...
    'ClosedOrbit',num2cell(orb,1),...
    'M44', squeeze(num2cell(MS,[1 2]))',...
    'beta', num2cell([BX,BY],2)',...
    'alpha', num2cell([AX,AY],2)',...
    'mu', num2cell([MX,MY],2)');

if CHROMFLAG
%     TD_DDP = twissring(LINE,DP+DDP,REFPTS);
%     DORBIT = reshape(cat(1,TD_DDP.ClosedOrbit),4,[]);
    R0 = [(TWISSDATAIN(end).ClosedOrbit + TWISSDATAIN(end).Dispersion*(DP+DDP));DP;0];
    [M44, MS, orb1] = findm44(LINE,(DP+DDP),REFPTS,R0);
    DISPERSION = num2cell((orb1-orb)/DDP,1);
    [TD.Dispersion] = deal( DISPERSION{:});
end

function UP = BetatronPhaseUnwrap(P)
% unwrap negative jumps in betatron
    DP = diff(P);
    JUMPS = [0; diff(P)] < 0;
    UP = P+cumsum(JUMPS)*pi;