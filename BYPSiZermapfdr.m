function q3=BYPSiZermapfdr(x); 

%y   %the observation vector (1*n)
%x    %the design points (1*n)
%    y=load('exp1-02');
% y=y.y;
y = x;

n=length(y); %sample size
 
x=(1:n)./n;


A=ones([n,1]);
 I=eye(n);

mmax=1000; %the maximum value of number of konts used in our paper

%mmax=max(floor(n/5)+1,81 ); % used when sample size is very large, e.g. more than 1000


nh=100; % the number of rows of SiZer map used in our paper
%nh=41; %another good choice in applications 
%nh=max(floor(mmax/5),21); % used in applications when sample size is very large,e.g. more than 1000
alpha=0.05; %nominal level
hSJ = SJbandwidth(x');
mmp = linspace(0.001,2*hSJ,nh);
% mmp= logspace(log10(1/1),log10(1/mmax),nh) ; 

for m=1:nh

      mm=round(1/(mmp(m)));

     
 kn=(1:mm)/(mm);
 kno=quantile(x,kn);
knot=[kno];

 h=zeros(mm,n);
 d=1./diff([min(x) knot]);
 

T=x;


for i=1:n
if min(x)<=T(i) & T(i)<=knot(1)
             h(1,i)=1;
    
end
end
if mm>1
for s=2:mm
       for i=1:n
         if knot(s-1)<T(i) & T(i)<=knot(s)
             h(s,i)=1;
         end
       end 
end
end
  Z0=-d(1)*(T'-knot(1)*A) .*h(1,:)';
  if mm>1
Z1(1,:)=d(1)*((T'-min(x)*A).*h(1,:)')-d(2)*((T'-knot(2)*A) .*h(2,:)'); 

 for s=2:mm-1;
   Z1(s,:)=d(s).*((T'-knot(s-1)*A).*h(s,:)')-d(s+1).*((T'-knot(s+1)*A) .*h(s+1,:)');
 end
 Z1(mm,:)=d(mm).*(T'-knot(mm-1)*A) .*h(mm,:)';

  elseif mm==1;
   Z1(mm,:)=d(mm).*(T'-min(x).*A) .*h(mm,:)'; 
  end
  
 X=[Z0'; Z1]'; 


efd=(X'*X)*ones(mm+1,1);
L=zeros(mm,mm+1);
    for i=1:mm
    L(i,i)=1;
    L(i,i+1)=-1;
    end



a=(X'*X)^(-1)*X'*y';
b=X*a;

bb=zeros(1,mm+1);

sigma(m)=y*(I-X*(X'*X)^(-1)*X')*y'/(n-mm-1);
for k=1:mm
    pp(m,k)=L(k,:)*(a)/((sqrt(sigma(m)))*((L(k,:)*((X'*X)^(-1))*L(k,:)')^(0.5)));

   p(m,k)=1-tcdf(pp(m,k),n-mm-1);   
   ppp(m,k)=1-p(m,k);
end

[ps, In]=sort(p(m,:));
[pps, Inn]=sort(ppp(m,:));
for k=1:mm
    dp(k)=(k/(sum(1./(1:mm))*(mm)))*alpha/2;
    dpp(k)=(k/(sum(1./(1:mm))*(mm)))*alpha/2;
end


   if ps-dp>0;
       t=0; 
   else
t=max(find(ps-dp<=0));
   end
if pps-dp>0
    tt=0;
else
tt=max(find(pps-dp<=0));
end

q(m,In(1:t))=1;
q(m,In(t+1:mm))=0;
qq(m,Inn(1:tt))=-1;
qq(m,Inn(tt+1:mm))=0;

for k=1:mm
    if efd(k)>=5&efd(k+1)>=5;
        q3(m,k)=q(m,k)+qq(m,k);
    else
         q3(m,k)=-2;
    end
end
end



 BYPSiZerfdr(q3,x,mmax,nh,mmp);


   




