function [fv] = ajustpdf(n,nd,Kv,nPoint);

if nd ==1
    for i = 1:nd;
        KNDv{i}=(1/(n(i)))*sum(Kv');
    end
else
    for i = 1:nd;
        KNDv{i}=(1/(n(i)))*sum(Kv(:,:,i));
    end
end


if nd == 1
    fv=zeros(1,nPoint(1));
    for i=1:nPoint(1)
        fv(i)=KNDv{1}(i);
    end
end

if nd == 2
    fv=zeros(nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            fv(i,j)=KNDv{1}(i)*KNDv{2}(j);
        end
    end
end

if nd==3
    fv=zeros(nPoint(1),nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            for k=1:nPoint(1)
                fv(i,j,k)=KNDv{1}(i)*KNDv{2}(j)*KNDv{3}(k);
            end
        end
    end
    
end