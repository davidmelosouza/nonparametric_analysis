function [hi] = stage23(x,h1,h,R,nPoint,alpha,deriv_mode,smooth_mode,enable_stage2,enable_stage3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EX: hf = stage23(DATA,href,h,R,nPoint,alpha,'KDE','PROB','ON','ON');
% EX: hf = stage23(DATA,href,h,R,nPoint,alpha,'DIFF','BOTH','OFF','OFF');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
doPlot = 0;
[Xpdf,pdf] = KDEfast_fixed(x,h1,nPoint); %PDF da referência;
% [pdf,Xpdf] = ssvkernel(x);
% [Xpdf,pdf] = ashN(x,10,'linear',Rudemo(x));
% hmi = min(diff(x));[hmi]= protec(hmi);
% hma = 3*max(diff(x));[hma]= protec(hma);
tic;
disp('STAGE[2][ON]');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estágio 2:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fpi = interp1(Xpdf,pdf,x,'linear',0); [fpi]= protec(fpi);
lambda=exp((length(x)^-1)*sum(log(fpi)));
if strcmp(enable_stage2,'ON')
    alpha_set = alpha;
elseif strcmp(enable_stage2,'OFF')
    disp('STAGE[2][OFF]');
    alpha_set = 2;
end
disp('STAGE[2][..]');
[hi] = hSSE_alfa(h1,lambda,fpi,alpha_set);
[hiSJ] = hSSE_alfa(h.PI.SJ,lambda,fpi,alpha_set);
[hiBCV2] = hSSE_alfa(h.CV.rBCV2,lambda,fpi,alpha_set);
[hiOSCV] = hSSE_alfa(h.CV.rOSCV,lambda,fpi,alpha_set);
s2time=toc;
disp(['STAGE[2][OK]TIME[' num2str(s2time) ']']);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estágio 3:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
disp('STAGE[3][ON]');
disp('STAGE[3][..]');
if strcmp(deriv_mode,'KDE')
    [Xd,df] = dKDE(x,h1,1,nPoint);
end
if strcmp(deriv_mode,'DIFF')
    [Xd,df]  = diffpdf(Xpdf,pdf);
end
prob = interp1(Xpdf,pdf,x,'linear','extrap'); [prob]= protec(prob);
deriv = interp1(Xd,df,x,'linear','extrap'); [deriv]= protec(deriv);
prob = prob/max(prob); [prob]= protec(prob);
deriv = abs(deriv)/max(abs(deriv));  [deriv]= protec(deriv);
if strcmp(enable_stage3,'OFF')
    disp('STAGE[3][OFF]');
    hi=hi;
elseif strcmp(enable_stage3,'ON')
    if R==0
        if strcmp(smooth_mode,'PROB')
            hip = [(hi'.*(1-prob)+hiSJ'.*prob) + (hiSJ'.*(1-prob)+hi'.*prob)]./2;
            hi = hip;
        end
        if strcmp(smooth_mode,'BOTH')
            hip = [(hi'.*(1-prob)+hiSJ'.*prob) + (hiSJ'.*(1-prob)+hi'.*prob)]./2;
            hid1 = [(hi'.*(1-deriv)+hiSJ'.*deriv) + (hiSJ'.*(1-deriv)+hi'.*deriv)]./2;
            hi= [hip+hid1]./2;
        end
    else
        if strcmp(smooth_mode,'PROB')
            hip = [(hi'.*(1-prob)+hiOSCV'.*prob) + (hiBCV2'.*(1-prob)+hi'.*prob)]./2;
            hi = hip;
        end
        if strcmp(smooth_mode,'BOTH')
            hip = [(hi'.*(1-prob)+hiOSCV'.*prob) + (hiBCV2'.*(1-prob)+hi'.*prob)]./2;
            hid1 = [(hi'.*(1-deriv)+hiOSCV'.*deriv) + (hiBCV2'.*(1-deriv)+hi'.*deriv)]./2;
            hi= [hip+hid1]./2;
        end
    end
    
end

% hi(hi>hma)=hma;
% hi(hi<hmi)=hmi;

s3time=toc;
disp(['STAGE[3][OK]TIME[' num2str(s3time) ']']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot de h:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if doPlot ==1
    figure
    plot(x,hi,':sk','markersize',4,'markerfacecolor','r'); hold on;
    plot(x,hiSJ,':','Color',[.65 .65 .65]); hold on
    plot(x,hiBCV2,':','Color',[.65 .65 .65]);
    plot(x,hiOSCV,':','Color',[.65 .65 .65]); hold on
    plot([min(x) max(x)],[h1 h1],'-r','linewidth',2);
    plot([min(x) max(x)],[hmi hmi],':k','linewidth',2);
    plot([min(x) max(x)],[hma hma],':k','linewidth',2);
    plot([min(x) max(x)],[h.truthG h.truthG],':g','linewidth',2);
    disp(['hmin:' num2str(hmi) '|h:' num2str(h1) '|gmax:' num2str(hma)])
    set(gca,'Yscale','log')
    xlabel('Amostras')
    ylabel('h_i')
    set(gca,'Fontsize',14);
    grid minor
    set(gca,'Gridlinestyle',':')
    set(gca,'LooseInset',get(gca,'TightInset'))
    axis tight
    legend('2º Estágio')
    pause
    close
end

end
