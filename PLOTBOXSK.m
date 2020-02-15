function [] = PLOTBOXSK(DATA,vEVT,xtag,ytag,legpos)
% Create a cell array with the data for each group
% vEVT = [100,500,1000,2000,5000];
% colormap('prism')
% cmap = colormap;

cmap = [128,128,128;
    211,211,211;
    135,206,250;
    191, 255, 193;
    128, 0, 0;
    255,0,0;
    255,165,0;
    240,240,0;
    0, 255, 0;
    61, 149, 6;
    0, 179, 0;
    0, 0, 255;
    230, 0, 230;
    76,0,230;    
    0,0,0]/255;
%     204, 0, 153;
%     255,255,255;
%     255, 128, 223;
aboxplot(DATA,'labels',vEVT,'Colormap',cmap(1:length(DATA),:),'colorrev',false,'OutlierMarker','+')
xlabel(xtag); % Set the X-axis label
ylabel(ytag); % Set the X-axis label
set(gca,'Fontsize',12);
% L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'TRUTH'}];
L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[PI]L1I'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'[CV]OSCV'};{'h*'}];

legend(L(1:length(DATA)),'Location',legpos,'FontSize' ,8);
lgd = legend;
lgd.NumColumns = 3;
legend('boxoff')
grid on
set(gca,'Gridlinestyle',':')
end

