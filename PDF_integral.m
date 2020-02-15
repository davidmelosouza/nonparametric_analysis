function [I,f] = PDF_integral(xi,xs,name)

syms x f
%%=========================================================================
%% Uniforme
%%=========================================================================
if strcmp(name,'Uniform')
    if xs>sg.g1.s
        xs=sg.g1.s;
    end
    if xi<sg.g1.i
        xi=sg.g1.i;
    end
    I=(1/(sg.g1.s-sg.g1.i))*(xs-xi);
end
%%=========================================================================
%% LogNormal
%%=========================================================================
if strcmp(name,'Logn')
    f=(1/(x*sg.std*sqrt(2*pi)))*exp(-((log(x)-sg.mu)^2)/(2*sg.std^2));
    I=double(int(f, xi, xs));
end
%%=========================================================================
%% GGD
%%=========================================================================
if strcmp(name,'Logn')
    mu=-3; beta= 1; rho=1;
    sbeta = sqrt(beta);
    f = exp(-abs(sbeta*(x-mu)').^rho) * sbeta / (2*gamma(1+1/rho));
    I=double(int(f, xi, xs));
end
%%=========================================================================
%% Beta
%%=========================================================================
if strcmp(name,'Logn')
    mu=-3; beta= 1; rho=1;
    sbeta = sqrt(beta);
    f = exp(-abs(sbeta*(x-mu)').^rho) * sbeta / (2*gamma(1+1/rho));
    I=double(int(f, xi, xs));
end


end
