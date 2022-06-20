function [selVal,time] = POIGDSS(objVal,selNum)
    tic;
    [length,~] = size(objVal);
    s = zeros(1,length);
    Population = s;
    Obj = [0,Inf];
    
    maxIteration = 1000;
    currentIteration = 0;   
    
    while currentIteration < maxIteration
        [N,~] = size(Population);
        index = randperm(N,1);
        offspring = Population(index,:);
        offspring = mutation(offspring,length);
        if sum(offspring)==0
           continue 
        end
        Population = [Population;offspring];
        objs = calObj(offspring,objVal,selNum);
        Obj = [Obj;objs];
        
        [FrontNo,~] = NDSort(Obj,1);
        Population = Population(FrontNo==1,:);
        Obj = Obj(FrontNo==1,:);
        currentIteration = currentIteration+1;
        if toc > 3600
            break
        end
    end
    
    check = Obj(:,1)>selNum;
    Obj(check,:) = [];
    Population(check,:) = [];
    
    [~,index] = min(Obj(:,2));
    bestoffspring = Population(index,:);
    selVal = objVal(bestoffspring==1,:);
    time = toc;
end

function offspring = mutation(offspring,length)
    Site = rand(1,length) < 1/length;
    offspring(Site) = ~offspring(Site);
end

function objs = calObj(offspring,objVal,selNum)
    obj1 = sum(offspring);
    if obj1 >= 2*selNum
        obj2 = Inf;
    else
        selected = objVal(offspring==1,:);
        obj2 = IGD(selected,objVal);
    end
    objs = [obj1,obj2];
end
