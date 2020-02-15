% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
type = 'Gaussian';
% vEVT = [25];
vEVT = [25 50 100 500 1000];
nPoint = 1000;
mod='dist';
nEST = 10;
nROI = 250;
nGRID = 10^5;
ntmax = 2;
% name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
for name =  {'D4c'}
    % for name = {'D2a'}
    disp(['=============================' name{1} '=============================' ]);
    for ievt=1:length(vEVT)
        nEVT = round(vEVT(ievt));
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        for i=1:ntmax
            disp(['EVT[' num2str(nEVT) ']IT[' num2str(i) ']'])
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            x = sort(DATA.sg.evt);
            [h] = h_methods(setup,DATA);
            %% Estágio 1:
            [X.s1,Y.s1,~] = KDESSEROI(x,{h.CV.OSCV},nPoint,h.CV.OSCV);
            %% Estágio 2:
            [h] = h_methods_ATLAS(data_robust(x));
            [X.s2,Y.s2,~] = KDESSEROI(x,{h.CV.OSCV},nPoint,h.CV.OSCV);
            %% Estágio 3:
            [h1,R] = stage1(x,h);
            [Xpdf,pdf] = KDEfast_fixed(x,h1,nPoint); %PDF da referência;
            fpi = interp1(Xpdf,pdf,x,'linear',0); [fpi]= protec(fpi);
            lambda=exp((length(x)^-1)*sum(log(fpi)));
            [hi] = hSSE(h1,lambda,fpi);[hi]= protec(hi);
            [X.s3,Y.s3,~] = KDESSEROI(x,{hi},nPoint,h1);
            %% Estágio 3:
            if length(x)<100
                [hf] = stage23(x,h1,h,R,nPoint,2,'KDE','PROB','ON','ON');
            end
            
            if length(x)>=100 && length(x)<=500
                [hf] = stage23(x,h1,h,R,nPoint,2,'KDE','PROB','ON','ON');
            end
            
            if length(x)>=1000
                [hf] = stage23(x,h1,h,R,nPoint,2,'KDE','BOTH','ON','ON');
            end
            [hf]= protec(hf);
            [X.s4,Y.s4,~] = KDESSEROI_Hi(x,{hf'},nPoint,h1);
            [A{ievt}(i,:),xgrid,ygrid{ievt}{i}] = areaKDEVAR_STAGE(DATA,X,Y);
            %             pause
            
            for ik = 1:4
                K{ik}(i,ievt)=A{ievt}(i,ik);
            end
        end
    end
    %     save([pwd '\KDE\KDE[VAR]DIST[' name{1} ']'],'K','xgrid','ygrid');
    
end


DADOS = {K{1};K{2};K{3};K{4}};
PLOTBOXKDE_VAR_STAGE(DADOS,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on