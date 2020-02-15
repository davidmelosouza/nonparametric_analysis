function [hi] = hiKDE(x,h1,nPoint)

[Xpdf,pdf] = KDEfast_fixed(x,h1,nPoint); %PDF da referência;
fpi = interp1(Xpdf,pdf,x,'linear',0); [fpi]= protec(fpi);
lambda=exp((length(x)^-1)*sum(log(fpi)));
[hi] = hSSE(h1,lambda,fpi);[hi]= protec(hi);
end