% angle-based knee point detection on BIC
% The method is organized by two parts:
% 1. get BIC values in an range from stable/reliable clustering algorithms
%    run c code RLS
% 2. get the knee point according to second derivative of BIC values and
% the global trend by angles
% author: Qinpei Zhao (University of Eastern Finland)
% paper: Knee Point Detection in BIC for Detecting the Number of Clusters,
% ACIVS'08   
% -------------------------
% Function: AngleCalc
% Input:  B -- an array of BIC values on each number of clusters m, usually
%         m starts from 2, so take B(1) = B(2);
% Output: local_min  -- the detected number of clusters by angle-based
%         method

function local_min= AngleCalc(B)
% figure; plot(1:length(B), B, 'x-r');
% title('BIC values', 'fontsize', 14);
% xlabel('number of clusters', 'fontsize', 14);
len = length(B);
DF = zeros(1, len);
% second derivative
F1 = B(1:end-2);
F2 = B(3:end);
DF(2:end-1) = F1+F2-2*B(2:end-1);
% figure;plot(1:len, DF, '-xb');
% title('Second derivative difference', 'fontsize', 14);
% xlabel('number of clusters', 'fontsize', 14);
% find minimums on DF
[maxtab, mintab] = peakdet(DF, 5); 
Id = mintab(:,1);
[minv, minid] = sort(mintab(:,2), 'ascend');
Id = Id(minid);

%normalize original value in B [1, len];
Bn = (len-1)*(B-B(2))/(B(end)-B(2));

    % check the angles on each Id
    angle = zeros(length(Id), 1);
    for i = 1:length(Id),
        v = [Id(i), Bn(Id(i))];
%         v1 = [Id(i)-1, Bn(Id(i)-1)];
%         v2 = [Id(i)+1, Bn(Id(i)+1)];
        v1 = [2, Bn(2)];
        v2 = [len, Bn(len)];
        pv1 = v1-v;
        pv2 = v2-v;
        C = dot(pv1, pv2)/(norm(pv1)*norm(pv2));
        theta = acos(C);
        angle(i) = theta*180/pi;
    end
%     figure; plot(1:length(angle), angle, 'x-r');
%     title('angles', 'fontsize', 14);
%     xlabel(num2str(Id'), 'fontsize', 14);
%     disp(Id);
    [a, b] = min(angle);
    local_min = Id(b);
end








