% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
band = 'fix';
type = 'Gaussian';
cl = 'yrbgkmc';
% vEVT = [25 50 100 500 1000];
vEVT = [50];
nPoint = 1000;
mod = 'dist';
%
nEST = nPoint;
nROI = 1;
nGRir = 10^5;
ntmax = 1;

for name = {'Logn'}
    for ne = 1:length(vEVT)
        nEVT = vEVT(ne);
        if strcmp(name,'Logn')
            range.SK =linspace(0.1,1,10);
        else
            range.SK = sort([logspace(0,1,9) 2]);
        end
        for id=1:length(range.SK)
            
            for im=1:ntmax
                tic
                [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRir,nEST,nROI);   % Definir os Parâmetros Iniciais
                if strcmp(name{1},'Logn')
                    setup.mu=0;
                    setup.std = range.SK(id);
                else
                    setup.rho = range.SK(id);
                end
                setup.ir=id;
                [DATA] = datasetGenSK(setup); DATA.nPoint = 1000;
                h = h_methods(setup,DATA);
                [A,L2,X,pdf] = areaKDEfix(setup,DATA,nPoint,h);
                plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'k'); hold on
                plot(X.L1I,pdf.L1I,':r'); hold on
                plot(X.TCV,pdf.TCV,'-r'); hold on
                 plot(X.OSCV,pdf.OSCV,'-b'); hold on
                xlabel('Variavel Aleatória')
                ylabel('Densidade de Probabilidade')
                legend('PDF','L1I','TCV','OSCV')
                pause
                close
            end
        end
        %         save([pwd '\KDE\KDE[SK]DIST[' name{1} ']EVT[' num2str(nEVT) ']'],'H','AREA','ERRORL2');
    end
end