function [DATA] = SELECT_DATA(pct)
load SkinNonSkin
%% Variáveis Primárias (1)
Skin.data = SkinNonSkin(SkinNonSkin(:,4)==1,:)';
nonSkin.data = SkinNonSkin(SkinNonSkin(:,4)==2,:)';
Skin.n = length(Skin.data);
nonSkin.n = length(nonSkin.data);
%% Randomizando dados (2)
Skin.data = Skin.data(:,randperm(Skin.n));
nonSkin.data = nonSkin.data(:,randperm(nonSkin.n));
nTR = round(pct*min([Skin.n nonSkin.n])); % selecionando nº de eventos
%% Aplicando ICA (3)
% [ICA.Skin] = myICA(Skin.data(1:3,:),3);
% [ICA.nonSkin] = myICA(nonSkin.data(1:3,:),3);

[ICA.Skin.DATA, ~, ICA.Skin.A] = fastica(Skin.data(1:3,:));
[ICA.nonSkin.DATA, ~, ICA.nonSkin.A] = fastica(nonSkin.data(1:3,:));
%% Organizando Variáveis (4)
% Skin
DATA.ICA.Skin.TR = ICA.Skin.DATA(:,1:nTR);
DATA.ICA.Skin.A = ICA.Skin.A;
DATA.NORMAL.Skin.TR = Skin.data(1:3,1:nTR);
% nonSkin
DATA.ICA.nonSkin.TR = ICA.nonSkin.DATA(:,1:nTR);
DATA.ICA.nonSkin.A = ICA.nonSkin.A;
DATA.NORMAL.nonSkin.TR = nonSkin.data(1:3,1:nTR);
% both
% DATA.ICA.VAL =  [ICA.Skin.DATA(:,nTR+1:end) ICA.nonSkin.DATA(:,nTR+1:end)];
DATA.NORMAL.VAL =  [Skin.data(:,nTR+1:end) nonSkin.data(:,nTR+1:end)];
%% Randomizando validação (5)
ind = randperm(length(DATA.NORMAL.VAL));
DATA.TAG = DATA.NORMAL.VAL(4,ind);
DATA.TAG(DATA.TAG==2)=0;
%% Formatando Validação
% DATA.ICA.VAL = DATA.ICA.VAL(:,ind);
DATA.NORMAL.VAL = DATA.NORMAL.VAL(1:3,ind);
end