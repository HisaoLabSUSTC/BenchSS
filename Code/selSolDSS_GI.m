function [selVal,time] = selSolDSS_GI(objVal,selNum)
    tic;
    selVal = [];
    
    [~,index] = max(objVal(:,1));
    selVal = [selVal;objVal(index,:)];
    objVal(index,:) = [];
    
    while size(selVal,1) < selNum
        % Distance calculation, other distances can be used.
        distance = pdist2(objVal,selVal);
        [~,index] = max(min(distance,[],2));
        selVal = [selVal;objVal(index,:)];
        objVal(index,:) = [];
        if toc > 3600 % The max time for one run is one hour
            break
        end
    end    
    time = toc;
end
