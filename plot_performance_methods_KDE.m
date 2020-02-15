close all; clear; clc;

vEVT = [25 50 100 500 1000];

ESTIMADOR = 'KDE';

for group = {'ALL','G1','G2','G3','G4'}
%     group = 'LARGE';
        if strcmp(group,'ALL')
            d = [1 3 4 5 7 8 10 11 12 14 15 16];
        elseif strcmp(group,'G1')
            d = [1 3 4];
        elseif strcmp(group,'G2')
            d = [5 7 11];
        elseif strcmp(group,'G3')
            d = [8 10 12];
        elseif strcmp(group,'G4')
            d = [14 15 16];
        end
    
    for i = 1:length(vEVT)
        EVENTOS = vEVT(i);
        load([pwd '\' ESTIMADOR '\' ESTIMADOR '[paper]EVT[' num2str(EVENTOS) ']'],'H','AREA');
        
        %         DADOS_AREA = [vec(AREA.SV(:,d)');vec(AREA.SVM1(:,d)');vec(AREA.SVM2(:,d)');vec(AREA.SJ(:,d)');vec(AREA.SC(:,d)');vec(AREA.L1I(:,d)');vec(AREA.MLCV(:,d)');vec(AREA.UCV(:,d)');vec(AREA.BCV1(:,d)');vec(AREA.BCV2(:,d)');vec(AREA.CCV(:,d)');vec(AREA.MCV(:,d)');vec(AREA.TCV(:,d)');vec(AREA.OSCV(:,d)');vec(AREA.TR(:,d)')];
        DADOS_AREA = [vec(AREA.SV(:,d)');vec(AREA.SVM1(:,d)');vec(AREA.SVM2(:,d)');vec(AREA.SJ(:,d)');vec(AREA.SC(:,d)');vec(AREA.L1I(:,d)');vec(AREA.rMLCV(:,d)');vec(AREA.rUCV(:,d)');vec(AREA.rBCV1(:,d)');vec(AREA.rBCV2(:,d)');vec(AREA.rCCV(:,d)');vec(AREA.rMCV(:,d)');vec(AREA.TCV(:,d)');vec(AREA.rOSCV(:,d)');vec(AREA.TRG(:,d)');vec(AREA.TRE(:,d)')];
        
        Pmean{i} = DADOS_AREA;
    end
    
    for ie = 1:5
        for im = 1:16
            METHOD{im}(:,ie) = Pmean{ie}(im,:);
        end
    end
    
    DATA = {METHOD{1};METHOD{2};METHOD{3};METHOD{4};METHOD{5};METHOD{6};METHOD{7};METHOD{8};METHOD{9};METHOD{10};METHOD{11};METHOD{12};METHOD{13};METHOD{14};METHOD{15};METHOD{16}};
    PLOTBOXKDE(DATA,vEVT,'Amostras','Erro de Área','northeast'); hold on
    grid minor
    set(gca,'Gridlinestyle',':')
    xlim([0.54 5.46]);
    set(gca,'LooseInset',get(gca,'TightInset'))
    
    saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[PERFORMANCE][' group{1} ']'],'fig');
    saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[PERFORMANCE][' group{1} ']'],'png');
    close
    clear Pmean DADOS_AREA METHOD DATA
end