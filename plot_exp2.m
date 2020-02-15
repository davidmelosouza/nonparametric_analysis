clear
xmin=-15;
xmax=15;
x = linspace(xmin,xmax,1000);
y1 = normpdf(x,0,2.2);
y2 = normpdf(x,0,1.8);

% ye1 = normpdf(x,0,2);
ye1 = normpdf(x,0,4);
ye2= y1+0.25*y1.*sin(x*10);



hf=area(x,y2); hold on
hf.FaceColor = [0.75 0 0];
hf.EdgeColor = [0.75 0 0];
alpha(0.5)

hf=area(x,y1); hold on
hf.FaceColor = [0.75 0.75 0.75];
hf.EdgeColor = [0.75 0.75 0.75];
alpha(0.5)

plot(x,ye1,':k'); hold on
plot(x,ye2,'-k'); hold on

A(1)= area2d(x,abs(y1-ye1));
A(2)= area2d(x,abs(y1-ye2));


legend('Sinal','Ruído','Estimação 1','Estimação 2')

xlabel('Variável Aleatória')
ylabel('Densidade de Probabilidade')
set(gca,'Fontsize',14)