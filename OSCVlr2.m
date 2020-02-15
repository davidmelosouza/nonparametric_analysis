clear
clc

n = 100;
data = randn(n,1)
nPoint = 10000;


b= linspace(0.01,2, 100);

wb = waitbar(0,'Aguarde');
for i=1:length(b)
[X,fr] = KDEOSCV(data,b(i),nPoint,'right');
[X,fl] = KDEOSCV(data,b(i),nPoint,'left');
dx = diff(X); dx = dx(1);

OSCVr(i) = sum((fr.^2)*dx)-(2*n^-1)*sum(fr);
OSCVl(i) = sum((fl.^2)*dx)-(2*n^-1)*sum(fl);
waitbar(i/length(b))
end
close(wb)
% C = 0.6168;
C = 0.5284; %non smoothed
% C = 0.6168; %smoothed
h = b*C;

[~,ir]=min(OSCVr);
[~,il]=min(OSCVl);
plot(h,OSCVr,':k'); hold on
plot(h,OSCVl,':r'); hold on
plot(h(ir),OSCVr(ir),'ok')
plot(h(il),OSCVl(il),'or')
legend('OSCV-right','OSCV-left')

 [h] = h_plugin(data);
h.PI
