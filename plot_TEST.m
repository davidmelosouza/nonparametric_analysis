close all; clear; clc;

ESTIMADOR = 'HIST';
EVENTOS = 500;

load([pwd '\' ESTIMADOR '\' ESTIMADOR '[all]EVT[' num2str(EVENTOS) '].mat'],'BIN','AREA');

if ~strcmp(ESTIMADOR,'KDE')
    DADOS_BIN = [median(BIN.FD-BIN.TR);median(BIN.SC-BIN.TR);median(BIN.ST-BIN.TR);median(BIN.DO-BIN.TR);median(BIN.KN-BIN.TR);median(BIN.WA-BIN.TR);median(BIN.SS-BIN.TR);median(BIN.RU-BIN.TR);median(BIN.LH-BIN.TR)];
    DADOS_BIN_IQR = [iqr(BIN.FD-BIN.TR);iqr(BIN.SC-BIN.TR);iqr(BIN.ST-BIN.TR);iqr(BIN.DO-BIN.TR);iqr(BIN.KN-BIN.TR);iqr(BIN.WA-BIN.TR);iqr(BIN.SS-BIN.TR);iqr(BIN.RU-BIN.TR);iqr(BIN.LH-BIN.TR)];
    DADOS_AREA = [median(AREA.FD);median(AREA.SC);median(AREA.ST);median(AREA.DO);median(AREA.KN);median(AREA.WA);median(AREA.SS);median(AREA.RU);median(AREA.LH);median(AREA.TR)];
    DADOS_AREA_STD = [std(AREA.FD);std(AREA.SC);std(AREA.ST);std(AREA.DO);std(AREA.KN);std(AREA.WA);std(AREA.SS);std(AREA.RU);std(AREA.LH);std(AREA.TR)];
else
DADOS_AREA = [median(AREA.SV);median(AREA.SVM1);median(AREA.SVM2);median(AREA.SJ);median(AREA.SC);median(AREA.L1I);median(AREA.MLCV);median(AREA.UCV);median(AREA.BCV1);median(AREA.BCV2);median(AREA.CCV);median(AREA.MCV);median(AREA.TCV);median(AREA.OSCV);median(AREA.TR)];
DADOS_BIN = [median(H.SV-H.TR);median(H.SVM1-H.TR);median(H.SVM2-H.TR);median(H.SJ-H.TR);median(H.SC-H.TR);median(H.MLCV-H.TR);median(H.UCV-H.TR);median(H.BCV1-H.TR);median(H.BCV2-H.TR);median(H.CCV-H.TR);median(H.MCV-H.TR);median(H.TCV-H.TR);median(H.OSCV-H.TR)];
DADOS_AREA_STD = [iqr(AREA.SV);iqr(AREA.SVM1);iqr(AREA.SVM2);iqr(AREA.SJ);iqr(AREA.SC);iqr(AREA.L1I);iqr(AREA.MLCV);iqr(AREA.UCV);iqr(AREA.BCV1);iqr(AREA.BCV2);iqr(AREA.CCV);iqr(AREA.MCV);iqr(AREA.TCV);iqr(AREA.OSCV);iqr(AREA.TR)];
DADOS_BIN_STD = [iqr(H.SV-H.TR);iqr(H.SVM1-H.TR);iqr(H.SVM2-H.TR);iqr(H.SJ-H.TR);iqr(H.SC-H.TR);iqr(H.L1I-H.TR);iqr(H.MLCV-H.TR);iqr(H.UCV-H.TR);iqr(H.BCV1-H.TR);iqr(H.BCV2-H.TR);iqr(H.CCV-H.TR);iqr(H.MCV-H.TR);iqr(H.TCV-H.TR);iqr(H.OSCV-H.TR)];
end

plotMATRIX(DADOS_AREA,DADOS_AREA_STD)
plotMATRIX_SIM(DADOS_BIN,DADOS_BIN_IQR)

