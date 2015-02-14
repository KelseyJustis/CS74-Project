function error = q6_test_error(Xtrain, Ytrain, Xtest, Ytest, tau)
% Given training and test set, it trains the model and calculates the test error.
%
% INPUT
%  Xtrain: [m x d] matrix, where each row is a d-dimensional training example
%  Ytrain: [m x 1] vector, where the i-th element is the output value 
%                  for the i-th training example.
%  Xtest : [M x d] matrix, where each row is a d-dimensional test example
%  Ytest : [M x 1] vector, containing the output values of the test examples
%  tau   : [1 x K] vector, containing the set of values for the reguralization parameter
%
% OUTPUT
%  error : [1 x K] vector, containing test errors, one for each value of tau.
%
    error = zeros(1, size(tau,2));
    for i=1:size(tau,2)
        predictedValues=zeros(size(Ytest,1),1);
        for j=1:size(Ytest,1)
            predictedValues(j)=q6_predict(Xtrain,Ytrain,Xtest(j,:)',tau(i));
        end
        error(i)=q5_mse(predictedValues,Ytest);
    end
end