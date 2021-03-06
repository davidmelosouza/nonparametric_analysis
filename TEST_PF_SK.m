% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
band = 'fix';
type = 'Gaussian';
cl = ['yrbgkmc'];
vEVT = [100 500 1000 2000 5000];
nPoint = 1000;
mod='dist';
nEVT = round(vEVT(1));
nEST = nPoint;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
in = 0;

for name = {'GGD','Logn'}
    in = in+1;
    if strcmp(name,'Logn')
        range.SK =linspace(0.1,1,10);
    else
        range.SK = sort([[logspace(0,1,9)] 2]);
    end
    for ir=1:length(range.SK)
        
        for im=1:ntmax
            tic
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            if strcmp(name{1},'Logn')
                setup.mu=4;
                setup.std = range.SK(ir);
            else
                setup.rho = range.SK(ir);
            end
            setup.ir=ir;
            [DATA] = datasetGenSK(setup);
            if strcmp(name{1},'Logn')
                sk(im,ir)=skewness(DATA.sg.evt);
                kind = 'Skewness';
            else
                sk(im,ir)=kurtosis(DATA.sg.evt);
                kind = 'Kurtosis';
            end
            
            bin = bin_hunter(DATA,'all','PF');
            BIN.FD(im,ir) = bin.fd;
            BIN.SC(im,ir) = bin.scott;
            BIN.ST(im,ir) = bin.sturges;
            BIN.DO(im,ir) = bin.doane;
            BIN.SS(im,ir) = bin.shimazaki;
            BIN.RU(im,ir) = bin.rudemo;
            BIN.LH(im,ir) = bin.LHM;
            BIN.KN(im,ir) = bin.knuth;
            BIN.WA(im,ir) = bin.wand;
            BIN.TR(im,ir) = bin.truth;
            
            AREA.FD(im,ir) = areaPF(DATA,inter,bin.fd);
            AREA.SC(im,ir) = areaPF(DATA,inter,bin.scott);
            AREA.ST(im,ir) = areaPF(DATA,inter,bin.sturges);
            AREA.DO(im,ir) = areaPF(DATA,inter,bin.doane);
            AREA.SS(im,ir) = areaPF(DATA,inter,bin.shimazaki);
            AREA.RU(im,ir) = areaPF(DATA,inter,bin.rudemo);
            AREA.LH(im,ir) = areaPF(DATA,inter,bin.LHM);
            AREA.KN(im,ir) = areaPF(DATA,inter,bin.knuth);
            AREA.WA(im,ir) = areaPF(DATA,inter,bin.wand);
            AREA.TR(im,ir) = areaPF(DATA,inter,bin.truth);
            disp(['[PF][PCT][' num2str(ir/length(range.SK)) ']NAME[' name{1} ']IT[' num2str(im) ']TRUTH[' num2str(bin.truth) ']TIME[' num2str(toc) ']'])
            
        end
    end
    save([pwd '\PF\PF[SK]DIST[' name{1} ']EVT[' num2str(nEVT) ']'],'BIN','AREA');
end