% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
type = 'Gaussian';
vEVT = [25 50 100 500 1000];
% vEVT = [50];
nPoint = 1000;
mod='dist';
nEST = 10;
nROI = 250;
nGRID = 10^5;
ntmax = 100;
for name = {,'D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
    load([pwd '\KDE\Stage3\KDE[alfa]DIST[' name{1} ']']);
    pause
end