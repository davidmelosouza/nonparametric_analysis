% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
band = 'fix';
nPoint = 1000;
nEVT = 5000;
ntmax = 100;
nROI = 1;
nGRID = 10000;
vEVT = [25];
ne = 0;
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
nEST = vEVT;
ntmax = 50;
vnr =[2:2:10];
vnl =[2:2:10];
ni=0;
for nr =vnr
    ni=ni+1;
    nil=0;
    for nl =vnl
        nil=nil+1;
        for nt = 1:ntmax
            ne=0;
            for ne_cut = [25]
                ne=ne+1;
                disp(['NEURON[' num2str(nr) ']NT[' num2str(nt) ']NE[' num2str(ne_cut) ']'])
                [DADO.SG] = signal_GEN(nEVT,nGRID,nEST,nROI);
                [DADO.BG] = background_GEN(nEVT,nGRID,nEST,nROI);
                
                DATA.FULL = [DADO.SG.EVT DADO.BG.EVT];
                TARGET =[ones(1,nEVT) zeros(1,nEVT)];
                n = length(DATA.FULL);
                
                [ind.trainf,ind.valf,ind.test] = dividerand(n,0.25,0.25,0.5);
                [ind] = cut_ind(ind,TARGET,ne_cut);
                
                
                DATA.TRAIN = DATA.FULL(:,ind.train);
                DATA.TEST = DATA.FULL(:,ind.test);
                [net] = BP_RNA(DATA.FULL,TARGET,[nr nl],ind);
                
                out = net(DATA.TEST);
                [auc.rna,fpr.rna,tpr.rna] = fastAUC(logical(TARGET(ind.test))',out',0);
                [bsp.rna,ei.rna,es.rna] = best_sp(tpr.rna,fpr.rna,DATA.TEST(1,TARGET(ind.test)==1),DATA.TEST(1,TARGET(ind.test)==0));
                spv(nt,ni,nil) = bsp.rna;
                clear ind
            end
        end
    end
end

save([pwd '\KDE\RNA[H][SIMULATION][25]TEST'],'spv');

MSP = reshape(mean(spv),size(spv,2),size(spv,3));
SSP = reshape(std(spv),size(spv,2),size(spv,3));

for i=1:5
    errorbar(vnr,MSP(:,i),SSP(:,i)/sqrt(ntmax),':s'); hold on
end
legend('25 Amostras','50 Amostras','100 Amostras','500 Amostras','1000 Amostras')
