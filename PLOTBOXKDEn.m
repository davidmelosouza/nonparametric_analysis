function [] = PLOTBOXKDEn(DATA,vEVT,xtag,ytag,legpos)
% Create a cell array with the data for each group
% vEVT = [100,500,1000,2000,5000];
% colormap('prism')
% cmap = colormap;
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
    255,255,0;
    0, 255, 0;
    61, 149, 6;
    0, 48, 0;
    0, 0, 255;
    0, 0, 101;
    27, 24, 23;
    255,255,255]/255;
cmap = (cmap*1.3);
cmap(find(cmap>=1))=1;
%     204, 0, 153;
%     255,255,255;
%     255, 128, 223;
aboxplotn(DATA,'labels',vEVT,'Colormap',cmap(1:length(DATA),:),'colorrev',false,'OutlierMarker','+','EdgeColor','red')
xlabel(xtag); % Set the X-axis label
ylabel(ytag); % Set the X-axis label
set(gca,'Fontsize',14);
% L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'TRUTH'}];
L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[PI]L1I'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'[CV]OSCV'};{'h*'}];

% legend([L(1:length(DATA))],'Location',legpos);
% lgd = legend;
% lgd.NumColumns = 2;
grid on
set(gca,'Gridlinestyle',':')
end

