function [] = plotMATRIX(DADOS_AREA,DADOS_STD)



DADOS = DADOS_AREA+DADOS_STD;
DADOI = DADOS_AREA-DADOS_STD;
DADOI(DADOI<0) = 0;
clim = [min(min(DADOI)) max(max(DADOS))];
% clim = [0 1];
matplot_revista(DADOS_AREA,clim,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d';'D4a';'D4b';'D4c';'D4d']',['[PI]SV  ';'[PI]SVM1';'[PI]SVM2';'[PI]SJ  ';'[PI]SC  ';'[PI]L1I ';'[CV]MLCV';'[CV]UCV ';'[CV]BCV1';'[CV]BCV2';'[CV]CCV ';'[CV]MCV ';'[CV]TCV ';'[CV]OSCV';'h*      ']', 'Error Area')
hold on


[fs] = mapGEN(DADOS,clim);
[fi] = mapGEN(DADOI,clim);
[in,jn]=size(DADOS_AREA);

w = 0.2;
for i=1:in
    for j=1:jn
        rectangle('Position',[j+(0.7-2*w),i+(0.6-w),w,w],'FaceColor',[1 1 1]*fs(i,j),'EdgeColor','none','LineWidth',1)
        rectangle('Position',[j+(0.7-w),i+(0.6-w),w,w],'FaceColor',[1 1 1]*fi(i,j),'EdgeColor','none','LineWidth',1)
    end
end
xlabel('Distribution')
ylabel('Methods')
set(gca,'Fontsize',12);
end

