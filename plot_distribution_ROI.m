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
vEVT = 50;
nEST = 10000;
nROI = 20;
nGRID = 10^5;
ntmax = 1;

for ne = 1:length(vEVT)
    id = 0;
    nEVT =vEVT(ne);
    %     load([pwd '\KDE\KDE[full]PDF[' num2str(nEVT) ']'],'xgrid','ygrid');
    %     pause
    for name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
        name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
        [setup] = IN(name{1},'sg',errortype,'deriv',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenMix(setup);
        id = id+1;
        figure
%         hf=area(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y); hold on
%         hf.FaceColor = [0.75 0.75 0.75];
%         hf.EdgeColor = [0.75 0.75 0.75];
        in=0;
        for i = DATA.sg.RoI.iRoI
            in=in+1;
%             hf=area(DATA.sg.RoI.x{i},DATA.sg.RoI.y{i}); hold on
            hf=area(DATA.sg.pdf.truth.x(DATA.sg.RoI.ind{in}),DATA.sg.pdf.truth.y(DATA.sg.RoI.ind{i})); hold on
               hf.FaceColor = [0.75 0.75 0.75];
              hf.EdgeColor = [1 1 1];
%             hf.FaceColor = [0.5+5*(i/10) 0.5+5*(i/10) 0.5+5*(i/10)];
%             hf.EdgeColor = [0.5+5*(i/10) 0.5+5*(i/10) 0.5+5*(i/10)];
            hold on
        end
        
        for j = 1:nROI
        xl(j) = (DATA.sg.RoI.x{j}(1)+DATA.sg.RoI.x{j}(end))/2;
        end
        xticks(sort(xl))
        xticklabels({'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'})
        axis tight
        
        %       plot(xgrid{id}.SVM1,ygrid{id}.SVM1,'-k','linewidth',1)
        %       plot(xgrid{id}.SJ,ygrid{id}.SJ,'-r','linewidth',1)
        %       plot(xgrid{id}.CCV,ygrid{id}.CCV,'-b','linewidth',1)
        axis tight
        ylabel('Densidade de Probabilidade','Fontsize',14)
        xlabel('Região de Interesse','Fontsize',14)
        set(gca,'Fontsize',12)
        pause
        %             saveas(gcf,[pwd '\figuras\desenvolvimento\[DIST][' name_true{id} ']'],'fig');
        %      saveas(gcf,[pwd '\figuras\desenvolvimento\[DIST][' name_true{id} ']'],'png');
        
        close
        %         if id==1
        %             %     subplot(4,4,id);legend('Model','SVM1','SJ','CCV')
        %         end
    end
    
end
% matplot(DADOS_BIN,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', '\DeltaBins')
% matplot(DADOS_AREA,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', 'Error Area')
% matplot(DADOS_AREA_VAR,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', '\sigma')