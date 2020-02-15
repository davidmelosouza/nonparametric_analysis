function [] = plotMATRIX(DADOS_AREA,DADOS_STD)

DADOS_AREA(DADOS_AREA>2)=2;
DADOS_AREA(DADOS_AREA<0)=0;

DADOS = DADOS_AREA+DADOS_STD;
% DADOS(DADOS>2)=2;
DADOI = DADOS_AREA-DADOS_STD;
% DADOI(DADOI<0) = 0;
clim = [0 2];

matplot_revista(DADOS_AREA,clim,['D1a';'D1b';'D1c';'D2a';'D2b';'D2c';'D3a';'D3b';'D3c';'D4a';'D4b';'D4c']',['FD       ';'Scott    ';'Sturges  ';'Doane    ';'Knuth    ';'Wand     ';'Shimazaki';'Rudemo   ';'LHM      ';'Bin*     ']', 'Erro de Área')
hold on


[fs] = mapGEN(DADOS,clim);
[fi] = mapGEN(DADOI,clim);
[in,jn]=size(DADOS_AREA);
M=gray(64);
Mf = linspace(0,1,64);
w = 0.2;
for i=1:in
    for j=1:jn
        inds=find(abs(fs(i,j)-Mf)==min(abs(fs(i,j)-Mf)));
        indi=find(abs(fi(i,j)-Mf)==min(abs(fi(i,j)-Mf)));
        rectangle('Position',[j+(0.7-2*w),i+(0.6-w),w,w],'FaceColor',M(indi(1),:),'EdgeColor','none','LineWidth',1)
        rectangle('Position',[j+(0.7-w),i+(0.6-w),w,w],'FaceColor',M(inds(1),:),'EdgeColor','none','LineWidth',1)
%                 rectangle('Position',[j+(0.7-2*w),i+(0.6-w),w,w],'FaceColor',[1 1 1]*fs(i,j),'EdgeColor','none','LineWidth',1)
%                 rectangle('Position',[j+(0.7-w),i+(0.6-w),w,w],'FaceColor',[1 1 1]*fi(i,j),'EdgeColor','none','LineWidth',1)
    end
end
xlabel('Distribuição')
ylabel('Métodos')
set(gca,'Fontsize',12);
end

