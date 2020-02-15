function [A,xgrid,ygrid] = areaKDEVAR_STAGE(DATA,x,y)
inter = 'linear';
ygrid(1,:)=interp1(x.s0,y.s0,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(2,:)=interp1(x.s1,y.s1,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(3,:)=interp1(x.s2,y.s2,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(4,:)=interp1(x.s3,y.s3,DATA.sg.pdf.truth.x,inter,'extrap');
% ygrid(5,:)=interp1(x.PDF,y.PDF,DATA.sg.pdf.truth.x,inter,'extrap');

xgrid=DATA.sg.pdf.truth.x;
for i=1:4
    [ygrid]= protec(ygrid);
    A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end