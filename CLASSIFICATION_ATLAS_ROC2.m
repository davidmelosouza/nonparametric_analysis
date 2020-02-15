clear;
clc;
close all;

ne = 10000;
ntmax = 100;
nPoint = 2000;

load likelihood_electron
load likelihood_jet
load IK0000000032P

inde = 1:length(likelihood_electron);
indj = 1:length(likelihood_jet);
% v = [1 2 4:13];
v = [1:13];
for i=v
    inde = intersect(inde,ind_k_e{i});
    indj = intersect(indj,ind_k_j{i});
end

likelihood_electron=likelihood_electron(v,inde);
likelihood_jet=likelihood_jet(v,indj);
% [mad(likelihood_electron) mad(likelihood_jet)]
data.full = [likelihood_electron(:,randi(length(likelihood_electron),ne,1)) likelihood_jet(:,randi(length(likelihood_jet),ne,1))];
clear likelihood_electron likelihood_jet
target = [ones(ne,1);zeros(ne,1)]';

close
ic = 0;
% for ne_cut = [25 50 100 500 1000]
for ne_cut = [100]
    ic = ic+1;
    %%=========================================== LIKELIHOOD - TRAINING =====================================================
    [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.125,0.625);
    isg = find(target(ind.trainf)==1); isg = isg(randperm(length(isg),ne_cut));
    ibg = find(target(ind.trainf)==0); ibg = ibg(randperm(length(ibg),ne_cut));
    itrain = [isg ibg];
    ind.train = ind.trainf(:,itrain(randperm(length(itrain),length(itrain))));
    ind.val = ind.valf(:,randi(length(ind.valf),2*ne_cut,1));
    data.TRAIN=data.full(:,ind.train);
    for d= 1:size(data.full,1)
        data.VAL=data.full(d,ind.val);
        data.TEST=data.full(d,ind.test);
        DATA_test = data.TEST;
        disp(num2str(d))
        save DATA_test DATA_test        
        [x.sg{d},y.sg{d}] = KDE_methods_ATLAS(data.TRAIN(d,target(ind.train)==1),nPoint);
        [x.bg{d},y.bg{d}] = KDE_methods_ATLAS(data.TRAIN(d,target(ind.train)==0),nPoint);
    end
    %%=============================================== RNA - TRAINING ========================================================
    n=15;
    [net] = BP_RNA(data.full,target,n,ind);
    %%========================================================================================================================
    for nt = 1:ntmax
        [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.125,0.625);
        %%============================================= DATA =================================================================
        data.TEST=data.full(:,ind.test);
        %%=========================================== LIKELIHOOD - TEST ================================================
        for d= 1:size(data.full,1)
            [p.sg{d}]= pfull(data.TEST(d,:),x.sg{d},y.sg{d});
            [p.bg{d}]= pfull(data.TEST(d,:),x.bg{d},y.bg{d});
        end
        [LH] = LH_ATLAS(p);
        [auc.SS,fpr.SS,tpr.SS] = fastAUC(logical(target(ind.test))',LH(1,:)',0);
        [auc.BKDE,fpr.BKDE,tpr.BKDE] = fastAUC(logical(target(ind.test))',LH(2,:)',0);
        [auc.SV,fpr.SV,tpr.SV] = fastAUC(logical(target(ind.test))',LH(3,:)',0);
        [auc.ROIKDE,fpr.ROIKDE,tpr.ROIKDE] = fastAUC(logical(target(ind.test))',LH(4,:)',0);
        [auc.F,fpr.F,tpr.F] = fastAUC(logical(target(ind.test))',LH(5,:)',0);
        ef.SS{ic}(nt,:) =tpr.SS;
        ef.BKDE{ic}(nt,:) =tpr.BKDE;
        ef.SV{ic}(nt,:) =tpr.SV;
        ef.ROIKDE{ic}(nt,:) =tpr.ROIKDE;
        ef.F{ic}(nt,:) =tpr.F;
        fa.SS{ic}(nt,:) = fpr.SS;
        fa.BKDE{ic}(nt,:) = fpr.BKDE;
        fa.SV{ic}(nt,:) = fpr.SV;
        fa.ROIKDE{ic}(nt,:) = fpr.ROIKDE;
        fa.F{ic}(nt,:) = fpr.F;
        %%=============================================== RNA - TEST =======================================================
        out = net(data.TEST);
        [auc.rna,fpr.rna,tpr.rna] = fastAUC(logical(target(ind.test))',out',0);
        ef.rna{ic}(nt,:) =tpr.rna;
        fa.rna{ic}(nt,:) = fpr.rna;
        %%========================================================================================================================
        disp(['[' num2str(ic) '][' num2str(nt) ']=>TR[' num2str(length(ind.train)) ']VAL[' num2str(length(ind.val)) ']TEST[' num2str(length(ind.test)) ']'])
        clear p LH auc fpr tpr
    end
    figure(ne_cut)
    plot(mean(ef.SS{ic}),1-mean(fa.SS{ic}),':r','Linewidth',2); hold on
    plot(mean(ef.BKDE{ic}),1-mean(fa.BKDE{ic}),'r','Linewidth',2); hold on
    plot(mean(ef.SV{ic}),1-mean(fa.SV{ic}),':k','Linewidth',2); hold on
    plot(mean(ef.ROIKDE{ic}),1-mean(fa.ROIKDE{ic}),'k','Linewidth',2); hold on
    plot(mean(ef.rna{ic}),1-mean(fa.rna{ic}),'Color',[0.5 0.5 0.5],'Linewidth',2); hold on
    plot(mean(ef.F{ic}),1-mean(fa.F{ic}),'G','Linewidth',2); hold on
    legend('SS','BKDE','SV','ROIKDE','RNA','FIXED','Location','Southwest')
    grid minor
%     xlim([0.7 1]);
%     ylim([0.7 1]);
    xlabel('Detecção de Sinal')
    ylabel('Rejeição de Ruído')
end

