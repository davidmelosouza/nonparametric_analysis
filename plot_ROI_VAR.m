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
nROI = 500;
nGRID = 10^5;
ntmax = 25;
for name =  {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
    % for name = {'D1a','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
    nEVT = vEVT(1);
    disp(['=============================' name{1} '=============================' ]);
    [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
    [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
    load([pwd '\KDE\BEST\KDE[VAR]DIST[' name{1} ']']);
    %     pause
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PLOT DAS PDFS E ROIS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %      KDEMAP_ROI_MISE(DATA,xgrid,ygrid{1},nROI,setup);
    %      KDEMAP_ROI_ABS(DATA,xgrid,ygrid{1},nROI,setup);
    KDEMAP_ROI_MIX(DATA,xgrid,ygrid{1},nROI,setup);
    set(gcf, 'WindowState', 'maximized');
    saveas(gcf,[pwd '\KDE\KDEVAR[ROIMAP][' name{1} ']EVT[' num2str(nEVT) ']'],'png');
    %     saveas(gcf,[pwd '\KDE\KDEVAR[ROIMAP][' name{1} ']'],'fig');
    close
    clear xgrid ygrid
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