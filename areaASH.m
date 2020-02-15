function [AREA] = areaASH(DATA,inter,bin)
m=10;
if bin == 2
    bin =3;
end
[x,y] = ASHmethods(DATA.sg.evt,m,inter,bin);
ygrid=interp1(x,y,DATA.sg.pdf.truth.x,inter,0);
AREA = area2d(DATA.sg.pdf.truth.x,abs(ygrid-DATA.sg.pdf.truth.y));
end