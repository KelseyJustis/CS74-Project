function [ terminate ] = isStoppingCriterion(curDepth, maxDepth, X, Y, usedFeatures)
    % return true if termination criteria satisfied

    % if curDepth == maxDepth
        % return true (term = 1)
    % elseif sumSquares() < blah
        % return true (term =1)
    % elseif curDataSubset.size() < minsize
        % return true
    % else return false (term = 0)
    
    true = 1;
    false = 0;
    minSize = 2;
    s_variance = sampleVariance(Y) / size(Y, 1);
    
    minSS = 0.001;
    size(usedFeatures, 2);
    if curDepth == maxDepth || size(usedFeatures, 2) == size(X, 2)
        terminate = true;
    %bound on sumSquaresError
    elseif s_variance < minSS || isnan(s_variance)
        terminate = true;
    %bound on examples left
    elseif size(X, 1) < minSize
        terminate = true;
    else
        terminate = false;
    end
end
