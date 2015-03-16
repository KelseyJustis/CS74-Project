
% Given the current tree depth, the maximum depth, our X and Y (sub)sets,
% the parent node, and the used feature set, recursively build a decision Tree.
function [ regTree ] = buildTree(curDepth, maxDepth, X, Y, parent, usedFeatures)
    
    % Build a leaf node if we reach a base case.
    if isStoppingCriterion(curDepth, maxDepth, X, Y, usedFeatures)
        if size(Y, 1) >= 1
            regTree = Tree(curDepth, 0, 0, 1, sum(Y) / size(Y, 1), parent, 0); 
        else
            regTree = Tree(curDepth, 0, 0, 1, parent.prediction, parent, 0);
        end   
        
    % Otherwise, recurse on both subsets created by splitting.    
    else            
        [feature, threshold, cat_split] = findBestSplit(X, Y, usedFeatures);
        usedFeatures = [usedFeatures feature];
        
        % Split on continous feature.
        if threshold ~= -1
            regTree = Tree(curDepth, feature, threshold, 0, sum(Y) / size(Y, 1), parent, 0); 
            
            idxLeft = (find(cell2mat(X(:, feature)) < threshold));
            idxRight = (find(cell2mat(X(:, feature)) >= threshold));
            
            regTree.leftChild = buildTree(curDepth + 1, maxDepth, X(idxLeft, :), Y(idxLeft, :), regTree, usedFeatures);
            regTree.rightChild = buildTree(curDepth + 1, maxDepth, X(idxRight, :), Y(idxRight, :), regTree, usedFeatures);
        
        % Split on categorical feature.
        else
            regTree = Tree(curDepth, feature, threshold, 0, sum(Y) / size(Y, 1), parent, 1);
            regTree.catSplits = cat_split;
            
            for i=1:size(cat_split, 1)
                idx = [];
                for j=1:size(cat_split(i, :), 2)
                    if cat_split{i, j} ~= 0 
                        idx = [idx find(strcmp(X(:, feature), cat_split(i, j))).'];
                    end    
                end
                
                n = size(regTree.catChildren, 2);
                regTree.catChildren{1, n + 1} = buildTree(curDepth + 1, maxDepth, ...
                        X(idx, :), Y(idx, :), regTree, usedFeatures);
            end 
        end
    end
end

