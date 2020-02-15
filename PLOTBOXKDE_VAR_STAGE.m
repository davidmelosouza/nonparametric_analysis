function [] = PLOTBOXKDE_VAR_STAGE(DATA,vEVT,xtag,ytag,legpos)
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
    0, 48, 0;
    0, 0, 255;
    0, 0, 86;
    204, 0, 153;
    255, 128, 223;
    255,255,255]/255;
aboxplot(DATA,'labels',vEVT,'Colormap',cmap(1:length(DATA),:),'colorrev',false,'OutlierMarker','+')
xlabel(xtag); % Set the X-axis label
ylabel(ytag); % Set the X-axis label
	
% L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'[CV]LSCV'};{'TRUTH'}];
L = [{'1º Estágio'};{'2º Estágio'};{'3º Estágio'};{'4º Estágio'}];

legend([L(1:length(DATA))],'Location',legpos);

end
% ygrid(1,:)=interp1(x.SS,y.SS,DATA.sg.pdf.truth.x,inter,0); 
% ygrid(2,:)=interp1(x.BKDE,y.BKDE,DATA.sg.pdf.truth.x,inter,0); 
% ygrid(3,:)=interp1(x.SV,y.SV,DATA.sg.pdf.truth.x,inter,0); 
% ygrid(4,:)=interp1(x.MGKDE,y.MGKDE,DATA.sg.pdf.truth.x,inter,0); 
