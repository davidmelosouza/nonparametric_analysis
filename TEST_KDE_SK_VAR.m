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
vEVT = [25 1000];
nPoint = 1000;
mod = 'dist';
%
nEST = nPoint;
nROI = 1;
nGRir = 10^5;
ntmax = 100;

for name = {'GGD','Logn'}
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
                if strcmp(name{1},'Logn')
                    sk(im,id)=skewness(DATA.sg.evt);
                    kind = 'Skewness';
                else
                    sk(im,id)=kurtosis(DATA.sg.evt);
                    kind = 'Kurtosis';
                end
                
                [x,y] = KDE_methods(setup,DATA,nPoint);
                [A,~,~] = areaKDEVAR(DATA,x,y);
                
                AREA.SS(im,id)= A(1);
                AREA.BKDE(im,id)= A(2);
                AREA.SV(im,id)= A(3);
                AREA.KDEROI(im,id)= A(4);
                
                %             pause
                disp(['[KDE][PCT][' num2str(id/length(range.SK)) ']NAME[' name{1} ']IT[' num2str(im) ']TIME[' num2str(toc) ']'])
            end
        end
        save([pwd '\KDE\KDE[SK][VAR]DIST[' name{1} ']EVT[' num2str(nEVT) ']'],'AREA');
    end
end