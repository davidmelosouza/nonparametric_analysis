close all; clear; clc;

vEVT = [25 50 100 500 1000];

for ESTIMADOR = {'HIST','PF','ASH'}
    
    for group = {'ALL','G1','G2','G3','G4'}
        
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
            load([pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[all]EVT[' num2str(EVENTOS) ']'],'BIN','AREA');
            
            DADOS_AREA = [vec(AREA.FD(:,d)');vec(AREA.SC(:,d)');vec(AREA.ST(:,d)');vec(AREA.DO(:,d)');vec(AREA.KN(:,d)');vec(AREA.WA(:,d)');vec(AREA.SS(:,d)');vec(AREA.RU(:,d)');vec(AREA.LH(:,d)');vec(AREA.TR(:,d)')];
            
            Pmean{i} = DADOS_AREA;
        end
        
        for ie = 1:5
            for im = 1:10
                METHOD{im}(:,ie) = Pmean{ie}(im,:);
            end
        end
        
        DATA = {METHOD{1};METHOD{2};METHOD{3};METHOD{4};METHOD{5};METHOD{6};METHOD{7};METHOD{8};METHOD{9};METHOD{10}};
        PLOTBOX(DATA,vEVT,'Amostras','Área do Erro','northeast'); hold on
        grid minor
        set(gca,'Gridlinestyle',':')
        set(gca, 'Position',  [0.1211    0.1351    0.8754    0.8625])
            xlim([0.54 5.46]);
        saveas(gcf,[pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[PERFORMANCE][' group{1} ']'],'fig');
        saveas(gcf,[pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[PERFORMANCE][' group{1} ']'],'png');
        close
      clear Pmean DADOS_AREA METHOD DATA 
    end
end