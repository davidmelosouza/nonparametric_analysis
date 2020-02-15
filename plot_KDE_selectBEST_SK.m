% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
method = 'KDE';
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
band = 'fix';
nPoint = 1000;
vEVT = [500];
nEST = 1000;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
% name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};
name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};
dn = [1 3 4 5 7 8 10 11 12 14 15 16];

for ne = 1:length(vEVT)
    load([pwd '\' method '\' method '[paper]EVT[' num2str(vEVT(ne)) ']'],'H','AREA','INFO');
    for id = dn
        AREAD(1)=median(AREA.SV(:,id));
        AREAD(2)=median(AREA.SVM1(:,id));
        AREAD(3)=median(AREA.SVM2(:,id));
        AREAD(4)=median(AREA.SJ(:,id));
        AREAD(5)=median(AREA.SC(:,id));
        AREAD(6)=median(AREA.L1I(:,id));
        AREAD(7)=median(AREA.MLCV(:,id));
        AREAD(8)=median(AREA.UCV(:,id));
        AREAD(9)=median(AREA.BCV1(:,id));
        AREAD(10)=median(AREA.BCV2(:,id));
        AREAD(11)=median(AREA.CCV(:,id));
        AREAD(12)=median(AREA.MCV(:,id));
        AREAD(13)=median(AREA.TCV(:,id));
        AREAD(14)=median(AREA.OSCV(:,id));
        
        [~,m]=sort(AREAD);
        bm(ne,id) = m(1);
        KURTD.med(id)=median(INFO.kurt(:,id));
        KURTD.iqr(id)=iqr(INFO.kurt(:,id));
        SKEWD.med(id)=median(INFO.skew(:,id));
        SKEWD.iqr(id)=iqr(INFO.skew(:,id));
        
        
        
        %         SK{ne} = INFO.skew;
        %         KT{ne} = INFO.kurt;
        %
        %         matplot_revista(INFO.kurt(:,dn),[min(min(INFO.kurt(:,dn))) max(max(INFO.kurt(:,dn)))],['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d';'D4a';'D4b';'D4c';'D4d']',[], 'Área do Erro')
        %         pause
        %         %     STD{ne} = INFO.std;
        %     MAD{ne} =INFO.mad;
    end
    errorbar([1:12], KURTD.med(KURTD.med~=0),KURTD.iqr(KURTD.iqr~=0),'sk:','markerfacecolor','k'); hold on
    errorbar([1:12], SKEWD.med(SKEWD.med~=0),SKEWD.iqr(SKEWD.iqr~=0),'s:','Color',[0.5 0.5 0.5],'markerfacecolor',[.5 .5 .5])
    %     xlim([0 13])
    xticks([1:12])
    xticklabels({'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'})
    xtickangle(90)
    axis tight
    patch([[0 13] fliplr([0 13])], [[KURTD.med(1)+KURTD.iqr(1) KURTD.med(1)+KURTD.iqr(1)] fliplr([KURTD.med(1)-KURTD.iqr(1) KURTD.med(1)-KURTD.iqr(1)])],'w','EdgeColor','none','FaceColor',[.5 .5 .5],'FaceAlpha',.1)
    patch([[0 13] fliplr([0 13])], [[SKEWD.med(1)+SKEWD.iqr(1) SKEWD.med(1)+SKEWD.iqr(1)] fliplr([SKEWD.med(1)-SKEWD.iqr(1) SKEWD.med(1)-SKEWD.iqr(1)])],'w','EdgeColor','none','FaceColor',[.5 .5 .5],'FaceAlpha',.1)
    ylabel('Valor')
    xlabel('Distribuição')
    legend('Curtose','Assimetria')
    set(gca,'Fontsize',14);
    grid minor
    set(gca,'Gridlinestyle',':')
    set(gca,'LooseInset',get(gca,'TightInset'))
    saveas(gcf,[pwd '\' method '\' method '[SK][MEASURE]EVT[' num2str(vEVT(ne)) ']'],'fig');
    saveas(gcf,[pwd '\' method '\' method '[SK][MEASURE]EVT[' num2str(vEVT(ne)) ']'],'png');
    
    
    pause
%     close
end



% %
% for ie = 1:5
%     for id = 1:16
%         AREA.SV=iqr(AREA.SV(:,id));
%         AREA.SVM1=iqr(AREA.SVM1(:,id));
%         AREA.SVM2=iqr(AREA.SVM2(:,id));
%         AREA.SJ=iqr(AREA.SJ(:,id));
%         AREA.SC=iqr(AREA.SC(:,id));
%         AREA.L1I=iqr(AREA.L1I(:,id));
%         AREA.MLCV=iqr(AREA.MLCV(:,id));
%         AREA.UCV=iqr(AREA.UCV(:,id));
%         AREA.BCV1=iqr(AREA.BCV1(:,id));
%         AREA.BCV2=iqr(AREA.BCV2(:,id));
%         AREA.CCV=iqr(AREA.CCV(:,id));
%         AREA.MCV=iqr(AREA.MCV(:,id));
%         AREA.TCV=iqr(AREA.TCV(:,id));
%         AREA.OSCV=iqr(AREA.OSCV(:,id));
%         AREA.TRG=iqr(AREA.TRG(:,id));
%         AREA.TRE=iqr(AREA.TRE(:,id));
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         AREAH.SV=Ht{ie}.SV(:,id));
%         AREAH.SVM1=Ht{ie}.SVM1(:,id));
%         AREAH.SVM2=Ht{ie}.SVM2(:,id));
%         AREAH.SJ=Ht{ie}.SJ(:,id));
%         AREAH.SC=Ht{ie}.SC(:,id));
%         AREAH.L1I=Ht{ie}.L1I(:,id));
%         AREAH.MLCV=Ht{ie}.MLCV(:,id));
%         AREAH.UCV=Ht{ie}.UCV(:,id));
%         AREAH.BCV1=Ht{ie}.BCV1(:,id));
%         AREAH.BCV2=Ht{ie}.BCV2(:,id));
%         AREAH.CCV=Ht{ie}.CCV(:,id));
%         AREAH.MCV=Ht{ie}.MCV(:,id));
%         AREAH.TCV=Ht{ie}.TCV(:,id));
%         AREAH.OSCV=Ht{ie}.OSCV(:,id));
%         AREAH.TRG=Ht{ie}.TRG(:,id));
%         AREAH.TRE=Ht{ie}.TRE(:,id));
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         AREA.rMLCV=iqr(AREA.rMLCV(:,id));
%         AREA.rUCV=iqr(AREA.rUCV(:,id));
%         AREA.rBCV1=iqr(AREA.rBCV1(:,id));
%         AREA.rBCV2=iqr(AREA.rBCV2(:,id));
%         AREA.rCCV=iqr(AREA.rCCV(:,id));
%         AREA.rMCV=iqr(AREA.rMCV(:,id));
%         AREA.rOSCV=iqr(AREA.rOSCV(:,id));
%         AREAH.rMLCV=Ht{ie}.MLCV(:,id));
%         AREAH.rUCV=Ht{ie}.rUCV(:,id));
%         AREAH.rBCV1=Ht{ie}.rBCV1(:,id));
%         AREAH.rBCV2=Ht{ie}.rBCV2(:,id));
%         AREAH.rCCV=Ht{ie}.rCCV(:,id));
%         AREAH.rMCV=Ht{ie}.rMCV(:,id));
%         AREAH.rOSCV=Ht{ie}.rOSCV(:,id));
%
%     end
% end
%
%
% % dn = [1 3 4 5 7 8 10 11 12 14 15 16];
% % name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
% % dt=0;
% % for d = dn
% %     dt = dt+1;
% %     %   DADOS_AREA = {AREA.SV{d};AREA.SVM1{d};AREA.SVM2{d};AREA.SJ{d};AREA.SC{d};AREA.L1I{d};AREA.MLCV{d};AREA.UCV{d};AREA.BCV1{d};AREA.BCV2{d};AREA.CCV{d};AREA.MCV{d};AREA.TCV{d};AREA.OSCV{d};AREA.TR{d}};
% %     DADOS_AREAr = {AREA.SV{d};AREA.SVM1{d};AREA.SVM2{d};AREA.SJ{d};AREA.SC{d};AREA.L1I{d};AREA.rMLCV{d};AREA.rUCV{d};AREA.rBCV1{d};AREA.rBCV2{d};AREA.rCCV{d};AREA.rMCV{d};AREA.TCV{d};AREA.rOSCV{d};AREA.TRG{d};AREA.TRE{d}};
% %
% %
% %
% % end