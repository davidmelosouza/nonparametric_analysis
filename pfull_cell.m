function [p]= pfull_cell(DATA,x,y)

p{1} = interp1(x.SS,y.SS,DATA,'linear','extrap');           p{1} = protec(p{1});
p{2} = interp1(x.BKDE,y.BKDE,DATA,'linear','extrap');       p{2} = protec(p{2});
p{3} = interp1(x.SV,y.SV,DATA,'linear','extrap');           p{3} = protec(p{3});
p{4} = interp1(x.KDEROI,y.KDEROI,DATA,'linear','extrap');   p{4} = protec(p{4});
p{5} = interp1(x.PDF,y.PDF,DATA,'linear','extrap');         p{5} = protec(p{5});
end
