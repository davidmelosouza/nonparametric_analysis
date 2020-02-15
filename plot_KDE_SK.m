close all; clear; clc;

ESTIMADOR = 'KDE';
for  EVENTOS = [25 50 100 500 1000]
    for dist = {'Logn'}
        
        
        load([pwd '\' ESTIMADOR '\' ESTIMADOR '[SK]DIST[' dist{1} ']EVT[' num2str(EVENTOS) ']'],'H','AREA');
        load([pwd '\' ESTIMADOR '\XSK[' dist{1} ']'])
        DADOS_AREA = [{AREA.SV};{AREA.SVM1};{AREA.SVM2};{AREA.SJ};{AREA.SC};{AREA.L1I};{AREA.MLCV};{AREA.UCV};{AREA.BCV1};{AREA.BCV2};{AREA.CCV};{AREA.MCV};{AREA.TCV};{AREA.OSCV};{AREA.TR}];
        
       x_sk= round(x_sk,1);
        if strcmp(dist{1},'Logn')
            kind = 'Assimetria';
        else
            kind = 'Curtose';
        end
        
        
        PLOTBOXKDE_SK(DADOS_AREA,x_sk,kind,'Área do Erro','northeast'); hold on
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        grid minor
        set(gca,'Gridlinestyle',':')
        set(gca,'LooseInset',get(gca,'TightInset'))
        set(gca, 'Position',  [ 0.0734    0.1140    0.9252    0.8784])
        xlim([0.54 10.46]);
        
        saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[' kind ']DIST[' dist{1} ']EVENTOS[' num2str(EVENTOS) ']'],'fig');
        saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[' kind ']DIST[' dist{1} ']EVENTOS[' num2str(EVENTOS) ']'],'png');
        pause(0.5)
        close
    end
end