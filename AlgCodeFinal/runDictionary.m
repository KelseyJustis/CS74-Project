function runDictionary(reps, maxDepth)
    load('dataDictionaryFeatures.mat');

    [error, error_trn] = getResults(X, Y, reps, maxDepth);
    graphResults(error, error_trn);
end

