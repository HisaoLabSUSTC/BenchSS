function [Subset,time] = LazyHVSelection(PopObj,selNum,ref)
    %PopObj = Population.objs;
    tic;
    [a,M] = size(PopObj);
    selectedPop = [];
    
    %selectedPop = [0,0,1;0,1,0;1,0,0];
    %selectedPop = [0,0,0,0,1;0,0,0,1,0;0,0,1,0,0;0,1,0,0,0;1,0,0,0,0];
   
    if a<=selNum
       Subset=PopObj; 
    else
    %t2 = 0;
    %% heap initialization
    heap.size=0;
    heap.index=[];
    heap.hvc=[];
    refUse = max(PopObj,[],1)*ref;
    for n = 1 : a
       heap.index(n) = n; 
       currentPop = [selectedPop; PopObj(n, :)];
       heap.hvc(n) = HVC(currentPop, refUse, 1);
       heap.size = heap.size +1;   
    end
    toc   
    si = heap.size;
    while(si >= 1)
        heap = heap_down_sink(si, heap);
        si = si - 1;
    end
    toc
    %% Select first solution
    top = heap.index(1);
    selectedPop = [selectedPop; PopObj(top, :)];
    heap = min_heap_popup(heap);
    toc
    %% Select other solutions
    while size(selectedPop, 1) < selNum
        %size(selectedPop, 1) 
        while true
            last_index = heap.index(1);
            top = heap.index(1);
            cuurentPop = [selectedPop; PopObj(top, :)];
            heap.hvc(1) = HVC(cuurentPop, max(PopObj,[],1)*ref, size(cuurentPop, 1));
            % t1 = toc; %measure the time used on heap operation
            heap = heap_down_sink(1, heap);
            %t2 = t2 + toc - t1;
            if(heap.index(1) == last_index)            
                selectedPop = [selectedPop; PopObj(heap.index(1), :)];
                heap = min_heap_popup(heap);
                break;  
            end
            if toc > 3600 % The max time for one run is one hour
                break
            end     
        end 
        
        if toc > 3600 % The max time for one run is one hour
            break
        end  
    end
    %% output 
    Subset = selectedPop;
    time = toc;
    end
    %Score = HVExact(selectedPop, max(selectedPop,[],1)*1.1)
    
end

function heap = heap_down_sink(self, heap)
lchild =self*2;
rchild =self*2+1;
if(lchild <= heap.size && rchild <= heap.size)
    if(heap.hvc(self) < heap.hvc(lchild) || heap.hvc(self) < heap.hvc(rchild))
        if(heap.hvc(lchild) >= heap.hvc(rchild))%左右子树相等的情况下，优先往左子树下沉
            
            heap = heap_swap_node(lchild,self,heap);
            heap = heap_down_sink(lchild, heap);
        else
            heap = heap_swap_node(rchild,self, heap);
            heap = heap_down_sink(rchild, heap);
        end
    end
elseif(lchild <= heap.size)%仅仅只存在左叶子树
    if(heap.hvc(self) < heap.hvc(lchild))
        heap = heap_swap_node(lchild,self, heap);
    end
end
end

function heap = heap_swap_node(node1,node2, heap)
%     heap.index(node1)
%     heap.index(node2)
    t_index = heap.index(node1);
    t_hvc = heap.hvc(node1);
    
    heap.index(node1) = heap.index(node2);
    heap.hvc(node1) = heap.hvc(node2);

    heap.index(node2) = t_index;
    heap.hvc(node2) = t_hvc;
    
%     heap.index(node1)
%     heap.index(node2)
    
end


function heap = min_heap_popup(heap)
heap = heap_swap_node(1,heap.size, heap);%交换根节点和尾结点
heap.size =heap.size -1;
heap = heap_down_sink(1,heap);%根节点下沉
end

