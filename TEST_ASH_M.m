% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'nearest';
errortype = 'none';
mod = 'abs';
j=0;
cl = ['yrbgkmc'];
% binmax = 500;
% for vEVT = [100 500 1000 2000 5000];
vEVT = 500;
out = [];
% for name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};
mvec = [1 3 5 7 10 13 15];
for name={'D2a'}
    for j=1:length(vEVT)
        % j=j+1;
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
        ntmax = 50;
%         mmax = 12;
        wb = waitbar(0,'Aguarde...');
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenMix(setup);
            [BIN]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],'all');
            BIN.scott = round(range([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out])/(2.57*std([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out])*DATA.sg.n.evt^(-1/5)));
            for m=1:length(mvec)
                load binmax
                [BIN.truth,MA,nbin]=ASHtruth(DATA,mvec(m),binmax,inter);
                [x,y] = ASHmethods(DATA.sg.evt,m,inter,BIN);
                
                ygrid(1,:)=interp1(x.fd,y.fd,DATA.sg.pdf.truth.x,inter,0);
                ygrid(2,:)=interp1(x.scott,y.scott,DATA.sg.pdf.truth.x,inter,0);
                ygrid(3,:)=interp1(x.sturges,y.sturges,DATA.sg.pdf.truth.x,inter,0);
                ygrid(4,:)=interp1(x.doane,y.doane,DATA.sg.pdf.truth.x,inter,0);
                ygrid(5,:)=interp1(x.shimazaki,y.shimazaki,DATA.sg.pdf.truth.x,inter,0);
                ygrid(6,:)=interp1(x.rudemo,y.rudemo,DATA.sg.pdf.truth.x,inter,0);
                ygrid(7,:)=interp1(x.LHM,y.LHM,DATA.sg.pdf.truth.x,inter,0);
                ygrid(8,:)=interp1(x.knuth,y.knuth,DATA.sg.pdf.truth.x,inter,0);
                ygrid(9,:)=interp1(x.wand,y.wand,DATA.sg.pdf.truth.x,inter,0);
                ygrid(10,:)=interp1(x.truth,y.truth,DATA.sg.pdf.truth.x,inter,0);
                
                A{1}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(1,:)-DATA.sg.pdf.truth.y));
                A{2}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(2,:)-DATA.sg.pdf.truth.y));
                A{3}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(3,:)-DATA.sg.pdf.truth.y));
                A{4}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(4,:)-DATA.sg.pdf.truth.y));
                A{5}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(5,:)-DATA.sg.pdf.truth.y));
                A{6}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(6,:)-DATA.sg.pdf.truth.y));
                A{7}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(7,:)-DATA.sg.pdf.truth.y));
                A{8}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(8,:)-DATA.sg.pdf.truth.y));
                A{9}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(9,:)-DATA.sg.pdf.truth.y));
                A{10}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(10,:)-DATA.sg.pdf.truth.y));
                
            end
            waitbar(i/ntmax)
        end
        close(wb)
    end
    
end

figure(1)
DADOS = {A{1};A{2};A{3};A{4};A{5};A{6};A{7};A{8};A{9};A{10}};

% % for ievt=1:5
% for im=1:mmax
% for imet = 1:8
%     MA=A{imet};
%     [Q1,Q2,Q3]=quartile(MA(:,im));
% M(imet,im) = Q2;
% IQ1(imet,im) =Q1;
% IQ3(imet,im) =Q3;
% end
% end
% end

% errorbar(repmat(1:mmax,imet,1)',M',M'-IQ1',IQ3'-M','s');hold on
% plot(1:mmax,IQ1',':')
% plot(1:mmax,IQ3',':')

figure(1)
PLOTBOX(DADOS,mvec,'M','Erro de Área','NorthEast'); hold on
% plot([0 20.5],[0 0],':k'); hold on
%  ADD_xtick(cell2mat(DADOS),[0:20]+0.5)
grid minor
set(gca,'Gridlinestyle',':')
% set(gca, 'XTickLabel', '');
