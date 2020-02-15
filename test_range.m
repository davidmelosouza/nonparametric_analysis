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
vEVT = [25 50 100 500 1000];
% vEVT = [25 50];
nEST = 10000;
nROI = 1;
nGRID = 10^5;
ntmax = 5;
hv=logspace(-2,1.2,5);
for ne = 1:length(vEVT)
    id = 0;
    %  for name = {'D4a','D4b','D4c','D4d'}
    for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
        id = id+1;
        nEVT = vEVT(ne);
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for im = 1:ntmax
            ih = 0;
            for h = hv
                ih = ih+1;
                
                [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
                data = DATA.sg.evt;
                nPoint = 10000;
                [X,pdf] = KDEfast_fixed(data,h,nPoint);
                
                xmin = X(1);
                xmax = X(end);        
                
                xmin_evt1 = min(data)-h*3;
                xmax_evt1 = max(data)+h*3;
                
                xmin_evt2 = min(data)-h*3.5;
                xmax_evt2 = max(data)+h*3.5;
                
                xmin_evt3 = min(data)-h*4;
                xmax_evt3 = max(data)+h*4;
                
                tic
%                 [X,pdf] = KDEfast_fixed_minmax(data,h,nPoint,xmin,xmax);
                AD{id}(ih,im) = area2d(X,pdf);
                [X1,pdf1] = KDEfast_fixed_minmax(data,h,nPoint,xmin_evt1,xmax_evt1);
                AE1{id}(ih,im) = area2d(X1,pdf1);
                [X2,pdf2] = KDEfast_fixed_minmax(data,h,nPoint,xmin_evt2,xmax_evt2);
                AE2{id}(im) = area2d(X2,pdf2);
                [X3,pdf3] = KDEfast_fixed_minmax(data,h,nPoint,xmin_evt3,xmax_evt3);
                AE3{id}(im) = area2d(X3,pdf3);
                
                disp(['NAME[' name{1} ']IT[' num2str(im) ']IH[' num2str(ih) ']TIME[' num2str(toc) ']'])
                %             subplot(3,1,1);bar([xmin xmin_evt xmax xmax_evt])
                %             subplot(3,1,2);bar([A AE])
                %
                %             subplot(3,1,3);plot(X,pdf,'k'); hold on
                %             subplot(3,1,3);plot(Xm,pdfm,'r')
            end
        end
    end
end