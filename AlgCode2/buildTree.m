function [ regTree ] = buildTree(curDepth, maxDepth, X, Y, parent)
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
        if size(Y, 1) >= 1
            regTree = Tree(curDepth, 0, 0, 1, sum(Y) / size(Y, 1), parent); 
        else
            regTree = Tree(curDepth, 0, 0, 1, parent.prediction, parent);
        end   
    else            
        [feature, threshold] = findBestSplit(X, Y);
        regTree = Tree(curDepth, feature, threshold, 0, sum(Y) / size(Y, 1), parent); 
        idxLeft = (X(:, feature) < threshold);
        idxRight = (X(:, feature) >= threshold);

        regTree = insertLeft(regTree, buildTree(curDepth + 1, maxDepth, X(idxLeft, :), Y(idxLeft, :), regTree));
        regTree = insertRight(regTree, buildTree(curDepth + 1, maxDepth, X(idxRight, :), Y(idxRight, :), regTree));
    end
end

