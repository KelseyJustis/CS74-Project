function [feature, threshold,bestError] = findBestSplit(X, Y)

%initialize bestsplit and MSE
%bestSplit = [0 0]
%bestMSE = inf

%for i = 1: Xfeatures (size(X,2))
    %sortedXarray = sort X based on feature(i)
    % for j = 1: #examples (every split location) 
           %SSE = sumSquares(Y);
           %tresh = (X(j, i) + X(j+1,i))/2
           % if bestSSE > SSE
                %besSSE = SSE
                %bestSplit = [feature(i) thresh]
feature = 0;
threshold = 0;
bestError = Inf;

for i=1:size(X, 2)
    [X_i, index] = sortrows(X, i);
    Y_i = Y(index, :);
   
    for j=1:(size(X, 1) - 1) 
        error = sumSquaresError(Y_i(1:j,1)) + sumSquaresError(Y_i(j:end,1));
        
        if error < bestError
            feature = i;
            threshold = (X_i(j, i) + X_i(j + 1, i)) / 2;
            bestError = error;
        end    
    end    
end    
end

