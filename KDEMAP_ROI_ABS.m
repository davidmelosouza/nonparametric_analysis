function [D] = KDEMAP_ROI_ABS(DATA,X,Y,nROI,setup)
% X=xgrid;
% Y=ygrid{1};

% save testROI DATA X Y nROI setup
% pause 
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

% YT=YT/size(Y,2);
DC_BIAS = reshape(median(D),size(Y{1},1),nROI);
DC_VAR = reshape(var(D),size(Y{1},1),nROI);
DC = abs(DC_BIAS);

% ls={'-',':','--','-',':'};
% cl=['rrkkk'];
% m = ['BKDE  ';'AKDE  ';'VKDE  ';'MGKDE ';'VKDE* '];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2 Métodos + Modelo -> PDF
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%
% 
% 
% figure(1)
% cla = [0.85 0.85 0.85];
% h = area(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y); axis tight; hold on
% h(1).FaceColor = cla;
% h(1).EdgeColor = cla;
% for inm=1:size(Y{1},1)
%     for int = 1:size(Y,2)
%         MY{inm}(int,:) =  Y{int}(inm,:);
%     end  
%      plot(DATA.sg.pdf.truth.x,mean(MY{inm},1),cl(inm),'linestyle',ls{inm},'linewidth',1); hold on
% %     shadedErrorBar(DATA.sg.pdf.truth.x,mean(MY{inm},1),std(MY{inm}),'lineprops',cl(inm),'transparent',1); hold on; axis tight
%     grid minor
%     set(gca,'Gridlinestyle',':');
% %     set(gca,'xtick',[])
% end
% legend('MODELO','BKDE ', 'AKDE ','VKDE ','MGKDE','VKDE*');
% set(gca,'Fontsize',12);
% xlabel('Variável Aleatória')
% ylabel('Densidade de Probabilidade')
% grid on
% grid minor
% set(gca,'Gridlinestyle',':')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4 Métodos RoIs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
setup.TYPE.ROI = 'dist';
[DATA] = datasetGenMix(setup);
subplot(3,1,1); MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(3,1,1); xlabel('Variável Aleatória'); %set(gca,'Fontsize',12);
setup.TYPE.ROI = 'prob';
[DATA] = datasetGenMix(setup);
DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
subplot(3,1,2);MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(3,1,2); xlabel('Probabilidade');%set(gca,'Fontsize',12);
setup.TYPE.ROI = 'deriv';
[DATA] = datasetGenMix(setup);
DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
subplot(3,1,3);MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(3,1,3); xlabel('1ª Derivada');%set(gca,'Fontsize',12);
% setup.TYPE.ROI = 'deriv2';
% [DATA] = datasetGenMix(setup);
% DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
% subplot(4,1,4);MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
% subplot(4,1,4); xlabel('2ª Derivada');%set(gca,'Fontsize',12);