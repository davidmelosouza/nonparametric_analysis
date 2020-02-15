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
nROI = 1;
nGRID = 10^5;
ntmax = 1;


for ne = 1:length(vEVT)
    id = 0;
    nEVT =vEVT(ne);
    %     load([pwd '\KDE\KDE[full]PDF[' num2str(nEVT) ']'],'xgrid','ygrid');
    %     pause
    for name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
        name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
        
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenMix(setup);
        id = id+1;
        figure
        hf=area(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y); hold on
        xest = linspace(min(DATA.sg.pdf.truth.x),max(DATA.sg.pdf.truth.x),100);
        xgrid = linspace(min(DATA.sg.pdf.truth.x),max(DATA.sg.pdf.truth.x),1000);
        [yest] = GridNew(DATA.sg,xest,name{1});
        [ygrid] = GridNew(DATA.sg,xgrid,name{1});
        plot(xest,yest,'ok','markersize',2);
        plot(xgrid,ygrid,'.r','markersize',1);
        hf.FaceColor = [0.75 0.75 0.75];
        hf.EdgeColor = [0.75 0.75 0.75];
        %       plot(xgrid{id}.SVM1,ygrid{id}.SVM1,'-k','linewidth',1)
        %       plot(xgrid{id}.SJ,ygrid{id}.SJ,'-r','linewidth',1)
        %       plot(xgrid{id}.CCV,ygrid{id}.CCV,'-b','linewidth',1)
        axis tight
        ylabel('Densidade de Probabilidade','Fontsize',14)
        xlabel('Variável Aleatória','Fontsize',14)
        title(name_true{id},'Fontsize',12)
        pause
        %             saveas(gcf,[pwd '\figuras\desenvolvimento\[DIST][' name_true{id} ']'],'fig');
        %      saveas(gcf,[pwd '\figuras\desenvolvimento\[DIST][' name_true{id} ']'],'png');
        
        close
        %         if id==1
        %             %     subplot(4,4,id);legend('Model','SVM1','SJ','CCV')
        %         end
    end
    
end
