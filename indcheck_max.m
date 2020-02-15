function [ind] = indcheck_max(ind,h,hc)



 
if (~isempty(ind.valley))
    if length(ind.valley)==1
        ind.normal = ind.valley;
        %================================
        ind.robust = ind.valley;
    else
        hcvalley =  hc(ind.valley);             
        ind_normal = find(hcvalley == max(hcvalley));
        ind.normal = ind.valley(ind_normal);
        %===============================================
        hvalley =  h.CV.range(ind.valley);
        dvalley = hvalley - h.CV.TCV;
        indTCV_valley = find(dvalley == min(dvalley));
        ind.robust = ind.valley(indTCV_valley);
    end
else
    ind_CV = find(hc==max(hc));
    ind.normal = ind_CV;
    %===============================================
    ind_TCV = find(h.CV.Cost{7}==min(h.CV.Cost{7}));
    ind.robust = ind_TCV;
end


% if ind.global==1 || ind.global== length(h.CV.range) || isempty(ind.valley)
%     dc = abs(h.CV.range-h.CV.TCV);
%     ind.out = find(dc==min(dc),1);
% else
%     dSJ = abs(h.CV.TCV - h.CV.range(ind.valley));
%     ind.out= ind.valley(find(dSJ==min(dSJ),1));
% end
%
% if isempty(ind.out) || isnan(ind.out)
%     dc = abs(h.CV.range-h.CV.TCV);
%     ind.out = find(dc==min(dc),1);
% end