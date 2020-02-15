function [href,R,Pk] = stage1(DATA,h)
%h -> inicial deve ser OSCV
tic;
disp('STAGE[1][ON]');
href = h.CV.rOSCV;

disp('STAGE[1][..]')
[~,dy,~,~] = SIZER(DATA,href);
n=length(DATA);
CTH = dy(end,:);
[Pk] = findTran(CTH);
kt = kurtosis(DATA);
sk = skewness(DATA);

if Pk == 1
    if kt>=(2.5) && kt<=(3.5)
        if abs(sk)<=(0.3)
            disp(['Bandwidth[SV]']);
            R=0;
            href = h.PI.SJ;
        else
            href = h.CV.rOSCV;
            disp(['Bandwidth[OSCV]']);
            R=1;
        end
    else
        R=1;
        href = h.CV.rOSCV;
        disp(['Bandwidth[OSCV]']);
    end    
else
    R=1;
    href = h.CV.rOSCV;
    disp(['Bandwidth[OSCV]']);
end
s1time=toc;

% % if n<=500
%     href = h.PI.SJ;
% end
disp(['STAGE[1][OK]TIME[' num2str(s1time) ']'])
end