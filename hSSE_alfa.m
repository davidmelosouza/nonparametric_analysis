function [hi] = hSSE_alfa(h,lambda,fpi,alfa)
[fpi]= protec(fpi);

for i=1:length(fpi)    
    hi(i)=abs((h).*((lambda./fpi(i))^(1/alfa)));
end
[hi]= protec(hi);

end

