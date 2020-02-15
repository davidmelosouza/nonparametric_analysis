close all; clear; clc;

vEVT = [25 50 100 500 1000];
in=0;
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
for d = [1 3 4 5 7 8 10 11 12 14 15 16]
    in = in+1;
    for i = 1:length(vEVT)
        EVENTOS = vEVT(i);
        load([pwd '\HIST\HIST[all]EVT[' num2str(EVENTOS) ']'],'BIN','AREA');
        DADOS_HIST = [vec(AREA.RU(:,d)')];
        load([pwd '\PF\PF[all]EVT[' num2str(EVENTOS) ']'],'BIN','AREA');
        DADOS_PF = [vec(AREA.RU(:,d)')];
        load([pwd '\ASH\ASH[all]EVT[' num2str(EVENTOS) ']'],'BIN','AREA');
        DADOS_ASH = [vec(AREA.RU(:,d)')];
        load([pwd '\KDE\KDE[paper]EVT[' num2str(EVENTOS) ']'],'H','AREA');
        DADOS_KDE = [vec(AREA.rOSCV(1:50,d)')];
        DADOS_AREA = [DADOS_HIST;DADOS_PF;DADOS_ASH;DADOS_KDE];
        Pmean{i} = DADOS_AREA;
    end
    
    for ie = 1:5
        for im = 1:4
            METHOD{im}(:,ie) = Pmean{ie}(im,:);
        end
    end
    
    DATA_MEAN = [mean(METHOD{1});mean(METHOD{2});mean(METHOD{3});mean(METHOD{4})];
    DATA_STD = [std(METHOD{1});std(METHOD{2});std(METHOD{3});std(METHOD{4})]/sqrt(50);
    
    cl = ['kkkr'];
    mk = ['v^os'];
    
    for i=1:4
        errorbar(vEVT,DATA_MEAN(i,:),DATA_STD(i,:),':','marker',mk(i),'markersize',7,'color',cl(i),'markerfacecolor',cl(i),'markeredgecolor','w'); hold on
    end
    
    legend({'Histograma','PF','ASH','KDE'},'Fontsize',14);
    grid on
    set(gca,'Gridlinestyle',':');
    set(gca, 'Position',  [0.1140    0.1200    0.8538    0.8739])
    axis tight
    xlabel('Amostras');
    ylabel('Área do Erro');
    set(gca,'Fontsize',12)
    % xlim([0.54 5.46]);
    saveas(gcf,[pwd '\COMPARACAO\COMP[FIX][' name_true{in} ']'],'fig');
    saveas(gcf,[pwd '\COMPARACAO\COMP[FIX][' name_true{in} ']'],'png');
    pause(0.5)
    close
    clear Pmean DADOS_AREA METHOD DATA
end
