clear;
clc;

ne = 100000;
ntmax = 100;
itmax = 25;
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
        [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.5,0.25);
        isg = find(target(ind.trainf)==1); isg = isg(randperm(length(isg),ne_cut));
        ibg = find(target(ind.trainf)==0); ibg = ibg(randperm(length(ibg),ne_cut));
        itrain = [isg ibg];
        ind.train = ind.trainf(:,itrain(randperm(length(itrain),length(itrain))));
        ind.val = ind.valf(:,randi(length(ind.valf),ne_cut,1));
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
            [LH] = LH_ATLAS(p);
            [auc.SS,fpr.SS,tpr.SS] = fastAUC(logical(target(ind.test))',LH(1,:)',0);
            [auc.BKDE,fpr.BKDE,tpr.BKDE] = fastAUC(logical(target(ind.test))',LH(2,:)',0);
            [auc.SV,fpr.SV,tpr.SV] = fastAUC(logical(target(ind.test))',LH(3,:)',0);
            [auc.MGKDE,fpr.MGKDE,tpr.MGKDE] = fastAUC(logical(target(ind.test))',LH(4,:)',0);
            aucv.SS{ic}{it}(nt,:) =auc.SS;
            aucv.BKDE{ic}{it}(nt,:) =auc.BKDE;
            aucv.SV{ic}{it}(nt,:) =auc.SV;
            aucv.MGKDE{ic}{it}(nt,:) =auc.MGKDE;
            [bsp.SS,ei.SS,es.SS] = best_sp(tpr.SS,fpr.SS,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            [bsp.BKDE,ei.BKDE,es.BKDE] = best_sp(tpr.BKDE,fpr.BKDE,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            [bsp.SV,ei.SV,es.SV] = best_sp(tpr.SV,fpr.SV,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            [bsp.MGKDE,ei.MGKDE,es.MGKDE] = best_sp(tpr.MGKDE,fpr.MGKDE,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            spv.SS{ic}{it}(nt,:) = bsp.SS;
            spv.BKDE{ic}{it}(nt,:) = bsp.BKDE;
            spv.SV{ic}{it}(nt,:) = bsp.SV;
            spv.MGKDE{ic}{it}(nt,:) = bsp.MGKDE;
            %%=============================================== RNA - TEST =======================================================
            out = net(data.TEST);
            [auc.rna,fpr.rna,tpr.rna] = fastAUC(logical(target(ind.test))',out',0);
            aucv.rna{ic}{it}(nt,:) =auc.rna;
            [bsp.rna,ei.rna,es.rna] = best_sp(tpr.rna,fpr.rna,data.TEST(d,target(ind.test)==1),data.TEST(d,target(ind.test)==0));
            spv.rna{ic}{it}(nt,:) = bsp.rna;            
              MSP{it}(nt,:)= bsp.rna;
            %%========================================================================================================================
            disp(['[' num2str(ic) '][' num2str(nt) ']=>TR[' num2str(length(ind.train)) ']VAL[' num2str(length(ind.val)) ']TEST[' num2str(length(ind.test)) ']'])
            clear p LH auc fpr tpr
        end        
    end 
      save([pwd '\KDE\CLASSIFICATION[SP]EVT[' num2str(ne_cut) ']'],'MSP');
end
  save([pwd '\KDE\CLASSIFICATION[SP]'],'spv');
  
ic = 0;
for ne = nev
    ic = ic+1;
    for it=1:itmax
        V(it,1,ic)=mean(spv.SS{ic}{it});
        V(it,2,ic)=mean(spv.BKDE{ic}{it});
        V(it,3,ic)=mean(spv.SV{ic}{it});
        V(it,4,ic)=mean(spv.MGKDE{ic}{it});
        V(it,5,ic)=mean(spv.rna{ic}{it});
    end
end

V = reshape(mean(V),size(V,2),size(V,3));
cl = 'rrkkb'; mk = '^v^vs'; ln=':-:--';

for m = 1:5
    plot(nev,V(m,:),[ln(m) cl(m) mk(m)]); hold on
end
legend('SS','BKDE','SV','ROIKDE','RNA','Location','Southwest')
grid minor
% ylim([70 100]);
xlabel('Amostras')
ylabel('melhor SP')