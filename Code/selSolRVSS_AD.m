function [selVal,time] = selSolRVSS_AD(objVal,selNum)
    tic;
    %selVal = [];
    [~,M] = size(objVal);
    [W,selNum] = UniformPoint(selNum,M);
    
    
    Cosine   = pdist2(objVal,W,'cosine');
    [d,pi] = min(Cosine,[],1);
    
    selVal = objVal(pi,:);
   
    time = toc;
end
