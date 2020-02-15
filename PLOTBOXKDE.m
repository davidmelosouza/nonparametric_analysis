function [] = PLOTBOXKDE(DATA,vEVT,xtag,ytag,legpos)
% Create a cell array with the data for each group
% vEVT = [100,500,1000,2000,5000];
% colormap('prism')
% cmap = colormap;
% cmap = [ 37,37,37;
%     150,150,150;
%     82,82,82;
%     189,189,189;
%     115,115,115;
%     217,217,217;
%     253,187,132;
%     161,217,155;
%     158,202,225;
%     239,101,72;
%     65,171,93;
%     66,146,198;
%     179,0,0;
%     0,109,44;
%     8,81,156]/255;
% cmap = [5,48,97;
%         33,102,172;
%         67,147,195;
%         146,197,222;
%         209,229,240;
%         247,247,247;
%         253,219,199;
%         244,165,130;
%         214,96,77;
%         178,24,43;
%         103,0,31;
%         26,26,26;
%         77,77,77;
%         135,135,135;
%         224,224,224]/255;
cmap = [128,128,128;
    211,211,211;
    135,206,250;
    191, 255, 193;
    128, 0, 0;
    255,0,0;
    255,165,0;
    240,240,0;
    0, 255, 0;
    0, 102, 0;
    0, 179, 0;
    0, 0, 255;
    230, 0, 230;
    0,0,152;    
    0,0,0;
    255,255,255]/255;

aboxplotKDE(DATA,'labels',vEVT,'Colormap',cmap(1:length(DATA),:),'colorrev',false,'OutlierMarker','+')
xlabel(xtag); % Set the X-axis label
ylabel(ytag); % Set the X-axis label
set(gca,'Fontsize',14);
% L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'TRUTH'}];
L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[PI]L1I'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'[CV]OSCV'};{'[G]h*'};{'[E]h*'}];

legend(L(1:length(DATA)),'Location',legpos);
lgd.FontSize = 16;
lgd = legend;
lgd.NumColumns = 3;
% legend('boxoff')
grid on
set(gca,'Gridlinestyle',':')
% xtickformat('%2f')
axis tight
end

