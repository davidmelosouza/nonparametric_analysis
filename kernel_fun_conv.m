function [fx] = kernel_fun_conv(kernel,r)
syms x
if strcmp(kernel,'epanechnikov') && (r >= 3); disp('epanechnikov kernel derivative = 0 for order >= 3'); end
if strcmp(kernel,'uniform') && (r >= 1);      disp('uniform kernel derivative = 0 for order >= 1'); end
if strcmp(kernel,'triweight') && (r >= 7);    disp('triweight kernel derivative = 0 for order >= 7'); end
if strcmp(kernel,'biweight') && (r >= 5);     disp('biweight kernel derivative = 0 for order >= 5'); end
if strcmp(kernel,'triangular') && (r >= 2);   disp('triangxlar kernel derivative = 0 for order >= 2'); end
if strcmp(kernel,'tricube') && (r >= 10);     disp('tricxbe kernel derivative = 0 for order >= 10'); end

if strcmp(kernel,'uniform')
    if (r==0)
        fx = (0.5-0.25*abs(x))*(abs(x)<=2);
    end
elseif strcmp(kernel,'epanechnikov')
    if (r==0);     fx = ((3/5)-(3/160)*abs(x)^5+(3/8)*abs(x)^3-(3/4)*x^2)*(abs(x)<=2);
    elseif (r==1); fx = (-(3/2)-(3/8)*abs(x)^3+(9/4)*abs(x))*(abs(x)<=2);
    elseif (r==2); fx = ((9/2)-(9/4)*abs(x))*(abs(x)<=2);
    end
elseif strcmp(kernel,'triweight')
    if (r==0);     fx = (-(35/22)*x^2+(350/429)+(35/11264)*abs(x)^11-(35/768)*abs(x)^9+(35/64)*abs(x)^7-(35/32)*x^6+(35/24)*x^4-(175/1757184)*abs(x)^13)*(abs(x)<=2);
    elseif (r==1); fx = (-(35/11)+(735/32)*abs(x)^5+(35/2)*x^2-(175/11264)*abs(x)^11+(175/512)*abs(x)^9-(105/32)*abs(x)^7-(525/16)*x^4)*(abs(x)<=2);
    elseif (r==2); fx = (35-(2205/16)*abs(x)^5+(3675/8)*abs(x)^3-(1575/4)*x^2-(875/512)*abs(x)^9+(1575/64)*abs(x)^7)*(abs(x)<=2);
    elseif (r==3); fx = ((11025/4)*abs(x)+(33075/32)*abs(x)^5-(11025/4)*abs(x)^3-(7875/64)*abs(x)^7-(1575/2))*(abs(x)<=2);
    elseif (r==4); fx = (33075-(165375/32)*abs(x)^5+(165375/8)*abs(x)^3+(165375/4)*x^2-99225*abs(x))*(abs(x)<=2);
    elseif (r==5); fx = (-(826875/2)-(826875/8)*abs(x)^3+(2480625/4)*abs(x))*(abs(x)<=2);
    elseif (r==6); fx = ((2480625/2)-(2480625/4)*abs(x))*(abs(x)<=2);
    end
elseif strcmp(kernel,'biweight')
    if (r==0);     fx = (-(15/32)*abs(x)^5-(15/14)*x^2-(5/3584)*abs(x)^9+(15/448)*abs(x)^7+(15/16)*x^4+(5/7))*(abs(x)<=2);
    elseif (r==1); fx = ((45/32)*abs(x)^5-(75/8)*abs(x)^3+(45/4)*x^2-(45/448)*abs(x)^7-(15/7)) *(abs(x)<=2);
    elseif (r==2); fx = ((45/2)-(135/32)*abs(x)^5+(225/8)*abs(x)^3-(225/4)*abs(x)) *(abs(x)<=2);
    elseif (r==3); fx = (-(675/2)-(675/8)*abs(x)^3+(2025/4)*abs(x)) *(abs(x)<=2);
    elseif (r==4); fx = ((2025/2)-(2025/4)*abs(x)) *(abs(x)<=2);
    end
elseif strcmp(kernel,'cosine')
    fx = ((-1)^(r+1) * (pi^(2*r+2)/2^(2*r+5)) * cos(0.5*pi*abs(x))*abs(x) + (-1)^r * (pi^(2*r+2)/2^(2*r+4))* cos(0.5*pi*abs(x))+(pi^(2*r+1)/2^(2*r+4))*sin(0.5*pi*abs(x)))*(abs(x)<=2);
elseif strcmp(kernel,'triangxlar')
    if (r==0);  fx = ((1/6)*(x+2)^3 *(x <=- 1 & x > -2 ) + (-(1/2)*x^3-x^2+(2/3)) *(x <= 0 & x > -1 )+((2/3)+(1/2)*x^3-x^2)*(x <= 1 & x > 0 )-(1/6)*(x-2)^3 * (x <=2 & x >1) );
    elseif (r==1); fx = (x+2)*(x <=-1 & x >= -2 )+(-3*x-2)*(x <=0 & x > -1 )+(3*x-2)*(x <= 1 & x > 0 )+(2-x)*(x <= 2 & x > 1);
    end
elseif strcmp(kernel,'tricube')
    if (r==0); fx = (x <= -1 & x > -2)*((2870/351)*x^6+(21560/2187)*x^4+(7840/1683)*x^2+...
            (22400/20007)+(70/81)*x^9+(15680/6561)*x+(11305/2187)*x^7+(980/99)*x^5+...
            (2800/351)*x^3+(35/625482)*x^16+(1085/6561)*x^10+(245/303046029)*x^19+...
            (665/312741)*x^13+(245/99)*x^8)+ (x <= 0 & x > -1)*(-(350/117)*x^6+(980/729)*x^4-...
            (210/187)*x^2+(175/247)-(70/81)*x^9-(2905/729)*x^7-(35/625482)*x^16-...
            (1085/6561)*x^10-(245/101015343)*x^19-(1295/312741)*x^13-(245/99)*x^8)+...
            (x > 0 & x <= 1)*(-(350/117)*x^6+(980/729)*x^4-(210/187)*x^2+(175/247)+...
            (70/81)*x^9+(2905/729)*x^7-(35/625482)*x^16-(1085/6561)*x^10+(245/101015343)*...
            x^19+(1295/312741)*x^13-(245/99)*x^8)+(x > 1 & x < 2)*((2870/351)*x^6+(21560/2187)*...
            x^4+(7840/1683)*x^2+(22400/20007)-(15680/6561)*x-(70/81)*x^9+(245/99)*x^8-...
            (11305/2187)*x^7-(980/99)*x^5-(2800/351)*x^3-(245/303046029)*x^19-...
            (665/312741)*x^13+(35/625482)*x^16+(1085/6561)*x^10);
    elseif (r==1); fx = (x <= -1 & x > -2)*((86240/729)*x^2+(28700/117)*x^4+(15680/1683)+...
            (560/9)*x^7+(10850/729)*x^8+(1400/104247)*x^14+(13720/99)*x^6+(490/1772199)*...
            x^17+(2660/8019)*x^11+(158270/729)*x^5+(19600/99)*x^3+(5600/117)*x)+...
            (x <= 0 & x > -1)* ((3920/243)*x^2-(3500/39)*x^4-(420/187)-(560/9)*x^7-...
            (10850/729)*x^8-(1400/104247)*x^14-(13720/99)*x^6-(490/590733)*x^17-...
            (5180/8019)*x^11-(40670/243)*x^5)+(x > 0 & x <= 1)*((3920/243)*x^2-...
            (3500/39)*x^4-(420/187)+(560/9)*x^7-(10850/729)*x^8-(1400/104247)*x^14-...
            (13720/99)*x^6+(490/590733)*x^17+(5180/8019)*x^11+(40670/243)*x^5)+...
            (x > 1 & x < 2)*((86240/729)*x^2+(28700/117)*x^4+(15680/1683)-(560/9)*x^7+...
            (10850/729)*x^8-(158270/729)*x^5+(13720/99)*x^6-(19600/99)*x^3-(5600/117)*x+...
            (1400/104247)*x^14-(2660/8019)*x^11-(490/1772199)*x^17);
    elseif (r==2); fx = (x <= -1 & x > -2)*((114800/39)*x^2+(172480/729)+(3165400/729)*x^3+...
            (607600/729)*x^6+(26600/729)*x^9+(7840/104247)*x^15+(7840/3)*x^5+...
            (137200/33)*x^4+(39200/33)*x+(19600/8019)*x^12)+ (x <= 0 & x > -1)*...
            (-(14000/13)*x^2+(7840/243)-(813400/243)*x^3-(607600/729)*x^6-(51800/729)*...
            x^9-(7840/34749)*x^15-(7840/3)*x^5-(137200/33)*x^4-(19600/8019)*x^12)+...
            (x > 0 & x <= 1)*(-(14000/13)*x^2+(7840/243)+(813400/243)*x^3+(51800/729)*...
            x^9-(607600/729)*x^6+(7840/34749)*x^15+(7840/3)*x^5-(137200/33)*x^4-...
            (19600/8019)*x^12)+ (x > 1 & x < 2)*((114800/39)*x^2+(172480/729)-...
            (3165400/729)*x^3+(19600/8019)*x^12-(26600/729)*x^9+(607600/729)*x^6-...
            (7840/3)*x^5-(39200/33)*x+(137200/33)*x^4-(7840/104247)*x^15);
    elseif (r==3); fx = (x <= -1 & x > -2)*( (229600/39)+(212800/81)*x^7+(78400/243)*x^10+...
            (548800/34749)*x^13+(6076000/243)*x^4+(6330800/243)*x+(156800/3)*x^3+...
            (548800/11)*x^2)+ (x <= 0 & x > -1)* ( -(28000/13)-(414400/81)*x^7-...
            (548800/11583)*x^13-(6076000/243)*x^4-(1626800/81)*x-(78400/243)*x^10-...
            (156800/3)*x^3-(548800/11)*x^2) +(x > 0 & x <= 1)*( (-28000/13)+...
            (414400/81)*x^7+(548800/11583)*x^13+(1626800/81)*x-(6076000/243)*x^4-...
            (78400/243)*x^10+(156800/3)*x^3-(548800/11)*x^2)+ (x > 1 & x < 2)*...
            ((229600/39)+(78400/243)*x^10-(6330800/243)*x+(6076000/243)*x^4-...
            (548800/34749)*x^13-(212800/81)*x^7-(156800/3)*x^3+(548800/11)*x^2);
    elseif (r==4); fx = (x <= -1 & x > -2)*( -(589568000/81)*x^2-(29478400/33)-(16777600/27)*...
            x^5-(11603200/3)*x+(2195200/891)*x^11+(784000/27)*x^8-(21952000/3)*x^3-...
            (10976000/3)*x^4)+(x <= 0 & x > -1)* ( (551936000/81)*x^2+(4076800/11)+...
            (2038400/3)*x^5+2822400*x-(2195200/297)*x^11-(784000/27)*x^8+(21952000/3)*...
            x^3+(10976000/3)*x^4)+(x > 0 & x <= 1)*((551936000/81)*x^2+(4076800/11)-...
            (2038400/3)*x^5-2822400*x-(784000/27)*x^8+(2195200/297)*x^11-(21952000/3)*...
            x^3+(10976000/3)*x^4)+ (x > 1 & x < 2)*(-(589568000/81)*x^2-(29478400/33)+...
            (16777600/27)*x^5+(11603200/3)*x+(784000/27)*x^8-(2195200/891)*x^11-...
            (10976000/3)*x^4+(21952000/3)*x^3);
    elseif (r==5); fx = (x <= -1 & x > -2)*((2885120000/81)+(4406080000/27)*x^3+219520000*x^2+...
            (43904000/27)*x^6+43904000*x^4+137984000*x+(21952000/81)*x^9)+...
            (x <= 0 & x > -1)* ( -(1944320000/81)-(486080000/3)*x^3-219520000*x^2-...
            (43904000/27)*x^6-43904000*x^4-125440000*x-(21952000/27)*x^9)+...
            (x > 0 & x <= 1)*( -(1944320000/81)+(486080000/3)*x^3-219520000*x^2-...
            (43904000/27)*x^6-43904000*x^4+125440000*x+(21952000/27)*x^9)+...
            (x > 1 & x < 2)*( (2885120000/81)+43904000*x^4+219520000*x^2-137984000*x-...
            (4406080000/27)*x^3-(21952000/81)*x^9+(43904000/27)*x^6);
    elseif (r==6); fx = (x <= -1 & x > -2)*( (-2320640000/3)-(3512320000/3)*x^3-(22798720000/9)*x+...
            (175616000/9)*x^7-2985472000*x^2+(439040000/9)*x^4)+ (x <= 0 & x > -1)*...
            ( 689920000+(3512320000/3)*x^3+2540160000*x-(175616000/3)*x^7+2985472000*...
            x^2-(439040000/9)*x^4)+ (x > 0 & x <= 1)*( 689920000-(3512320000/3)*x^3-...
            2540160000*x+(175616000/3)*x^7+2985472000*x^2-(439040000/9)*x^4)+...
            (x > 1 & x < 2)*((-2320640000/3)+(3512320000/3)*x^3+(22798720000/9)*x-...
            (175616000/9)*x^7-2985472000*x^2+(439040000/9)*x^4);
    elseif (r==7); fx = (x <= -1 & x > -2)*( 9834496000+24586240000*x+(2458624000/3)*x^5+...
            (49172480000/3)*x^2)+(x <= 0 & x > -1)* ( -9834496000-24586240000*x-...
            2458624000*x^5-(49172480000/3)*x^2)+(x > 0 & x <= 1)*( -9834496000+...
            24586240000*x+2458624000*x^5-(49172480000/3)*x^2)+ (x > 1 & x < 2)*...
            (9834496000-24586240000*x-(2458624000/3)*x^5+(49172480000/3)*x^2);
    elseif (r==8); fx = (x <= -1 & x > -2)*(-98344960000*x+(49172480000/3)*x^3-(196689920000/3))+...
            (x <= 0 & x > -1)*(98344960000*x-49172480000*x^3+(196689920000/3))+...
            (x > 0 & x <= 1)* (49172480000*x^3-98344960000*x+(196689920000/3))+...
            (x > 1 & x < 2)*( 98344960000*x-(49172480000/3)*x^3-(196689920000/3));
    elseif (r==9); fx = (x <= -1 & x > -2)*( 98344960000*x+196689920000)+ (x <= 0 & x > -1)*...
            (-295034880000*x-196689920000)+(x > 0 & x <= 1)* ( 295034880000*x-...
            196689920000)+ (x > 1 & x < 2)*( -98344960000*x+196689920000);
    end
elseif strcmp(kernel,'silverman')
    if (r==0); fx = (x < 0)*((1/16)*exp((1/2)*x*sqrt(2))*(3*sqrt(2)*cos((1/2)*x*sqrt(2))-...
            3*sqrt(2)*sin((1/2)*x*sqrt(2))+2*sin((1/2)*x*sqrt(2))*x))+ (x >= 0)*((1/16)*...
            exp(-(1/2)*x*sqrt(2))*(3*sqrt(2)*cos((1/2)*x*sqrt(2))+3*sqrt(2)*sin((1/2)*x*...
            sqrt(2))+2*sin((1/2)*x*sqrt(2))*x));
    elseif (r==1); fx = (x < 0)*(-(1/16)*exp((1/2)*x*sqrt(2))*(sqrt(2)*cos((1/2)*x*sqrt(2))+...
            sqrt(2)*sin((1/2)*x*sqrt(2))-2*cos((1/2)*x*sqrt(2))*x))+ (x >= 0)*...
            (-(1/16)*exp(-(1/2)*x*sqrt(2))*(sqrt(2)*cos((1/2)*x*sqrt(2))+2*cos((1/2)*...
            x*sqrt(2))*x-sqrt(2)*sin((1/2)*x*sqrt(2))));
    elseif (r==2); fx = (x < 0)*((1/16)*exp((1/2)*x*sqrt(2))*(sqrt(2)*cos((1/2)*x*sqrt(2))-...
            sqrt(2)*sin((1/2)*x*sqrt(2))-2*sin((1/2)*x*sqrt(2))*x))+ (x >= 0)*...
            ((1/16)*exp(-(1/2)*x*sqrt(2))*(sqrt(2)*cos((1/2)*x*sqrt(2))+sqrt(2)*...
            sin((1/2)*x*sqrt(2))-2*sin((1/2)*x*sqrt(2))*x));
    elseif (r==3); fx = (x < 0)*(-(1/16)*exp((1/2)*x*sqrt(2))*(3*sqrt(2)*cos((1/2)*x*sqrt(2))+...
            3*sqrt(2)*sin((1/2)*x*sqrt(2))+2*cos((1/2)*x*sqrt(2))*x))+ (x >= 0)*...
            (-(1/16)*exp(-(1/2)*x*sqrt(2))*(3*sqrt(2)*cos((1/2)*x*sqrt(2))-3*sqrt(2)*...
            sin((1/2)*x*sqrt(2))-2*cos((1/2)*x*sqrt(2))*x));
    end
elseif strcmp(kernel,'Gaussian')

    if (r==0); fx =(1/(sqrt(2)*sqrt(2*pi)))*exp(-(1/4)*x^2);
    elseif (r==1); fx = (1/8)*exp(-(1/4)*x^2)*(x^2-2)/sqrt(pi);
    elseif (r==2); fx = (1/32)*exp(-(1/4)*x^2)*(12-12*x^2+x^4)/sqrt(pi);
    elseif (r==3); fx = (1/128)*exp(-(1/4)*x^2)*(x^6-30*x^4+180*x^2-120)/sqrt(pi);
    elseif (r==4); fx = (1/512)*exp(-(1/4)*x^2)*(x^8-56*x^6+840*x^4-3360*x^2+1680)/sqrt(pi);
    elseif (r==5); fx = (1/2048)*exp(-(1/4)*x^2)*(x^10-90*x^8+2520*x^6-25200*x^4+75600*x^2-30240)/sqrt(pi);
    elseif (r==6); fx = (1/8192)*exp(-(1/4)*x^2)*(x^12-132*x^10+5940*x^8-110880*x^6+831600*x^4-1995840*x^2+665280)/sqrt(pi);
    elseif (r==7); fx = (1/32768)*exp(-(1/4)*x^2)*(x^14-182*x^12+12012*x^10-360360*x^8+5045040*x^6-30270240*x^4+60540480*x^2-17297280)/sqrt(pi);
    elseif (r==8); fx = (1/131072)*exp(-(1/4)*x^2)*(x^16-240*x^14+21840*x^12-960960*x^10+21621600*x^8-242161920*x^6+1210809600*x^4-2075673600*x^2+518918400)/sqrt(pi);
    elseif (r==9); fx = (1/524288)*exp(-(1/4)*x^2)*(x^18-306*x^16+36720*x^14-2227680*x^12+73513440*x^10-1323241920*x^8+12350257920*x^6-52929676800*x^4+79394515200*x^2-17643225600)/sqrt(pi);
    elseif (r==10); fx = (1/2097152)*exp(-(1/4)*x^2)*(x^20-380*x^18+58140*x^16-4651200*x^14+211629600*x^12-5587021440*x^10+83805321600*x^8-670442572800*x^6+2514159648000*x^4-3352212864000*x^2+670442572800)/sqrt(pi);
    elseif (r==11); fx = (1/8388608)*exp(-(1/4)*x^2)*(x^22-462*x^20+87780*x^18-8953560*x^16+537213600*x^14-19554575040*x^12+430200650880*x^10-5531151225600*x^8+38718058579200*x^6-129060195264000*x^4+154872234316800*x^2-28158588057600)/sqrt(pi);
    elseif (r==12); fx = (1/33554432)*exp(-(1/4)*x^2)*(x^24-552*x^22+127512*x^20-16151520*x^18+1235591280*x^16-59308381440*x^14+1799020903680*x^12-33924394183680*x^10+381649434566400*x^8-2374707592857600*x^6+7124122778572800*x^4-7771770303897600*x^2+1295295050649600)/sqrt(pi);
    elseif (r==13); fx = (1/134217728)*exp(-(1/4)*x^2)*(x^26-650*x^24+179400*x^22-27627600*x^20+2624622000*x^18-160626866400*x^16+6425074656000*x^14-167051941056000*x^12+2756357027424000*x^10-27563570274240000*x^8+154355993535744000*x^6-420970891461120000*x^4+420970891461120000*x^2-64764752532480000)/sqrt(pi);
    elseif (r==14); fx = (1/536870912)*exp(-(1/4)*x^2)*(x^28-756*x^26+245700*x^24-45208800*x^22+5221616400*x^20-396842846400*x^18+20238985166400*x^16-693908062848000*x^14+15786408429792000*x^12-231533990303616000*x^10+2083805912732544000*x^8-10608466464820224000*x^6+26521166162050560000*x^4-24481076457277440000*x^2+3497296636753920000)/sqrt(pi);
    elseif (r==15); fx = (1/2147483648)*exp(-(1/4)*x^2)*(x^30-870*x^28+328860*x^26-71253000*x^24+9832914000*x^22-908561253600*x^20+57542212728000*x^18-2515416727824000*x^16+75462501834720000*x^14-1526019481546560000*x^12+20143457156414592000*x^10-164810104007028480000*x^8+769113818699466240000*x^6-1774878043152614400000*x^4+1521324036987955200000*x^2-202843204931727360000)/sqrt(pi);
    elseif (r==16); fx = (1/8589934592)*exp(-(1/4)*x^2)*(x^32-992*x^30+431520*x^28-108743040*x^26+17670744000*x^24-1950850137600*x^22+150215460595200*x^20-8154553575168000*x^18+311911674250176000*x^16-8317644646671360000*x^14+151381132569418752000*x^12-1816573590833025024000*x^10+13624301931247687680000*x^8-58689300626913116160000*x^6+125762787057670963200000*x^4-100610229646136770560000*x^2+12576278705767096320000)/sqrt(pi);
    elseif (r==17); fx = (1/34359738368)*exp(-(1/4)*x^2)*(x^34-1122*x^32+556512*x^30-161388480*x^28+30502422720*x^26-3965314953600*x^24+364808975731200*x^22-24077392398259200*x^20+1143676138917312000*x^18-38884988723188608000*x^16+933239729356526592000*x^14-15440875522080712704000*x^12+169849630742887839744000*x^10-1175882058989223505920000*x^8+4703528235956894023680000*x^6-9407056471913788047360000*x^4+7055292353935341035520000*x^2-830034394580628357120000)/sqrt(pi);
    elseif (r==18); fx = (1/137438953472)*exp(-(1/4)*x^2)*(x^36-1260*x^34+706860*x^32-233735040*x^30+50837371200*x^28-7686610525440*x^26+832716140256000*x^24-65665615631616000*x^22+3792189302725824000*x^20-160114659448423680000*x^18+4899508579121764608000*x^16-106898368999020318720000*x^14+1621291929818474833920000*x^12-16462348825849129082880000*x^10+105829385309030115532800000*x^8-395096371820379097989120000*x^6+740805697163210808729600000*x^4-522921668585795864985600000*x^2+58102407620643984998400000)/sqrt(pi);
    elseif (r==19); fx = (1/549755813888)*exp(-(1/4)*x^2)*(x^38-1406*x^36+885780*x^34-331281720*x^32+82157866560*x^30-14295468781440*x^28+1801229066461440*x^26-167256984742848000*x^24+11540731947256512000*x^22-592424239959167616000*x^20+22512121118448369408000*x^18-626246278385927367168000*x^16+12524925567718547343360000*x^14-175348957948059662807040000*x^12+1653290174938848249323520000*x^10-9919741049633089495941120000*x^8+34719093673715813235793920000*x^6-61268988835969082180812800000*x^4+40845992557312721453875200000*x^2-4299578163927654889881600000)/sqrt(pi);
    elseif (r==20); fx = (1/2199023255552)*exp(-(1/4)*x^2)*(x^40-1560*x^38+1096680*x^36-460605600*x^34+129199870800*x^32-25633254366720*x^30+3716821883174400*x^28-401416763382835200*x^26+32615112024855360000*x^24-2000393537524462080000*x^22+92418181433630148096000*x^20-3192628085889041479680000*x^18+81412016190170557731840000*x^16-1502991068126225681203200000*x^14+19538883885640933855641600000*x^12-171942178193640217929646080000*x^10+967174752339226225854259200000*x^8-3185987419470392273402265600000*x^6+5309979032450653789003776000000*x^4-3353670967863570814107648000000*x^2+335367096786357081410764800000)/sqrt(pi);
    elseif (r==21); fx = (1/8796093022208)*exp(-(1/4)*x^2)*(x^42-1722*x^40+1343160*x^38-629494320*x^36+198290710800*x^34-44496435503520*x^32+7356744003248640*x^30-914338183260902400*x^28+86404958318155276800*x^26-6240358100755658880000*x^24+344467767161712370176000*x^22-14467646220791919547392000*x^20+458142130325077452334080000*x^18-10783960913805669262632960000*x^16+184867901379525758787993600000*x^14-2243063870071579206627655680000*x^12+18505276928090528454678159360000*x^10-97969113148714562407119667200000*x^8+304792796462667527488816742400000*x^6-481251783888422411824447488000000*x^4+288751070333053447094668492800000*x^2-27500101936481280675682713600000)/sqrt(pi);
    elseif (r==22); fx = (1/35184372088832)*exp(-(1/4)*x^2)*(x^44-1892*x^42+1629012*x^40-847086240*x^38+297750813360*x^36-75033204966720*x^34+14031209328776640*x^32-1988422807735203840*x^30+216240980341203417600*x^28-18164242348661087078400*x^26+1180675752662970660096000*x^24-59248455951814527670272000*x^22+2281065554144859315305472000*x^20-66677300813465118447390720000*x^18+1457375289208594731778682880000*x^16-23318004627337515708458926080000*x^14+265242302635964241183720284160000*x^12-2059528467526310578603004559360000*x^10+10297642337631552893015022796800000*x^8-30350945837229840105728488243200000*x^6+45526418755844760158592732364800000*x^4-26015096431911291519195847065600000*x^2+2365008766537390138108713369600000)/sqrt(pi);
    elseif (r==23); fx = (1/140737488355328)*exp(-(1/4)*x^2)*(x^46-2070*x^44+1958220*x^42-1124018280*x^40+438367129200*x^38-123268836731040*x^36+25886455713518400*x^34-4149229044366806400*x^32+514504401501483993600*x^30-49735425478476786048000*x^28+3759998166172845025228800*x^26-222181709819304478763520000*x^24+10220358651688006023121920000*x^22-363215822852296829437102080000*x^20+9858715191705199656149913600000*x^18-201117789910786072985458237440000*x^16+3016766848661791094781873561600000*x^14-32297150968026234073547116953600000*x^12+236845773765525716539345524326400000*x^10-1121901033626174446765320904704000000*x^8+3141322894153288450942898533171200000*x^6-4487604134504697787061283618816000000*x^4+2447784073366198792942518337536000000*x^2-212850788988365112429784203264000000)/sqrt(pi);
    elseif (r==24); fx = (1/562949953421312)*exp(-(1/4)*x^2)*(x^48-2256*x^46+2334960*x^44-1472581440*x^42+633946309920*x^40-197791248695040*x^38+46349082610871040*x^36-8342834869956787200*x^34+1170082590511439404800*x^32-128969103309705321062400*x^30+11220311987944362932428800*x^28-771141442080539852446924800*x^26+41770161446029242007541760000*x^24-1773625316785241660627927040000*x^22+58529635453912974800721592320000*x^20-1482750764832462028284947005440000*x^18+28357608377420836290949611479040000*x^16-400342706504764747636935691468800000*x^14+4047909587992621337217905324851200000*x^12-28122319242896106132250710677913600000*x^10+126550436593032477595128198050611200000*x^8-337467830914753273587008528134963200000*x^6+460183405792845373073193447456768000000*x^4-240095689978875846820796581281792000000*x^2+20007974164906320568399715106816000000)/sqrt(pi);
    elseif (r==25); fx = (1/2251799813685248)*exp(-(1/4)*x^2)*(x^50-2450*x^48+2763600*x^46-1906884000*x^44+901956132000*x^42-310633691860800*x^40+80764759883808000*x^38-16222178913804864000*x^36+2554993178924266080000*x^34-318522482972558504640000*x^32+31597430310877803660288000*x^30-2499069488223971744040960000*x^28+157441377758110219874580480000*x^26-7872068887905510993729024000000*x^24+310384430437417290609887232000000*x^22-9559840457472452550784526745600000*x^20+227046210864970748081132510208000000*x^18-4086831795569473465460385183744000000*x^16+54491090607592979539471802449920000000*x^14-521967288977995909272835160309760000000*x^12+3444984107254773001200712058044416000000*x^10-14764217602520455719431623105904640000000*x^8+37581644806415705467644131542302720000000*x^6-49019536704020485392579302011699200000000*x^4+24509768352010242696289651005849600000000*x^2-1960781468160819415703172080467968000000)/sqrt(pi);
    elseif (r==26); fx = (1/9007199254740992)*exp(-(1/4)*x^2)*(x^52-2652*x^50+3248700*x^48-2443022400*x^46+1264264092000*x^44-478397532412800*x^42+137300091802473600*x^40-30598306173122688000*x^38+5377652309926312416000*x^36-752871323389683738240000*x^34+84472162484322515430528000*x^32-7617853198586175937007616000*x^30+552294356897497755433052160000*x^28-32118041062654484854414417920000*x^26+1491194763623243939669240832000000*x^24-54875967301335376979828062617600000*x^22+1584543555826059010292535308083200000*x^20-35419208894935436700656671592448000000*x^18+602126551213902423911163417071616000000*x^16-7605809067965083249404169478799360000000*x^14+69212862518482257569577942257074176000000*x^12-435052278687602761865918494187323392000000*x^10+1779759321903829480360575658039050240000000*x^8-4333327044635410908704010297834209280000000*x^6+5416658805794263635880012872292761600000000*x^4-2599996226781246545222406178700525568000000*x^2+199999709752403580401723552207732736000000)/sqrt(pi);
    elseif (r==27); fx = (1/36028797018963968)*exp(-(1/4)*x^2)*(x^54-2862*x^52+3795012*x^50-3099259800*x^48+1747982527200*x^46-723664766260800*x^44+228195622960905600*x^42-56136123248382777600*x^40+10946544033434641632000*x^38-1710093434556567348288000*x^36+215471772754127485884288000*x^34-21978120820921003560197376000*x^32+1816857987862802960976316416000*x^30-121589726880049121234568867840000*x^28+6565845251522652546666718863360000*x^26-284519960899314943688891150745600000*x^24+9815938651026365557266744700723200000*x^22-266762568045540052203366826572595200000*x^20+5631654214294734435404410783199232000000*x^18-90699273135483617749144721034682368000000*x^16+1088391277625803412989736652416188416000000*x^14-9432724406090296245911050987606966272000000*x^12+56596346436541777475466305925641797632000000*x^10-221463964316902607512694240578598338560000000*x^8+516749250072772750862953228016729456640000000*x^6-620099100087327301035543873620075347968000000*x^4+286199584655689523554866403209265545216000000*x^2-21199969233754779522582696534019670016000000)/sqrt(pi);
    elseif (r==28); fx = (1/144115188075855872)*exp(-(1/4)*x^2)*(x^56-3080*x^54+4407480*x^52-3896212320*x^50+2386430046000*x^48-1076757236755200*x^46+371481246680544000*x^44-100406074102798464000*x^42+21612407450627369376000*x^40-3746150624775410691840000*x^38+526708777843422743272704000*x^36-60332096371155696047600640000*x^34+5641051010703057580450659840000*x^32-430455584816725624600542658560000*x^30+26749739913610806671605150924800000*x^28-1348186891645984656248899606609920000*x^26+54770092473118126660111546518528000000*x^24-1778417120303600348022445510483968000000*x^22+45646039421125742265909434769088512000000*x^20-912920788422514845318188695381770240000000*x^18+13967688062864477133368287039341084672000000*x^16-159630720718451167238494709021040967680000000*x^14+1320581416852641474427547138264975278080000000*x^12-7578989001067333679323314010912032030720000000*x^10+28421208754002501297462427540920120115200000000*x^8-63663507608965602906315837691661069058048000000*x^6+73457893394960311045749043490378156605440000000*x^4-32647952619982360464777352662390291824640000000*x^2+2331996615713025747484096618742163701760000000)/sqrt(pi);
    elseif (r==29); fx = (1/576460752303423488)*exp(-(1/4)*x^2)*(x^58-3306*x^56+5091240*x^54-4857042960*x^52+3220219482480*x^50-1577907546415200*x^48+593293237452115200*x^46-175445285932268352000*x^44+41492810122981465248000*x^42-7938957670197120350784000*x^40+1238477396550750774722304000*x^38-158299929050032326296323584000*x^36+16621492550253394261113976320000*x^34-1434562664721869873920760110080000*x^32+101649011671721065352099573514240000*x^30-5895642676959821790421775263825920000*x^28+278569116486351579597428881215774720000*x^26-10651172100948736866960516046485504000000*x^24+326635944429094597253455825425555456000000*x^22-7942410859275879154268241649821401088000000*x^20+150905806326241703931096591346606620672000000*x^18-2198913177896664828710264616764839329792000000*x^16+23988143758872707222293795819252792688640000000*x^14-189819224526731857150324819091478620405760000000*x^12+1044005734897025214326786505003132412231680000000*x^10-3758420645629290771576431418011276684034048000000*x^8+8095059852124626277241544592639672857919488000000*x^6-8994510946805140308046160658488525397688320000000*x^4+3854790405773631560591211710780796599009280000000*x^2-265847614191284935213187014536606662000640000000)/sqrt(pi);
    elseif (r==30); fx = (1/2305843009213693952)*exp(-(1/4)*x^2)*(x^60-3540*x^58+5851620*x^56-6007663200*x^54+4298483019600*x^52-2279915393595840*x^50+930965452384968000*x^48-300036865797212544000*x^46+77634539025028745760000*x^44-16320505315039376330880000*x^42+2810391015249780604177536000*x^40-398564543980877976592450560000*x^38+46698479069759536257415457280000*x^36-4526160279069001206487959705600000*x^34+362739416651101382405677913548800000*x^32-23989166754526171423095499349360640000*x^30+1304410942277360571130817777121484800000*x^28-58007921903628505398523425853167206400000*x^26+2094730513186584917168901489142149120000000*x^24-60857433856789203909328085368761384960000000*x^22+1405806722091830610305478772018387992576000000*x^20-25438407352137887234099139684142258913280000000*x^18+353825120443372431528833488333978692157440000000*x^16-3692088213322147111605219008702386352947200000000*x^14+27998335617692948929672910815993096509849600000000*x^12-147831212061418770348672969108443549572005888000000*x^10+511723426366449589668483354606150748518481920000000*x^8-1061352291723006556349446957701645996927221760000000*x^6+1137163169703221310374407454680334996707737600000000*x^4-470550277118574335327341015729793791741132800000000*x^2+31370018474571622355156067715319586116075520000000)/sqrt(pi);
    elseif (r>=31); fx = NA;
    end
end
