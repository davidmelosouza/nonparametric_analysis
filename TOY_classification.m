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
nEVT = 1000;
ntmax = 100;
nROI = 1;
nGRID = 10000;
vEVT = [25];
ne = 0;
wb=waitbar(0,'Aguarde...');
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
nEST = vEVT;

[DADO.SG] = signal_GEN(nEVT,nGRID,nEST,nROI);
[DADO.BG] = background_GEN(nEVT,nGRID,nEST,nROI);



