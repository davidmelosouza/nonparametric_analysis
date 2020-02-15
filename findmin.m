function [ind_goal] = findmin(hc)

dn = abs(diff(hc,1))/max(abs(diff(hc,1)));
dn_sort = sort(dn);
hc_sort = sort(hc);

for i = 1:80
    imin_dn(i) = find(dn==dn_sort(i));
    imin_hc(i) = find(hc==hc_sort(i));
end
indc=intersect(imin_dn,imin_hc);

hc_new = (hc-min(hc))/(max(hc)-min(hc));

% plot(rc,hc_new,':k'); hold on
% plot(rc(indc),hc_new(indc),'or'); hold on
j=0;
for i=1:length(indc)
    ind = indc(i);
    if ~(ind == 1 || ind == length(hc_new))
        if ((hc_new(ind-1)>hc_new(ind)) &&  (hc_new(ind)<hc_new(ind+1)))
            j = j+1;
            ind_goal(j) = ind;
        else
            j = j+1;
            ind_goal(j) = NaN;
        end
    end
end
ind_goal = ind_goal(~isnan(ind_goal));
if (isempty(ind_goal))
     ind_goal=19;
end
if length(ind_goal)>1
    ind_goal =ind_goal(find(hc_new(ind_goal)==min(hc_new(ind_goal))));
end
if (ind_goal == 1) || (ind_goal == length(hc_new))
    ind_goal=19;
end




% plot(rc(ind_goal),hc_new(ind_goal),'sb')
