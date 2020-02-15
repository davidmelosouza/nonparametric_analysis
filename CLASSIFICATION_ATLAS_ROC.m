clear;
clc;

ne = 100000;
ntmax = 100;
itmax = 1;
nPoint = 2000;

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
nev = [25 50 100 500 1000];

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
            [x.bg{d},y.bg{d}] = KDE_methods_ATLAS(data.TRAIN(d,target(ind.train)==0),nPoint);
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
                [p.sg{d}]= pfull(data.TEST(d,:),x.sg{d},y.sg{d});
                [p.bg{d}]= pfull(data.TEST(d,:),x.bg{d},y.bg{d});
            end
            [LH] = LH_ATLAS_M(p);
            [auc.SS,fpr.SS,tpr.SS] = fastAUC(logical(target(ind.test))',LH(1,:)',0);
            [auc.BKDE,fpr.BKDE,tpr.BKDE] = fastAUC(logical(target(ind.test))',LH(2,:)',0);
            [auc.SV,fpr.SV,tpr.SV] = fastAUC(logical(target(ind.test))',LH(3,:)',0);
            [auc.ROIKDE,fpr.ROIKDE,tpr.ROIKDE] = fastAUC(logical(target(ind.test))',LH(4,:)',0);
            ef.SS{ic}(nt,:) =tpr.SS;
            ef.BKDE{ic}(nt,:) =tpr.BKDE;
            ef.SV{ic}(nt,:) =tpr.SV;
            ef.ROIKDE{ic}(nt,:) =tpr.ROIKDE;
            fa.SS{ic}(nt,:) = fpr.SS;
            fa.BKDE{ic}(nt,:) = fpr.BKDE;
            fa.SV{ic}(nt,:) = fpr.SV;
            fa.ROIKDE{ic}(nt,:) = fpr.ROIKDE;
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
    
    M.fa.SS{ic} = mean(fa.SS{ic});
    M.fa.BKDE{ic} = mean(fa.BKDE{ic});
    M.fa.SV{ic} = mean(fa.SV{ic});
    M.fa.ROIKDE{ic} = mean(fa.ROIKDE{ic});
    M.fa.rna{ic} = mean(fa.rna{ic});    
    
    save([pwd '\KDE\CLASSIFICATION[ROC][ATLAS]EVT[' num2str(ne_cut) ']'],'M');
    
%     figure(ne_cut)
%     plot(mean(ef.SS{ic}),1-mean(fa.SS{ic}),':r','Linewidth',2); hold on
%     plot(mean(ef.BKDE{ic}),1-mean(fa.BKDE{ic}),'r','Linewidth',2); hold on
%     plot(mean(ef.SV{ic}),1-mean(fa.SV{ic}),':k','Linewidth',2); hold on
%     plot(mean(ef.ROIKDE{ic}),1-mean(fa.ROIKDE{ic}),'k','Linewidth',2); hold on
%     plot(mean(ef.rna{ic}),1-mean(fa.rna{ic}),'Color',[0.5 0.5 0.5],'Linewidth',2); hold on
%     legend('SS','BKDE','SV','ROIKDE','RNA','Location','Southwest')
%     grid minor
%     %     xlim([0.7 1]);
%     %     ylim([0.7 1]);
%     xlabel('Detecção de Sinal')
%     ylabel('Rejeição de Ruído')
%     close
end
