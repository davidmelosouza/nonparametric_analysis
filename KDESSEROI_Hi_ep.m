function [X,fv,Hi] = KDESSEROI_Hi_ep(x,Hi,nPoint,href)
%==========================================================================
% Fazendo os Cálculos do KERNEL ND de banda Fixa e Variável
%==========================================================================
doNorm = 0;
% h=waitbar(0','[KDEND]WORKANDO...');
[nd,n,x]= format_data(x);
% X = linspace(min(x),max(x),nPoint);
% Hi = Hi(:)';
% [Hi,~] = h_adjust({Hi},[],1);
X = linspace(min(x)-5*href,max(x)+5*href,nPoint);

if nd==1
    Hi=cell2mat(Hi);
    for j=1:nPoint(1)
        Kv(j,:)=Hi.^(-1/2).*Knep(Hi.^(-1/2).*(repmat(X(:,j),1,length(x))-x));
    end  
   
end

[fv] = ajustpdf(n,nd,Kv,nPoint);
[X,fv] = adjustpdf_RANGE(n,x,X,fv,Hi,nPoint);


if doNorm == 1
    [A]= area2d(X,fv);
    fv = fv/A;
end
