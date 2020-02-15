function [p] = ProbabilitySnS(ICA,x,y) 

for d= 1:3
[p.Skin{d}]= pfull(ICA.Skin.VAL,x.Skin,y.Skin,d);
[p.nonSkin{d}]= pfull(ICA.nonSkin.VAL,x.nonSkin,y.nonSkin,d);     
end

end