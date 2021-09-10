function Score = HV(PopObj,problem,r,Set)
% <metric> <max>
% Hypervolume

%------------------------------- Reference --------------------------------
% E. Zitzler and L. Thiele, Multiobjective evolutionary algorithms: A
% comparative case study and the strength Pareto approach, IEEE
% Transactions on Evolutionary Computation, 1999, 3(4): 257-271.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    % Normalize the population according to the reference point set
    [N,M]  = size(PopObj);
    switch problem
        case "DTLZ1"
            PF = 0.5*ones(1,M);
        case "DTLZ2"
            PF = ones(1,M);
        case "DTLZ7"
            interval     = [0,0.251412,0.631627,0.859401];
            median       = (interval(2)-interval(1))/(interval(4)-interval(3)+interval(2)-interval(1));
            X            = ReplicatePoint(1000,M-1);
            X(X<=median) = X(X<=median)*(interval(2)-interval(1))/median+interval(1);
            X(X>median)  = (X(X>median)-median)*(interval(4)-interval(3))/(1-median)+interval(3);
            PF            = [X,2*(M-sum(X/2.*(1+sin(3*pi.*X)),2))];
        case "WFG3"
            PF = Set;
        case "MinusDTLZ1"
            PF = 551.16*ones(1,M);
        case "MinusDTLZ2"
            PF = 3.5*ones(1,M);
    end
    
    RefPoint = max(PF,[],1)*r;
    PopObj(any(PopObj>repmat(RefPoint,N,1),2),:) = [];
    % The reference point is set to (1,1,...)
    if isempty(PopObj)
        Score = 0;
    else
        Score = stk_dominatedhv(PopObj,RefPoint);
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