% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
band = 'fix';
nPoint = 10000;
vEVT = [100 500 1000 2000 5000];
% vEVT = [500];
nEST = 10;
nROI = 1;
nGRID = 10^5;
ntmax = 10;

for ne = 1:length(vEVT)
    id = 0;
    for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
%     for name = {'D3c'}
        id = id+1;
        nEVT = vEVT(ne);
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for im = 1:ntmax
            tic
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            h = h_methods_TEST(DATA);
            %             pause
            %             figure(1)
            [A.min,~,~] = areaKDEfix_TEST(DATA,nPoint,h.min,inter);
            [A.find,~,~] = areaKDEfix_TEST(DATA,nPoint,h.find,inter);
            
            H{1}.min(im,id)= h.min.CV.MLCV;
            H{2}.min(im,id)= h.min.CV.UCV;
            H{3}.min(im,id)= h.min.CV.BCV1;
            H{4}.min(im,id)= h.min.CV.BCV2;
            H{5}.min(im,id)= h.min.CV.CCV;
            H{6}.min(im,id)= h.min.CV.MCV;
            H{7}.min(im,id)= h.min.CV.TCV;
            H{8}.min(im,id)= h.min.truth;
            
            AREA{1}.min(im,id)= A.min(1);
            AREA{2}.min(im,id)= A.min(2);
            AREA{3}.min(im,id)= A.min(3);
            AREA{4}.min(im,id)= A.min(4);
            AREA{5}.min(im,id)= A.min(5);
            AREA{6}.min(im,id)= A.min(6);
            AREA{7}.min(im,id)= A.min(7);
            AREA{8}.min(im,id)= A.min(8);
            
            H{1}.find(im,id)= h.find.CV.MLCV;
            H{2}.find(im,id)= h.find.CV.UCV;
            H{3}.find(im,id)= h.find.CV.BCV1;
            H{4}.find(im,id)= h.find.CV.BCV2;
            H{5}.find(im,id)= h.find.CV.CCV;
            H{6}.find(im,id)= h.find.CV.MCV;
            H{7}.find(im,id)= h.find.CV.TCV;
            H{8}.find(im,id)= h.find.truth;
            
            AREA{1}.find(im,id)= A.find(1);
            AREA{2}.find(im,id)= A.find(2);
            AREA{3}.find(im,id)= A.find(3);
            AREA{4}.find(im,id)= A.find(4);
            AREA{5}.find(im,id)= A.find(5);
            AREA{6}.find(im,id)= A.find(6);
            AREA{7}.find(im,id)= A.find(7);
            AREA{8}.find(im,id)= A.find(8);
            
            
            
            disp(['NAME[' name{1} ']IT[' num2str(im) ']TRUTH[' num2str(h.find.truth) ']HTCV[' num2str(h.find.CV.TCV) ']TIME[' num2str(toc) ']'])
        end
        %         pause
    end
         save([pwd '\KDE\CVFIX[all]EVT[' num2str(nEVT) ']'],'H','AREA');
end
% % 
% for i=1:7
%     for j=1:
%     [ytcv,xtcv]=hist(H{8}.find-H{1}.min,20); hold on
%     [ymin,xmin]=hist(H{8}.find-H{i}.min,20); hold on
%     [yfind,xfind]=hist(H{8}.find-H{i}.find,20);
%     subplot(2,4,i);stairs(xtcv,ytcv,'s:k','markersize',2); hold on
%     subplot(2,4,i);stairs(xmin,ymin,'s:r','markersize',2);
%     subplot(2,4,i);stairs(xfind,yfind,'s:b','markersize',2);
%     
%     %     subplot(2,4,i);histogram(H{8}.find-H{1}.min,20); hold on
%     %     subplot(2,4,i);histogram(H{8}.find-H{i}.min,20); hold on
%     %     subplot(2,4,i);histogram(H{8}.find-H{i}.find,20);
%     set(gca,'YScale','log')
%     
%     legend('TCV','min','find')
% end
% 
% for i=1:7
%     subplot(2,4,i);histogram(AREA{8}.find-AREA{1}.min,20); hold on
%     subplot(2,4,i);histogram(AREA{8}.find-AREA{i}.min,20); hold on
%     subplot(2,4,i);histogram(AREA{8}.find-AREA{i}.find,20);
%     legend('TCV','min','find')
% end
%             H.MLCV.min(im,id)= h.min.CV.MLCV;
%             H.UCV.min(im,id)= h.min.CV.UCV;
%             H.BCV1.min(im,id)= h.min.CV.BCV1;
%             H.BCV2.min(im,id)= h.min.CV.BCV2;
%             H.CCV.min(im,id)= h.min.CV.CCV;
%             H.MCV.min(im,id)= h.min.CV.MCV;
%             H.TCV.min(im,id)= h.min.CV.TCV;
%             H.TR(im,id)= h.min.truth;
%
%             AREA.MLCV.min(im,id)= A.min(1);
%             AREA.UCV.min(im,id)= A.min(2);
%             AREA.BCV1.min(im,id)= A.min(3);
%             AREA.BCV2.min(im,id)= A.min(4);
%             AREA.CCV.min(im,id)= A.min(5);
%             AREA.MCV.min(im,id)= A.min(6);
%             AREA.TCV.min(im,id)= A.min(7);
%             AREA.TR(im,id)= A.min(8);
%
%             H.MLCV.find(im,id)= h.find.CV.MLCV;
%             H.UCV.find(im,id)= h.find.CV.UCV;
%             H.BCV1.find(im,id)= h.find.CV.BCV1;
%             H.BCV2.find(im,id)= h.find.CV.BCV2;
%             H.CCV.find(im,id)= h.find.CV.CCV;
%             H.MCV.find(im,id)= h.find.CV.MCV;
%             H.TCV.find(im,id)= h.find.CV.TCV;
%             H.TR(im,id)= h.find.truth;
%
%             AREA.MLCV.find(im,id)= A.find(1);
%             AREA.UCV.find(im,id)= A.find(2);
%             AREA.BCV1.find(im,id)= A.find(3);
%             AREA.BCV2.find(im,id)= A.find(4);
%             AREA.CCV.find(im,id)= A.find(5);
%             AREA.MCV.find(im,id)= A.find(6);
%             AREA.TCV.find(im,id)= A.find(7);
%             AREA.TR(im,id)= A.find(8);

% matplot(DADOS_BIN,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', '\DeltaBins')
% matplot(DADOS_AREA,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', 'Error Area')
% matplot(DADOS_AREA_VAR,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', '\sigma')