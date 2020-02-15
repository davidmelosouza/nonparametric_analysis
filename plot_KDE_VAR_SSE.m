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
vEVT = [25 50 100 500 1000];
nEST = 1000;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
% name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};
name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};

for ne = 1:length(vEVT)
    load([pwd '\' method '\' method '[paper]EVT[' num2str(vEVT(ne)) ']SSE'],'H','AREA');
    A{ne} = AREA;
%     Ht{ne} = H;
end


for ie = 1:5
    for id = 1:12
        METHOD.SV{id}(:,ie)=A{ie}.SV(:,id);
        METHOD.SVM1{id}(:,ie)=A{ie}.SVM1(:,id);
        METHOD.SVM2{id}(:,ie)=A{ie}.SVM2(:,id);
        METHOD.SJ{id}(:,ie)=A{ie}.SJ(:,id);
        METHOD.SC{id}(:,ie)=A{ie}.SC(:,id);
        METHOD.L1I{id}(:,ie)=A{ie}.L1I(:,id);
        METHOD.MLCV{id}(:,ie)=A{ie}.MLCV(:,id);
        METHOD.UCV{id}(:,ie)=A{ie}.UCV(:,id);
        METHOD.BCV1{id}(:,ie)=A{ie}.BCV1(:,id);
        METHOD.BCV2{id}(:,ie)=A{ie}.BCV2(:,id);
        METHOD.CCV{id}(:,ie)=A{ie}.CCV(:,id);
        METHOD.MCV{id}(:,ie)=A{ie}.MCV(:,id);
        METHOD.TCV{id}(:,ie)=A{ie}.TCV(:,id);
        METHOD.OSCV{id}(:,ie)=A{ie}.OSCV(:,id);
        METHOD.TRG{id}(:,ie)=A{ie}.TRG(:,id);
        METHOD.TRE{id}(:,ie)=A{ie}.TRE(:,id);
%         
%         METHODBIN.SV{id}(:,ie)=Ht{ie}.SV(:,id);
%         METHODBIN.SVM1{id}(:,ie)=Ht{ie}.SVM1(:,id);
%         METHODBIN.SVM2{id}(:,ie)=Ht{ie}.SVM2(:,id);
%         METHODBIN.SJ{id}(:,ie)=Ht{ie}.SJ(:,id);
%         METHODBIN.SC{id}(:,ie)=Ht{ie}.SC(:,id);
%         METHODBIN.L1I{id}(:,ie)=Ht{ie}.L1I(:,id);
%         METHODBIN.MLCV{id}(:,ie)=Ht{ie}.MLCV(:,id);
%         METHODBIN.UCV{id}(:,ie)=Ht{ie}.UCV(:,id);
%         METHODBIN.BCV1{id}(:,ie)=Ht{ie}.BCV1(:,id);
%         METHODBIN.BCV2{id}(:,ie)=Ht{ie}.BCV2(:,id);
%         METHODBIN.CCV{id}(:,ie)=Ht{ie}.CCV(:,id);
%         METHODBIN.MCV{id}(:,ie)=Ht{ie}.MCV(:,id);
%         METHODBIN.TCV{id}(:,ie)=Ht{ie}.TCV(:,id);
%         METHODBIN.OSCV{id}(:,ie)=Ht{ie}.OSCV(:,id);
%         METHODBIN.TRG{id}(:,ie)=Ht{ie}.TRG(:,id);
%         METHODBIN.TRE{id}(:,ie)=Ht{ie}.TRE(:,id);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         METHOD.rSV{id}(:,ie)=A{ie}.rTR(:,id);
        %         METHOD.rSVM1{id}(:,ie)=A{ie}.rTR(:,id);
        %         METHOD.rSVM2{id}(:,ie)=A{ie}.rTR(:,id);
        %         METHOD.rSJ{id}(:,ie)=A{ie}.rTR(:,id);
        %         METHOD.rSC{id}(:,ie)=A{ie}.rTR(:,id);
        %         METHOD.rL1I{id}(:,ie)=A{ie}.rTR(:,id);
        METHOD.rMLCV{id}(:,ie)=A{ie}.rMLCV(:,id);
        METHOD.rUCV{id}(:,ie)=A{ie}.rUCV(:,id);
        METHOD.rBCV1{id}(:,ie)=A{ie}.rBCV1(:,id);
        METHOD.rBCV2{id}(:,ie)=A{ie}.rBCV2(:,id);
        METHOD.rCCV{id}(:,ie)=A{ie}.rCCV(:,id);
        METHOD.rMCV{id}(:,ie)=A{ie}.rMCV(:,id);
        METHOD.rOSCV{id}(:,ie)=A{ie}.rOSCV(:,id);
        %         METHOD.rTR{id}(:,ie)=A{ie}.rTR(:,id);
        
        %         METHODBIN.rSV{id}(:,ie)=Ht{ie}.rTR(:,id);
        %         METHODBIN.rSVM1{id}(:,ie)=Ht{ie}.rTR(:,id);
        %         METHODBIN.rSVM2{id}(:,ie)=Ht{ie}.rTR(:,id);
        %         METHODBIN.rSJ{id}(:,ie)=Ht{ie}.rTR(:,id);
        %         METHODBIN.rSC{id}(:,ie)=Ht{ie}.rTR(:,id);
        %         METHODBIN.rL1I{id}(:,ie)=Ht{ie}.rTR(:,id);
%         METHODBIN.rMLCV{id}(:,ie)=Ht{ie}.MLCV(:,id);
%         METHODBIN.rUCV{id}(:,ie)=Ht{ie}.rUCV(:,id);
%         METHODBIN.rBCV1{id}(:,ie)=Ht{ie}.rBCV1(:,id);
%         METHODBIN.rBCV2{id}(:,ie)=Ht{ie}.rBCV2(:,id);
%         METHODBIN.rCCV{id}(:,ie)=Ht{ie}.rCCV(:,id);
%         METHODBIN.rMCV{id}(:,ie)=Ht{ie}.rMCV(:,id);
%         METHODBIN.rOSCV{id}(:,ie)=Ht{ie}.rOSCV(:,id);
        %         METHODBIN.rTR{id}(:,ie)=Ht{ie}.rTR(:,id);
        
    end
end

% dn = [1 3 4 5 7 8 10 11 12 14 15 16];
dn = [1:12];
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
dt=0;
for d = dn
    dt = dt+1;
    %   DADOS_AREA = {METHOD.SV{d};METHOD.SVM1{d};METHOD.SVM2{d};METHOD.SJ{d};METHOD.SC{d};METHOD.L1I{d};METHOD.MLCV{d};METHOD.UCV{d};METHOD.BCV1{d};METHOD.BCV2{d};METHOD.CCV{d};METHOD.MCV{d};METHOD.TCV{d};METHOD.OSCV{d};METHOD.TR{d}};
    DADOS_AREAr = {METHOD.SV{d};METHOD.SVM1{d};METHOD.SVM2{d};METHOD.SJ{d};METHOD.SC{d};METHOD.L1I{d};METHOD.rMLCV{d};METHOD.rUCV{d};METHOD.rBCV1{d};METHOD.rBCV2{d};METHOD.rCCV{d};METHOD.rMCV{d};METHOD.TCV{d};METHOD.rOSCV{d};METHOD.TRG{d};METHOD.TRE{d}};
    
    %   PLOTBOXKDEn(DADOS_nAREA,vEVT,'Samples','Error Area','northeast'); hold on
    PLOTBOXKDE(DADOS_AREAr,vEVT,'Amostras','Área do Erro','northeast'); hold on
    
    grid minor
    set(gca,'Gridlinestyle',':')
    xlim([0.54 5.46]);
    set(gca,'LooseInset',get(gca,'TightInset'))
    %   pause
    saveas(gcf,[pwd '\' method '\' method '[AREA]DIST[' name_true{dt} '][SSE]'],'fig');
    saveas(gcf,[pwd '\' method '\' method '[AREA]DIST[' name_true{dt} '][SSE]'],'png');
    close
%     %   DADOS_H = {METHODBIN.SV{d}-METHODBIN.TR{d};METHODBIN.SVM1{d}-METHODBIN.TR{d};METHODBIN.SVM2{d}-METHODBIN.TR{d};METHODBIN.SJ{d}-METHODBIN.TR{d};METHODBIN.SC{d}-METHODBIN.TR{d};METHODBIN.L1I{d}-METHODBIN.TR{d};METHODBIN.MLCV{d}-METHODBIN.TR{d};METHODBIN.UCV{d}-METHODBIN.TR{d};METHODBIN.BCV1{d}-METHODBIN.TR{d};METHODBIN.BCV2{d}-METHODBIN.TR{d};METHODBIN.CCV{d}-METHODBIN.TR{d};METHODBIN.MCV{d}-METHODBIN.TR{d};METHODBIN.TCV{d}-METHODBIN.TR{d};METHODBIN.OSCV{d}-METHODBIN.TR{d}};
%     DADOS_Hr = {METHODBIN.SV{d}-METHODBIN.TRG{d};METHODBIN.SVM1{d}-METHODBIN.TRG{d};METHODBIN.SVM2{d}-METHODBIN.TRG{d};METHODBIN.SJ{d}-METHODBIN.TRG{d};METHODBIN.SC{d}-METHODBIN.TRG{d};METHODBIN.L1I{d}-METHODBIN.TRE{d};METHODBIN.rMLCV{d}-METHODBIN.TRG{d};METHODBIN.rUCV{d}-METHODBIN.TRG{d};METHODBIN.rBCV1{d}-METHODBIN.TRG{d};METHODBIN.rBCV2{d}-METHODBIN.TRG{d};METHODBIN.rCCV{d}-METHODBIN.TRG{d};METHODBIN.rMCV{d}-METHODBIN.TRG{d};METHODBIN.TCV{d}-METHODBIN.TRG{d};METHODBIN.rOSCV{d}-METHODBIN.TRG{d}};
%     
%     PLOTBOXKDE(DADOS_Hr,vEVT,'Amostras','\Deltah','northeast'); hold on
%     plot([0.54 5.46],[0 0],':k','HandleVisibility','off')
%     grid minor
%     set(gca,'Gridlinestyle',':')
%     xlim([0.54 5.46]);
%     set(gca,'LooseInset',get(gca,'TightInset'))
%     %   pause
%     saveas(gcf,[pwd '\' method '\' method '[H]DIST[' name_true{dt} '][SSE]'],'fig');
%     saveas(gcf,[pwd '\' method '\' method '[H]DIST[' name_true{dt} '][SSE]'],'png');
%     close
end