function [x,y] = KDE_methods(setup,DATA,nPoint)
DATA.sg.evt = sort(DATA.sg.evt);
[h] = h_methods(setup,DATA);
% disp('debug1')
[x.BKDE,y.BKDE] = KDEBINNED(DATA.sg.evt,h.CV.rOSCV,nPoint);
% disp('debug2')
A(2)=area2d(x.BKDE,y.BKDE);
[y.SS,x.SS] = ssvkernel(DATA.sg.evt,x.BKDE);
% disp('debug3')
A(1)=area2d(x.SS,y.SS);
[x.SV,y.SV] = kernelND(DATA.sg.evt,nPoint,'KDE','',h.CV.rOSCV,[],'SSE',1);
% disp('debug4')
A(3)=area2d(x.SV,y.SV);
[x.KDEROI,y.KDEROI] = ROIKDE_AUTO(DATA.sg.evt,nPoint);
A(4)=area2d(x.KDEROI,y.KDEROI);
% disp([num2str(A)]);
x.PDF = DATA.sg.pdf.truth.x;
y.PDF = DATA.sg.pdf.truth.y;
% figure
% plot(x.SS,y.SS,':r'); hold on
% plot(x.BKDE,y.BKDE,'r'); hold on
% plot(x.SV,y.SV,':b');
% plot(x.KDEROI,y.KDEROI,'k'); 
% plot(DATA.sg.evt,0,'xb'); 
% plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-g'); 
% legend('SS','BKDE','SV','KDEROI','DATA','PDF')
% pause
% close

end
