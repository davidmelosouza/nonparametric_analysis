load teste
for d =1:13
% [x,dy,h,y] = SIZER(teste);
DATA=data.TRAIN(d,:);
% DATA=teste;
[x,dy,h,y] = SIZER(DATA);
% [bin,mq]=Rudemo(data.TRAIN(d,:));
% hist(data.TRAIN(d,:),bin);
mymap = [1 0 0      
0.5 0.5 0.5
0 0 0.5
0.5 0 0.5];

subplot(2,1,1);plot(x,y,':k');axis tight 
subplot(2,1,2);mesh(x,h,dy);
subplot(2,1,2);colormap(mymap);view(2);
set(gca,'Yscale','log')
axis tight 
pause
close 
hist(data.TRAIN(d,:));
pause
close
end
