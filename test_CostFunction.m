% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
dist = 0;
band = 'fix';
vEVT = [25];
% vEVT = [50];
nPoint = 10000;
for name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
    dist = dist+1;
    for j=1:length(vEVT)
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
        ntmax = 1;
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenMix(setup); DATA.nPoint = 1000;
        for i=1:ntmax
            tic
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenMix(setup); DATA.nPoint = 1000;
            h{dist} = h_methods(setup,DATA);
            toc
        end
    end
end

ln=[{'-'},{':'},{'--'},{'-'},{':'},{'--'},{'-'},{':'},{'--'},{'-'},{':'},{'--'}];
mk=[{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'}];
cl=[{'k'},{'k'},{'k'},{'r'},{'r'},{'r'},{'b'},{'b'},{'b'},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]}];
dn = [1 3 4 5 7 8 10 11 12 14 15 16];
L = [{'MLCV','UCV','BCV1','BCV2','CCV','MCV','TCV','OSCV'}];
nameCV = [{'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'}];
for m=1:8
    idn=0;
    for d=dn
        idn=idn+1;        
        V = (h{d}.CV.Cost{m}-min(h{d}.CV.Cost{m}))/(max(h{d}.CV.Cost{m}-min(h{d}.CV.Cost{m})));
        plot(h{d}.CV.newrange,V, 'linestyle',ln{idn},'color', cl{idn},'linewidth',1); hold on
    end
    
    axis tight
    xlim([0 5])
     ylim([0 0.5])
    legend(nameCV,'Location','best');
    lgd = legend;
    lgd.NumColumns = 3;
    set(gca,'Fontsize',16);
    grid minor
    set(gca,'Gridlinestyle',':')
    xlabel('h'); % Set the X-axis label
    ylabel('Cost Funtion'); % Set the X-axis label
    set(gca,'Fontsize',12);
%     pause
    saveas(gcf,[pwd '\KDE\KDE[CostCV]EVT[' num2str(nEVT) ']METHOD[' L{m} ']'],'fig');
    saveas(gcf,[pwd '\KDE\KDE[CostCV]EVT[' num2str(nEVT) ']METHOD[' L{m} ']'],'png');
    close
end

