function [lnP] = My_log(P)
    % 当矩阵P中的元素为0时，返回0
    n = size(P,1);
    m = size(P,2);
    lnP = zeros(n,m);
    for i = 1:n*m
        if P(i) == 0
            lnP(i) = 0;
        else
            lnP(i) = log(P(i));
        end
    end
end
