function [X,pdf] = KDEfast_fixed_minmax(data,H,nPoint,xmin,xmax)
Div=length(data);
[~,n,data]= format_data(data);
Hi = ones(1,length(data))*H^2;
X=linspace(xmin,xmax,nPoint);

pdf=zeros(1,nPoint);
for j=1:Div
    pdf(1,(1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j))=(((1/n)*sum((repmat((Hi.^(-1/2)),nPoint/Div,1).*Kn(repmat((Hi.^(-1/2)),nPoint/Div,1).*((repmat(X((1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j)),length(data),1)')-repmat(data,nPoint/Div,1)))),2))');
end

% if doNorm == 1
%     [A]= area2d(data,pdf);
%     pdf = pdf/A;
% end






