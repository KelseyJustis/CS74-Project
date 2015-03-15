function [feature, threshold, cat_split] = findBestSplit(X, Y, usedFeatures)

%initialize bestsplit and MSE
%bestSplit = [0 0]
%bestMSE = inf

        %pseudocode
%for i = 1: Xfeatures (size(X,2))
    %sortedXarray = sort X based on feature(i)
    % for j = 1: #examples (every split location) 
           %SSE = sumSquares(Y);
           %tresh = (X(j, i) + X(j+1,i))/2
           % if bestSSE > SSE
                %besSSE = SSE
                %bestSplit = [feature(i) thresh]
feature = 0;
threshold = -1;
cat_split = -1;
bestError = Inf;

for i=1:size(X, 2)
    if ismember(i, usedFeatures) == 0
        if iscellstr(X(:, i)) == 0 
            
            [X_i, index] = sortrows(X, i);
            Y_i = Y(index, :);

            for j=1:(size(X, 1) - 1) 
                error = sampleVariance(Y_i(1:j,1)) + sampleVariance(Y_i(j:end,1)) / 2;

                if error < bestError
                    feature = i;
                    threshold = (X_i{j, i}) + .1;
                    bestError = error;
                end    
            end
        else 
            cats = unique(X(:, i));
            rand('twister', 0);
            rng(0,'twister');

            for j=ceil((size(cats, 1) / 5)):ceil((size(cats, 1) / 2)) 
                for k=1:100
                    temp_split = cell(ceil(size(cats, 1) / j), j);
                    temp_split(1:end, 1:end) = {0};

                    split_variance = 0;
                    rnd = randperm(size(cats, 1));

                    for l=1:ceil(size(cats, 1) / j)
                        
                        range = rnd(j*(l-1)+1:min(l*j, size(cats, 1)));
                        temp_split(l, 1:size(range, 2)) = cats(range);
                        idx = [];   
                        for m=1:size(temp_split(l, :), 2)
                           if temp_split{l, m} ~= 0 
                               idx = [idx find(strcmp(X(:, i), temp_split(l, m))).'];
                           end
                        end
                        split_variance = split_variance + sampleVariance(Y(idx));
                    end
                    split_variance = split_variance / ceil(size(cats, 1) / j);
                    
                    if (split_variance < bestError)
                           cat_split = temp_split;
                           bestError = split_variance;
                           threshold = -1;
                           feature = i;
                    end
                end
            end 
        end 
    end    
end    

end

