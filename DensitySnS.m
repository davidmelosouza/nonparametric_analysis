function [x,y] = DensitySnS(ICA,nPoint)
wb = waitbar(0,'Aguarde[Dimensões]...');
for d= 1:3
[x.Skin{d},y.Skin{d}] = KDE_methods(ICA.Skin.TR(d,:),nPoint);
[x.nonSkin{d},y.nonSkin{d}] = KDE_methods(ICA.nonSkin.TR(d,:),nPoint);
waitbar(d/3)
end
close(wb)
end