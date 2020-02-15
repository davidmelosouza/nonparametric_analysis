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
    load([pwd '\' method '\' method '[paper]EVT[' num2str(vEVT(ne)) ']'],'H','AREA');
    A{ne} = AREA;
    Ht{ne} = H;
    
end

% pause
for ie = 1:5
    for id = 1:16
        METHOD.SV{id}(:,ie)=A{ie}.SV(:,id);
        METHOD.SVM1{id}(:,ie)=A{ie}.SVM1(:,id);
        METHOD.SVM2{id}(:,ie)=A{ie}.SVM2(:,id);
        METHOD.SJ{id}(:,ie)=A{ie}.SJ(:,id);
        METHOD.SC{id}(:,ie)=A{ie}.SC(:,id);
        METHOD.L1I{id}(:,ie)=A{ie}.L1I(:,id);
        METHOD.rMLCV{id}(:,ie)=A{ie}.rMLCV(:,id);
        METHOD.rUCV{id}(:,ie)=A{ie}.rUCV(:,id);
        METHOD.rBCV1{id}(:,ie)=A{ie}.rBCV1(:,id);
        METHOD.rBCV2{id}(:,ie)=A{ie}.rBCV2(:,id);
        METHOD.rCCV{id}(:,ie)=A{ie}.rCCV(:,id);
        METHOD.rMCV{id}(:,ie)=A{ie}.rMCV(:,id);
        METHOD.TCV{id}(:,ie)=A{ie}.TCV(:,id);
        METHOD.rOSCV{id}(:,ie)=A{ie}.rOSCV(:,id);
        METHOD.TRG{id}(:,ie)=A{ie}.TRG(:,id);
        METHOD.TRE{id}(:,ie)=A{ie}.TRE(:,id);
        
        METHODBIN.SV{id}(:,ie)=Ht{ie}.SV(:,id);
        METHODBIN.SVM1{id}(:,ie)=Ht{ie}.SVM1(:,id);
        METHODBIN.SVM2{id}(:,ie)=Ht{ie}.SVM2(:,id);
        METHODBIN.SJ{id}(:,ie)=Ht{ie}.SJ(:,id);
        METHODBIN.SC{id}(:,ie)=Ht{ie}.SC(:,id);
        METHODBIN.L1I{id}(:,ie)=Ht{ie}.L1I(:,id);
        METHODBIN.rMLCV{id}(:,ie)=Ht{ie}.rMLCV(:,id);
        METHODBIN.rUCV{id}(:,ie)=Ht{ie}.rUCV(:,id);
        METHODBIN.rBCV1{id}(:,ie)=Ht{ie}.rBCV1(:,id);
        METHODBIN.rBCV2{id}(:,ie)=Ht{ie}.rBCV2(:,id);
        METHODBIN.rCCV{id}(:,ie)=Ht{ie}.rCCV(:,id);
        METHODBIN.rMCV{id}(:,ie)=Ht{ie}.rMCV(:,id);
        METHODBIN.TCV{id}(:,ie)=Ht{ie}.TCV(:,id);
        METHODBIN.rOSCV{id}(:,ie)=Ht{ie}.rOSCV(:,id);
        METHODBIN.TRG{id}(:,ie)=Ht{ie}.TRG(:,id);
        METHODBIN.TRE{id}(:,ie)=Ht{ie}.TRE(:,id);
        
    end
end
vd = [1 3 4 5 7 8 10 11 12 14 15 16];
id = 0;
for d = vd
    id = id+1;
    %  DADOS_AREAn = {METHOD.SV{d};METHOD.SVM1{d};METHOD.SVM2{d};METHOD.SJ{d};METHOD.SC{d};METHOD.L1I{d};METHOD.MLCV{d};METHOD.UCV{d};METHOD.BCV1{d};METHOD.BCV2{d};METHOD.CCV{d};METHOD.MCV{d};METHOD.TCV{d};METHOD.OSCV{d};METHOD.TR{d}};
    DADOS_AREAr = {METHOD.SV{id};METHOD.SVM1{id};METHOD.SVM2{id};METHOD.SJ{id};METHOD.SC{id};METHOD.L1I{id};METHOD.rMLCV{id};METHOD.rUCV{id};METHOD.rBCV1{id};METHOD.rBCV2{id};METHOD.rCCV{id};METHOD.rMCV{id};METHOD.TCV{id};METHOD.rOSCV{id};METHOD.TRG{id};METHOD.TRE{id}};
    
    for m=1:16
        Tm{id}(:,m)=median(DADOS_AREAr{m});
        Tiqr{id}(:,m)=iqr(DADOS_AREAr{m});
    end
    %   DADOS_H = {METHODBIN.SV{id}-METHODBIN.TR{id};METHODBIN.SVM1{id}-METHODBIN.TR{id};METHODBIN.SVM2{id}-METHODBIN.TR{id};METHODBIN.SJ{id}-METHODBIN.TR{id};METHODBIN.SC{id}-METHODBIN.TR{id};METHODBIN.L1I{id}-METHODBIN.TR{id};METHODBIN.MLCV{id}-METHODBIN.TR{id};METHODBIN.UCV{id}-METHODBIN.TR{id};METHODBIN.BCV1{id}-METHODBIN.TR{id};METHODBIN.BCV2{id}-METHODBIN.TR{id};METHODBIN.CCV{id}-METHODBIN.TR{id};METHODBIN.MCV{id}-METHODBIN.TR{id};METHODBIN.TCV{id}-METHODBIN.TR{id};METHODBIN.OSCV{id}-METHODBIN.TR{id}};
    DADOS_Hr = {METHODBIN.SV{id}-METHODBIN.TRG{id};METHODBIN.SVM1{id}-METHODBIN.TRG{id};METHODBIN.SVM2{id}-METHODBIN.TRG{id};METHODBIN.SJ{id}-METHODBIN.TRG{id};METHODBIN.SC{id}-METHODBIN.TRG{id};METHODBIN.L1I{id}-METHODBIN.TRE{id};METHODBIN.rMLCV{id}-METHODBIN.TRG{id};METHODBIN.rUCV{id}-METHODBIN.TRG{id};METHODBIN.rBCV1{id}-METHODBIN.TRG{id};METHODBIN.rBCV2{id}-METHODBIN.TRG{id};METHODBIN.rCCV{id}-METHODBIN.TRG{id};METHODBIN.rMCV{id}-METHODBIN.TRG{id};METHODBIN.TCV{id}-METHODBIN.TRG{id};METHODBIN.rOSCV{id}-METHODBIN.TRG{id}};
    
    
    
end