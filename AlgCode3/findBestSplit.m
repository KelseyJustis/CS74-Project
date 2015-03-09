function [feature, threshold, cat_split] = findBestSplit(X, Y, usedFeatures)

feature = 0;
threshold = -1;
cat_split = -1;
bestError = Inf;

for i=1:size(X, 2)
  
  if ismember(i, usedFeatures) == 0 
        if iscellstr(X(:, i)) == 0 
            
            [X_i, index] = sortrows(X, i);
            Y_i = Y(index, :);

            for j=ceil(size(X, 1)/5): ceil(4 * (size(X, 1) - 1) / 5)
                error = (sampleVariance(Y_i(1:j,1)) + sampleVariance(Y_i(j:end,1))) / 2;

                if error < bestError
                    feature = i;
                    threshold = (X_i{j, i}) + .1;
                    bestError = error;
                end    
            end
           
        else  
            
            cats = unique(X(:, i));
            meanMedians = zeros(size(cats, 1), 1);
            catCounts = zeros(size(cats, 1), 1);
            
            for j=1:size(X, 1) 
                idx = find(strcmp(X{j, i}, cats));
                meanMedians(idx) = meanMedians(idx) + Y(j);
                catCounts(idx) = catCounts(idx) + 1;
            end
            
            
            meanMedians = meanMedians./catCounts;
            [~, idxs] = sort(meanMedians);
            cats = cats(idxs);
            
            for k = ceil(size(cats, 1) / 5): ceil(4 * size(cats, 1) / 5)
                temp_split = cell(2, size(cats, 1));
                temp_split(1:end, 1:end) = {0};
                
                temp_split(1, 1:k) = cats(1:k);
                temp_split(2, 1:(end - k)) = cats(k+1:end);
                
                split_variance = 0;
                idx = [];
                for l=1:2
                    for m=1:size(temp_split(l, :), 2)
                         if temp_split{l, m} ~= 0 
                                  idx = [idx find(strcmp(X(:, i), temp_split(l, m))).'];
                         end
                    end
                    split_variance = split_variance + sampleVariance(Y(idx));
                end    
                split_variance = split_variance / 2;
               
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



