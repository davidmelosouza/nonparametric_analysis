function [pdf] = ggd(x,rho)
pdf = [exp(-abs(x').^rho) / (2*gamma(1+1/rho))];
end

