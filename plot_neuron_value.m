type = 'ATLAS';

load([pwd '\KDE\RNA[H][' type ']TEST'],'spv');
load([pwd '\KDE\RNA[H][' type ']TEST2'],'spv2');
MSP = reshape(mean(spv),size(spv,2),size(spv,3));
SSP = reshape(std(spv),size(spv,2),size(spv,3));
MSP2 = reshape(mean(spv2),size(spv2,2),size(spv2,3));
SSP2 = reshape(std(spv2),size(spv2,2),size(spv2,3));
MSP = [MSP; MSP2]
SSP = [SSP; SSP2]
cl = ['kkkkk'];
mk = ['v>^os'];
vnr =[2:2:30 35:5:50];
for i=1:5
    errorbar(vnr,MSP(:,i),SSP(:,i)/sqrt(ntmax),':','marker',mk(i),'markersize',7,'color',cl(i),'markerfacecolor',cl(i),'markeredgecolor','w'); hold on
end
legend('25 Amostras','50 Amostras','100 Amostras','500 Amostras','1000 Amostras','Fontsize',14,'location','southeast')
grid on
set(gca,'Gridlinestyle',':');
set(gca, 'Position',  [0.1140    0.1200    0.8538    0.8739])
axis tight
xlabel('Neurônios');
ylabel('SP');
set(gca,'Fontsize',12)

% 
saveas(gcf,[pwd '\RNA\RNA[NEURON][' type ']'],'fig');
saveas(gcf,[pwd '\RNA\RNA[NEURON][' type ']'],'png');