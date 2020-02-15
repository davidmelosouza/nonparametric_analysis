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
        %%=============================================== RNA - TRAINING ========================================================
        n=[28 28];
        ind.train = ind.train(1:ne_cut);
        ind.val = ind.val(1:ne_cut);
        [net] = BP_RNA(data.full,target,n,ind);
        %%========================================================================================================================
        for nt = 1:ntmax
            [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.5,0.25);
            %%============================================= DATA =================================================================
            data.TEST=data.full(:,ind.test);
            %%=========================================== LIKELIHOOD - TEST ================================================
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
    save([pwd '\KDE\CLASSIFICATION[SP]SIMULATION]EVT[' num2str(ne_cut) '][RNA]'],'MSP');
end
save([pwd '\KDE\CLASSIFICATION[SP][SIMULATION][RNA]'],'spv');
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