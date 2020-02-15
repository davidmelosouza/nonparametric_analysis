clear
xmin=-15;
xmax=15;
x = linspace(xmin,xmax,1000);
y1 = normpdf(x,0,5);
y2 = unifpdf(x,-2,2);
y3 = normpdf(x,1,0.5);

        hf=area(x,y2); hold on
        hf.FaceColor = [0.75 0.75 0.75];
        hf.EdgeColor = [0.75 0.75 0.75];
        
plot(x,y1,':k'); hold on
% plot(x,y2)
plot(x,y3,'k')
evt = 1+0.5*randn(3,1);
evt(evt>2)=2;
plot(evt,zeros(length(evt),1),'xk')


A(1)= area2d(x,abs(y1-y2));
A(2)= area2d(x,abs(y3-y2));

legend('Uniforme','\mu=0; \sigma=5','\mu=1; \sigma=0.5','Amostras')

xlabel('Variável Aleatória')
ylabel('Densidade de Probabilidade')
set(gca,'Fontsize',14)