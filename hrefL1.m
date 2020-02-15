function [h] = hrefL1(data)
n = length(data);
s=iqr(data)/1.35;
h = 2.279*s*n^(-1/5);
end

    