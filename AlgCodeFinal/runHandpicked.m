function runHandpicked(reps, maxDepth)
    load('dataHandPickedFeatures.mat');

    [error, error_trn] = getResults(X, Y, reps, maxDepth);
    graphResults(error, error_trn);
end

