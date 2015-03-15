classdef Tree
    %define a node
    properties
        depth = 0;
        feature = 0;
        threshold = 0;
        leftChild = 0;
        rightChild = 0;
        catChildren = {};
        isCategorical = 0;
        catSplits = {};
        isLeaf = 0;
        prediction = -1; 
        parent = 0;
    end
    
    methods
        %class constructer
        function obj = Tree(depth, feature, threshold, isLeaf, prediction, parent, isCategorical)
            obj.depth = depth;
            obj.feature = feature;
            obj.threshold = threshold;
            obj.isLeaf = isLeaf;
            obj.prediction = prediction;
            obj.parent = parent;
            obj.isCategorical = isCategorical;
        end   
    end
    
end

 