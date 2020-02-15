close all; clear; clc;

ESTIMADOR = 'HIST';
for dist = {'GGD','Logn'}

EVENTOS = 25;
load([pwd '\' ESTIMADOR '\' ESTIMADOR '[SK]DIST[' dist{1} ']EVT[' num2str(EVENTOS) ']'],'BIN','AREA');
load([pwd '\' ESTIMADOR '\XSK[' dist{1} ']'])
DADOS_AREA = [{AREA.FD};{AREA.SC};{AREA.ST};{AREA.DO};{AREA.KN};{AREA.WA};{AREA.SS};{AREA.RU};{AREA.LH};{AREA.TR}];


if strcmp(dist{1},'Logn')
    kind = 'Skewness';
else
    kind = 'Kurtosis';
end


PLOTBOX(DADOS_AREA,x_sk,'Events','Average Performance','northeast'); hold on
grid minor
set(gca,'Gridlinestyle',':')
%
saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[' kind ']DIST[' dist{1} ']'],'fig');
% close
end