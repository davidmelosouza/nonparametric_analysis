function [A,xgrid,ygrid] = areaKDEROI_VAR(DATA,x,y)
inter = 'linear';
ygrid(1,:)=interp1(x.ROI1,y.ROI1,DATA.sg.pdf.truth.x,inter,0); 
ygrid(2,:)=interp1(x.ROI2,y.ROI2,DATA.sg.pdf.truth.x,inter,0);
ygrid(3,:)=interp1(x.ROI3,y.ROI3,DATA.sg.pdf.truth.x,inter,0);
% ygrid(4,:)=interp1(x.ROI4,y.ROI4,DATA.sg.pdf.truth.x,inter,0);
% ygrid(5,:)=interp1(x.ROI5,y.ROI5,DATA.sg.pdf.truth.x,inter,0);
% ygrid(6,:)=interp1(x.ROI6,y.ROI6,DATA.sg.pdf.truth.x,inter,0);
% ygrid(7,:)=interp1(x.ROI7,y.ROI7,DATA.sg.pdf.truth.x,inter,0);
% ygrid(8,:)=interp1(x.ROI8,y.ROI8,DATA.sg.pdf.truth.x,inter,0);
% ygrid(9,:)=interp1(x.ROI9,y.ROI9,DATA.sg.pdf.truth.x,inter,0);

xgrid=DATA.sg.pdf.truth.x;
for i=1:3
ygrid(i,(ygrid(i,:)<0))=0;
A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end