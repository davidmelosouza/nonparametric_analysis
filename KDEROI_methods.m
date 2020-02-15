function [x,y] = KDEROI_methods(setup,DATA,nPoint)

[h] = h_methods(setup,DATA);
[x.ROI1,y.ROI1]=ROIKDE(DATA.sg.evt,h,nPoint,[],'KDE','PROB','OFF','OFF');
[x.ROI2,y.ROI2]=ROIKDE(DATA.sg.evt,h,nPoint,[],'KDE','PROB','OFF','ON');
[x.ROI3,y.ROI3]=ROIKDE(DATA.sg.evt,h,nPoint,[],'KDE','BOTH','OFF','ON');
end