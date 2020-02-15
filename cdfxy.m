function [xp,cdfy] = cdfxy(xp,yp)
dx = diff(xp); dx=dx(1); 
ycdf=0;
for i=1:length(xp)
   ycdf=ycdf+yp(i)*dx;
   cdfy(i)=ycdf;
end
end