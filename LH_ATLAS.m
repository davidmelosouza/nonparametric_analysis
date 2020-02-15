function [LH] = LH_ATLAS(p)

for m = 1:5
    pLH.sg{m} = ones(1,length(p.sg{1}{m}));
    pLH.bg{m} = ones(1,length(p.bg{1}{m}));
    for d = 1:length(p.sg);   
        pLH.sg{m}=p.sg{d}{m}.*pLH.sg{m};
        pLH.bg{m}=p.bg{d}{m}.*pLH.bg{m};
    end
end

for m = 1:5
   LH_d(m,:)=(pLH.sg{m} +  pLH.bg{m});
   LH_d(m,LH_d(m,:)<=0) = min(LH_d(m,LH_d(m,:)>0));
   LH(m,:)= pLH.sg{m}./(LH_d(m,:));
end