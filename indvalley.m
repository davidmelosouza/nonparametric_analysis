function [ind] = indvalley(ind,hn)

j=0;
ne = length(ind.e12);
for i=1:ne
    inde = ind.e12(i);
    if inde>1 && inde<length(hn)
        if  hn(inde-1)>hn(inde) && hn(inde)<hn(inde+1)
            j=j+1;
            ind.valley(j) = inde;
%             disp(['ind:' num2str(inde)])
        end
    end
end

if j==0
    ind.valley = [];
%      disp(['nb local min:' num2str(0)])
     ind.n = 0;
else
%      disp(['nb local min:' num2str(length(ind.valley))])
      ind.n = length(ind.valley);
end

ind.global=find(hn==min(hn));

end