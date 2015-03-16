% Given current depth, maximum depth, X and Y subsets, and used feature
% set, stop building tree branch if we have reached a base case.
function [ terminate ] = isStoppingCriterion(curDepth, maxDepth, X, Y, usedFeatures)
    minSize = 2;
    s_variance = sampleVariance(Y) / size(Y, 1);
    minSS = 0.001;
    
    % Terminate if we have reached the max depth or exhausted feature set:
    if curDepth == maxDepth || size(usedFeatures, 2) == size(X, 2)
        terminate = 1;
    
    % Terminate if variance below certain threshold:
    elseif s_variance < minSS || isnan(s_variance)
        terminate = 1;
        
    % Terminate if subset below minSize:
    elseif size(X, 1) < minSize
        terminate = 1;
        
    % Else continue building tree:    
    else
        terminate = 0;
    end
end
