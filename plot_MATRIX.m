close all; clear; clc;

for ESTIMADOR = {'HIST','PF','ASH'}
   d = [1 3 4 5 7 8 10 11 12 14 15 16];
for EVENTOS = [25 50 100 500 1000]
    
    load([pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[all]EVT[' num2str(EVENTOS) ']'],'BIN','AREA');
    
    DADOS_BIN = [median(BIN.FD(:,d)-BIN.TR(:,d));median(BIN.SC(:,d)-BIN.TR(:,d));median(BIN.ST(:,d)-BIN.TR(:,d));median(BIN.DO(:,d)-BIN.TR(:,d));median(BIN.KN(:,d)-BIN.TR(:,d));median(BIN.WA(:,d)-BIN.TR(:,d));median(BIN.SS(:,d)-BIN.TR(:,d));median(BIN.RU(:,d)-BIN.TR(:,d));median(BIN.LH(:,d)-BIN.TR(:,d))];
    DADOS_AREA = [median(AREA.FD(:,d));median(AREA.SC(:,d));median(AREA.ST(:,d));median(AREA.DO(:,d));median(AREA.KN(:,d));median(AREA.WA(:,d));median(AREA.SS(:,d));median(AREA.RU(:,d));median(AREA.LH(:,d));median(AREA.TR(:,d))];
    DADOS_AREA_STD = [iqr(AREA.FD(:,d));iqr(AREA.SC(:,d));iqr(AREA.ST(:,d));iqr(AREA.DO(:,d));iqr(AREA.KN(:,d));iqr(AREA.WA(:,d));iqr(AREA.SS(:,d));iqr(AREA.RU(:,d));iqr(AREA.LH(:,d));iqr(AREA.TR(:,d))];
    DADOS_BIN_STD = [iqr(BIN.FD(:,d)-BIN.TR(:,d));iqr(BIN.SC(:,d)-BIN.TR(:,d));iqr(BIN.ST(:,d)-BIN.TR(:,d));iqr(BIN.DO(:,d)-BIN.TR(:,d));iqr(BIN.KN(:,d)-BIN.TR(:,d));iqr(BIN.WA(:,d)-BIN.TR(:,d));iqr(BIN.SS(:,d)-BIN.TR(:,d));iqr(BIN.RU(:,d)-BIN.TR(:,d));iqr(BIN.LH(:,d)-BIN.TR(:,d))];
    
    plotMATRIX(DADOS_AREA,DADOS_AREA_STD);
%     pause
    saveas(gcf,[pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[MATRIX][AREA]EVT[' num2str(EVENTOS) ']'],'fig');
        saveas(gcf,[pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[MATRIX][AREA]EVT[' num2str(EVENTOS) ']'],'png');
    close
    
    plotMATRIX_SIM(DADOS_BIN,DADOS_BIN_STD);
    saveas(gcf,[pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[MATRIX][BIN]EVT[' num2str(EVENTOS) ']'],'fig');
        saveas(gcf,[pwd '\' ESTIMADOR{1} '\' ESTIMADOR{1} '[MATRIX][BIN]EVT[' num2str(EVENTOS) ']'],'png');
    close
end
end
