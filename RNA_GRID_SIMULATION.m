clear;
clc;

ne = 100000;
ntmax = 100;
itmax = 2;
nPoint = 2000;
nROI = 1;
nGRID = 10000;
nEST = 100;

[DADO.SG] = signal_GEN(ne,nGRID,nEST,nROI);
[DADO.BG] = background_GEN(ne,nGRID,nEST,nROI);
data.full= [DADO.SG.EVT DADO.BG.EVT];
target =[ones(1,ne) zeros(1,ne)];
nev = [25];

ic = 0;
for ne_cut = nev
    ic = ic+1;
    %%=========================================== LIKELIHOOD - TRAINING =====================================================
    for it = 1:itmax
        [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.25,0.5);
        [ind] = cut_ind(ind,target,ne_cut);
        data.TRAIN=data.full(:,ind.train);
        data.VAL=data.full(:,ind.val);
        %%=============================================== RNA - TRAINING ========================================================
        n=10;
        ind.train = ind.train(1:ne_cut);
        ind.val = ind.val(1:ne_cut);
        [net] = BP_RNA(data.full,target,n,ind);
        %%========================================================================================================================
        for nt = 1:ntmax
            [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.5,0.25);
            %%============================================= DATA =================================================================
            data.TEST=data.full(:,ind.test);
            %%=============================================== RNA - TEST =======================================================
            out = net(data.TEST);
            [auc.rna,fpr.rna,tpr.rna] = fastAUC(logical(target(ind.test))',out',0);
            ef.rna{ic}(nt,:) =tpr.rna;
            fa.rna{ic}(nt,:) = fpr.rna;
            %%========================================================================================================================
            disp(['[' num2str(ic) '][' num2str(nt) ']=>TR[' num2str(length(ind.train)) ']VAL[' num2str(length(ind.val)) ']TEST[' num2str(length(ind.test)) ']'])
            clear p LH auc fpr tpr
        end
    end
    
    figure(ne_cut)
    plot(mean(ef.SS{ic}),1-mean(fa.SS{ic}),':r','Linewidth',2); hold on
    plot(mean(ef.BKDE{ic}),1-mean(fa.BKDE{ic}),'r','Linewidth',2); hold on
    plot(mean(ef.SV{ic}),1-mean(fa.SV{ic}),':k','Linewidth',2); hold on
    plot(mean(ef.ROIKDE{ic}),1-mean(fa.ROIKDE{ic}),'k','Linewidth',2); hold on
    plot(mean(ef.rna{ic}),1-mean(fa.rna{ic}),'Color',[0.5 0.5 0.5],'Linewidth',2); hold on
    plot(mean(ef.PDF{ic}),1-mean(fa.PDF{ic}),'G','Linewidth',2); hold on
    legend('SS','BKDE','SV','ROIKDE','RNA','PDF','Location','Southwest')
    grid minor
    %     xlim([0.7 1]);
    %     ylim([0.7 1]);
    xlabel('Detecção de Sinal')
    ylabel('Rejeição de Ruído')
end
