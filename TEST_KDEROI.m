% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
type = 'Gaussian';
vEVT = [25 50 100 500 1000];
nPoint = 1000;
mod='dist';
nEST = 10;
nROI = 1;
nGRID = 10^5;
ntmax = 25;
% for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
    disp([name{1}]);
    disp('=============================');
    for ievt=1:length(vEVT)
        nEVT = round(vEVT(ievt));
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for i=1:ntmax
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            [x,y] = KDEROI_methods(setup,DATA,nPoint);
            [A{ievt}(i,:),xgrid,ygrid{ievt}{i}] = areaKDEROI_VAR(DATA,x,y);
            for ik = 1:3
                K{ik}(i,ievt)=A{ievt}(i,ik);
            end
        end
    end
    %     save([pwd '\KDE\KDE[ROIKDE]DIST[' name{1} ']'],'K','xgrid','ygrid');
    save([pwd '\KDE\KDE[ROIKDE]DIST[' name{1} ']'],'K');
end

DADOS = {K{1};K{2};K{3};K{4}};
%     figure(3)
%     PLOTBOXKDE_VAR(DADOS,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on