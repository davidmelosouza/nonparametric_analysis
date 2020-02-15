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
nev = [100000];

for ne_cut = nev
    ic = ic+1;
    %%=========================================== LIKELIHOOD - TRAINING =====================================================
    for it = 1:itmax
        [ind.trainf,ind.valf,ind.test] = dividerand(2*ne,0.25,0.25,0.5);
        [ind] = cut_ind(ind,target,ne_cut);
        data.TRAIN=data.full(:,ind.train);
        data.VAL=data.full(:,ind.val);
        id = 0;
        for d= 1:13
            id = id+1;
            
            [x.sg,y.sg] = KDEfast_fixed(data.TRAIN(d,target(ind.train)==1),3*SJbandwidth(data.TRAIN(d,target(ind.train)==1)'),nPoint);
            [x.bg,y.bg] = KDEfast_fixed(data.TRAIN(d,target(ind.train)==0),3*SJbandwidth(data.TRAIN(d,target(ind.train)==0)'),nPoint);
            subplot(4,4,id);hsg=area(x.sg,y.sg); hold on; alpha(0.5); 
            hsg.FaceColor = [0.5 0.5 0.5];
            hsg.EdgeColor = [0.5 0.5 0.5];
            subplot(4,4,id);hbg=area(x.bg,y.bg); hold on; alpha(0.5);axis tight
            hbg.FaceColor = [0.5 0 0];
            hbg.EdgeColor = [0.5 0 0];
            pause(0.5)
            xlabel('Variável Aleatória')
            ylabel('Densidade')
            legend('Sinal','Ruído')
        end
    end
    
    
    %     save([pwd '\KDE\CLASSIFICATION[ROC][ATLAS]EVT[' num2str(ne_cut) ']'],'M');
    
    
end
