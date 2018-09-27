function randnum = randncut(varargin)
% RANDNCUT - Generate a random distribution using matlab randn but with
% cutoff
%
%  INPUTS
% 1. standard argument for randn
% 2. If 'CutOff' take next value for CutOffThreshold (3 sigma per defaults)
%

CuttOffFlag = 1;
CutOffThreshold = 3;

% Look for flags
for i = length(varargin):-1:1
    if ischar(varargin{i})
        if strcmpi(varargin{i}, 'CutOff')
            varargin(i) = [];
            CutOffThreshold = varargin{i};
            varargin(i) = [];
        end
    end
end

randnum = randn(varargin{:});
sigma = 1;

if CuttOffFlag
    ind = find(abs(randnum) > CutOffThreshold*sigma);
    while ~isempty(ind)
        randnum(ind) = sigma*randn(1,length(ind));
        ind = find(abs(randnum) > CutOffThreshold*sigma);
    end
end