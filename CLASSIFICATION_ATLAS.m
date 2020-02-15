clear;
clc;

ne = 10000;
ntmax = 100;
nPoint = 10000;

load likelihood_electron
load likelihood_jet
load IK0000000032P

inde = 1:length(likelihood_electron);
indj = 1:length(likelihood_jet);
for i=1:13
    inde = intersect(inde,ind_k_e{i});
    indj = intersect(indj,ind_k_j{i});
end

likelihood_electron=likelihood_electron(:,inde);
likelihood_jet=likelihood_jet(:,indj);
data.full = [likelihood_electron(:,randi(length(likelihood_electron),ne,1)) likelihood_jet(:,randi(length(likelihood_jet),ne,1))];
clear likelihood_electron likelihood_jet
target = [ones(ne,1);zeros(ne,1)]';
ic = 0;
% for ne_cut = [25 50 100 500 1000]
for ne_cut = [50]
    ic = ic+1;
    %%=========================================== LIKELIHOOD - TRAINING =====================================================    
    [ind.trainf,ind.val,ind.testf] = dividerand(2*ne,0.25,0.5,0.25);
    isg = find(target(ind.trainf)==1); isg = isg(randperm(length(isg),ne_cut));
    ibg = find(target(ind.trainf)==0); ibg = ibg(randperm(length(ibg),ne_cut));
    itrain = [isg ibg];
    ind.train = ind.trainf(:,itrain(randperm(length(itrain),length(itrain))));
    ind.test = ind.testf(:,randi(length(ind.testf),ne_cut,1));
    data.TRAIN=data.full(:,ind.train);
    data.TEST=data.full(:,ind.test);
    for d= 1:size(data.full,1)
        [x.sg{d},y.sg{d}] = KDE_methods(data.TRAIN(d,target(ind.train)==1),nPoint);
        [x.bg{d},y.bg{d}] = KDE_methods(data.TRAIN(d,target(ind.train)==0),nPoint);
    end
    %%=============================================== RNA - TRAINING ========================================================
    n=10;
    ind.train = ind.train(1:ne_cut);
    ind.test = ind.test(1:ne_cut);
    [net] = BP_RNA(data.full,target,n,ind);
    %%========================================================================================================================    
    for nt = 1:ntmax        
        [ind.trainf,ind.val,ind.testf] = dividerand(2*ne,0.25,0.5,0.25);
        %%============================================= DATA =================================================================
        data.VAL=data.full(:,ind.val);
        %%=========================================== LIKELIHOOD - VALIDATION ================================================
        for d= 1:size(data.full,1)
            [p.sg{d}]= pfull(data.VAL(d,:),x.sg{d},y.sg{d});
            [p.bg{d}]= pfull(data.VAL(d,:),x.bg{d},y.bg{d});
        end
        [LH] = LH_ATLAS(p);
        [auc.SS,fpr.SS,tpr.SS] = fastAUC(logical(target(ind.val))',LH(1,:)',0);
        [auc.BKDE,fpr.BKDE,tpr.BKDE] = fastAUC(logical(target(ind.val))',LH(2,:)',0);
        [auc.SV,fpr.SV,tpr.SV] = fastAUC(logical(target(ind.val))',LH(3,:)',0);
        [auc.MGKDE,fpr.MGKDE,tpr.MGKDE] = fastAUC(logical(target(ind.val))',LH(4,:)',0);
        ef.SS{ic}(nt,:) =tpr.SS;
        ef.BKDE{ic}(nt,:) =tpr.BKDE;
        ef.SV{ic}(nt,:) =tpr.SV;
        ef.MGKDE{ic}(nt,:) =tpr.MGKDE;
        fa.SS{ic}(nt,:) = fpr.SS;
        fa.BKDE{ic}(nt,:) = fpr.BKDE;
        fa.SV{ic}(nt,:) = fpr.SV;
        fa.MGKDE{ic}(nt,:) = fpr.MGKDE;
        %%=============================================== RNA - VALIDATION =======================================================
        out = net(data.VAL);
        [auc.rna,fpr.rna,tpr.rna] = fastAUC(logical(target(ind.val))',out',0);
        ef.rna{ic}(nt,:) =tpr.rna;
        fa.rna{ic}(nt,:) = fpr.rna;
        %%========================================================================================================================        
        disp(['[' num2str(ic) '][' num2str(nt) ']=>TR[' num2str(length(ind.train)) ']TST[' num2str(length(ind.test)) ']VAL[' num2str(length(ind.val)) ']'])
        clear p LH auc fpr tpr
    end
    figure(ne_cut)
    plot(mean(ef.SS{ic}),1-mean(fa.SS{ic}),':r','Linewidth',2); hold on
    plot(mean(ef.BKDE{ic}),1-mean(fa.BKDE{ic}),'r','Linewidth',2); hold on
    plot(mean(ef.SV{ic}),1-mean(fa.SV{ic}),':k','Linewidth',2); hold on
    plot(mean(ef.MGKDE{ic}),1-mean(fa.MGKDE{ic}),'k','Linewidth',2); hold on
    plot(mean(ef.rna{ic}),1-mean(fa.rna{ic}),'Color',[0.5 0.5 0.5],'Linewidth',2); hold on
    legend('SS','BKDE','SV','MGKDE','RNA','Location','Southwest')
    grid minor
    xlim([0.7 1]);
    ylim([0.7 1]);
    xlabel('Detecção de Sinal')
    ylabel('Rejeição de Ruído')
end

