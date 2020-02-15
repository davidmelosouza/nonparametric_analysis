function q3= HBPSiZermapfwer(x); 


y = x;

n=length(y); %sample size
 
x=(1:n)./n;


A=ones([n,1]);
 I=eye(n);


%mmax=81;  
%mmax=87;
mmax=max(floor(n/5),81 );
%nh=21;
%nh=41;
nh=max(floor(mmax/5),21);
alpha=0.05;
mmp= logspace(log10(1/1),log10(1/mmax),nh) ;

for m=1:nh

      mm=round(1/(mmp(m)));

     
 kn=(1:mm)/(mm);

kno=min(x)+kn.*(max(x)-min(x));
knot=[kno];

 h=zeros(mm,n);
 d=1./diff([min(x) knot]);
 

T=x;


for i=1:n
if 0<=T(i) & T(i)<=knot(1)
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

if rank(X)==mm+1;
   
efd=(X'*X)*ones(mm+1,1);

L=zeros(mm,mm+1);
    for i=1:mm
    L(i,i)=1;
    L(i,i+1)=-1;
    end



a=(X'*X)^(-1)*X'*y';

bb=zeros(1,mm+1);

sigma(m)=y*(I-X*(X'*X)^(-1)*X')*y'/(n-mm-1);
for k=1:mm
    pp(m,k)=L(k,:)*(a)/((sqrt(sigma(m)))*((L(k,:)*((X'*X)^(-1))*L(k,:)')^(0.5)));

   p(m,k)=1-tcdf(pp(m,k),n-mm-1);   
   ppp(m,k)=1-p(m,k);
end

elseif   rank(X)<mm+1;
    for k=1:mm
  p(m,k)=-1;   
   ppp(m,k)=0;  
    end
    efd=-2*ones(mm+1,1);
end
[ps, In]=sort(p(m,:));
[pps, Inn]=sort(ppp(m,:));

for k=1:mm
    dp(k)=(1/((mm-k+1)))*alpha/2;
    dpp(k)=(1/((mm-k+1)))*alpha/2;
end


   if ps-dp<=0;
       t=0; 
       q(m,In(1:mm))=1;
   else
t=min(find(ps-dp>0));
   end
if pps-dp<=0
    tt=0;
     qq(m,Inn(1:mm))=-1;
else
tt=min(find(pps-dpp>0));
end
if t==1;
   q(m,In(t:mm))=0;
elseif t>1;
q(m,In(1:t-1))=1;
q(m,In(t:mm))=0;
end

if tt==1;
   qq(m,Inn(tt:mm))=0;
elseif tt>1;
qq(m,Inn(1:tt-1))=-1;
qq(m,Inn(tt:mm))=0;
end

for k=1:mm
    if efd(k)>=5&efd(k+1)>=5;
        q3(m,k)=q(m,k)+qq(m,k);
    else
         q3(m,k)=-2;
    end
end
end



HBPSiZerfwer(q3,x,mmax,nh);


   




