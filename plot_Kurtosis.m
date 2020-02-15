% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
type = 'Gaussian';
cl = ['yrbgkmc'];
band = 'fix';
vEVT = [100 500 1000 2000 5000];
nPoint = 1000;
mod='dist';
name = {'GGD'};
nEVT = round(vEVT(end));
nEST = 10;
nROI = 100;
nGRID = 10^5;
ntmax = 50;
[setup] = IN(name{1},'sg',errortype,mod,inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais

range.rho= [sort([[logspace(0,1,9)] 2])];
% for m=1:length(range.rho)
%     setup.rho = range.rho(m);
%      setup.ir = (m);
%     [DATA] = datasetGenSK(setup); n=length(DATA.sg.evt);
%     kt(m)=kurtosis(DATA.sg.evt);
%     if m == 1 || m==length(range.rho)
%         plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k'); hold on
%     else
%         plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'color',[0.85 0.85 0.85],'linestyle','-'); hold on
%     end
%     pause(0.1)
% end
% axis tight
% xlabel('Random Variable'); % Set the X-axis label
% ylabel('Probability Density'); % Set the X-axis label
% set(gca,'Fontsize',12);
% grid minor
% set(gca,'Gridlinestyle',':')
% xlim([-6 6])
% % 
% range.rho= sort([[logspace(0,1,9)] 2]);
ntmax = 500;
%
wb=waitbar(0,'Aguarde');
for m=1:length(range.rho)
    for nt=1:ntmax
        setup.rho = range.rho(m);
   setup.ir = (m);
        [DATA] = datasetGenSK(setup); n=length(DATA.sg.evt);
        kt(m,nt)=kurtosis(DATA.sg.evt);
    end
    waitbar(m/length(range.rho))
end
close(wb)

figure
errorbar(range.rho(1:end), mean(kt(1:end,:)'),std(kt(1:end,:)')/sqrt(ntmax),':ok')
axis tight
ylabel('Kurtosis'); % Set the X-axis label
xlabel('\rho'); % Set the X-axis label
set(gca,'Fontsize',12);
grid minor
set(gca,'Gridlinestyle',':')
% 
% %
% %

x_sk =  mean(kt(1:end,:)');

save([pwd '\HIST\XSK[' name{1} ']'],'x_sk');
save([pwd '\PF\XSK[' name{1} ']'],'x_sk');
save([pwd '\ASH\XSK[' name{1} ']'],'x_sk');
save([pwd '\KDE\XSK[' name{1} ']'],'x_sk');
