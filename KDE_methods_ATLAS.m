function [x,y] = KDE_methods_ATLAS(DATA,nPoint)
DATA = sort(DATA);
[h] = h_methods_ATLAS(DATA');
% save h h
[x.BKDE,y.BKDE] = KDEBINNED(DATA',h.CV.OSCV,nPoint);
[y.SS,x.SS] = ssvkernel(DATA',x.BKDE);
% [x.BKDE,y.BKDE] = bkde(DATA',h.PI.SJ,nPoint);
% [x.SS,y.SS] = kernelND(DATA',nPoint,'KDE','',h.PI.SJ,[],'SSE',1);
% [x.BKDE,y.BKDE] = kernelND(DATA',nPoint,'KDE','',h.CV.TCV,[],'SSE',1);
[x.SV,y.SV] = kernelND(DATA',nPoint,'KDE','',h.CV.OSCV,[],'SSE',1);
% [x.SV,y.SV] = KDEfast_fixed(DATA,h.CV.TCV,nPoint);
% [x.MGKDE,y.MGKDE] = kernelND(DATA',nPoint,'KDE','',h.PI.SJ,[],'SSE',1);
% [x.MGKDE,y.MGKDE] = MGKDE(DATA',nPoint,'KDE','',h,'SSE',1);
% [x.MGKDE,y.MGKDE]=ROIKDE(DATA',h,nPoint,[],'KDE','BOTH','OFF','ON');
% [x.SV,y.SV]=ROIKDE(DATA',h,nPoint,[],'KDE','PROB','OFF','ON');
[x.KDEROI,y.KDEROI] = ROIKDE_AUTO(DATA',nPoint);
[x.F,y.F] = KDEfast_fixed(DATA,h.PI.SJ,nPoint);
% [x.MGKDE,y.MGKDE] = KDEfast_fixed(DATA,h.CV.TCV,nPoint);
% load data_test
% figure
% DATA_test=DATA_test(DATA_test>x.KDEROI(1) & DATA_test<x.KDEROI(end));
% % [xh,yh] = KDEfast_fixed(DATA_test,h.CV.OSCV,nPoint);hold on
% [yh,xh]=hist(DATA_test,Rudemo(DATA_test)); hold on
% [yhd,xhd]=hist(DATA,Rudemo(DATA)); hold on
% A = area2d(xh,yh);
% Ad = area2d(xhd,yhd);
% stairs(xh,yh/A,'g');
% stairs(xhd,yhd/Ad,':g');
% plot(x.SS,y.SS,':r'); hold on
% plot(x.BKDE,y.BKDE,'r'); hold on
% plot(x.SV,y.SV,':b');
% plot(x.KDEROI,y.KDEROI,'k'); 
% plot(x.F,y.F,':k'); 
% plot(DATA,0,'xb'); 
% legend('DATA','SS','BKDE','SV','KDEROI','FIXED')
% xlim([x.KDEROI(1) x.KDEROI(end)])
% 
% pause
% close
end