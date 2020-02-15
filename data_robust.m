function [data] = data_robust(data)
[pct] = STDPCT(2);
n = length(data);
nr = n-floor(n*pct);
[~,ind] = edist(data);
data = data(ind(nr+1:end));
end
