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
% vEVT = [1000];
vEVT = [25 50 100 500 1000];
nEST = 100;
nROI = 1;
nGRID = 10^5;
ntmax = 100;

for ne = 1:length(vEVT)
    id = 0;
    %     for name = {'D4d'}
    for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
        id = id+1;
        nEVT = vEVT(ne);
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for im = 1:ntmax
            
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            h = h_methods(setup,DATA);
            [A,L2,~,~] = areaKDEfix_SSE(setup,DATA,nPoint,h);
            H.SV(im,id)= h.PI.SV;
            H.SVM1(im,id)= h.PI.SVM1;
            H.SVM2(im,id)= h.PI.SVM2;
            H.SJ(im,id)= h.PI.SJ;
            H.SC(im,id)= h.PI.SC;
            H.L1I(im,id)= h.PI.L1I;
            
            H.MLCV(im,id)= h.CV.MLCV;
            H.UCV(im,id)= h.CV.UCV;
            H.BCV1(im,id)= h.CV.BCV1;
            H.BCV2(im,id)= h.CV.BCV2;
            H.CCV(im,id)= h.CV.CCV;
            H.MCV(im,id)= h.CV.MCV;
            H.TCV(im,id)= h.CV.TCV;
            H.OSCV(im,id)= h.CV.OSCV;
            H.TRG(im,id)= h.truthG;
            H.TRE(im,id)= h.truthE;
            
            H.rMLCV(im,id)= h.CV.rMLCV;
            H.rUCV(im,id)= h.CV.rUCV;
            H.rBCV1(im,id)= h.CV.rBCV1;
            H.rBCV2(im,id)= h.CV.rBCV2;
            H.rCCV(im,id)= h.CV.rCCV;
            H.rMCV(im,id)= h.CV.rMCV;
            H.rTCV(im,id)= h.CV.TCV;
            H.rOSCV(im,id)= h.CV.rOSCV;
            
            H.n{1}(im,id)=h.CV.n(1);
            H.n{2}(im,id)=h.CV.n(2);
            H.n{3}(im,id)=h.CV.n(3);
            H.n{4}(im,id)=h.CV.n(4);
            H.n{5}(im,id)=h.CV.n(5);
            H.n{6}(im,id)=h.CV.n(6);
            H.n{7}(im,id)=h.CV.n(7);
            H.n{8}(im,id)=h.CV.n(8);
            
            AREA.SV(im,id)= A(1);
            AREA.SVM1(im,id)= A(2);
            AREA.SVM2(im,id)= A(3);
            AREA.SJ(im,id)= A(4);
            AREA.SC(im,id)= A(5);
            AREA.L1I(im,id)= A(6);
            AREA.MLCV(im,id)= A(7);
            AREA.UCV(im,id)= A(8);
            AREA.BCV1(im,id)= A(9);
            AREA.BCV2(im,id)= A(10);
            AREA.CCV(im,id)= A(11);
            AREA.MCV(im,id)= A(12);
            AREA.TCV(im,id)= A(13);
            AREA.OSCV(im,id)= A(14);
            AREA.TRG(im,id)= A(15);
            AREA.TRE(im,id)= A(16);
            
            AREA.rMLCV(im,id)= A(17);
            AREA.rUCV(im,id)= A(18);
            AREA.rBCV1(im,id)= A(19);
            AREA.rBCV2(im,id)= A(20);
            AREA.rCCV(im,id)= A(21);
            AREA.rMCV(im,id)= A(22);
            AREA.rOSCV(im,id)= A(23);
            
            ERRORL2.SV(im,id)= L2(1);
            ERRORL2.SVM1(im,id)= L2(2);
            ERRORL2.SVM2(im,id)= L2(3);
            ERRORL2.SJ(im,id)= L2(4);
            ERRORL2.SC(im,id)= L2(5);
            ERRORL2.L1I(im,id)= L2(6);
            ERRORL2.MLCV(im,id)= L2(7);
            ERRORL2.UCV(im,id)= L2(8);
            ERRORL2.BCV1(im,id)= L2(9);
            ERRORL2.BCV2(im,id)= L2(10);
            ERRORL2.CCV(im,id)= L2(11);
            ERRORL2.MCV(im,id)= L2(12);
            ERRORL2.TCV(im,id)= L2(13);
            ERRORL2.OSCV(im,id)= L2(14);
            ERRORL2.TRG(im,id)= L2(15);
            ERRORL2.TRE(im,id)= L2(16);
            
            ERRORL2.rMLCV(im,id)= L2(17);
            ERRORL2.rUCV(im,id)= L2(18);
            ERRORL2.rBCV1(im,id)= L2(19);
            ERRORL2.rBCV2(im,id)= L2(20);
            ERRORL2.rCCV(im,id)= L2(21);
            ERRORL2.rMCV(im,id)= L2(22);
            ERRORL2.rOSCV(im,id)= L2(23);
            %
            disp(['NAME[' name{1} ']IT[' num2str(im) ']TRUTH[' num2str(h.truthG) ']HSJ[' num2str(h.CV.TCV) ']TIME[' num2str(toc) ']'])
            disp('=======================================================================================')
            
        end
        %         pause
    end
    save([pwd '\KDE\KDE[paper]EVT[' num2str(nEVT) ']SSE'],'H','AREA','ERRORL2');
end
