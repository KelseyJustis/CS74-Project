function error = q5_test_error(X, Y, Xtest, Ytest, lambda, mode)
% Given training and test set, it trains the model and calculates the test error.
%
% INPUT
%  X: [m x d] matrix, where each row is a d-dimensional training example
%  Y: [m x 1] vector, where the i-th element is the output value 
%     for the i-th training example.
%  Xtest: [M x d] matrix, where each row is a d-dimensional test example
%  Ytest: [M x 1] vector, containing the output values of the test examples
%  lambda: [1 x K] vector, containing the list of reguralization parameters
%  mode: type of features, wither 'linear' or 'quadratic'
%
% OUTPUT
%  error: [1 x K] vector containing test errors, one for each lambda.
%
    error=zeros(size(lambda));
    errorIndex=1;
    for l=lambda
        theta=q5_train(X,Y,l,mode);
        predictedY=q5_predict(theta,Xtest,mode);
        error(errorIndex) = q5_mse(predictedY,Ytest);
        errorIndex=errorIndex+1;
    end
end