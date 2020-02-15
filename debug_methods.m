function [] = debug_methods(C,hv,ind,type)
if strcmp(type,'min')
    plot(hv,C,':'); hold on
    plot(hv(find(C==min(C))),C(find(C==min(C))),'vr')
    plot(hv,C,':');
    plot(hv(ind),C(ind),'ok')
else if strcmp(type,'max')
        plot(hv,C,':'); hold on
        plot(hv(find(C==max(C))),C(find(C==max(C))),'vr')
        plot(hv,C,':');
        plot(hv(ind),C(ind),'ok')
    end
    set(gca,'Xscale','log')
    set(gca,'Yscale','log')
end