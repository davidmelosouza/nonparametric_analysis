function [] = PLOTBOX(DATA,vEVT,xtag,ytag,legpos)
% Create a cell array with the data for each group
% vEVT = [100,500,1000,2000,5000];
% colormap('prism')
% cmap = colormap;

cmap = [128,128,128;
    211,211,211;
    135,206,250;
    191, 255, 193;
    255,0,0;
    255,165,0;
    255,255,0;
    0, 255, 0;
    61, 149, 6;
    0,0,0;
    0, 48, 0;
    0, 0, 255;
    0, 0, 101;    
    255,255,255]/255;
%     204, 0, 153;
%     255,255,255;
%     255, 128, 223;
% cmap = [0.50,0.50,0.50;
% 0.80,0.80,0.80;
% 0.94,0.94,0.94;
% 1,0,0;
% 1,0.72,0.19;
% 1,0.88,0.66;
% 0,0,0.57;
% 0.25,0.25,1;
% 0.85,0.85,1;
% 1,1,0];

aboxplot(DATA,'labels',vEVT,'Colormap',cmap(1:length(DATA),:),'colorrev',false,'OutlierMarker','+')
set(gca,'Fontsize',12);
xlabel(xtag); % Set the X-axis label
ylabel(ytag); % Set the X-axis label
L = [{'FD'};{'Scott'};{'Sturges'};{'Doane'};{'Knuth'};{'Wand'};{'Shimazaki'};{'Rudemo'};{'LHM'};{'Bin*'}];
legend(L(1:length(DATA)),'Location',legpos,'FontSize' ,12);
lgd = legend;
lgd.NumColumns = 2;
% legend('boxoff')
grid on
set(gca,'Gridlinestyle',':')
% xtickformat('%2f')
axis tight

end


