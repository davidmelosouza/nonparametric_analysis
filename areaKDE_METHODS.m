function [A,xgrid,ygrid] = areaKDE_METHODS(DATA,nPoint,inter,est,bin_method,h_method,type,dolambda)

  h = h_methods(DATA);
bin=calcnbins(DATA.sg.evt,bin_method);
[X.SV,pdf.SV] = kernelND(DATA,nPoint,est,bin,h,[],type,dolambda);
[X.BKDE,pdf.BKDE] = bkde(DATA.sg.evt,h,nPoint);
[pdf.SS,X.SS] = ssvkernel(DATA.sg.evt); 
[X.truth,pdf.truth] = kernelND(DATA,nPoint,'truth',bin,h,[],type,dolambda);

xgrid = DATA.sg.pdf.truth.x;
ygrid(1,:)=interp1(X.SV,pdf.SV,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(2,:)=interp1(X.BKDE,pdf.BKDE,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(3,:)=interp1(X.SS,pdf.SS,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(4,:)=interp1(X.truth,pdf.truth,DATA.sg.pdf.truth.x,inter,'extrap');


for i=1:4
    ygrid(i,(ygrid(i,:)<0))=0;
    A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end