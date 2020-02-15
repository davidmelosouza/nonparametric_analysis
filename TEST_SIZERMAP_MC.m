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
nPoint = 10000;
% vEVT = [1000];
vEVT = [25 50 100 500 1000];
nEST = 10000;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
mymap = [1 0 0
    0.5 0.5 0.5
    0 0 0.5
    0.5 0 0.5];
d = [1 3 4 5 7 8 10 11 12 14 15 16];
TRUTH = [1 1 1 2 2 2 2 3 3 1 2 3];
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
for ne = 1:length(vEVT)
    
    %     for name = {'D4d'}
    for im = 1:ntmax
        id = 0;
        for name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
            
            id = id+1;
            nEVT = vEVT(ne);
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            
            [DATA] = datasetGenMix(setup); DATA.nPoint = nPoint;
            DATA.sg.evt = normalize(DATA.sg.evt);
            %             hall = h_methods(setup,DATA);
            %             href = hall.CV.TCV;
            %             href = h_imp_L1(DATA.sg.evt');
            href = SJbandwidth(DATA.sg.evt);
            [x,dy,h,y] = SIZER(DATA.sg.evt,href);
            %             mymap = [1 0 0
            %                 0.5 0.5 0.5
            %                 0 0 0.5
            %                 0.5 0 0.5];
            %             figure(1)
            %             plot(x,y,'-','Color',[.75 .75 .75]);axis tight; hold on
            %             plot(x,y(end,:),':k','Linewidth',1);axis tight
            %             ylabel('Densidade')
            %             xlabel('Amostras')
            %             set(gca,'Fontsize',14); grid minor
            %
            %             figure(2)
            %             mesh(x,h(1:end-1),dy(1:end-1,:));hold on
            %             colormap(mymap);view(2);hold on
            %             plot3([min(x) max(x)],[href  href],[2 2],':k','Linewidth',1)
            %             xlabel('Amostras')
            %             ylabel('h')
            %             set(gca,'Fontsize',14);
            
            PTH = y(end,:);
            CTH = dy(end,:);
            
            [T{ne}(id,im)] = findTran(CTH);
            [P{ne}(id,im)] = findPeaks(PTH);
%             disp([name_true{id} '=' num2str(T{ne}(id,im)) '|' num2str(P{ne}(id,im)) '|' num2str(TRUTH(id))])
%             set(gca,'Yscale','log')
%             
%             axis tight
%             pause
%             close
        end
        PCT.SIZER(ne,im)=sum(T{ne}(:,im)==TRUTH')/12;
        PCT.PDF(ne,im)=sum(P{ne}(:,im)==TRUTH')/12;
        disp(['EVT[' num2str(nEVT) ']' num2str(PCT.SIZER(ne,im)) '|' num2str(PCT.PDF(ne,im))])
    end
        save([pwd '\KDE\KDE[SIZER]EVT[' num2str(nEVT) ']'],'T','P','PCT');
end

