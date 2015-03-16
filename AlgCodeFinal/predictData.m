% Given a decision tree and test set, perform prediction for each example,
% returning the resulting medians.
function [predMedians] = predictData(tree, X)
    predMedians = zeros(size(X, 1), 1);
    
    for i=1:size(X, 1)
       currNode = tree;
      
       % Continue until a leaf node is reach or the test example
       % cannot follow either branch.
       while currNode.isLeaf == 0
           % Continue on categorical feature split:
           if currNode.isCategorical == 1
               for j=1:size(currNode.catSplits, 1)
                   currNode.feature;
                   
                   if find(strncmp(X(i, currNode.feature), currNode.catSplits(j, :), length(X(i, currNode.feature))))
                       currNode = currNode.catChildren{1, j};
                       break;
                   end    
               end 
               predMedians(i, 1) = currNode.prediction;
               break;
               
           % Continue on continuous feature split:    
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

