function Score = IGDp(PopObj,problem,Set)
    [N,M]  = size(PopObj);
    switch problem
        case "DTLZ1"
            PF = UniformPoint(1000000,M)/2;
        case "DTLZ2"
            P = UniformPoint(1000000,M);
            PF = P./repmat(sqrt(sum(P.^2,2)),1,M);
        case "DTLZ7"
            interval     = [0,0.251412,0.631627,0.859401];
            median       = (interval(2)-interval(1))/(interval(4)-interval(3)+interval(2)-interval(1));
            X            = ReplicatePoint(1000000,M-1);
            X(X<=median) = X(X<=median)*(interval(2)-interval(1))/median+interval(1);
            X(X>median)  = (X(X>median)-median)*(interval(4)-interval(3))/(1-median)+interval(3);
            PF            = [X,2*(M-sum(X/2.*(1+sin(3*pi.*X)),2))];
        case "WFG3"
            PF = Set;
        case "MinusDTLZ1"
            g = 1101.25;
            PF = UniformPoint(1000000,M)/2*(1+g)*(-1);
            PF = PF+551.16;
        case "MinusDTLZ2"
            g = 0.5^2*10;
            P = UniformPoint(1000000,M);
            PF = P./repmat(sqrt(sum(P.^2,2)),1,M)*(1+g)*(-1);
            PF = PF + 3.5;
    end
    Distance = min(igddis(PF,PopObj),[],2);
    Score    = mean(Distance);
end

function [dis] = igddis(PF,Population)
    dis = zeros(size(PF, 1), size(Population, 1));
    for i = 1:size(PF, 1)
        for j = 1:size(Population, 1)
        dis(i, j) = sqrt(sum(max(Population(j,:) - PF(i,:), 0).^2));
        end
    end

end
function W = ReplicatePoint(SampleNum,M)
    if M > 1
        SampleNum = (ceil(SampleNum^(1/M)))^M;
        Gap       = 0:1/(SampleNum^(1/M)-1):1;
        eval(sprintf('[%s]=ndgrid(Gap);',sprintf('c%d,',1:M)))
        eval(sprintf('W=[%s];',sprintf('c%d(:),',1:M)))
    else
        W = (0:1/(SampleNum-1):1)';
    end
end