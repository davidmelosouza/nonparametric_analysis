function [j] = findPeaks(PTH)
j=0;
for i=2:length(PTH)-1
        if  PTH(i-1)<PTH(i) && PTH(i)>PTH(i+1)
            j=j+1;
        end
end

if j==0
    j=1;
end