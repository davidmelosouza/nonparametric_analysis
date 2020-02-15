
clear; clc; close all;
%% CARREGANDO/ORGANIZANDO/ICA NO BANCO DE DADOS
% for ip = 1:10
%     pct = 0.0025*ip;
pct = 0.01;
[DATA] = SELECT_DATA(pct);

DATA_input = DATA.NORMAL.VAL;
DATA_target = DATA.TAG;
%% APLICANDO ICA NA VALIDAÇÃO
% ICA.Skin.TR=DATA.NORMAL.Skin.TR;
% ICA.nonSkin.TR=DATA.NORMAL.nonSkin.TR;
% ICA.Skin.VAL=DATA.NORMAL.VAL;
% ICA.nonSkin.VAL=DATA.NORMAL.VAL;
[ICA.Skin.VAL] = ICAset(DATA.NORMAL.VAL,DATA.ICA.Skin.A);
[ICA.nonSkin.VAL] = ICAset(DATA.NORMAL.VAL,DATA.ICA.nonSkin.A);
%% DENSIDADE
nPoint = 1000;
[x,y] = DensitySnS(DATA.ICA,nPoint);
%% INTERPOLAÇÃO
[p] = ProbabilitySnS(ICA,x,y);
%% LH
[LH] = LH_SnS(p);
%% PERFORMANCE
%     [ef,fa,bsp(ip,:)]=ROC_SnS(DATA,LH,0);
[ef,fa,bsp]=ROC_SnS(DATA,LH,1);
figure
plotconfusion(LH(1,:)>0.5,logical(DATA.TAG))
% end
