function [ind] = indcheck(ind,h)

if ind.global==1 || ind.global== length(h.CV.range) || isempty(ind.valley)
    dc = abs(h.CV.range-h.CV.TCV);
    ind.out = find(dc==min(dc),1);
else    
    dSJ = abs(h.CV.TCV - h.CV.range(ind.valley));
    ind.out= ind.valley(find(dSJ==min(dSJ),1));
end

if isempty(ind.out) || isnan(ind.out)
    dc = abs(h.CV.range-h.CV.TCV);
    ind.out = find(dc==min(dc),1);
end