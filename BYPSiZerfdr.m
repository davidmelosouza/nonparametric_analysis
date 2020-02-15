function BYPSiZerfdr(q3,x,mmax,nh,mmp)

color=[0,0,0];
%mmp= logspace(log10(1),log10(1/mmax),nh) ;


    
b=log10(1);
a=log10(1/mmax);
ab=(b-a)/(nh-1);
for m=1:nh  
      mmm=nh+1-m;
 i=round(1/(mmp(mmm)));
     kn=(1:i)/(i);
 kno=quantile(x,kn);


d=[min(x) kno];
   


    for j=1:i
 
       
        switch q3(mmm,j)
            case -1
                color=[0,0,1];
            case 0
                color=[0.5,0,0.5];
            case 1
                color=[1,0,0];
            case -2
                color=[0.35,0.35,0.35];
        end
     fy=[a+ab*(m-1),a+ab*(m-1),a+ab*(m),a+ab*(m)];
         fx=[d(j),d(j+1),d(j+1),d(j)];
   
            h=fill(fx,fy,color);
            
           set(h,'LineStyle','none');
          hold on;
         
    end  
end

% for k=1:mmm/6
%     x(k)=(6*k)/mmm;
%     y(k)=0;
%      plot(x(k)*ones(mmm,1),(1:mmm),'k')
%      
%        hold on; 
%     
%        end
axis([min(x),max(x),a,b]);
%set(gca,'xtick',[(1:14)/24],'xticklabel',[86:99])
hold on;
%set(gca,'xtick',[(15:24)/24],'xticklabel',[00:09])
  
  
  
  
 
hold off;

 xlabel('x','FontSize',16) ;
 ylabel('log_{10}1/m','FontSize',16) ; 

 title('BYP SiZerLS','FontSize',16) ;



