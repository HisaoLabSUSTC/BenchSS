function [subset,time] = K_medoid_S(Points, K)
    tic;
    opts = statset('MaxIter',1000);
    if size(Points,1)==1000000
        [~,subset]= mykmedoids(Points, K,'Options',opts);
    else
        [~,subset]= kmedoids(Points, K,'Options',opts);
    end
    time = toc;
end

