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
nPoint = 1000;
vEVT = [25 50 100 500 1000];
nEST = 1000;
nROI = 1;
nGRID = 10^5;
ntmax = 50;

for ne = 1:length(vEVT)
    id = 0;
    for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
        id = id+1;
        nEVT = vEVT(ne);
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for im = 1:ntmax
            tic
            [DATA] = datasetGenMix(setup);
            bin = bin_hunter(DATA,'all','ASH');
            
            BIN.FD(im,id) = bin.fd;
            BIN.SC(im,id) = bin.scott;
            BIN.ST(im,id) = bin.sturges;
            BIN.DO(im,id) = bin.doane;
            BIN.SS(im,id) = bin.shimazaki;
            BIN.RU(im,id) = bin.rudemo;
            BIN.LH(im,id) = bin.LHM;
            BIN.KN(im,id) = bin.knuth;
            BIN.WA(im,id) = bin.wand;
            BIN.TR(im,id) = bin.truth;
            
            AREA.FD(im,id) = areaASH(DATA,inter,bin.fd);
            AREA.SC(im,id) = areaASH(DATA,inter,bin.scott);
            AREA.ST(im,id) = areaASH(DATA,inter,bin.sturges);
            AREA.DO(im,id) = areaASH(DATA,inter,bin.doane);
            AREA.SS(im,id) = areaASH(DATA,inter,bin.shimazaki);
            AREA.RU(im,id) = areaASH(DATA,inter,bin.rudemo);
            AREA.LH(im,id) = areaASH(DATA,inter,bin.LHM);
            AREA.KN(im,id) = areaASH(DATA,inter,bin.knuth);
            AREA.WA(im,id) = areaASH(DATA,inter,bin.wand);
            AREA.TR(im,id) = areaASH(DATA,inter,bin.truth);
            
            ERRORL2.FD(im,id) = L2PF(DATA,inter,bin.fd);
            ERRORL2.SC(im,id) = L2PF(DATA,inter,bin.scott);
            ERRORL2.ST(im,id) = L2PF(DATA,inter,bin.sturges);
            ERRORL2.DO(im,id) = L2PF(DATA,inter,bin.doane);
            ERRORL2.SS(im,id) = L2PF(DATA,inter,bin.shimazaki);
            ERRORL2.RU(im,id) = L2PF(DATA,inter,bin.rudemo);
            ERRORL2.LH(im,id) = L2PF(DATA,inter,bin.LHM);
            ERRORL2.KN(im,id) = L2PF(DATA,inter,bin.knuth);
            ERRORL2.WA(im,id) = L2PF(DATA,inter,bin.wand);
            ERRORL2.TR(im,id) = L2PF(DATA,inter,bin.truth);
            disp(['NAME[' name{1} ']IT[' num2str(im) ']TRUTH[' num2str(bin.truth) ']TIME[' num2str(toc) ']'])
        end
        DADOS_BIN = [median(BIN.FD-BIN.TR);median(BIN.SC-BIN.TR);median(BIN.ST-BIN.TR);median(BIN.DO-BIN.TR);median(BIN.KN-BIN.TR);median(BIN.WA-BIN.TR);median(BIN.SS-BIN.TR);median(BIN.RU-BIN.TR);median(BIN.LH-BIN.TR)];
        DADOS_AREA = [median(AREA.FD);median(AREA.SC);median(AREA.ST);median(AREA.DO);median(AREA.KN);median(AREA.WA);median(AREA.SS);median(AREA.RU);median(AREA.LH);median(AREA.TR)];
        DADOS_AREA_VAR = [std(AREA.FD);std(AREA.SC);std(AREA.ST);std(AREA.DO);std(AREA.KN);std(AREA.WA);std(AREA.SS);std(AREA.RU);std(AREA.LH);std(AREA.TR)];
        %     figure(1)
        %     PLOTBOX(DADOS_BIN,nEVT,'Events','\DeltaBins','NorthWest'); hold on
        %     plot([0 5000],[0 0],':k','HandleVisibility','off')
        %     pause
    end
    save([pwd '\ASH\ASH[all]EVT[' num2str(nEVT) ']'],'BIN','AREA','ERRORL2');
end
% matplot(DADOS_BIN,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', '\DeltaBins')
% matplot(DADOS_AREA,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', 'Error Area')
% matplot(DADOS_AREA_VAR,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', '\sigma')