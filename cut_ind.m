function [ind] = cut_ind(ind,TARGET,ne_cut)
isg_t = find(TARGET(ind.trainf)==1); isg_t = isg_t(randperm(length(isg_t),ne_cut));
ibg_t = find(TARGET(ind.trainf)==0); ibg_t = ibg_t(randperm(length(ibg_t),ne_cut));
itrain = [isg_t ibg_t];
ind.train = ind.trainf(:,itrain(randperm(length(itrain),length(itrain))));

isg_v = find(TARGET(ind.valf)==1); isg_v = isg_v(randperm(length(isg_v),ne_cut));
ibg_v = find(TARGET(ind.valf)==0); ibg_v = ibg_v(randperm(length(ibg_v),ne_cut));
ival = [isg_v ibg_v];
ind.val = ind.trainf(:,ival(randperm(length(ival),length(ival))));
end