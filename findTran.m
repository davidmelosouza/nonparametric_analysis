function[T] = findTran(CTH)
   CTH=CTH(CTH~=0);
    CTH=CTH(CTH~=2);
if isempty(CTH)
    T=1;
else
    REF=(CTH(1));
    T=0;
    
    for i=1:length(CTH)
        if CTH(i)~=REF
            if CTH(i)<REF
                T=T+1;
            end
            REF = CTH(i);
        end
    end
    
end

if T==0;
   T=1; 
end