function [DATA,TARGET] = load_data_electron (ne)

load likelihood_electron
load likelihood_jet
load IK0000000032P

inde = 1:length(likelihood_electron);
indj = 1:length(likelihood_jet);
% v = [1 2 4:13];
v = [1:13];
for i=v
    inde = intersect(inde,ind_k_e{i});
    indj = intersect(indj,ind_k_j{i});
end

likelihood_electron=likelihood_electron(v,inde);
likelihood_jet=likelihood_jet(v,indj);
% [mad(likelihood_electron) mad(likelihood_jet)]
DATA.FULL = [likelihood_electron(:,randi(length(likelihood_electron),ne,1)) likelihood_jet(:,randi(length(likelihood_jet),ne,1))];
clear likelihood_electron likelihood_jet
TARGET = [ones(ne,1);zeros(ne,1)]';

end