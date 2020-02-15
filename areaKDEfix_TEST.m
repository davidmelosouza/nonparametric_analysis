function [A,X,pdf] = areaKDEfix_TEST(DATA,nPoint,h,inter)


[X.MLCV,pdf.MLCV] = KDEfast_fixed(DATA.sg.evt,h.CV.MLCV,nPoint);
[X.UCV,pdf.UCV] = KDEfast_fixed(DATA.sg.evt,h.CV.UCV,nPoint);
[X.BCV1,pdf.BCV1] = KDEfast_fixed(DATA.sg.evt,h.CV.BCV1,nPoint);
[X.BCV2,pdf.BCV2] = KDEfast_fixed(DATA.sg.evt,h.CV.BCV2,nPoint);
[X.CCV,pdf.CCV] = KDEfast_fixed(DATA.sg.evt,h.CV.CCV,nPoint);
[X.MCV,pdf.MCV] = KDEfast_fixed(DATA.sg.evt,h.CV.MCV,nPoint);
[X.TCV,pdf.TCV] = KDEfast_fixed(DATA.sg.evt,h.CV.TCV,nPoint);
[X.TRUTH,pdf.TRUTH] = KDEfast_fixed(DATA.sg.evt,h.truth,nPoint);

ygrid(1,:)=interp1(X.MLCV,pdf.MLCV,DATA.sg.pdf.truth.x,inter,0);
ygrid(2,:)=interp1(X.UCV,pdf.UCV,DATA.sg.pdf.truth.x,inter,0);
ygrid(3,:)=interp1(X.BCV1,pdf.BCV1,DATA.sg.pdf.truth.x,inter,0);
ygrid(4,:)=interp1(X.BCV2,pdf.BCV2,DATA.sg.pdf.truth.x,inter,0);
ygrid(5,:)=interp1(X.CCV,pdf.CCV,DATA.sg.pdf.truth.x,inter,0);
ygrid(6,:)=interp1(X.MCV,pdf.MCV,DATA.sg.pdf.truth.x,inter,0);
ygrid(7,:)=interp1(X.TCV,pdf.TCV,DATA.sg.pdf.truth.x,inter,0);
ygrid(8,:)=interp1(X.TRUTH,pdf.TRUTH,DATA.sg.pdf.truth.x,inter,0);

for i=1:8
    ygrid(i,(ygrid(i,:)<0))=0;
    A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end