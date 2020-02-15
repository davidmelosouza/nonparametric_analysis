clear
ne_cut = 1000
load([pwd '\KDE\CLASSIFICATION[ROC][ATLAS]EVT[' num2str(ne_cut) ']'],'M');
ic = 4;
% figure(ne_cut)
plot(M.ef.SS{ic},1-M.fa.SS{ic},':k','Linewidth',2); hold on
plot(M.ef.BKDE{ic},1-M.fa.BKDE{ic},'k','Linewidth',2); hold on
plot(M.ef.SV{ic},1-M.fa.SV{ic},'Color',[0.5 0.5 0.5],'Linewidth',2); hold on
plot(M.ef.ROIKDE{ic},1-M.fa.ROIKDE{ic},'r','Linewidth',2); hold on
plot(M.ef.rna{ic},1-M.fa.rna{ic},'b','Linewidth',2); hold on
% plot(M.ef.PDF{ic},1-M.fa.PDF{ic},'G','Linewidth',2); hold on
legend('AKDE','BKDE','VKDE','ROIKDE','RNA','PDF','Location','Southwest')
grid minor
set(gca,'Fontsize',12); 
    xlim([0.85 1]);
    ylim([0.85 1]);
xlabel('Detecção de Sinal')
ylabel('Rejeição de Ruído')

% xlim([0.987 1])
% ylim([0.987 1])

[bsp.SS,ei.SS,es.SS,ind(1),ef(1),fa(1)] = best_sp(M.ef.SS{ic},M.fa.SS{ic},ones(ne_cut,1),zeros(ne_cut,1));
[bsp.BKDE,ei.BKDE,es.BKDE,ind(2),ef(2),fa(2)] = best_sp(M.ef.BKDE{ic},M.fa.BKDE{ic},ones(ne_cut,1),zeros(ne_cut,1));
[bsp.SV,ei.SV,es.SV,ind(3),ef(3),fa(3)] = best_sp(M.ef.SV{ic},M.fa.SV{ic},ones(ne_cut,1),zeros(ne_cut,1));
[bsp.ROIKDE,ei.ROIKDE,es.ROIKDE,ind(4),ef(4),fa(4)] = best_sp(M.ef.ROIKDE{ic},M.fa.ROIKDE{ic},ones(ne_cut,1),zeros(ne_cut,1));
[bsp.rna,ei.rna,es.rna,ind(5),ef(5),fa(5)] = best_sp(M.ef.rna{ic},M.fa.rna{ic},ones(ne_cut,1),zeros(ne_cut,1));
% [bsp.PDF,ei.PDF,es.PDF,ind(6),ef(6),fa(6)] = best_sp(M.ef.PDF{ic},M.fa.PDF{ic},ones(ne_cut,1),zeros(ne_cut,1));

cl=[0 0 0
    0 0 0
    0.5 0.5 0.5
    1 0 0
    0 0 1
    0 1 0];
for i=1:5
plot(ef(i),1-fa(i),'sk','markerface',cl(i,:)); hold on
end