function [ area ] = area2d( x,y )
%==========================================================================
% Objetivo: * Calcular a �rea 
%==========================================================================
tbin=diff(x);
y = reshape(y,length(y),1);
tbin=reshape(tbin,length(tbin),1);
area=sum((y(1:end-1)).*abs(tbin));

end