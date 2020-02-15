close
clear variables
vEVT = [25 50 100 500 1000];
id=0;
for  name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
    id=id+1;
    
    load([pwd '\KDE\BEST\KDE[VAR]DIST[' name{1} ']'],'K');
    DADOS = {K{1};K{2};K{3};K{4}};
    
    for i=1:4
       
        DADOS_M{id}(i,:) = median(DADOS{i});
        DADOS_IQR{id}(i,:) = iqr(DADOS{i});
%         DADOS_MAD{id}(i,:) = iqr(DADOS{i});
    end
%     PLOTBOXKDE_VAR(DADOS,vEVT,'Eventos','¡rea do Erro','NorthEast'); hold on
%     set(gca,'LooseInset',get(gca,'TightInset'))
%     xlim([0.54 5.46])
%     set(gca,'Position', [0.094404759509932,0.117619041516668,0.902023811918639,0.88000000610238])
%     saveas(gcf,[pwd '\KDE\KDEVAR[ROIKDE][' name{1} ']'],'png');
%     saveas(gcf,[pwd '\KDE\KDEVAR[ROIKDE][' name{1} ']'],'fig');
    
%         pause
%     close
end
% 
% cmap = [235,235,235;
%     200,200,200;
%     128,128,128;
%     255, 0, 0]/255;
% 
% DADOS_NEW= reshape(mean(DADOS_M),4,5);
% DADOS_NEW_STD= reshape(mean(DADOS_STD),4,5);
% DADOS_NEW_MED= reshape(median(DADOS_M),4,5);
% DADOS_NEW_MAD= reshape(mean(DADOS_MAD),4,5);
% 
% figure
% for i=1:4
%     errorbar(vEVT,DADOS_NEW(i,:),DADOS_NEW_MAD(i,:),'Color',cmap(i,:),'marker','s','markerface',cmap(i,:),'markeredge','k'); hold on
% end
% set(gca,'Fontsize',12);
% legend([{['BKDE']},{['AKDE']},{['VKDE']},{['ROIKDE']}],'Fontsize',12);
% grid on
% set(gca,'gridlinestyle',':')
% xlabel('Amostras')
% ylabel('¡rea do Erro')
% axis tight
% xlim([20 1005])
% set(gca,'LooseInset',get(gca,'TightInset'))
% saveas(gcf,[pwd '\KDE\KDEVAR[ROIKDE][IMPROVE][MEAN]'],'png');
% saveas(gcf,[pwd '\KDE\KDEVAR[ROIKDE][IMPROVE][MEAN]'],'fig');
% close
% figure
% for i=1:4
%     errorbar(vEVT,DADOS_NEW_MED(i,:),DADOS_NEW_MAD(i,:),'Color',cmap(i,:),'marker','s','markerface',cmap(i,:),'markeredge','k'); hold on
% end
% set(gca,'Fontsize',12);
% legend([{['BKDE']},{['AKDE']},{['VKDE']},{['ROIKDE']}],'Fontsize',12);
% grid on
% set(gca,'gridlinestyle',':')
% xlabel('Amostras')
% ylabel('\Delta¡rea do Erro')
% axis tight
% xlim([20 1005])
% set(gca,'LooseInset',get(gca,'TightInset'))
% saveas(gcf,[pwd '\KDE\KDEVAR[ROIKDE][IMPROVE][MEDIAN]'],'png');
% saveas(gcf,[pwd '\KDE\KDEVAR[ROIKDE][IMPROVE][MEDIAN]'],'fig');
% close