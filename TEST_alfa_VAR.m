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
ntmax = 25;
% for name = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'}
id =0;
for name = {'D1a','D1c','D1d','D2a','D2c','D2d'}
    id = id+1;
    
    for ievt=1:length(vEVT)
        nEVT = round(vEVT(ievt));
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for i=1:ntmax
            tic
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            [hf] = h_truth(setup,DATA);
            x = DATA.sg.evt;
            [xest,yest] = KDEfast_fixed(x,hf.truthG,nPoint);
            fx = interp1(xest,yest,x,'linear','extrap');
            lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
            fpi = interp1(xest,yest,x,'linear','extrap');
            ia=0;
            for alfa=logspace(0,2,100)
                ia=ia+1;
                [hi] = hSSE_alfa(hf.truthG,lambda,fpi,alfa);
                [X,f] = KDESSE_alfa(x,{hi},nPoint,hf.truthG);
                
                xtruth=linspace(min(X),max(X),nGRID);
                [ytruth] = GridNew(DATA.sg,xtruth,name{1});
%                                 [area2d(X,f) area2d(xtruth,ytruth)]
                
                ygrid = interp1(X,f,xtruth,'linear',0);
                e(ia)=area2d(xtruth,abs(ytruth-ygrid));
            end
            
            alfaM=logspace(0,2,100);
            %             plot(alfaM,e); hold on
            %             set(gca,'xscale','log')
            %             pause(0.1)
            ind=find(e==min(e));
            ALFA{id}(i,ievt)=alfaM(ind);
            disp(['NAME[' name{1} ']IT[' num2str(i) ']HTRUTH[' num2str(hf.truthG) ']TIME[' num2str(toc) ']'])
            disp('=================================================');
        end
        close
    end
end

save([pwd '\KDE\KDE[alfa]DIST[1-6]'],'ALFA');