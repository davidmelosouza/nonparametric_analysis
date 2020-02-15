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
nEVT = 1000;
ntmax = 1;
nROI = 1;
nGRID = 10^7;
vEVT = [100:100:1000 2000:1000:10000 50000 10^5 10^6];
ne = 0;
wb=waitbar(0,'Aguarde...');
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
for nEST = vEVT
    ne = ne+1;
        for nt=1:ntmax
        p=0;
       for name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
            p=p+1;
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenMix(setup);  
            [yGrid] = GridNew(DATA.sg,DATA.sg.pdf.truth.x,name{1});%
            xEST = linspace(DATA.sg.pdf.truth.x(1),DATA.sg.pdf.truth.x(end),nEST);
            [yEST] = GridNew(DATA.sg,xEST,name{1});            
            yGRID = interp1(xEST,yEST,DATA.sg.pdf.truth.x,'linear',0);
            
            Aerro(nt,p,ne) = area2d(DATA.sg.pdf.truth.x,abs(yGRID-yGrid));
            
        end
        end
    waitbar(ne/length(vEVT))
end
close(wb)
ln=[{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'}];
mk=[{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'}];
cl=[{'k'},{'k'},{'k'},{'r'},{'r'},{'r'},{'b'},{'b'},{'b'},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]}];
% 
% mA = reshape(mean(Aerro),12,length(vEVT));
% sA = reshape(std(Aerro),12,length(vEVT));
mA = reshape((Aerro),12,length(vEVT));
% sA = reshape((Aerro),12,length(vEVT));

ind = [1 4 10:3:19 20:22];

for i=1:12
plot(vEVT(ind),mA(i,ind),[':' mk{i}],'Color',cl{i},'markersize',5,'markerfacecolor',[cl{i}],'markeredgecolor','k'); hold on
end
set(gca,'yscale','log','xscale','log')
% xlim([100 50000])
% ylim([1e-4 1e0])
grid on
set(gca,'Gridlinestyle',':')
legend(name_true,'Location','northeast','FontSize' ,12);
lgd = legend;
lgd.NumColumns = 2;
xlabel('Pontos de Grid','FontSize' ,14)
ylabel('Área do Erro','FontSize' ,14)

% 
% TABLE=[mA(:,ind(end-1))]
% save TABLE_pts_GRID TABLE
