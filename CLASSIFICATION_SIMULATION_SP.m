clear;
clc;

ne = 100000;
ntmax = 100;
itmax = 20;
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
        n=20;
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
            
            aucv.SS{ic}{it}(nt,:) =auc.SS;
            aucv.BKDE{ic}{it}(nt,:) =auc.BKDE;
            aucv.SV{ic}{it}(nt,:) =auc.SV;
            aucv.ROIKDE{ic}{it}(nt,:) =auc.ROIKDE;
            aucv.PDF{ic}{it}(nt,:) =auc.PDF;
            
            [bsp.SS,ei.SS,es.SS] = best_sp(tpr.SS,fpr.SS,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            [bsp.BKDE,ei.BKDE,es.BKDE] = best_sp(tpr.BKDE,fpr.BKDE,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            [bsp.SV,ei.SV,es.SV] = best_sp(tpr.SV,fpr.SV,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            [bsp.ROIKDE,ei.ROIKDE,es.ROIKDE] = best_sp(tpr.ROIKDE,fpr.ROIKDE,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            [bsp.PDF,ei.PDF,es.PDF] = best_sp(tpr.PDF,fpr.PDF,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            
            spv.SS{ic}{it}(nt,:) = bsp.SS;
            spv.BKDE{ic}{it}(nt,:) = bsp.BKDE;
            spv.SV{ic}{it}(nt,:) = bsp.SV;
            spv.ROIKDE{ic}{it}(nt,:) = bsp.ROIKDE;
            spv.PDF{ic}{it}(nt,:) = bsp.PDF;
            %%=============================================== RNA - TEST =======================================================
            out = net(data.TEST);
            [auc.rna,fpr.rna,tpr.rna] = fastAUC(logical(target(ind.test))',out',0);
            aucv.rna{ic}{it}(nt,:) =auc.rna;
            [bsp.rna,ei.rna,es.rna] = best_sp(tpr.rna,fpr.rna,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            spv.rna{ic}{it}(nt,:) = bsp.rna;
            
            MSP{it}(nt,:)= bsp;
            %%========================================================================================================================
            disp(['[' num2str(it) '][' num2str(nt) ']=>TR[' num2str(length(ind.train)) ']VAL[' num2str(length(ind.val)) ']TEST[' num2str(length(ind.test)) ']'])
            clear p LH auc fpr tpr
        end
    end
    save([pwd '\KDE\CLASSIFICATION[SP]SIMULATION]EVT[' num2str(ne_cut) ']'],'MSP');
end
save([pwd '\KDE\CLASSIFICATION[SP][SIMULATION]'],'spv');
ic = 0;
for ne = nev
    ic = ic+1;
    for it=1:itmax
        V(it,1,ic)=mean(spv.SS{ic}{it});
        V(it,2,ic)=mean(spv.BKDE{ic}{it});
        V(it,3,ic)=mean(spv.SV{ic}{it});
        V(it,4,ic)=mean(spv.ROIKDE{ic}{it});
        V(it,5,ic)=mean(spv.rna{ic}{it});
        V(it,6,ic)=mean(spv.PDF{ic}{it});
    end
end

V = reshape(mean(V),size(V,2),size(V,3));
cl = 'rrkkbb'; mk = '^v^v^s'; ln=':-:-:-';

for m = 1:6
    plot(nev,V(m,:),[ln(m) cl(m) mk(m)]); hold on
end
legend('SS','BKDE','SV','ROIKDE','RNA','PDF','Location','Southwest')
grid minor
% ylim([70 100]);
xlabel('Amostras')
ylabel('melhor SP')