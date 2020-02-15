function [A,xgrid,ygrid] = areaKDEVAR(DATA,x,y)
inter = 'linear';
ygrid(1,:)=interp1(x.SS,y.SS,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(2,:)=interp1(x.BKDE,y.BKDE,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(3,:)=interp1(x.SV,y.SV,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(4,:)=interp1(x.KDEROI,y.KDEROI,DATA.sg.pdf.truth.x,inter,'extrap');
% ygrid(5,:)=interp1(x.PDF,y.PDF,DATA.sg.pdf.truth.x,inter,'extrap');

xgrid=DATA.sg.pdf.truth.x;
for i=1:4
    [ygrid]= protec(ygrid);
    A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end