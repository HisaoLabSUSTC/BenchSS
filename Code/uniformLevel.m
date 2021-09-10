function val = uniformLevel(subset)
    distance = pdist2(subset,subset);
    distance(logical(eye(size(distance))))=inf(1,length(subset));
    val = min(min(distance));
end