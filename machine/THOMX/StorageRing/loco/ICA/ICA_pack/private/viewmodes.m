function varargout = viewmodes( dout,icom,haxes,varargin)
%plot the selected mode to current axes
%dout,    a structure containing result of icatbtrun
%icom,    mode index
%haxes,   contains 4 axes handles

	z = dout.z  ;
	s = dout.s  ;
	A = dout.A  ;
	w = dout.w  ;
	dd =dout.dd  ;
	pdK=dout.pdK ;
    offF = dout.offF;
	
	st = dout.st  ;
	wid = dout.wid  ;
	tao = dout.tao ;
	el = dout.el  ;
	datasrc = dout.datasrc ;
  	n = 1:size(s,2);
%    plotmode = 'view';

	if length(haxes)==4 %strcmp(plotmode,'view')
		%disp('view 1')
		splotdd(haxes(1),s,dd,offF,tao,datasrc,st,wid,icom);
        
      %  disp('view 2')
        splottemporal(haxes(2),s,icom);
        
		%disp('view 3')
        splotspatial(haxes(3),A,datasrc,icom);        
        
		%disp('view 4')
		splotfft(haxes(4),s,pdK,icom);
    elseif length(haxes)==1
        if nargin<4
            return
        end
        switch varargin{1}
        case {1}
            splotdd(haxes,s,dd,offF,tao,datasrc,st,wid,icom);
        case {2}
            splottemporal(haxes,s,icom);
        case {3}
            splotspatial(haxes,A,datasrc,icom); 
        case {4}
            splotfft(haxes,s,pdK,icom);
        otherwise 
            return
        end
%    elseif strcmp(plotmode,'beta')
%             subplot(2,1,1);
%             h = plot(1:length(beta),beta,'b');
%             set(h,'LineWidth',2,'Marker','o','MarkerEdgeColor','r');
%             %plot(A(1:2,betacom(1)));
%             subplot(2,1,2);
%             h = plot(1:length(psi),psi,'b');
%             set(h,'LineWidth',2,'Marker','o','MarkerEdgeColor','r');
   end %if

function splotdd(ha,s,dd,offF,tao,datasrc,st,wid,icom)
%
        axes(ha);
        set(ha,'FontSize',14);
		%set(ha,'FontSize',10);
        %h = plot(1:size(s,1),dd,'o');grid
		h = plot(1:size(s,1),dd,'o',icom,dd(icom,:),'k*');grid
		for i=1:length(h)
			set(h(i),'LineWidth',3);
		end
  %      legend(num2str(tao(1)),num2str(tao(2)),...
  %          num2str(tao(3)),num2str(tao(4)),0);
        %set(h,'MarkerFaceColor','auto');
		diagelem = ['offF:'];
        taostr = [];
		for i=1:length(tao)
			%num2str(dd(icom,i),'%4.2e')
            %diagelem = [diagelem,' ',num2str(dd(icom,i),'%4.2e')]
            diagelem = [diagelem,' ',num2str(offF(i),'%2.1e')];
            taostr = [taostr,' ',num2str(tao(i),'%1d')];
        end
%        title(sprintf('data: %s, %d:%d, \\tau=[%s]',datasrc,st,wid,taostr));
        xlabel(diagelem);
%        xlabel('Mode index i')
        ylabel('D_{ii}(\tau)')

function splottemporal(ha,s,icom)
%
		axes(ha);  
		set(ha,'FontSize',14);
		%set(ha,'FontSize',10);
        n = 1:size(s,2);
		h = plot(n, s(icom,:),'b');grid
        set(h,'LineWidth',1);
        axis([1,size(s,2),-.2,.2]);
		%title(sprintf('MODE %d, norm = %f',icom,sqrt(sum(s(icom,:).^2))));
 %       title(sprintf('MODE %d, temporal pattern',icom));
        xlabel('Turn index')
        ylabel(sprintf('s_{%d}(t)',icom))
        
function splotspatial(ha,A,datasrc,icom)
%
        axes(ha);
		set(ha,'FontSize',14);
		%set(ha,'FontSize',10);
        if strcmp(datasrc,'xy') 
            xind=1:size(A,1)/2;
            yind=xind + size(A,1)/2;
            h = plot(xind,A(xind,icom),'ro');
            set(h,'LineStyle','-','LineWidth',2,'MarkerFaceColor','r','Color','b','MarkerEdgeColor','r');
            hold on
%            h = plot(xind,A(yind,icom),xind,A(yind,icom),'mv');grid
            h = plot(xind,A(yind,icom),'mv');grid
            hold off
            set(h(1),'LineStyle','-','LineWidth',2,'MarkerFaceColor','m','Color','b','MarkerEdgeColor','m');
            set(ha,'XLim',[0,length(xind)]);
            legend('H','V',0);
        else
            %h = plot(1:size(A,1),A(:,icom),1:size(A,1),A(:,icom),'ro');grid
            %set(h(1),'LineWidth',1.5);
            %set(h(2),'LineWidth',2,'MarkerFaceColor','r');
            h = plot(1:size(A,1),A(:,icom),'ro');grid
            set(h(1),'LineStyle','-','LineWidth',2,'MarkerFaceColor','r','Color','b','MarkerEdgeColor','m');
            set(ha,'XLim',[0,size(A,1)]);
        end
        %axis([1,size(A,1),-5,5]);
%        title('amplitude at BPMs');
%        xlabel('red = H, magenta = V: 1=l01, 2=s01, etc');
        xlabel('BPM index')
        ylabel(sprintf('A_{%d}',icom));

function splotfft(ha,s,pdK,icom)
%
        axes(ha);
		set(ha,'FontSize',14);
		%set(ha,'FontSize',10);
		fq = fft(s(icom,:));
		len = floor(size(s,2)/2);
   		%h = plot(1.-(1:len)/len/2.,abs(fq(1:len)),'b');hold on
   		h = plot((1:len)/len/2.,abs(fq(1:len)),'b');hold on
        set(h,'LineWidth',1);
%        title('FFT of temporal pattern');
       % axis([0.5,1.0,0.,150.]);
    	
	  
% 	   [peak_v,peak_pos,peak_width] = peakdetect(abs(fq), 1,len,pdK);
% 		if length(peak_v) > 6
% 			[speak_v, speak_indx]=sort(peak_v);
% 			peakindx= speak_indx(1:length(peak_v)-6) ;
% 			peak_v(peakindx) = [];
% 			peak_pos(peakindx) = [];
% 			peak_width(peakindx) = [];
% 		end
%     	plot(1.-peak_pos/len/2.,peak_v,'ro');hold off
% 		tune = [];
%     	for i=length(peak_v):-1:1
%        	 	tune = [tune,'  ',num2str(1.-peak_pos(i-1)/size(s,2))];
%         end
%     	xlabel(tune);grid
		
		[c,f,ns] = ipfa(s(icom,:),1,0.00005);
		[sf,sindx]=sort(f);
		
		N = size(s,2);
		sfv = zeros(size(f));
		for i=1:length(f)
			tn = f(i)*N + 1;
			if abs(fq(floor(tn))) >= abs(fq(ceil(tn)))
				sfv(i) = abs(fq(floor(tn)));
			else
				sfv(i) = abs(fq(ceil(tn)));
			end
		end
		%h2=plot(1-f,sfv,'ro');hold off
		h2=plot(f,sfv,'ro');hold off
        set(h2,'LineWidth',2);
		tune = [];
		for i=length(sf):-1:1
			tune=[tune,'  ',num2str(sf(i),'%6.5f')];
		end
		xlabel(tune);grid
        %set(ha,'XLim',[0.5,1.0],'XTick',[0.5:0.1:1.0]);
	set(ha,'XLim',[0, 0.5],'XTick',[0.:0.1:.5]);        