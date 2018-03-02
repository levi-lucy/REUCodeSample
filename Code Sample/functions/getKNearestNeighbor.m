%%
%getKNearNeighbor finds the k-th nearest neighbor of each vector in the
%vectors list, and returns the list of indices, the index of their k-th
%nearest neighbor, and the euclidean distance between them. 
function neighbor = getKNearestNeighbor(vectors, k)
tree = KDTreeSearcher(vectors); %Creates KD-tree of distances between vectors
neighbor = zeros(size(vectors,1),3);

for i = 1:size(vectors,1)
    neighbors = knnsearch(tree,vectors(i,:),'k',k+1); %Find the k non-indentical neighbors
    neighbor(i,1) = neighbors(1,1); %Original Point
    neighbor(i,2) = neighbors(1,k+1); %K-th nearest neighbor
    neighbor(i,3) = norm(vectors(neighbor(i,1),:)-vectors(neighbor(i,2),:)); %Euclidean distance between
end
end