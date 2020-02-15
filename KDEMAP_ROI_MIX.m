function [D] = KDEMAP_ROI_MIX(DATA,X,Y,nROI,setup)
% X=xgrid;
% Y=ygrid{1};

% save testROI DATA X Y nROI setup
% pause 
YT=0;
for int=1:size(Y,2)
    for imeth = 1:size(Y{1},1)
        for iroi = 1:nROI
            YRoI= interp1(X,protec(Y{int}(imeth,:)),DATA.sg.RoI.x{iroi},'linear','extrap');
            YRoI(YRoI<0)=0;
            if isnan(YRoI)
                disp('Encontrado')
                pause
            end
            Ynew = protec(DATA.sg.RoI.y{iroi});
            D(int,imeth,iroi)=area2d(DATA.sg.RoI.x{iroi},YRoI-Ynew);
        end
    end
    YT = YT+Y{int};
end

% YT=YT/size(Y,2);
DC = reshape(mean(D),size(Y{1},1),nROI);
SC = reshape(std(D),size(Y{1},1),nROI);
ls={'--',':','-','-',':'};
cl=[0 0 0
    0 0 0
    0.5 0.5 0.5
    1 0 0
    0 0 1
    0 1 0];
m = ['AKDE  ';'BKDE  ';'VKDE  ';'ROIKDE'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 Métodos + Modelo -> PDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%


figure
cla = [0.85 0.85 0.85];
subplot(5,1,1:2);h = area(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y); axis tight; hold on
% plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,[],'Linewidth',1); hold on
subplot(5,1,1:2);h(1).FaceColor = cla;
subplot(5,1,1:2);h(1).EdgeColor = cla;
% for inm=2
for inm=1:size(Y{1},1)
    for int = 1:size(Y,2)
        MY{inm}(int,:) =  protec(Y{int}(inm,:));
    end  
%     plot_distribution_prctile(X,MY{inm},'Prctile',[25 50 75 90]);
%     stdshade(MY{inm},0.1,'k',DATA.sg.pdf.truth.x)
  subplot(5,1,1:2);plot(DATA.sg.pdf.truth.x,mean(MY{inm},1),'Color',cl(inm,:),'linestyle',ls{inm},'linewidth',1); hold on
%   shadedErrorBar(DATA.sg.pdf.truth.x,mean(MY{inm},1),std(MY{inm}),'lineprops',cl(inm),'transparent',1); hold on; axis tight
   subplot(5,1,1:2); grid minor
   subplot(5,1,1:2); set(gca,'Gridlinestyle',':');
%   set(gca,'xtick',[])
end
hold on

ADC = reshape(mean(abs(D)),size(Y{1},1),nROI);
ASC = reshape(std(abs(D)),size(Y{1},1),nROI);
% legend([{['MODELO']},{['BKDE[' num2str(sum(ADC(1,:))) '\pm' num2str(sum(ASC(1,:))/sqrt(nROI)) ']']},{['AKDE[' num2str(sum(ADC(2,:))) '\pm' num2str(sum(ASC(2,:))/sqrt(nROI)) ']']},{['VKDE[' num2str(sum(ADC(3,:))) '\pm' num2str(sum(ASC(3,:))/sqrt(nROI)) ']']},{['ROIKDE[' num2str(sum(ADC(4,:))) '\pm' num2str(sum(ASC(4,:))/sqrt(nROI)) ']']}]);
legend([{['MODELO']},{['AKDE']},{['BKDE']},{['VKDE']},{['ROIKDE']}],'location','best');

set(gca,'Fontsize',12);
xlabel('Variável Aleatória')
ylabel('Densidade de Probabilidade')
grid on
grid minor
set(gca,'Gridlinestyle',':')
 subplot(5,1,1:2); set(gca, 'Position', [0.044655929721816,0.596006144393241,0.945827232796486,0.400921658986175]); set(gca,'LooseInset',get(gca,'TightInset'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4 Métodos RoIs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
setup.TYPE.ROI = 'dist';
[DATA] = datasetGenMix(setup);
DATA.sg.RoI.Xaxis = 1:nROI;
subplot(5,1,3); MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(5,1,3); xlabel('RoI(Variável Aleatória)'); %set(gca,'Fontsize',12);
subplot(5,1,3);set(gca,'Fontsize',10);
 subplot(5,1,3); set(gca, 'Position', [0.044655929721816,0.416065948606660,0.945827232796486,0.089862349448483]); %set(gca,'LooseInset',get(gca,'TightInset'));

setup.TYPE.ROI = 'prob';
[DATA] = datasetGenMix(setup);
% DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
DATA.sg.RoI.Xaxis = 1:nROI;
subplot(5,1,4);MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(5,1,4); xlabel('RoI(Probabilidade)');%set(gca,'Fontsize',12);
subplot(5,1,4);set(gca,'Fontsize',10);
 subplot(5,1,4); set(gca, 'Position', [0.044655929721816,0.243396457081236,0.945827232796486,0.089862349448483]); %set(gca,'LooseInset',get(gca,'TightInset'));
setup.TYPE.ROI = 'deriv';
[DATA] = datasetGenMix(setup);
DATA.sg.RoI.Xaxis = 1:nROI;
% DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
subplot(5,1,5);MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
subplot(5,1,5); xlabel('RoI(1ª Derivada)');%set(gca,'Fontsize',12);
subplot(5,1,5);set(gca,'Fontsize',10);
 subplot(5,1,5); set(gca, 'Position', [0.044655929721816,0.070767281105991,0.945827232796486,0.089862349448483]); %set(gca,'LooseInset',get(gca,'TightInset'));

 set(gcf, 'WindowState', 'maximized');
 
 % setup.TYPE.ROI = 'deriv2';
% [DATA] = datasetGenMix(setup);
% DATA.sg.RoI.Xaxis = linspace(0,1,length(DATA.sg.RoI.Xaxis));
% subplot(4,1,4);MAP_ROI(DATA,DC,Y,DATA.sg.RoI.iRoI);
% subplot(4,1,4); xlabel('2ª Derivada');%set(gca,'Fontsize',12);