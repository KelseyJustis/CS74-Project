function [predMedians] = predictData(tree, X)
    predMedians = zeros(size(X, 1), 1);
    
    for i=1:size(X, 1)
       currNode = tree;
      
       while currNode.isLeaf == 0
           if X(i, currNode.feature) < currNode.threshold
              currNode = currNode.leftChild;
           else
              currNode = currNode.rightChild;
           end    
       end    
       
       predMedians(i, 1) = currNode.prediction;
    end    
end

