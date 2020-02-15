function [p]= pfull(DATA,x,y)

p(1,:) = interp1(x.SS,y.SS,DATA,'linear','extrap');       p(1,p(1,:)<=0) = min(p(1,p(1,:)>0)); 
p(2,:) = interp1(x.BKDE,y.BKDE,DATA,'linear','extrap');   p(2,p(2,:)<=0) = min(p(2,p(2,:)>0)); 
p(3,:) = interp1(x.SV,y.SV,DATA,'linear','extrap');       p(3,p(3,:)<=0) = min(p(3,p(3,:)>0)); 
p(4,:) = interp1(x.KDEROI,y.KDEROI,DATA,'linear','extrap'); p(4,p(4,:)<=0) = min(p(4,p(4,:)>0)); 
p(5,:) = interp1(x.PDF,y.PDF,DATA,'linear','extrap');     p(5,p(5,:)<=0) = min(p(5,p(5,:)>0)); 
end