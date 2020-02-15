function [ed,ind] = edist(d)
n = length(d);
for i=1:n
   ed(i)=sum(sqrt((d(i)-d).^2))/n;    
end
[~,ind]=sort(ed,'descend');
end
