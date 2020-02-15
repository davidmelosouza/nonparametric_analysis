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
nEST = 10000;
nROI = 50;
nGRID = 10^5;
ntmax = 5;
for ROItype = {'prob','deriv','deriv2'}
    for ne = 1:length(vEVT)
        id = 0;
        %     for name = {'D4d'}
        for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
            id = id+1;
            nEVT = vEVT(ne);
            [setup] = IN(name{1},'sg',errortype,ROItype{1},inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            for im = 1:ntmax
                [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
                h = h_methods(setup,DATA);
                [~,~,X,pdf] = areaKDEfix(setup,DATA,nPoint,h);
                
                [e{1}(im,:)] = eRoI(setup,DATA,X.SV,pdf.SV); disp('ok')
                [e{2}(im,:)] = eRoI(setup,DATA,X.SVM1,pdf.SVM1);disp('ok')
                [e{3}(im,:)] = eRoI(setup,DATA,X.SVM2,pdf.SVM2);disp('ok')
                [e{4}(im,:)] = eRoI(setup,DATA,X.SJ,pdf.SJ);disp('ok')
                [e{5}(im,:)] = eRoI(setup,DATA,X.SC,pdf.SC);disp('ok')
                [e{6}(im,:)] = eRoI(setup,DATA,X.L1I,pdf.L1I);disp('ok')
                [e{7}(im,:)] = eRoI(setup,DATA,X.rMLCV,pdf.rMLCV);disp('ok')
                [e{8}(im,:)] = eRoI(setup,DATA,X.rUCV,pdf.rUCV);disp('ok')
                [e{9}(im,:)] = eRoI(setup,DATA,X.rBCV1,pdf.rBCV1);disp('ok')
                [e{10}(im,:)] = eRoI(setup,DATA,X.rBCV2,pdf.rBCV2);disp('ok')
                [e{11}(im,:)] = eRoI(setup,DATA,X.rCCV,pdf.rCCV);disp('ok')
                [e{12}(im,:)] = eRoI(setup,DATA,X.rMCV,pdf.rMCV);disp('ok')
                [e{13}(im,:)] = eRoI(setup,DATA,X.TCV,pdf.rTCV);disp('ok')
                [e{14}(im,:)] = eRoI(setup,DATA,X.OSCV,pdf.rOSCV);disp('ok')
%                 [e{15}(im,:)] = eRoI(setup,DATA,X.TRUTHG,pdf.TRUTHG);disp('ok')
%                 [e{16}(im,:)] = eRoI(setup,DATA,X.TRUTHE,pdf.TRUTHE);disp('ok')
                %
                disp(['NAME[' name{1} ']IT[' num2str(im) ']TRUTH[' num2str(h.truthG) ']HSJ[' num2str(h.CV.TCV) ']TIME[' num2str(toc) ']'])
                disp('=======================================================================================')
                
            end
            save([pwd '\KDE\KDE[2oSTAGE][' ROItype{1} ']DIST[' name{1} ']EVT[' num2str(nEVT) ']'],'e');
        end
    end
end
