function [fpi,hi,X,hfix] = PILOT(DATA,nPoint,est,bin,h,hfix,type,dolambda)

if isempty(hfix)
hfix = h;
end

x = DATA;
X = linspace(min(x)-4*h,max(x)+4*h,nPoint);

switch est
    case 'ASH'
        M = 10;
        [xest,yest] = ashN(x,M,'linear',bin);
        if dolambda ==1
            fx = interp1(xest,yest,x,'linear','extrap');
            lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        else
            lambda = 1;
        end
        if strcmp(type,'SSE');
            fpi = interp1(xest,yest,x,'linear','extrap');
            [hi] = hSSE(hfix,lambda,fpi);
        end
        if strcmp(type,'BE');
            fpk = interp1(xest,yest,X,'linear','extrap');
            [hk] = hBE(hfix,lambda,fpk,x,X);
        end
        
    case 'HIST'
        [xest,yest] = data_normalized(x,bin);
        if dolambda ==1
            fx = interp1(xest,yest,x,'nearest','extrap');
            lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        else
            lambda = 1;
        end
        fx = interp1(xest,yest,x,'nearest','extrap');
        lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        
        if strcmp(type,'SSE');
            fpi = interp1(xest,yest,x,'nearest','extrap');
            [hi] = hSSE(hfix,lambda,fpi);
        end
        if strcmp(type,'BE');
            fpk = interp1(xest,yest,X,'nearest','extrap');
            [hk] = hBE(hfix,lambda,fpk,x,X);
        end
    case 'PF'
        [xest,yest] = data_normalized(x,bin);
        if dolambda ==1
            fx = interp1(xest,yest,x,'linear','extrap');
            lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        else
            lambda = 1;
        end
        fx = interp1(xest,yest,x,'linear','extrap');
        lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        
        if strcmp(type,'SSE');
            fpi = interp1(xest,yest,x,'linear','extrap');
            [hi] = hSSE(hfix,lambda,fpi);
        end
        if strcmp(type,'BE');
            fpk = interp1(xest,yest,X,'linear','extrap');
            [hk] = hBE(hfix,lambda,fpk,x,X);
        end
    case 'KDE'
        [xest,yest] = KDEfast_fixed(x,h,nPoint);
        if dolambda ==1
            fx = interp1(xest,yest,x,'linear','extrap');
            lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        else
            lambda = 1;
        end
        fx = interp1(xest,yest,x,'linear','extrap');
        lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        
        if strcmp(type,'SSE');
            fpi = interp1(xest,yest,x,'linear','extrap');
            [hi] = hSSE(hfix,lambda,fpi);
        end
        if strcmp(type,'BE');
            fpk = interp1(xest,yest,X,'linear','extrap');
            [hk] = hBE(hfix,lambda,fpk,x,X);
        end
    case 'truth'
        
        xest = DATA.sg.pdf.truth.x;
        yest = DATA.sg.pdf.truth.y;
        if dolambda ==1
            fx = interp1(xest,yest,x,'linear','extrap');
            lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        else
            lambda = 1;
        end
        fx = interp1(xest,yest,x,'linear','extrap');
        lambda=exp((length(x)^-1)*sum(log(fx(fx~=0))));
        
        if strcmp(type,'SSE');
            fpi = interp1(xest,yest,x,'linear','extrap');
            [hi] = hSSE(hfix,lambda,fpi);
        end
        if strcmp(type,'BE');
            fpk = interp1(xest,yest,X,'linear','extrap');
            [hk] = hBE(hfix,lambda,fpk,x,X);
        end
end