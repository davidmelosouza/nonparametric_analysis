figure(1);
[x, y] = meshgrid(linspace(2, 40, length(2:2:40)));
clf;

MSP = reshape(mean(spv),size(spv,2),size(spv,3));
SSP = reshape(std(spv),size(spv,2),size(spv,3));

surf(x, y, MSP, 'EdgeColor', 'none', 'FaceAlpha', 0.85);

zlim([85 100])

xlabel('Neurônios')
ylabel('Camadas')
zlabel('Melhor SP')
set(gca,'LooseInset',get(gca,'TightInset'))
set(gca,'Gridlinestyle',':')