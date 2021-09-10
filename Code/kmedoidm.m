function [cid, med, l]=kmedoidm(x,k,kdist)

n=size(x,1);
if nargin < 2
    k=n;
    kdist=2;
end
if nargin < 3
    kdist=2;
end
%d is distance each datum i and datum j, i=1,2,..n, j=1,2,..n
d=distance(x,kdist);

%Medoid Initation
%[med, index]=initmed(x,k);
[med, index]=kplus(x,k);

iter = 1;
% tol=0.0001;%Tolerance
% err=1;
sdist=1000;

while (iter <= 100)
    sdistold=sdist;
    [sdist, cid]=member(d,index);
    iter = iter + 1;
    %     err=abs(sdistold-sdist);
    [med, index, l]=updatemed(x,d,cid,index,k);
end
end

function d=distance(x,jenis)
n=size(x,1);
d2=zeros(n,n);
o=ones(n,1);

%d adalah distance each data -i and data j, i=1,2,..n, j=1,2,..n
if jenis==1%distance Euclidean
    
    for i=1:n-1
        j=(i+1):n;
        d2(i,j)=sum(((x(i*o(1:length(j)),:)-x(j,:)).^2),2);
        d2(j,i)=d2(i,j);
    end
elseif jenis==2%distance mahalanobis
    for i = 1 : n-1
        for j = i+1:n
            d2(j,i)=sum(max(x(i, :) - x(j, :), 0).^2,2);
            d2(i,j)=sum(max(x(j, :) - x(i, :), 0).^2,2);
        end
    end
    
end
d=sqrt(d2);
end

function [med, index]=initmed(x,d,k)
% n=size(x,1);
% D=sum(d);
% va=zeros(n,n);
% for iv=1:n
%     va(:,iv)=d(:,iv)/D(iv);
% end
% v=sum(va,2);
% [~,index] = sort(v);
% index=index(1:k,:);
index = randperm(size(x, 1), k);
med=x(index,:);
end

function [initialMedoids, index] = kplus(X,k) %从源代码复制的

% Select the first seed by sampling uniformly at random
index = zeros(k,1);
[initialMedoids(1,:), index(1)] = datasample(X,1,1);
minDist = inf(size(X,1),1);
% Select the rest of the seeds by a probabilistic model
for ii = 2:k
    minDist = min(minDist,pdist2(X,initialMedoids(ii-1,:)));
    denominator = sum(minDist);
    if denominator==0 || denominator==Inf
        [initialMedoids(ii:k,:), index(ii:k)] = datasample(X,k-ii+1,1,'Replace',false);
        break;
    end
    sampleProbability = minDist/denominator;
    [initialMedoids(ii,:), index(ii)] = datasample(X,1,1,'Replace',false,...
        'Weights',sampleProbability);
end

if issparse(initialMedoids)
    initialMedoids = full(initialMedoids);
end
end


function [med, index, l]=updatemed(x,d,cid,index,k)
[~, p]=size(x);

l=zeros(k,1);
med=zeros(k,p);

for ik = 1:k
    % finding all group members.
    ind = find(cid==ik);
    %counting member group;
    l(ik) = length(ind);
    if l(ik)>0
        % finding medoid.
        sdist =sum(d(ind,ind));
        xa=x(ind,:);
        [~,indms]=min(sdist);
        med(ik,:)=xa(indms,:);
        index(ik)=ind(indms);
    end
end
end

function [sdist, cid, dist]=member(d,index)
        dist = d(index,:);%distance all data to medoid all group
        % Inputing data to each group
        [nearest,cid] = min(dist);%nearest distance to group
        sdist=sum(nearest);
    end