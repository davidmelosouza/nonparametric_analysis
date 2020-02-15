function [D] = KDEMAP_ROI_MISE_EXPLANATION(DATA,X,Y,nROI,setup)
% X=xgrid;
% Y=ygrid{1};

YT=0;
for int=1:size(Y,2)
    for imeth = 1:size(Y{1},1)
        for iroi = 1:nROI
            YRoI= interp1(X,Y{int}(imeth,:),DATA.sg.RoI.x{iroi},'linear','extrap');
            YRoI(YRoI<0)=0;
            if isnan(YRoI)
                disp('Encontrado')
                pause
            end
            D(int,imeth,iroi)=area2d(DATA.sg.RoI.x{iroi},YRoI-DATA.sg.RoI.y{iroi});
        end
    end
    YT = YT+Y{int};
end


DC_BIAS = reshape(mean(D),size(Y{1},1),nROI);
DC_VAR = reshape(var(D),size(Y{1},1),nROI);
DC = (DC_BIAS.^2)+DC_VAR;
% YT=YT/size(Y,2);
% DC = reshape(var(D),size(Y{1},1),nROI);
% save DC DC 
% pause
% ls={'-',':','--','-.'};
cl=[0.35 0.35 0.35; 0.75 0.75 0.75];
m = ['VKDE '; 'BKDE ';'AKDE '];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 M�todos + Modelo -> PDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  subplot(8,1,1:4);plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,':k','linewidth',1); axis tight; hold on
% 
% for inm=[2 1]
%     for int = 1:size(Y,2)
%         MY{inm}(int,:) =  Y{int}(inm,:);
%     end  
%     subplot(8,1,1:4); plot(DATA.sg.pdf.truth.x,mean(MY{inm},1),'color',cl(inm,:)); hold on
% %     shadedErrorBar(DATA.sg.pdf.truth.x,mean(MY{inm},1),std(MY{inm}),'lineprops',cl(inm),'transparent',1); hold on; axis tight
%     grid minor
%     set(gca,'Gridlinestyle',':');
%     set(gca,'xtick',[])
% end
% legend('Modelo','Estima��o 1','Estima��o 2');
% set(gca,'Fontsize',12);
% % xlabel('Vari�vel Aleat�ria')
% ylabel('Densidade de Probabilidade')
% grid on
% grid minor
% set(gca,'Gridlinestyle',':')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4 M�todos RoIs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
figure
setup.TYPE.ROI = 'dist';
[DATA] = datasetGenSingle(setup);
subplot(4,1,1);MAP_ROI_EXPLANATION(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(4,1,1); xlabel('Vari�vel Aleat�ria');
setup.TYPE.ROI = 'prob';
[DATA] = datasetGenSingle(setup);
DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
subplot(4,1,2);MAP_ROI_EXPLANATION(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(4,1,2); xlabel('Probabilidade');
setup.TYPE.ROI = 'deriv';
[DATA] = datasetGenSingle(setup);
DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
subplot(4,1,3);MAP_ROI_EXPLANATION(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(4,1,3); xlabel('1� Derivada');
setup.TYPE.ROI = 'deriv2';
[DATA] = datasetGenSingle(setup);
DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
subplot(4,1,4);MAP_ROI_EXPLANATION(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(4,1,4); xlabel('2� Derivada');