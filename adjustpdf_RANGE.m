function [X,fv] = adjustpdf_RANGE(n,x,X,fv,Hi,nPoint)
nd=1;
[xp,cdfy] = cdfxy(X,fv);
[AR] = STDPCT(4);
TH = (1-AR)/2;
[~,i]=unique(cdfy);
xmin = interp1(cdfy(i),xp(i),TH,'linear','extrap');
xmax = interp1(cdfy(i),xp(i),1-TH,'linear','extrap');


X = linspace(xmin,xmax ,nPoint);

if nd==1
%     Hi=cell2mat(Hi);
    for j=1:nPoint(1)
        Kv(j,:)=Hi.^(-1/2).*Kn(Hi.^(-1/2).*(repmat(X(:,j),1,length(x))-x));
    end  
   
end

[fv] = ajustpdf(n,nd,Kv,nPoint);