function [i,cost] = cutstage(hc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
THd1 = 1; THh1 = 1;
THd2 = 1; THh2 = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dn = abs(diff(hc,1))/max(abs(diff(hc,1)));
hn = (hc-min(hc))/(max(hc)-min(hc));
%% Primeiro est�gio (valores discrepantes)
id1 = find(dn<THd1);
ih1= find(hn<THh1);
i.e1=intersect(id1,ih1);
%% Segundo est�gio Est�gio
id2 = find(dn<THd2);
ih2= find(hn<THh2);
i.e2=intersect(id2,ih2);
%% Unir est�gios
i.e12=intersect(i.e1,i.e2);
cost.d=dn; %derivada normalizada
cost.h=hn; %fun��o custo normalizada
