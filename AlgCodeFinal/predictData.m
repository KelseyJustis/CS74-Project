function [predMedians] = predictData(tree, X)
    predMedians = zeros(size(X, 1), 1);
    
    for i=1:size(X, 1)
       currNode = tree;
      
       while currNode.isLeaf == 0
           if currNode.isCategorical == 1
               for j=1:size(currNode.catSplits, 1)
                   currNode.feature;
                   %if strmatch(X(i, currNode.feature), currNode.catSplits{j, :})
                   if find(strncmp(X(i, currNode.feature), currNode.catSplits(j, :), length(X(i, currNode.feature))))
                       currNode = currNode.catChildren{1, j};
                       break;
                   end    
               end 
               predMedians(i, 1) = currNode.prediction;
               break;
           else
               if X{i, currNode.feature} < currNode.threshold
                  currNode = currNode.leftChild;
               else
                  currNode = currNode.rightChild;
               end 
           end    
       end    
       
        predMedians(i, 1) = currNode.prediction;
    end    
end

