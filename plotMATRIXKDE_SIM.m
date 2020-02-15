function plotMATRIXKDE_SIM(DADOS_AREA,DADOS_STD)

% DADOS_AREA = DADOS_BIN;
% DADOS_STD = DADOS_BIN_STD;

DADOS = DADOS_AREA+DADOS_STD;
DADOI = DADOS_AREA-DADOS_STD;

% DATA = abs([DADOS; DADOS; DADOI]);
% clim = [-max(max(DATA)) max(max(DATA))];
clim = [-1 1];
matplot_revista_sim(DADOS_AREA,clim,['D1a';'D1b';'D1c';'D2a';'D2b';'D2c';'D3a';'D3b';'D3c';'D4a';'D4b';'D4c']',['[PI]SV  ';'[PI]SVM1';'[PI]SVM2';'[PI]SJ  ';'[PI]SC  ';'[PI]L1I ';'[CV]MLCV';'[CV]UCV ';'[CV]BCV1';'[CV]BCV2';'[CV]CCV ';'[CV]MCV ';'[CV]TCV ';'[CV]OSCV';'[G]h*   ';'[E]h*   ']', '\Deltah')

hold on

% [f] = mapGEN([DADOS],clim);
% fl = sort(f(:));
% V=fl-0.5; ind=find(abs(V)==min(abs(V)));

[fs] = mapGEN_SIM(DADOS,clim);
[fi] = mapGEN_SIM(DADOI,clim);
[in,jn]=size(DADOS_AREA);

w = 0.2;
M=polarmap(128);
Mf = linspace(0,1,128);
% M(1:32,:) = fliplr(M(1:32,:));

for i=1:in
    for j=1:jn
        inds=find(abs(fs(i,j)-Mf)==min(abs(fs(i,j)-Mf)));
        indi=find(abs(fi(i,j)-Mf)==min(abs(fi(i,j)-Mf)));
        rectangle('Position',[j+(0.7-2*w),i+(0.6-w),w,w],'FaceColor',M(indi(1),:),'EdgeColor','none','LineWidth',1)
        rectangle('Position',[j+(0.7-w),i+(0.6-w),w,w],'FaceColor',M(inds(1),:),'EdgeColor','none','LineWidth',1)
        
    end
end
xlabel('Distribuição')
ylabel('Métodos')
set(gca,'Fontsize',12);
end



