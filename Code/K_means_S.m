function [subset,time] = K_means_S(Points, K)
tic;
T = kmeans(Points, K, 'MaxIter',1000);
index = zeros(1, length(K));

for i = 1:K
    p = find(T == i);
    minV = inf;
    
    distM = pdist2(Points(p, :), Points(p, :));
    
    for j = 1:length(p)
        cost = sum(distM(j,:));
        if cost < minV
            minV = cost;
            index(i) = p(j);
        end
    end
    if toc > 3600 % The max time for one run is one hour
        break
    end
end

subset = Points(index, :);
time = toc;
end

