function [] = plotSURF(MFT,range)
L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[PI]L1I'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'[CV]OSCV'};{'[G]h*'};{'[E]h*'}];
[~,ind]=sort(mean(MFT(range,:)));
[X,Y] = meshgrid(1:14,1:50);
MFT_sort = MFT(:,[ind]);
surf(X,Y,MFT_sort,'EdgeColor','none');camlight left; lighting phong; alpha(0.8)
xlabel('Métodos')
ylabel('RoI')
zlabel('Área do Erro')
xticks([1:14])
xticklabels(L(ind))
xtickangle(325)
grid minor
axis tight

hold on
[Xr,Yr] = meshgrid(1:14,range);
surf(Xr,Yr,MFT_sort(range,:),'EdgeColor','y','LineStyle',':');camlight left; lighting phong; alpha(0.8)

