% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
type = 'Gaussian';
% vEVT = [25 50 100 500 1000];
vEVT = [50];
nPoint = 1000;
mod='dist';
nEST = 10;
nROI = 250;
nGRID = 10^5;
ntmax = 1;
% for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}

for name = {'D1a'}
    disp([name{1}]);
    disp('=============================');
    for ievt=1:length(vEVT)
        nEVT = round(vEVT(ievt));
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for i=1:ntmax
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            [h] = h_methods(setup,DATA);
            x = sort(DATA.sg.evt);
%             [h1,R] = stage1(x,h.CV.OSCV);            
%             [hf] = stage2(x,h1,h,R,nPoint);           
            [Xpdf,Ypdf]=ROIKDE(x,h,nPoint);
          
            pause
        end
    end
end




