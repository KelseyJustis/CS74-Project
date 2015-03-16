% Compute the sample variance of Y, weighted according to
% sample size.
function [var] = sampleVariance(Y)
    mean = sum(Y)/size(Y, 1);

    var = 0;
    for i=1:size(Y, 1)
        var = var + (mean-Y(i))^2;
    end

end

