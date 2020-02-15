function out = bkfe(x, r,h,range,binned)
% r = 2;
% h = 0.3;
% binned = 1;
M = 401;
a = range(1);
b = range(2);

if strcmp(binned,'FALSE')
    gpoints = linspace(a,b,M);
    gcounts = histc(x,gpoints);
else
    gcounts = x;
    M = length(gcounts);
    gpoints = linspace(a, b, M);
end

n = sum(gcounts);
% n = length(x);
delta = (b-a)/(M-1);

tau = 4 + r;
L = min([floor((tau*h)/delta) M]);

lvec = 0:L;
arg = lvec*(delta/h);

kappam = pdf('normal',(arg),0,1)/(h^(r+1));
hmold0 = 1;
hmold1 = arg;
hmnew = 1;

if r >= 2
    for i = 2:r
        hmnew = arg.*hmold1 - (i-1)*hmold0;
        hmold0 = hmold1;
        hmold1 = hmnew;
        %             pause
    end
end

kappam =  (kappam .* hmnew);

P = 2^(ceil(log(M+L+1)/log(2)));
kappam = [kappam zeros(1,P-(2*L)-1) fliplr(kappam(2:end))];
Gcounts =  [gcounts  zeros(1, P-M)];
kappamf = fft(kappam);
Gcountsf =  fft(Gcounts);

M1=(Gcountsf.*kappamf);

% [Vi]= indmult(M1);
% for i = 1: size(M1,1)
% Mc(i) = M1(i,Vi(i)); 
% end
f2 =real(fft(M1))/P; f2 = fliplr(f2); f2=f2(1:M);
M2=gcounts.* f2;
% [Vj]= indmult(M2);
% for i = 1: size(M2,1)
% f3(i) = M2(i,Vj(i)); 
% end
out =(sum(M2))/(n^2);

