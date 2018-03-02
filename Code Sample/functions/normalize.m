%%
%Normalizes entries by dividing each column by maximum in that column
function mat = normalize(matrix)
    mat = zeros(size(matrix)); %create matrix with size of given matrix containing all zeros
    for i = 1:size(mat,2)      %Find the maximum of each column in the given matrix
        maximum = max(matrix(:,i));  
        if maximum ~= 0        %Never divide by zero. Bad things happen.
            mat(:,i) = matrix(:,i)/maximum;     %If it's safe, divide by maximum and put into the corresponding column
        end
    end
end