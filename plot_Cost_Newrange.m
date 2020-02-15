% plot(h.CV.range,h.CV.Cost{9},'-k','Linewidth',2); hold on
% % plot(h.CV.range,h.CV.Cost{11},':k','Linewidth',2);
% 
% plot(h.CV.range,h.CV.Cost{10},'-r','Linewidth',2); hold on
% % plot(h.CV.range,h.CV.Cost{12},':r','Linewidth',2);
% xlim([0 5])
% set(gca,'Yscale','log')
% xlabel('h')
% ylabel('Cost')
% legend('Gaussian New Range','Gaussian','Epanechikov New Range','Epanechikov')
% 
% h.CV.range
% hnew=linspace(min(h.CV.range),max(h.CV.range),1000);
% ynew=interp1(h.CV.range,h.CV.Cost{10},hnew,'pchip',0);
% ynew2=interp1(h.CV.range,h.CV.Cost{11},hnew,'pchip',0);
% 
% plot(h.CV.range,h.CV.Cost{10},':or'); hold on
% plot(hnew,ynew,'r');
% 
% 
% plot(h.CV.range,h.CV.Cost{11},':ok'); hold on
% plot(hnew,ynew2,'k');

c = [1 1 1 1 1 1 1 0.5730 1 1];
for m=1:10
    
plot(h.CV.newrange*c(m),h.CV.Cost{m},'-k','Linewidth',2); hold on
plot([h.CV.Methods{m} h.CV.Methods{m}],[min(h.CV.Cost{m}) max(h.CV.Cost{m})],':r','Linewidth',1); hold on
% plot(h.CV.newrange,h.CV.Cost{6},'-r','Linewidth',2); hold on
% xlim([0 5])
% set(gca,'Yscale','log')
xlabel('h')
ylabel('Cost')

% legend('Cost New Range')
pause
close
end