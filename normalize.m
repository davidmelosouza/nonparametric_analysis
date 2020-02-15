function [data] = normalize(data)
ran = (max(data)-min(data));
data = (data-min(data))/ran;
data=data;
end