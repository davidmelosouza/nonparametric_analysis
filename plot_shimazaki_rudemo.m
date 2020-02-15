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
vEVT = [1000];
nEST = 10000;
nROI = 1;
nGRID = 10^5;
ntmax = 1;
% dn = [1 3 4 5 7 8 10 11 12 14 15 16];
ln=[{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'}];
mk=[{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'}];
cl=[{'k'},{'k'},{'k'},{'r'},{'r'},{'r'},{'b'},{'b'},{'b'},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]}];
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
for ne = 1:length(vEVT)
    id = 0;
    %     for name = {'D1a','D2a','D3b','D4b'}
    for name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
        id = id+1;
        nEVT = vEVT(ne);
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for im = 1:ntmax
            tic
            [DATA] = datasetGenMix(setup);
            load binmax
            [nbins,C, ~] = sshist(DATA.sg.evt);
            [bin,mq]=Rudemo(DATA.sg.evt);
            [optM,logp] = optKnuth(DATA.sg.evt,binmax);
            bin1 = 2:binmax;
            bin2 = 2:binmax;
            bin3 = 1:binmax;
            
            C= (C-min(C))/(max(C)-min(C));
            mq = (mq-min(mq))/(max(mq)-min(mq));
            logp = (logp-min(logp))/(max(logp)-min(logp));
            
            CM(id,:) = C;
            mqM(id,:) = mq;
            logpM(id,:) = logp;
            
            [iC]=find(C==min(C));
            [imq]=find(mq==min(mq));
            [ilog]=find(logp==max(logp));
            
            min_C(id)=bin1(iC);
            min_mq(id)=bin2(imq);
            max_log(id)=bin3(ilog);
            
            value_C(id)=C(iC);
            value_mq(id)=mq(imq);
            value_log(id)=logp(ilog);
            
            %             figure(2)
            %             plot(2:binmax,mq,[ln{id} cl(id)],'linewidth',0.5,'markersize',4); hold on
            %             set(gca,'Xscale','log')
            %             grid on
            %             set(gca,'Gridlinestyle',':')
            %             axis tight
            %             figure(3)
            %             plot(1:binmax,logp,[ln{id}  cl(id)],'linewidth',0.5,'markersize',4); hold on
            %             grid on
            %             set(gca,'Gridlinestyle',':')
            %             axis tight
            
        end
        
    end
    %     save([pwd '\HIST\HIST[all]EVT[' num2str(nEVT) ']'],'BIN','AREA','ERRORL2');
end

%% SS
set(gca,'Fontsize',12);
for i=1:12
    figure(1)
    plot(min_C(i),value_C(i),mk{i},'Color',cl{i},'markerfacecolor',[cl{i}],'markeredgecolor','k'); hold on
end

for i=1:12
    figure(1)
    plot(bin1,CM(i,:),':','Color',cl{i},'linewidth',1,'markersize',4); hold on
end
figure(1)
axis tight
set(gca,'Xscale','log')
grid on
set(gca,'Gridlinestyle',':')
legend(name_true,'Location','northeast','FontSize' ,12);
lgd = legend;
lgd.NumColumns = 2;
xlabel('Número de bins','FontSize' ,14)
ylabel('C(h)','FontSize' ,14)

%% Rudemo
set(gca,'Fontsize',12);
for i=1:12
    figure(2)
    plot(min_mq(i),value_mq(i),mk{i},'Color',cl{i},'markerfacecolor',[cl{i}],'markeredgecolor','k'); hold on
end

for i=1:12
    figure(2)
    plot(bin2,mqM(i,:),':','Color',cl{i},'linewidth',1,'markersize',4); hold on
end
figure(2)
axis tight
set(gca,'Xscale','log')
grid on
set(gca,'Gridlinestyle',':')
legend(name_true,'Location','northeast','FontSize' ,12);
lgd = legend;
lgd.NumColumns = 2;
xlabel('Número de bins','FontSize' ,14)
ylabel('Q(h)','FontSize' ,14)

%% Knuth
set(gca,'Fontsize',12);
for i=1:12
    figure(3)
    plot(max_log(i),value_log(i),mk{i},'Color',cl{i},'markerfacecolor',[cl{i}],'markeredgecolor','k'); hold on
end

for i=1:12
    figure(3)
    plot(bin3,logpM(i,:),':','Color',cl{i},'linewidth',1,'markersize',4); hold on
end
figure(3)
axis tight
% set(gca,'Xscale','log')
grid on
set(gca,'Gridlinestyle',':')
legend(name_true,'Location','northeast','FontSize' ,12);
lgd = legend;
lgd.NumColumns = 2;
xlabel('Número de bins','FontSize' ,14)
ylabel('logp(M)','FontSize' ,14)