% Given feature set X and medians Y, randomly partition the data
% 'reps' times and create trees up to depth 'depth'. Output
% the average error at each max depth.
function [error, error_trn] = getResults(X, Y, reps, depth)
    error = zeros(depth + 1, 1);
    error_trn = zeros(depth + 1, 1);
    
    rand('twister', 0);
    
    for j = 1:reps
        
        % Randomly partititon data into training and test sets.
        k = randperm(size(X, 1));
        trainSize = round(size(X, 1) * .70);
   
        trainX = X(k(1:trainSize), :);
        trainY = Y(k(1:trainSize), :);
        testX = X(k(trainSize+1:end), :);
        testY = Y(k(trainSize+1:end), :);
        
        % Build trees up to maximum depth and record error.
        for i=0:depth
            regTree = buildTree(0, i, trainX, trainY, 0, []);
            pred_Yt = predictData(regTree, trainX);
           
            error_trn(i + 1, 1) = error_trn(i + 1, 1) + MSE(pred_Yt, trainY);

            pred_Y = predictData(regTree, testX);
            error(i + 1, 1) = error(i + 1, 1) + MSE(pred_Y, testY);
        end   
        disp('PASS');
    end
    
    % Average error.
    error_trn = error_trn./reps;
    error = error./reps;
end

