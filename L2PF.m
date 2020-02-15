function [L2] = L2PF(DATA,inter,bin)

[xh,yh]=data_normalized(DATA.sg.evt,bin);
yhgrid = interp1(xh,yh,DATA.sg.pdf.truth.x,inter,0);
L2 = area2d(DATA.sg.pdf.truth.x,(yhgrid-DATA.sg.pdf.truth.y).^2);

