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
% vEVT = [25 50 100 500 1000];
vEVT = [25];
nPoint = 2000;
mod='dist';
nEST = 10;
nROI = 250;
nGRID = 10^5;
ntmax = 5;
% name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
for name =  {'D4c'}
    % for name = {'D2a'}
    disp(['=============================' name{1} '=============================' ]);
    for ievt=1:length(vEVT)
        nEVT = round(vEVT(ievt));
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for i=1:ntmax
            disp(['EVT[' num2str(nEVT) ']IT[' num2str(i) ']'])
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            [h] = h_methods(setup,DATA);
            [X,Y,hi,hf]=KDE_STAGES(DATA,h,nPoint);
            [A{ievt}(i,:),xgrid,ygrid{ievt}{i}] = areaKDEVAR_STAGE(DATA,X,Y);
            %             pause            
            for ik = 1:4
                K{ik}(i,ievt)=A{ievt}(i,ik);
            end
        end
    end
    %     save([pwd '\KDE\KDE[VAR]DIST[' name{1} ']'],'K','xgrid','ygrid');    
end


DADOS = {K{1};K{2};K{3};K{4}};
PLOTBOXKDE_VAR_STAGE(DADOS,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on

figure
x = sort(DATA.sg.evt);
plot(x,hi.s0,'s:r'); hold on
plot(x,ones(length(x),1)*hf.s0,'-r'); 
plot(x,hi.s1,'s:b');
plot(x,ones(length(x),1)*hf.s1,'-b');
plot(x,hi.s2,'s:g');
plot(x,ones(length(x),1)*hf.s2,'-g');
plot(x,hi.s3,'s:m');
plot(x,ones(length(x),1)*hf.s3,'-m');
plot(x,hi.T,'s:k');
plot(x,ones(length(x),1)*hf.T,'-k');
% legend('Stage0','Stage1','Stage2','Stage3','Truth')
legend('Stage0','fix0','Stage1','fix1','Stage2','fix2','Stage3','fix3','Truth','fixTruth')
