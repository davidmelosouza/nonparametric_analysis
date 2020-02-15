% TEST DISTRIBUIÕES
% clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
band = 'fix';
type = 'Gaussian';
cl = ['yrbgkmc'];
vEVT = [500];
nPoint = 1000;
mod='dist';
nEVT = round(vEVT(1));
nEST = nPoint;
nROI = 1;
nGRir = 10^5;
ntmax = 25;
in = 0;
for name = {'GGD','Logn'}
    in = in+1;
    if strcmp(name,'Logn')
        range.SK =linspace(0.01,1,10);
    else
        range.SK = sort([logspace(0,1,9) 2]);
    end
    for ir=1:length(range.SK)
        
        for im=1:ntmax
            tic
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRir,nEST,nROI);   % Definir os Parâmetros Iniciais
            if strcmp(name{1},'Logn')
                setup.mu=log(2);
                setup.std = range.SK(ir);
            else
                setup.rho = range.SK(ir);
            end
            setup.ir=ir;
            [DATA] = datasetGenSK(setup); DATA.nPoint = 1000;
            if strcmp(name{1},'Logn')
                sk(im,ir)=skewness(DATA.sg.evt);
                kind = 'Skewness';
            else
                sk(im,ir)=kurtosis(DATA.sg.evt);
                kind = 'Kurtosis';
            end
            [h] = h_plugin(DATA.sg.evt);
            [hf] = h_TCVfast(DATA,h.PI.SJ);
            
            [X.TCV,pdf.TCV] = fastKDE(DATA.sg.evt,nPoint,1,2,hf.TCV,'fix');
            [X.TCVA,pdf.TCVA] = fastKDE(DATA.sg.evt,nPoint,1,2,hf.TCVA,'fix');
            
            ygrid=interp1(X,pdf,DATA.sg.pdf.truth.x,'linear',0);
            ygrid(ygrid<0)=0;
            A = area2d(DATA.sg.pdf.truth.x,abs(ygrid-DATA.sg.pdf.truth.y));
            H.TCV(im,ir)= hf.TCV;
            
            AREA.TCV(im,ir)= A;
            %             pause
            
            disp(['[KDE][PCT][' num2str(ir/length(range.SK)) ']NAME[' name{1} ']IT[' num2str(im) ']SJ[' num2str(h.PI.SJ) ']TIME[' num2str(toc) ']'])
        end
    end
    %     save([pwd '\KDE\KDE[SK]DIST[' name{1} ']EVT[' num2str(nEVT) ']'],'H','AREA');
end