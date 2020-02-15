function [ef_sp,fa_sp,bsp,i] = ROC_SnS(DATA,LH,doPlot)

cl = ['rrkk']
mk = [':-:-']
for m=1:4
[fa,ef] = perfcurve(DATA.TAG,LH(m,:),1);
[bsp(m),ei,es,i] = best_sp(ef,fa,sum(DATA.TAG==1),sum(DATA.TAG==0));
if doPlot==1
hold on
plot(ef,1-fa,[cl(m) mk(m)]); 
legend('SS','BKDE','SV','MGKDE')
end
ef_sp(m)=ef(i);
fa_sp(m)=fa(i);
end

