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
nev = [10000];

ic = 0;
for ne_cut = nev
    ic = ic+1;
    %%=========================================== LIKELIHOOD - TRAINING =====================================================
    for it = 1:itmax
        for d= 1:size(data.full,1)
            x.sg = DADO.SG.PDF.x(d,:); y.sg = DADO.SG.PDF.y(d,:);
            x.bg = DADO.BG.PDF.x(d,:); y.bg = DADO.BG.PDF.y(d,:);
            subplot(2,3,d);hsg=area(x.sg,y.sg); hold on; alpha(0.5);
            hsg.FaceColor = [0.5 0.5 0.5];
            hsg.EdgeColor = [0.5 0.5 0.5];
            subplot(2,3,d);hbg=area(x.bg,y.bg); hold on; alpha(0.5);axis tight
            hbg.FaceColor = [0.5 0 0];
            hbg.EdgeColor = [0.5 0 0];
            pause(0.5)
            xlabel('Variável Aleatória')
            ylabel('Densidade')
            legend('Sinal','Ruído')
        end
        %%=============================================== RNA - TRAINING ========================================================
        %%========================================================================================================================
        
    end
    
end
