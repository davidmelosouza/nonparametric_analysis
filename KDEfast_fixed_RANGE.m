function [X,pdf,A,L2] = KDEfast_fixed_RANGE(setup,DATA,H,nPoint)

inter = 'linear';
data = DATA.sg.evt;
Div = length(data);
[~,n,data]= format_data(data);
Hi = ones(1,length(data))*H^2;
xmin=min(data)-4*H;
xmax=max(data)+4*H;

%% Escolher maior range dentre estimação e truth
xmin = min([xmin DATA.sg.pdf.truth.x(1)]);
xmax = max([xmax DATA.sg.pdf.truth.x(end)]);
% disp(['EST[' num2str(xlimit(1)) '|' num2str(xlimit(2)) ']PDF[' num2str(DATA.sg.pdf.truth.x(1)) '|' num2str(DATA.sg.pdf.truth.x(end)) ']FINAL_RANGE[' num2str(xmin) '|' num2str(xmax) ']'] );
%% Fazer estimação com novo range;
X=linspace(xmin,xmax,nPoint);
pdf=zeros(1,nPoint);
for j=1:Div
    pdf(1,(1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j))=(((1/n)*sum((repmat((Hi.^(-1/2)),nPoint/Div,1).*Kn(repmat((Hi.^(-1/2)),nPoint/Div,1).*((repmat(X((1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j)),length(data),1)')-repmat(data,nPoint/Div,1)))),2))');
end
%% Alterar o range do Truth:
[DATA] = ChangePDFlimit(setup,DATA,xmin,xmax);
ygrid=interp1(X,pdf,DATA.sg.pdf.truth.x,inter,0);
ygrid(ygrid<0)=0;
% AE = area2d(X,pdf);
% AP =  area2d(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y);
% plot(X,pdf,'r'); hold on
% plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'k');
% pause
% close

% disp(['[Gaussian]AREA_EST[' num2str(AE) ']AREA_PDF[' num2str(AP) ']'] );
%% Calculo dos Erros:
A= area2d(DATA.sg.pdf.truth.x,abs(ygrid-DATA.sg.pdf.truth.y));
L2 = area2d(DATA.sg.pdf.truth.x,(ygrid-DATA.sg.pdf.truth.y).^2);

