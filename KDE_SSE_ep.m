function[xgrid,ygrid,A,L2] =KDE_SSE_ep(setup,DATA,h1,nPoint)
x = sort(DATA.sg.evt);
[Xpdf,pdf] = KDEfast_fixed(x,h1,nPoint); %PDF da referência;
fpi = interp1(Xpdf,pdf,x,'linear',0); [fpi]= protec(fpi);
lambda=exp((length(x)^-1)*sum(log(fpi)));
[hi] = hSSE_alfa(h1,lambda,fpi,2);
[hi]= protec(hi);
hi = hi(:)'.^2;
[xgrid,ygrid,~] = KDESSEROI_Hi_ep(x,{hi},nPoint,h1); [ygrid]= protec(ygrid);
[DATA] = ChangePDFlimit(setup,DATA,xgrid(1),xgrid(end));
ygrid = interp1(xgrid,ygrid,DATA.sg.pdf.truth.x,'linear');
A= area2d(DATA.sg.pdf.truth.x,abs(ygrid-DATA.sg.pdf.truth.y));
L2 = area2d(DATA.sg.pdf.truth.x,(ygrid-DATA.sg.pdf.truth.y).^2);
end