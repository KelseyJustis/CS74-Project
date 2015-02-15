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
ssError = sumSquaresError(Y);
minSS = 0.1;

if curDepth == maxDepth
    terminate = true;
%bound on sumSquaresError
elseif ssError < minSS
    terminate = true;
%bound on examples left
elseif X.size() <= minSize
    terminate = true;
else
    terminate = false;
end
end
