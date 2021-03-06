function [bin,MA,nbin]=bintruth(DATA,binmax,inter)

for nbin=2:binmax
        [yh,xh]=hist(DATA.sg.evt,nbin);
        d=diff(xh); d=d(1);
        yh=yh/area2d(xh,yh);
        yhgrid=interp1(xh,yh,DATA.sg.pdf.truth.x,inter,0);
        A(nbin) = area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yhgrid));
end



nbin=2:binmax;  
MA = A(nbin);
bin = find(MA==min(MA))+1;

% plot(A,':r'); hold on
% plot(nbin(bin),A(bin),'ok')
% pause
% close
end