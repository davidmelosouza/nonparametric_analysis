close all; clear; clc;  

ESTIMADOR = 'KDE';
   d = [1 3 4 5 7 8 10 11 12 14 15 16];
for EVENTOS = [25 50 100 500 1000]
    
    load([pwd '\' ESTIMADOR '\' ESTIMADOR '[paper]EVT[' num2str(EVENTOS) ']'],'H','AREA');
    DADOS_AREA = [median(AREA.SV(:,d));median(AREA.SVM1(:,d));median(AREA.SVM2(:,d));median(AREA.SJ(:,d));median(AREA.SC(:,d));median(AREA.L1I(:,d));median(AREA.MLCV(:,d));median(AREA.UCV(:,d));median(AREA.BCV1(:,d));median(AREA.BCV2(:,d));median(AREA.CCV(:,d));median(AREA.MCV(:,d));median(AREA.TCV(:,d));median(AREA.OSCV(:,d));median(AREA.TRG(:,d));median(AREA.TRE(:,d))];
    DADOS_BIN = [median(H.SV(:,d)-H.TRG(:,d));median(H.SVM1(:,d)-H.TRG(:,d));median(H.SVM2(:,d)-H.TRG(:,d));median(H.SJ(:,d)-H.TRG(:,d));median(H.SC(:,d)-H.TRG(:,d));median(H.L1I(:,d)-H.TRE(:,d));median(H.MLCV(:,d)-H.TRG(:,d));median(H.UCV(:,d)-H.TRG(:,d));median(H.BCV1(:,d)-H.TRG(:,d));median(H.BCV2(:,d)-H.TRG(:,d));median(H.CCV(:,d)-H.TRG(:,d));median(H.MCV(:,d)-H.TRG(:,d));median(H.TCV(:,d)-H.TRG(:,d));median(H.OSCV(:,d)-H.TRG(:,d))];
    DADOS_AREA_STD = [iqr(AREA.SV(:,d));iqr(AREA.SVM1(:,d));iqr(AREA.SVM2(:,d));iqr(AREA.SJ(:,d));iqr(AREA.SC(:,d));iqr(AREA.L1I(:,d));iqr(AREA.MLCV(:,d));iqr(AREA.UCV(:,d));iqr(AREA.BCV1(:,d));iqr(AREA.BCV2(:,d));iqr(AREA.CCV(:,d));iqr(AREA.MCV(:,d));iqr(AREA.TCV(:,d));iqr(AREA.OSCV(:,d));iqr(AREA.TRG(:,d));iqr(AREA.TRE(:,d))];
    DADOS_BIN_STD = [iqr(H.SV(:,d)-H.TRG(:,d));iqr(H.SVM1(:,d)-H.TRG(:,d));iqr(H.SVM2(:,d)-H.TRG(:,d));iqr(H.SJ(:,d)-H.TRG(:,d));iqr(H.SC(:,d)-H.TRG(:,d));iqr(H.L1I(:,d)-H.TRE(:,d));iqr(H.MLCV(:,d)-H.TRG(:,d));iqr(H.UCV(:,d)-H.TRG(:,d));iqr(H.BCV1(:,d)-H.TRG(:,d));iqr(H.BCV2(:,d)-H.TRG(:,d));iqr(H.CCV(:,d)-H.TRG(:,d));iqr(H.MCV(:,d)-H.TRG(:,d));iqr(H.TCV(:,d)-H.TRG(:,d));iqr(H.OSCV(:,d)-H.TRG(:,d))];
    
    plotMATRIXKDE(DADOS_AREA,DADOS_AREA_STD);
%     pause
    saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[MATRIX][AREA]EVT[' num2str(EVENTOS) ']'],'fig');
    saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[MATRIX][AREA]EVT[' num2str(EVENTOS) ']'],'png');
    close
    
    plotMATRIXKDE_SIM(DADOS_BIN,DADOS_BIN_STD);
%     pause
    saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[MATRIX][H]EVT[' num2str(EVENTOS) ']'],'fig');
    saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[MATRIX][H]EVT[' num2str(EVENTOS) ']'],'png');
    close
end
