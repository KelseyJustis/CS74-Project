function [ terminate ] = isStoppingCriterion(curDepth, maxDepth, X, Y)
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
    s_variance = sampleVariance(Y);
    minSS = 0.1;

    if curDepth == maxDepth
        terminate = true;
    %bound on sumSquaresError
    elseif s_variance < minSS
        terminate = true;
    %bound on examples left
    elseif size(X, 1) <= minSize
        terminate = true;
    else
        terminate = false;
    end
end
