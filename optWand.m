function out = optWand(x,L)
    n = length(x);
    M = 401;
    a = min(x);
    b = max(x);
%    alpha = ((1/(4*pi))^(1/10)) * ((243/(35*n))^(1/5))*sqrt(var(x));
%    gpoints = linspace(a,b,M);
%    gcounts = histc(x,gpoints);

    scalest = min(std(x),iqr(x)/1.349);
    sx = (x-mean(x))/scalest;
    sa = (a-mean(x))/scalest; 
    sb = (b-mean(x))/scalest;

    gpoints = linspace(sa, sb, M);
    gcounts = hist(sx, gpoints);

%    delta = (sb-sa)/(M - 1);

   if (L == 0)
        hpi = (24*sqrt(pi)/n)^(1/3); 
   end
   if (L == 1) 
        alpha = (2/(3*n))^(1/5)*sqrt(2);
        psi2hat = bkfe(gcounts, 2,alpha,[sa sb],'TRUE');
        hpi = (6/(-psi2hat*n))^(1/3);
   end
   if (L == 2) 
        alpha = ((2/(5*n))^(1/7))*sqrt(2);
        psi4hat = bkfe(gcounts, 4,alpha,[sa sb],'TRUE');
        alpha = (sqrt(2/pi)/(psi4hat*n))^(1/5);
        psi2hat = bkfe(gcounts, 2,alpha,[sa sb],'TRUE');
        hpi = (6/(-psi2hat*n))^(1/3);
   end
    if (L == 3) 
        alpha = ((2/(7*n))^(1/9))*sqrt(2);
        psi6hat = bkfe(gcounts, 6,alpha,[sa sb],'TRUE');
        alpha = (-3*sqrt(2/pi)/(psi6hat*n))^(1/7);
        psi4hat = bkfe(gcounts, 4,alpha,[sa sb],'TRUE');
        alpha = (sqrt(2/pi)/(psi4hat*n))^(1/5);
        psi2hat = bkfe(gcounts, 2,alpha,[sa sb],'TRUE');
        hpi = (6/(-psi2hat*n))^(1/3);
    end
    if (L == 4) 
        alpha = ((2/(9*n))^(1/11))*sqrt(2) ;
        psi8hat = bkfe(gcounts, 8,alpha,[sa sb],'TRUE');
        alpha = (15*sqrt(2/pi)/(psi8hat*n))^(1/9);
        psi6hat = bkfe(gcounts, 6,alpha,[sa sb],'TRUE');
        alpha = (-3*sqrt(2/pi)/(psi6hat*n))^(1/7);
        psi4hat = bkfe(gcounts, 4,alpha,[sa sb],'TRUE');
        alpha = (sqrt(2/pi)/(psi4hat*n))^(1/5);
        psi2hat = bkfe(gcounts, 2,alpha,[sa sb],'TRUE');
        hpi = (6/(-psi2hat*n))^(1/3);
    end
    if (L == 5) 
        alpha = ((2/(11*n))^(1/13))*sqrt(2);
        psi10hat = bkfe(gcounts, 10,alpha,[sa sb],'TRUE');
        alpha = (-105*sqrt(2/pi)/(psi10hat*n))^(1/11);
        psi8hat = bkfe(gcounts, 8,alpha,[sa sb],'TRUE');
        alpha = (15*sqrt(2/pi)/(psi8hat*n))^(1/9); 
        psi6hat = bkfe(gcounts, 6,alpha,[sa sb],'TRUE');
        alpha = (-3*sqrt(2/pi)/(psi6hat*n))^(1/7) ;
        psi4hat = bkfe(gcounts, 4,alpha,[sa sb],'TRUE');
        alpha = (sqrt(2/pi)/(psi4hat*n))^(1/5);
        psi2hat = bkfe(gcounts, 2,alpha,[sa sb],'TRUE');
        hpi = (6/(-psi2hat*n))^(1/3);
    end
%     hpi
    hout = scalest * hpi;
    out = ceil((sb-sa)/hout);
    if out <=2
        out = 3;
    end