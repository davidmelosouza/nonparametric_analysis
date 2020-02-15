% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
band = 'fix';
type = 'Gaussian';
cl = ['yrbgkmc'];
vEVT = [25 50 100 500 1000];
nPoint = 1000;
mod='dist';
nEVT = round(vEVT(1));
nEST = nPoint;
nROI = 1;
nGRID = 10^5;
ntmax = 15;
in = 0;
% [setup] = IN(names,'sg',errortype,mod,inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais


% wp = waitbar(0,'Aguarde...');
for name = {'Logn'}
    in = in+1;
    if strcmp(name,'Logn')
        range.SK =linspace(0.01,1,10);
    else
        range.SK = sort([logspace(0,1,9) 2]);
    end
    for ir=1:length(range.SK)
        
        for int=1:ntmax
            tic
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            if strcmp(name{1},'Logn')
                setup.mu=log(2);
                setup.std = range.SK(ir);
            else
                setup.rho = range.SK(ir);
            end
            setup.ir=ir;
            [DATA] = datasetGenSK(setup);
            if strcmp(name{1},'Logn')
                sk(ir,int)=skewness(DATA.sg.evt);
                kind = 'Skewness';
            else
                sk(ir,int)=kurtosis(DATA.sg.evt);
                kind = 'Kurtosis';
            end
            
            DATA.nPoint = nPoint;
            h = h_methods(setup,DATA);
%            pause
%             pause
            %                  pause
            hfix = [];
            bin = [];
%             pause
            %               bin = calcnbins(DATA.sg.evt,'Rudemo');
             [A(int,:),L2(int,:),X(int,:),pdf(int,:)] = areaKDEfix(DATA,nPoint,h,inter);
%             [A(int,:),X(int,:),pdf(int,:)] = areaKDE(DATA,nPoint,h,inter,band);
%                         [A(int,:)] = areaPILOT(DATA,nPoint,inter,'KDE',bin,h,hfix,'SSE',1);
%             %             H{1}(int,ir)= h.PI.SV;
            %             H{2}(int,ir)= h.PI.SVM1;
            %             H{3}(int,ir)= h.PI.SVM2;
            %             H{4}(int,ir)= h.PI.SJ;
            %             H{5}(int,ir)= h.PI.SC;
            %             H{6}(int,ir)= h.CV.MLCV;
            %             H{7}(int,ir)= h.CV.UCV;
            %             H{8}(int,ir)= h.CV.BCV1;
            %             H{9}(int,ir)= h.CV.BCV2;
            %             H{10}(int,ir)= h.CV.CCV;
            %             H{11}(int,ir)= h.CV.MCV;
            %             H{12}(int,ir)= h.CV.TCV;
            %             H{13}(int,ir)= h.truth;
            
            for ik = 1:15
                AREA{ik}(int,ir)=A(int,ik);
            end
            disp(['DIST[' name{1} ']NSK[' num2str(ir) ']NEVT[' num2str(nEVT) ']IT[' num2str(int) ']TIME[' num2str(toc) ']AREA[' num2str(area2d(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y)) ']'])
        end
        %         waitbar(ir/length(range.SK))
        if strcmp(name{1},'Logn')
            xEST = linspace(min(DATA.sg.pdf.truth.x),max(DATA.sg.pdf.truth.x),nEST);
            yEST = lognpdf(xEST,setup.mu,setup.std);
            yGRID = interp1(xEST,yEST,DATA.sg.pdf.truth.x,'linear');
            Aerro(ir) = area2d(DATA.sg.pdf.truth.x,abs(yGRID-DATA.sg.pdf.truth.y));
        else
            xEST = linspace(min(DATA.sg.pdf.truth.x),max(DATA.sg.pdf.truth.x),nEST);
            yEST = ggd(xEST,setup.rho)';
            yGRID = interp1(xEST,yEST,DATA.sg.pdf.truth.x,'linear');
            Aerro(ir) = area2d(DATA.sg.pdf.truth.x,abs(yGRID-DATA.sg.pdf.truth.y));
        end
        
    end
    %     close(wp)

DADOS_AREA = {AREA{1};AREA{2};AREA{3};AREA{4};AREA{5};AREA{6};AREA{7};AREA{8};AREA{9};AREA{10};AREA{11};AREA{12};AREA{13};AREA{14};AREA{15}};

%     figure(1)
PLOTBOXSK(DADOS_AREA,median(sk'),kind,'Área do Erro','NorthEast'); hold on
load XL
% % aboxplot(Aerro','labels',vEVT,'Colormap',[0 0 0],'colorrev',false,'OutlierMarker','+')
plot(XL,Aerro,'s:k','Linewidth',1,'DisplayName','Interpolação')
% 
% saveas(gcf,[pwd '\SK\SK[' name{1} ']'],'png');
% saveas(gcf,[pwd '\SK\SK[' name{1} ']'],'fig');
% save([pwd '\SK\SK[INFO][' name{1} ']'],'DADOS_AREA','sk','kind','XL','Aerro');
% close(1)
% clear A X pdf AREA DADOS_AREA
end



%     for ir=1:length(vEVT)
%         nEVT = round(vEVT(ir));
%         nEST = 10;
%         nROI = 100;
%         nGRID = 10^5;
%         ntmax = 10;
%         [setup] = IN(name{1},'sg',errortype,mod,inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
%         [DATA] = datasetGenSingle(setup); n=length(DATA.sg.evt);
%         for i=1:ntmax
%             tic
%             [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
%             [DATA] = datasetGenSingle(setup);
%             [A{ir}(i,:),xgrid,ygrid{ir}{i}] = areaKDE_NEWMETHOD(DATA,nPoint,inter,'KDE','Rudemo','Sir','SSE',1);
%             for ik = 1:5
%                 K{ik}(i,ir)=A{ir}(i,ik);
%             end
%                 disp(['DIST[' name{1} ']NEVT[' num2str(nEVT) ']IT[' num2str(i) ']TIME[' num2str(toc) ']'])
%         end
%     end
%
%
% DADOS = {K{1};K{2};K{3};K{4};K{5}};
%
% figure
% PLOTBOXKDE_VAR_NEWMETHOD(DADOS,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on
%
% saveas(gcf,[pwd '\MKDE\MKDE[AREA][' name{1} '][end]'],'png');
% saveas(gcf,[pwd '\MKDE\MKDE[AREA][' name{1} '][end]'],'fig');
% save([pwd '\MKDE\MKDE[INFO][' name{1} ']'],'xgrid','ygrid','K');
% close
% end