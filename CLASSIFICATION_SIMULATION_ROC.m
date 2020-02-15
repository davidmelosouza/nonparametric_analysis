clear;
clc;

ne = 100000;
ntmax = 100;
itmax = 1;
nPoint = 2000;
nROI = 1;
nGRID = 10000;
nEST = 100;

[DADO.SG] = signal_GEN(ne,nGRID,nEST,nROI);
[DADO.BG] = background_GEN(ne,nGRID,nEST,nROI);
data.full= [DADO.SG.EVT DADO.BG.EVT];
target =[ones(1,ne) zeros(1,ne)];
nev = [25 50 100 500 1000];

ic = 0;
for ne_cut = nev
    ic = ic+1;
    %%=========================================== LIKELIHOOD - TRAINING =====================================================
    for it = 1:itmax
        [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.25,0.5);
        [ind] = cut_ind(ind,target,ne_cut);
        data.TRAIN=data.full(:,ind.train);
        data.VAL=data.full(:,ind.val);
        for d= 1:size(data.full,1)
            [x.sg{d},y.sg{d}] = KDE_methods_ATLAS(data.TRAIN(d,target(ind.train)==1),nPoint);
            x.sg{d}.PDF = DADO.SG.PDF.x(d,:); y.sg{d}.PDF = DADO.SG.PDF.y(d,:);
            [x.bg{d},y.bg{d}] = KDE_methods_ATLAS(data.TRAIN(d,target(ind.train)==0),nPoint);
            x.bg{d}.PDF = DADO.BG.PDF.x(d,:); y.bg{d}.PDF = DADO.BG.PDF.y(d,:);
        end
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
            %%=========================================== LIKELIHOOD - TEST ================================================
            for d= 1:size(data.full,1)
                [p.sg{d}]= pfull_cell(data.TEST(d,:),x.sg{d},y.sg{d});
                [p.bg{d}]= pfull_cell(data.TEST(d,:),x.bg{d},y.bg{d});
            end
            [LH] = LH_ATLAS(p);
            [auc.SS,fpr.SS,tpr.SS] = fastAUC(logical(target(ind.test))',LH(1,:)',0);
            [auc.BKDE,fpr.BKDE,tpr.BKDE] = fastAUC(logical(target(ind.test))',LH(2,:)',0);
            [auc.SV,fpr.SV,tpr.SV] = fastAUC(logical(target(ind.test))',LH(3,:)',0);
            [auc.ROIKDE,fpr.ROIKDE,tpr.ROIKDE] = fastAUC(logical(target(ind.test))',LH(4,:)',0);
            [auc.PDF,fpr.PDF,tpr.PDF] = fastAUC(logical(target(ind.test))',LH(5,:)',0);
            
            ef.SS{ic}(nt,:) =tpr.SS;
            ef.BKDE{ic}(nt,:) =tpr.BKDE;
            ef.SV{ic}(nt,:) =tpr.SV;
            ef.ROIKDE{ic}(nt,:) =tpr.ROIKDE;
            ef.PDF{ic}(nt,:) =tpr.PDF;
            fa.SS{ic}(nt,:) = fpr.SS;
            fa.BKDE{ic}(nt,:) = fpr.BKDE;
            fa.SV{ic}(nt,:) = fpr.SV;
            fa.ROIKDE{ic}(nt,:) = fpr.ROIKDE;
            fa.PDF{ic}(nt,:) = fpr.PDF;
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
    
    M.ef.SS{ic} = mean(ef.SS{ic});
    M.ef.BKDE{ic} = mean(ef.BKDE{ic});
    M.ef.SV{ic} = mean(ef.SV{ic});
    M.ef.ROIKDE{ic} = mean(ef.ROIKDE{ic});
    M.ef.rna{ic} = mean(ef.rna{ic});
    M.ef.PDF{ic} = mean(ef.PDF{ic});
    
    M.fa.SS{ic} = mean(fa.SS{ic});
    M.fa.BKDE{ic} = mean(fa.BKDE{ic});
    M.fa.SV{ic} = mean(fa.SV{ic});
    M.fa.ROIKDE{ic} = mean(fa.ROIKDE{ic});
    M.fa.rna{ic} = mean(fa.rna{ic});    
    M.fa.PDF{ic} = mean(fa.PDF{ic});   
    
    save([pwd '\KDE\CLASSIFICATION[ROC][SIMULATION]EVT[' num2str(ne_cut) ']'],'M');
%     figure(ne_cut)
%     plot(mean(ef.SS{ic}),1-mean(fa.SS{ic}),':r','Linewidth',2); hold on
%     plot(mean(ef.BKDE{ic}),1-mean(fa.BKDE{ic}),'r','Linewidth',2); hold on
%     plot(mean(ef.SV{ic}),1-mean(fa.SV{ic}),':k','Linewidth',2); hold on
%     plot(mean(ef.ROIKDE{ic}),1-mean(fa.ROIKDE{ic}),'k','Linewidth',2); hold on
%     plot(mean(ef.rna{ic}),1-mean(fa.rna{ic}),'Color',[0.5 0.5 0.5],'Linewidth',2); hold on
%     plot(mean(ef.PDF{ic}),1-mean(fa.PDF{ic}),'G','Linewidth',2); hold on
%     legend('SS','BKDE','SV','ROIKDE','RNA','PDF','Location','Southwest')
%     grid minor
%     %     xlim([0.7 1]);
%     %     ylim([0.7 1]);
%     xlabel('Detecção de Sinal')
%     ylabel('Rejeição de Ruído')
end
