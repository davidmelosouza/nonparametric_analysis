clear
load([pwd '\CLASSIFICACAO\CLASSIFICATION[SP][SIMULATION]'],'spv');

nev = [25 50 100 500 1000];
itmax = 20;

ic = 0;
for ne = nev
    ic = ic+1;
    for it=1:itmax
        V(it,1,ic)=mean(spv.SS{ic}{it});
        V(it,2,ic)=mean(spv.BKDE{ic}{it});
        V(it,3,ic)=mean(spv.SV{ic}{it});
        V(it,5,ic)=mean(spv.ROIKDE{ic}{it});
        V(it,4,ic)=mean(spv.rna{ic}{it});
        V(it,6,ic)=mean(spv.PDF{ic}{it});
        
        Vs(it,1,ic)=std(spv.SS{ic}{it});
        Vs(it,2,ic)=std(spv.BKDE{ic}{it});
        Vs(it,3,ic)=std(spv.SV{ic}{it});
        Vs(it,5,ic)=std(spv.ROIKDE{ic}{it});
        Vs(it,4,ic)=std(spv.rna{ic}{it});
        Vs(it,6,ic)=std(spv.PDF{ic}{it});
    end
end

V = reshape(mean(V),size(V,2),size(V,3));
Vs = reshape(mean(Vs),size(Vs,2),size(Vs,3));
cl = [0,0,0;
      0,0,0;
      0.5,0.5,0.5;
      0,0,1;
      1,0,0
      0,1,0];
mk = '^o^oso'; 
ce = [0.5,0.5,0.5;
      0.5,0.5,0.5;
      0,0,0;
      0,0,0;
      0,0,0;
      0,0,0];
ln='::::::';

for m = 1:6
    errorbar(nev,V(m,:),Vs(m,:),[ln(m)  mk(m)],'color',cl(m,:),'markerfacecolor',cl(m,:),'markeredgecolor',ce(m,:),'markersize',6); hold on
end

legend('SS','BKDE','SV','RNA','ROIKDE','PDF','Location','Southwest','Fontsize',14,'location', 'southeast')
grid minor
% ylim([70 100]);
set(gca,'Fontsize',14)
xlabel('Amostras de Treinamento','Fontsize',14)
ylabel('Melhor SP','Fontsize',14)
set(gca, 'Position',  [0.1193    0.1327    0.8432    0.8387])
