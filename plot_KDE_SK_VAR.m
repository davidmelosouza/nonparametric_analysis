close all; clear; clc;

ESTIMADOR = 'KDE';
for  EVENTOS = [1000]
    for dist = {'Logn','GGD'}
        
        
        load([pwd '\' ESTIMADOR '\SK_MGKDE[INFO][' dist{1} ']']);
        load([pwd '\' ESTIMADOR '\XSK[' dist{1} ']'])
%         AREA.SS(AREA.SS>2)=2;
%         AREA.SS(AREA.BKDE>2)=2;
%         AREA.SS(AREA.SV>2)=2;
%         AREA.SS(AREA.KDEROI>2)=2;
        DADOS_AREA = [{DADOS_AREA{1}};{DADOS_AREA{2}};{DADOS_AREA{3}};{DADOS_AREA{4}}];

       x_sk= round(x_sk,1);
        if strcmp(dist{1},'Logn')
            kind = 'Assimetria';
        else
            kind = 'Curtose';
        end
        
        
        PLOTBOXKDE_VAR(DADOS_AREA,x_sk,kind,'Área do Erro','northwest'); hold on
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        grid minor
        set(gca,'Gridlinestyle',':')
        set(gca,'LooseInset',get(gca,'TightInset'))
        set(gca, 'Position',  [ 0.0734    0.1140    0.9252    0.8784])
        xlim([0.54 10.46]);
         ylim([0.035 0.15]);
        
        saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[' kind '][VAR]EVENTOS[' num2str(EVENTOS) ']'],'png');
        saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[' kind '][VAR]EVENTOS[' num2str(EVENTOS) ']'],'fig');

        pause(0.5)
        close
    end
end