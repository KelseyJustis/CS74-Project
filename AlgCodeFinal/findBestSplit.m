% Given X and Y subsets and the used feature set, find the best feature on
% which to split X, returning the feature and the threshold (continuous
% data) or category split. 
function [feature, threshold, cat_split] = findBestSplit(X, Y, usedFeatures)

    feature = 0;
    threshold = -1;
    cat_split = -1;
    bestError = Inf;

    for i=1:size(X, 2)

      % Only examine unused features.  
      if ismember(i, usedFeatures) == 0 

          % For each continuous feature, sort according to that feature
          % and partition between each pair of examples.
          if iscellstr(X(:, i)) == 0 

                [X_i, index] = sortrows(X, i);
                Y_i = Y(index, :);

                for j=1:size(X, 1)
                    error = (sampleVariance(Y_i(1:j,1)) + sampleVariance(Y_i(j:end,1)));

                    % If this is the best split found thus far, record it.
                    if error < bestError
                        feature = i;
                        threshold = (X_i{j, i}) + .1;
                        bestError = error;
                    end    
                end

          % Handle categorical feature:
          else  
            % Find unique categories.
            cats = unique(X(:, i));
            meanMedians = zeros(size(cats, 1), 1);
            catCounts = zeros(size(cats, 1), 1);

            % Find the mean medians of each category.
            for j=1:size(X, 1) 
                idx = find(strcmp(X{j, i}, cats));
                meanMedians(idx) = meanMedians(idx) + Y(j);
                catCounts(idx) = catCounts(idx) + 1;
            end

            % Sort cats by average medians. 
            meanMedians = meanMedians./catCounts;
            [~, idxs] = sort(meanMedians);
            cats = cats(idxs);

            % Try splitting at each category, such that all
            % categories with a lower mean median are in the same
            % partition.
            for k=1:size(cats, 1)
                temp_split = cell(2, size(cats, 1));
                temp_split(1:end, 1:end) = {0};

                temp_split(1, 1:k) = cats(1:k);
                temp_split(2, 1:(end - k)) = cats(k+1:end);

                % Determine variance.
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

                % If this is the best split found thus far, record it.
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



