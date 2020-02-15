% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
type = 'Gaussian';
% vEVT = [25];
vEVT = [25 50 100 500 1000];
nPoint = 1000;
mod='dist';
nEST = 10;
nROI = 250;
nGRID = 10^5;
ntmax = 25;
for name =  {'D4b','D4c','D4d'}
% for name = {'D2a'}
    disp(['=============================' name{1} '=============================' ]);
    for ievt=1:length(vEVT)
        nEVT = round(vEVT(ievt));
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for i=1:ntmax
            disp(['EVT[' num2str(nEVT) ']IT[' num2str(i) ']'])
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            [x,y] = KDE_methods(setup,DATA,nPoint);
%              [A{ievt}(i,:),xgrid,ygrid{ievt}{i}] = areaKDEVAR(DATA,x,y);
             [A{ievt}(i,:),xgrid,ygrid{ievt}{i}] = areaKDEVAR(DATA,x,y);
            for ik = 1:4
                K{ik}(i,ievt)=A{ievt}(i,ik);
            end
        end
    end
    save([pwd '\KDE\KDE[VAR]DIST[' name{1} ']'],'K','xgrid','ygrid');
    %     pause
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PLOT DAS PDFS E ROIS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %     KDEMAP_ROI_MISE(DATA,xgrid,ygrid{1},nROI,setup);
% %      KDEMAP_ROI_ABS(DATA,xgrid,ygrid{1},nROI,setup);
%      KDEMAP_ROI_MIX(DATA,xgrid,ygrid{1},nROI,setup);
%     [KDEMAP_ROI_ABS(DATA,X,Y,nROI,setup)
    %     pause
    %     figure(1)
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[PDF][' name{1} '][1]'],'png');
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[PDF][' name{1} '][1]'],'eps');
    %     close(1)
    %     figure(2)
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[ROI][' name{1} '][1]'],'png');
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[ROI][' name{1} '][1]'],'eps');
    %     close(2)
    %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         KDEMAP_ROI_MIX(DATA,xgrid,ygrid{1},nROI,setup);
    %     figure(1)
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[PDF][' name{1} '][mid]'],'png');
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[PDF][' name{1} '][mid]'],'eps');
    %     close(1)
    %     figure(2)
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[ROI][' name{1} '][mid]'],'png');
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[ROI][' name{1} '][mid]'],'eps');
    %     close(2)
    %     KDEMAP_ROI_MISE(DATA,xgrid,ygrid{end},nROI,setup);
    %     figure(1)
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[PDF][' name{1} '][end]'],'png');
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[PDF][' name{1} '][end]'],'eps');
    %     close(1)
    %     figure(2)
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[ROI][' name{1} '][end]'],'png');
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[ROI][' name{1} '][end]'],'eps');
    %     close(2)
    %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     % BOXPLOT PARA TODOS OS EVENTOS
    %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DADOS = {K{1};K{2};K{3};K{4}};
    %     figure(3)
    %     PLOTBOXKDE_VAR(DADOS,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on
    %     figure(3)
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[NEVT][' name{1} ']'],'png');
    %     saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE\KDEVAR[NEVT][' name{1} ']'],'eps');
    %     close(3)
    %     save([pwd '\DESENVOLVIMENTO\KDEVAR[INFO][' name{1} ']'],'xgrid','ygrid','K');
    %
end