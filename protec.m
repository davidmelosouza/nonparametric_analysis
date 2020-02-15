function [hi]= protec(hi)
MIN=min(hi(hi>0));
if ~isempty(MIN)
hi(hi<=0)=MIN(1);
hi(isnan(hi))=min(hi(intersect(hi>0,~isnan(hi))));
hi(isinf(hi))=max(hi(intersect(hi>0,~isinf(hi))));
end
end