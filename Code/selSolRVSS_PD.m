function [selVal,time] = selSolRVSS_PD(objVal,selNum)
    tic;
    %selVal = [];
    [~,M] = size(objVal);
    [W,selNum] = UniformPoint(selNum,M);
    
    
    Cosine   = 1 - pdist2(objVal,W,'cosine');
    Distance = repmat(sqrt(sum(objVal.^2,2)),1,selNum).*sqrt(1-Cosine.^2);
    % Associate each solution with its nearest reference point
    [d,pi] = min(Distance,[],1);
    
    selVal = objVal(pi,:);
   
    time = toc;
end
