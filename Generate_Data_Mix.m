% TEST DISTRIBUI�ES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUI��ES QUE SER�O UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
band = 'fix';
nPoint = 1000;
nEVT = 200;
nEST = 100;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
p=0;
% for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
for name = {'D2b'}
p=p+1;
[setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Par�metros Iniciais
[DATA] = datasetGenMix(setup);
subplot(4,4,p);[yh,xh]=hist(DATA.sg.evt,100);
d=diff(xh); d=d(1);

% subplot(4,4,p);figure, hold on; set(gca,'fontsize',14);
subplot(4,4,p);hf=area(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y); hold on
subplot(4,4,p);hf.FaceColor = [0.75 0.75 0.75];
subplot(4,4,p);hf.EdgeColor = [0.75 0.75 0.75];
% subplot(4,4,p);stairs(xh,yh/area2d(xh,yh),'-k'); hold on
subplot(4,4,p);axis tight
subplot(4,4,p);ylabel('Probability Density')
subplot(4,4,p);xlabel('Random Variable')
subplot(4,4,p);title(name{1})
% subplot(3,4,p);legend('Model','Data')
end