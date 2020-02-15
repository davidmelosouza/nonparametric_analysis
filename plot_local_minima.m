% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
method = 'KDE';
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
band = 'fix';
nPoint = 1000;
vEVT = [25 50 100 500 1000];
nEST = 1000;
nROI = 1;
nGRID = 10^5;
ntmax = 50;
% name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};
name={'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};

for ne = 1:length(vEVT)
    load([pwd '\' method '\' method '[paper]EVT[' num2str(vEVT(ne)) ']'],'H');
    Ht{ne} = H.n;
end


for ie = 1:5
    for id = 1:16
        METHOD.MLCV{id}(:,ie)=Ht{ie}{1}(:,id);
        METHOD.UCV{id}(:,ie)=Ht{ie}{2}(:,id);
        METHOD.BCV1{id}(:,ie)=Ht{ie}{3}(:,id);
        METHOD.BCV2{id}(:,ie)=Ht{ie}{4}(:,id);
        METHOD.CCV{id}(:,ie)=Ht{ie}{5}(:,id);
        METHOD.MCV{id}(:,ie)=Ht{ie}{6}(:,id);
        METHOD.TCV{id}(:,ie)=Ht{ie}{7}(:,id);
        METHOD.OSCV{id}(:,ie)=Ht{ie}{8}(:,id);
    end
end


vMLCV = cell2mat(METHOD.MLCV); vMLCV = vMLCV(:);
vUCV = cell2mat(METHOD.UCV); vUCV = vUCV(:);
vBCV1 = cell2mat(METHOD.MLCV); vBCV1 = vBCV1(:);
vBCV2 = cell2mat(METHOD.BCV2); vBCV2 = vBCV2(:);
vCCV = cell2mat(METHOD.CCV); vCCV = vCCV(:);
vMCV = cell2mat(METHOD.MCV); vMCV = vMCV(:);
vTCV = cell2mat(METHOD.TCV); vTCV = vTCV(:);
vOSCV = cell2mat(METHOD.OSCV); vOSCV = vOSCV(:);

DATA = [vMLCV,vUCV,vBCV1,vBCV2,vCCV,vMCV,vTCV,vOSCV];

PCT0 = sum((DATA==0))/length(DATA);
PCT1 = sum((DATA==1))/length(DATA);
PCT2 = sum((DATA==2))/length(DATA);
PCT3 = sum((DATA==3))/length(DATA);
PCT4 = sum((DATA==4))/length(DATA);

PCT = [PCT0;PCT1;PCT2;PCT3;PCT4];

nameCV = [{'D1a','D1b','D1c','D2a','D2b','D2c','D3a','D3b','D3c','D4a','D4b','D4c'}];
mat = PCT';              % A 5-by-5 matrix of random values from 0 to 1
imagesc(mat);            % Create a colored plot of the matrix values
colormap(flipud(gray));  % Change the colormap to gray (so higher values are
%   black and lower values are white)

textStrings = num2str(mat(:), '%0.4f');       % Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
[x, y] = meshgrid(1:size(mat,2),1:size(mat,1));  % Create x and y coordinates for the strings
hStrings = text(x(:), y(:), textStrings(:), ...  % Plot the strings
    'HorizontalAlignment', 'center');
midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range
textColors = repmat(mat(:) > midValue, 1, 3);  % Choose white or black for the
%   text color of the strings so
%   they can be easily seen over
%   the background color
set(hStrings, {'Color'}, num2cell(textColors, 2));  % Change the text colors

set(gca, 'XTick', 1:5, ...                             % Change the axes tick marks
    'XTickLabel', {'0*','1 ','2 ','3 ','4 '}, ...  %   and tick labels
    'YTick', 1:8, ...
    'YTickLabel', {'MLCV','UCV ','BCV1','BCV2','CCV ','MCV ','TCV ','OSCV'}, ...
    'TickLength', [0 0]);
set(gca,'Fontsize',12);
xlabel('Número de mínimos locais')

h = colorbar; title(h,'%')

[a,b]=size(PCT);
for i=1:a
    for j=1:b
        [vm,err]=binofit(PCT(i,j)*8000,8000);
%         err
        es(i,j) = err(2)-vm;
        ei(i,j) = vm-err(1);
    end
end
