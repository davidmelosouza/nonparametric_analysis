% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
method = 'ASH';
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
band = 'fix';
nPoint = 1000;
vEVT = [25 50 100 500 1000];
nEST = 1000;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};
for ne = 1:length(vEVT)
    load([pwd '\' method '\' method '[all]EVT[' num2str(vEVT(ne)) ']'],'BIN','AREA');
    A{ne} = AREA;
    B{ne} = BIN;
end

for ie = 1:5
    for id = 1:16
        METHOD.FD{id}(:,ie) = A{ie}.FD(:,id);
        METHOD.SC{id}(:,ie) = A{ie}.SC(:,id);
        METHOD.ST{id}(:,ie) = A{ie}.ST(:,id);
        METHOD.DO{id}(:,ie) = A{ie}.DO(:,id);
        METHOD.KN{id}(:,ie) = A{ie}.KN(:,id);
        METHOD.WA{id}(:,ie) = A{ie}.WA(:,id);
        METHOD.SS{id}(:,ie) = A{ie}.SS(:,id);
        METHOD.RU{id}(:,ie) = A{ie}.RU(:,id);
        METHOD.LH{id}(:,ie) = A{ie}.LH(:,id);
        METHOD.TR{id}(:,ie) = A{ie}.TR(:,id);
        
        METHODBIN.FD{id}(:,ie) = B{ie}.FD(:,id);
        METHODBIN.SC{id}(:,ie) = B{ie}.SC(:,id);
        METHODBIN.ST{id}(:,ie) = B{ie}.ST(:,id);
        METHODBIN.DO{id}(:,ie) = B{ie}.DO(:,id);
        METHODBIN.KN{id}(:,ie) = B{ie}.KN(:,id);
        METHODBIN.WA{id}(:,ie) = B{ie}.WA(:,id);
        METHODBIN.SS{id}(:,ie) = B{ie}.SS(:,id);
        METHODBIN.RU{id}(:,ie) = B{ie}.RU(:,id);
        METHODBIN.LH{id}(:,ie) = B{ie}.LH(:,id);
        METHODBIN.TR{id}(:,ie) = B{ie}.TR(:,id);
    end
end
dn = [1 3 4 5 7 8 10 11 12 14 15 16];
    name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
    dt=0;
for d = dn
    dt = dt+1;
    DADOS_AREA = {METHOD.FD{d};METHOD.SC{d};METHOD.ST{d};METHOD.DO{d};METHOD.KN{d};METHOD.WA{d};METHOD.SS{d};METHOD.RU{d};METHOD.LH{d};METHOD.TR{d}};
    PLOTBOX(DADOS_AREA,vEVT,'Amostras','Área do Erro','northeast'); hold on
    grid minor
    set(gca,'Gridlinestyle',':')
    xlim([0.54 5.46]);
    set(gca,'LooseInset',get(gca,'TightInset'))
    saveas(gcf,[pwd '\' method '\' method '[AREA]DIST[' name_true{dt} ']'],'fig');
    saveas(gcf,[pwd '\' method '\' method '[AREA]DIST[' name_true{dt} ']'],'png');
    close
    
    DADOS_BIN = {METHODBIN.FD{d}-METHODBIN.TR{d};METHODBIN.SC{d}-METHODBIN.TR{d};METHODBIN.ST{d}-METHODBIN.TR{d};METHODBIN.DO{d}-METHODBIN.TR{d};METHODBIN.KN{d}-METHODBIN.TR{d};METHODBIN.WA{d}-METHODBIN.TR{d};METHODBIN.SS{d}-METHODBIN.TR{d};METHODBIN.RU{d}-METHODBIN.TR{d};METHODBIN.LH{d}-METHODBIN.TR{d}};
    PLOTBOX(DADOS_BIN,vEVT,'Amostras','\Delta Bins','northeast'); hold on
    plot([0.54 5.46],[0 0],':k','HandleVisibility','off')
    set(gca,'LooseInset',get(gca,'TightInset'))
    grid minor
    set(gca,'Gridlinestyle',':')
    saveas(gcf,[pwd '\' method '\' method '[BIN]DIST[' name_true{dt} ']'],'fig');
    saveas(gcf,[pwd '\' method '\' method '[BIN]DIST[' name_true{dt} ']'],'png');
    close
end