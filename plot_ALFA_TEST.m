
clear variables;  clc; close all;
vEVT = [25 50 100 500 1000];
load([pwd '\KDE\Stage3\KDE[alfa]DIST[1-6]'],'ALFA');
ALFA_A=ALFA;
load([pwd '\KDE\Stage3\KDE[alfa]DIST[7-12]'],'ALFA');
ALFA_B=ALFA;
clear ALFA

ALFA = [{ALFA_A{1}};{ALFA_A{2}};{ALFA_A{3}};{ALFA_A{4}};{ALFA_A{5}};{ALFA_A{6}};{ALFA_B{1}};{ALFA_B{2}};{ALFA_B{3}};{ALFA_B{4}};{ALFA_B{5}};{ALFA_B{6}}];
clear ALFA_A ALFA_B

for i=1:12

% errorbar(i,mean(mean(ALFA{i})),std(std(ALFA{i})/sqrt(25))/sqrt(5),':s');hold on; 
errorbar(i,median(median(ALFA{i})),iqr(iqr(ALFA{i})),':s');hold on; 
end
plot([1 12],[2 2],'k-')

% set(gca,'Yscale','log')