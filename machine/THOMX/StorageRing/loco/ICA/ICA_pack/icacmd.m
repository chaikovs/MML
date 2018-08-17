function varargout = icacmd(cmd,varargin)
%varargout = icacmd(cmd,varargin)
%cmd	command
%='run', varargin={data,method,st,wid,tao,el,[preprocess]}
%	or   varargin={data,para}, para contains the parameters listed below except data
%		data   a nxN matrix containing raw data
%		method = 'ICA' | 'PCA'
%		st, integer
%		wid,
%		tao,
%		el, 
%		preprocess = 'zero mean' | 'l...' | 
%	varargout = dout
%='print'	print the 4 plots of a mode to EPS
%		varargin = {dout, datasrc, icom}
%		dout = the output of icacmd('run',...)
%		datasrc, a string for filename
%		icom, the component to be printed
%='export'  save given modes to MAT or TXT
%		varargin = { dout, pickup, filename,opt}
%		pickup = selected modes, e.g. [1 2 3 5]
%		filename, the file to be created, the extension will be what 'opt' specifies
%		opt = 'MAT' | 'TXT', by default 'MAT'
%='pair'   find the paired modes automatically
%		dout = varargin{1};      dout is the output when cmd='run'
%		[lowlist, pairlist] = pairmodes(dout);
%		varargout{1} = lowlist;	
%		varargout{2} = pairlist;	mx2, each row has two numbers indicating the paired mode indices
%


switch(cmd)
case 'run'
	if nargin == 3
		data = varargin{1};
		para = varargin{2};
		method = para.method;
		st  = para.st;
		wid = para.wid;
		tao = para.tao;
		el = para.el;
		preprocess = para.preprocess;
	else
		if nargin < 7
			disp('not enough arguments')
			return
		end
		data = varargin{1};
		method = varargin{2};
		st = varargin{3};
		wid= varargin{4};
		tao= varargin{5};
		el = varargin{6};
		if nargin >=8 
			preprocess = varargin{7};
		else
			preprocess = 'zero mean';
		end
	
	end
	dout = icarun(data, method,st,wid,tao,el,preprocess,varargin);
	varargout{1} = dout;
		
case 'print'
	if nargin<4
		disp('not enough arguments')
		return
	end
	dout = varargin{1};
	datasrc = varargin{2};
	icom  = varargin{3};
	icaprint(dout,datasrc,icom);

case 'export'
	if nargin<4
		disp('not enough arguments')
		return
	end
	dout = varargin{1};
	pickup = varargin{2};
	filename = varargin{3};
	icaexport(dout, pickup, filename,varargin{4:end});
	
case 'pair'
	dout = varargin{1};
	[lowlist, pairlist] = pairmodes(dout);
	
	varargout{1} = lowlist;
	varargout{2} = pairlist;
	
end

function icaexport(dout, pickup, filename,varargin)
%
opt = 'mat';
if nargin>=4
	opt = varargin{1};
end
usedata = '';
if nargin>=5
	usedata = varargin{2};
end
if length(filename) < 2
	filename = 'temp';
end

	data.s = dout.s(pickup,:);
	data.A = dout.A(:,pickup);
	data.usedata = usedata;

	para.st = dout.st;
	para.wid = dout.wid;
	para.el = dout.el;
	para.datasrc = dout.datasrc;
	para.tao = dout.tao;
	para.action = dout.action;
	
switch opt
case 'mat'
	eval(['save ' filename ' data para pickup']);
	
case 'txt'
	paralist = [para.st,para.wid,para.el,para.action];
	%sprintf('st %d; wid %d; el %f; action %d\n tau',para.st,para.wid,para.el,para.action);
	tau = para.tao;
	s = data.s;
	A = data.A;
	linebreak = 'source';
	eval(['save ' filename '.txt paralist tau A s -ascii']);

end

function icaprint(dout,datasrc,icom,varargin)
%
set(0,'DefaultFigurePaperUnits', 'inches')
set(0,'DefaultFigurePaperType', 'usletter') %11.00 X 8.5 inch
set(0,'DefaultFigurePaperOrientation', 'landscape')

filename = [datasrc '_' num2str(icom)];

for i=1:4
	hf = figure;
	set(hf,'Visible','off');
	ha = axes;%('position',[0,0,.8,.8]);

    viewmodes( dout,icom,ha,i);
    set(hf,'Visible','off','PaperUnits','inch');
    exportfig(hf,[filename,'_',num2str(i),'.eps'],'Color','rgb','Width',10.5,'Height',8.0,...
		'FontMode','fixed','FontSize',20,'LineWidth',4);
	delete(hf)
end


function dout = icarun(data, method,st,wid,tao,el,preprocess,varargin)
%
%el   = 
%preprocess = 
	%'zero mean'
	%'lo 10 c0.1'
	%'lo 40 c0.1'
	%'hi 10 c0.1'
	%'hi 40 c0.1'

switch method
case 'ICA'
	action = 5; %4 = jg amuse, 5=sobi, 6=seons,, 7 = ac-dc, 8= PCA, 9=ICAtest
case 'PCA'
	action = 8;
end	
if st + wid + max(tao) -1 > size(data,2) | st<1
	disp('exceeding data limits');
	return
end

ndata = icapreprocess(data, st,wid,tao,preprocess);
dout = icatbtrun(ndata,action,st,wid,tao,el,preprocess);

function [lowlist, pairlist] = pairmodes(dout,varargin)
%pl = pairmodes(dout)
%find and pair the modes with phases at different locations, such as betatron modes
%lowlist   , the list of modes with low frequencies (assume tau = [1 2 3 4] )
%pairlist,   each row is a pair of paried modes
%

flist = 1:size(dout.s, 1);
lowlist = [];
pairlist = [];

dc_threshold = 0.99;
if nargin >= 2
	dc_threshold = varargin{1};
end

for i=1:length(flist)
	if std(dout.dd(i,:)) < 0.1
		lowlist = [lowlist,i];
	else
		res = ispeaked(dout.s(i,:),0.3);
		if res == 0 %not peaked
			lowlist = [lowlist,i];
		end
	end	
end

if ~isempty(lowlist)
	flist(lowlist) = [];
end

while length(flist) >=2
	i = flist(1);
	for jf=2:length(flist)
		j = flist(jf);
		dc = dout.dd(i,:)*dout.dd(j,:)'/norm(dout.dd(i,:))/norm(dout.dd(j,:));
		if dc > dc_threshold
			pairlist = [pairlist; i,j];	
			flist(jf) = [];
			break
		end
	end
	flist(1) = [];	
end

