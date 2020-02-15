function [hn,hrobust,ind,hc] = findHCV(range,hc,h,type)

hnew=linspace(min(range),max(range),1000);
hc=interp1(range,hc,hnew,'pchip',0);
h.CV.range = hnew;
switch type
    case 'min'
        [ind,cost] = cutstage(hc);
        [ind] = indvalley(ind,cost.h);
        [ind] = indcheck_min(ind,h,hc);
    case 'max'
        [ind,cost] = cutstage_max(hc);
        [ind] = indvalley_max(ind,cost.h);
        [ind] = indcheck_max(ind,h,hc);        
end

hn = hnew(ind.normal);
hrobust = hnew(ind.robust);