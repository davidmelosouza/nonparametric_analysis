function [] = plotMATRIXPERF(DADOS_AREA,DADOS_MAX,DADOS_MIN)



DADOS = DADOS_MAX;
DADOI = DADOS_MIN;
clim = [min(min(DADOI)) max(max(DADOS))];
matplot_revista(DADOS_AREA,clim,['D1a';'D1b';'D1c';'D1d';'D2a';'D2b';'D2c';'D2d';'D3a';'D3b';'D3c';'D3d']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', 'Error Area')
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

end