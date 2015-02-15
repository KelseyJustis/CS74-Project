function [ regTree ] = buildTree(curDepth, maxDepth, X, Y)
% recursive partitioning

% create empty treeObj
% if isStoppingCriterion(MaxDepth)
      %create leaf node
      %average median grades at leaf -- set predictionMedian
      %insert leaf into treeObj
      %return treeObj
% else 
    % [splitFeat splitTresh] = bestSplit()
    % create node with bestSplit
        % add feature + children to treeObj
            % treeObj.addLeftChild(depth,dataSubset split from treshold, MaxDepth)
            % treeObj.addRightChild(" " ")
    if isStoppingCriterion(curDepth, maxDepth, X, Y)
        regTree = Tree(curDepth, 0, 0, 1, sum(Y) / size(Y, 1));  
    else            
        [feature, threshold] = findBestSplit(X, Y);
        regTree = Tree(curDepth, feature, threshold, 0, -1); 
        idxLeft = (X(:, feature) < threshold);
        idxRight = (X(:, feature) >= threshold);

        regTree = insertLeft(regTree, buildTree(curDepth + 1, maxDepth, X(idxLeft, :), Y(idxLeft, :)));
        regTree = insertRight(regTree, buildTree(curDepth + 1, maxDepth, X(idxRight, :), Y(idxRight, :)));
    end
end

