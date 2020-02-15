function [xp,cdfy] = cdfxyfast(xp,yp)
dx = diff(xp); dx=dx(1); 
cdfy=cumsum(yp)*dx;
end