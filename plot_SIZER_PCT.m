% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
band = 'fix';
nPoint = 10000;
% vEVT = [1000];
vEVT = [25 50 100 500 1000];
nEST = 10000;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
mymap = [1 0 0
    0.5 0.5 0.5
    0 0 0.5
    0.5 0 0.5];
d = [1 3 4 5 7 8 10 11 12 14 15 16];
TRUTH = [1 1 1 2 2 2 2 3 3 1 2 3];
name_true = {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'};
load([pwd '\KDE\KDE[SIZER]EVT[' num2str(1000) ']'],'T','P','PCT');

for ie = 1:5
    for id = 1:12
        for int=1:50
            DATA{id}(int,ie) = sum(P{ie}(id,int)'==TRUTH(id)');
        end
    end
end

for id = 1:12
    DATAPCT(id,:) = sum(DATA{id})/50;
end

% DATAM = [{DATA{1}};{DATA{2}};{DATA{3}};{DATA{4}};{DATA{5}};{DATA{6}};{DATA{7}};{DATA{8}};{DATA{9}};{DATA{10}};{DATA{11}};{DATA{12}}];
% PLOTBOX(DATAM,vEVT,'Amostras','Eficiência(%)','northeast')


DATAPCT = 100*DATAPCT';


% mat = PCT';              % A 5-by-5 matrix of random values from 0 to 1
% imagesc(mat);            % Create a colored plot of the matrix values
% colormap(flipud(gray));  % Change the colormap to gray (so higher values are
% %   black and lower values are white)
% 
% textStrings = num2str(mat(:), '%0.2f');       % Create strings from the matrix values
% textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
% [x, y] = meshgrid(1:size(mat,2),1:size(mat,1));  % Create x and y coordinates for the strings
% hStrings = text(x(:), y(:), textStrings(:), ...  % Plot the strings
%     'HorizontalAlignment', 'center');
% midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range
% textColors = repmat(mat(:) > midValue, 1, 3);  % Choose white or black for the
% %   text color of the strings so
% %   they can be easily seen over
% %   the background color
% set(hStrings, {'Color'}, num2cell(textColors, 2));  % Change the text colors
% 
% set(gca, 'XTick', 1:5, ...                             % Change the axes tick marks
%     'XTickLabel', {'25','50','100','500','1000'}, ...  %   and tick labels
%     'YTick', 1:12, ...
%     'YTickLabel', {'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'}, ...
%     'TickLength', [0 0]);
% set(gca,'Fontsize',12);
% xlabel('Local Minimum')
% 
% h = colorbar; title(h,'Eficiência(%)')


ln=[{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'},{':'}];
mk=[{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'},{'s'},{'o'},{'^'},{'v'}];
cl=[{'k'},{'k'},{'k'},{'r'},{'r'},{'r'},{'b'},{'b'},{'b'},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]},{[0.5 0.5 0.5]}];
figure
for id=1:12
    for  ie = 1:5
        [m,e]=binofit((DATAPCT(ie,id)/100)*50,50);
        vPCT(ie,id)=m*100;
       vei(ie,id)=(e(1))*100;
       ves(ie,id)=(e(2))*100;
    end
%      errorbar(vEVT,vPCT,vei,ves,':','marker',mk{id},'color',cl{id},'markerFaceColor',cl{id}); hold on
end
plotMATRIXSIZER(vPCT',vei',ves')
% set(gca,'yscale','log')
