function [LH] = LH_SnS(p)

for m = 1:4
    pLH.sg{m} = ones(1,length(p.Skin{1}(m,:)));
    pLH.bg{m} = ones(1,length(p.nonSkin{1}(m,:)));
    for d = 1:3        
        pLH.sg{m}=p.Skin{d}(m,:).*pLH.sg{m};
        pLH.bg{m}=p.nonSkin{d}(m,:).*pLH.bg{m};
    end
end

for m = 1:4
   LH_d(m,:)=(pLH.sg{m} +  pLH.bg{m});
   LH_d(m,LH_d(m,:)<=0) = min(LH_d(m,LH_d(m,:)>0));
   LH(m,:)= pLH.sg{m}./(LH_d(m,:));
end