
function [y] = mapGEN_SIM(x,clim)
min_val=clim(1);%finding maximum value of data
max_val=clim(2);%finding minimum value of data
ran = (max_val-min_val);
[in,jn]=size(x);

for i=1:in
    for j=1:jn
        y(i,j)=(x(i,j)-min_val)/ran;
%         y(i,j)=(x(i,j)-min_val)/2;
    end
end

end