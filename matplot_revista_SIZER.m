function [  ] = matplot_revista_SIZER( matrix,clim, eixoX, eixoY, title_new)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           plot_matrix                                   %
% Função tem como objetivo gerar um plot de matrix e surface              %
%   ENTRADAS:                                                             %
%            - matrix -> Matrix que deseja ser feito o plot               %
%            - eixoX -> Vetor X da Matrix;                                %
%            - eixoY -> Vetor Y da Matrix;                                %
%            - title_new -> Titulo da Figura                              %
%   SAIDA:                                                                %
%            - Plot da Pcolor e Surf da Matrix                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% PLOT MATRIZ

[tam1,tam2]=size(matrix);
c1=cellstr(num2str(eixoX'));
c2=cellstr(num2str(eixoY'));

matrix1=matrix;
matrix1(tam1+1,:)=0;
matrix1(:,tam2+1)=0;

figure
axes('Fontsize',16);
vetorX=1:1:tam2;
vetorY=1:1:tam1;
pcolor(matrix1);
% title(title_new)


colorbar
colormap('gray');
caxis([clim(1) clim(2)])
% caxis([0 2])
% set(gca,'CLim',clim,'Colormap',polarmap(128));
set(gca,'YTick',vetorY+0.5)
set(gca,'YTickLabel',c2)
set(gca,'XTick',vetorX+.5)
set(gca,'XTickLabel',c1)
set(gca,'XTickLabelRotation',0)
% xticklabel_rotate([1:tam2],90,c2(1:tam2,1),'Fontsize',16);

c=colorbar('vert'); 
title(c,title_new)
% figure
% surf(eixoY,eixoX,matrix)
% title(title_new)

end

