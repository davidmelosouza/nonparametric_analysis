function [data] = GGD_DATA(mu,beta,rho,alpha,N)
% sbeta = sqrt(beta);
  
data= [];
for k = 1:length(mu)
    x = gg6(1,ceil(alpha(k)*N),mu(k),beta(k),rho(k));
    data = [data x];
end
data = data(randperm(length(data),N));

end