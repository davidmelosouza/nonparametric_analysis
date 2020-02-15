function [Xpdf,Ypdf] = MGKDE(DATA,nPoint,est,bin,h,type,dolambda)


[fp.sj,hi.sj,~,~] = PILOT(DATA,nPoint,est,bin,h.PI.SJ,[],type,dolambda);
[fp.tcv,hi.tcv,~,~] = PILOT(DATA,nPoint,est,bin,h.CV.OSCV,[],type,dolambda);

dpi = fp.sj/max(fp.sj);
[X,df] = dKDE(DATA,h.CV.TCV,1,nPoint);
df = abs(df);
d1f = interp1(X,df,DATA,'linear',0);
d1f = d1f/max(d1f);

[X,df] = dKDE(DATA,h.CV.TCV,2,nPoint);
df = abs(df);
d2f = interp1(X,df,DATA,'linear',0);
d2f = d2f/max(d2f);

[dpi]= protec(dpi);
[d1f]= protec(d1f);
[d2f]= protec(d2f);
  
hi.sj = hi.sj';
% himg= (((hi.tcv.*d1f')+(hi.sj'.*(1-d1f')))+((hi.tcv.*dpi')+(hi.sj'.*(1-dpi')))+((hi.tcv.*d2f')+(hi.sj'.*(1-d2f'))))/3;
% himg= (((hi.tcv.*d1f')+(hi.sj'.*(1-d1f')))+((hi.tcv.*dpi')+(hi.sj'.*(1-dpi'))))/2;
himg= ((hi.tcv.*dpi')+(hi.sj'.*(1-dpi')));
[Xpdf,Ypdf,~] = KDESSE(DATA,{himg'},nPoint);
% [Xpdf,Ypdf] = KDEfast_fixed(DATA,himg,nPoint);
end