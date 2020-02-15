function [X,pdf] = KDEOSCV(data,H,nPoint,type)
Div = 4;


[~,n,data]= format_data(data);
Hi = ones(1,length(data))*H^2;
X=linspace(min(data),max(data),nPoint);

pdf=zeros(1,nPoint);
for j=1:Div
    u = repmat((Hi.^(-1/2)),nPoint/Div,1).*((repmat(X((1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j)),length(data),1)')-repmat(data,nPoint/Div,1));
    HiM = repmat((Hi.^(-1/2)),nPoint/Div,1);
    if strcmp(type,'left')
        I = (u<0 & abs(u)<1);
%         u = u(I);
%         HiM = HiM(I);
    end
    if strcmp(type,'right')
          I = (u>0 & abs(u)<1);
%         u = u(I);
%         HiM = HiM(I);
     end
    pdf(1,(1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j))=(((1/n)*sum((HiM.*I.*Kos(u.*I)*2),2))');
end




