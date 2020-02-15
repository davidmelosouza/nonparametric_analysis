function [m,u] = GGD_Gen(x,mu,beta,rho,alpha)
sbeta = sqrt(beta);
m = zeros(size(x));
for j = 1:length(mu)
    u(j,:) = alpha(j) * exp(-abs(sbeta(j)*(x-mu(j))).^rho(j)) * sbeta(j) / (2*gamma(1+1/rho(j)));
    m = m + u(j,:);
end
if sum(alpha) == length(alpha)
m=m/length(mu);
end
end
