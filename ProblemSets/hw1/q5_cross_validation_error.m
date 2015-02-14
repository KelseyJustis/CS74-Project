function error = q5_cross_validation_error(X, Y, lambda, mode, N)
% Calculates the cross-validation errors for different values of lambda, given the
% training set X, Y.
%
% ** Implementation notes **
% - As discussed in class, you should first randomly permute the examples, before starting the
%   cross-validation stage. Here we do it for you: use the vector idxperm
%   to index the examples
% - In the cross-validation stage, the indexes of the examples for the k-th subset must be 
%   idxperm([floor(m / N * k + 1) : floor(m / N * (k + 1))])
%   where k \in {0, 1, ..., N-1}
% - Do not change/initialize/reset the Matlab pseudo-number generator.
%
% INPUT
%  X: [m x d] matrix, where each row is a d-dimensional data example
%  Y: [m x 1] vector, where the i-th element is the ground truth target value for the i-th example. 
%  lambda: [1 x K] vector, containing the set of regularization hyperparameter values
%  mode: type of features, either 'linear' or 'quadratic'
%  N: number of folds for the cross-validation stage
%
% OUTPUT
%  error: [1 x K] vector containing the cross-validation error (i.e., the average of the mean 
%         squared errors over the N validation sets) for each lambda.
%


% ********  DO NOT TOUCH THE FOLLOWING 3 LINES  ********************
rand('twister', 0);
[m,  d] = size(X);
idxperm = randperm(m);
% ******************************************************************
    X=X(idxperm,:);
    Y=Y(idxperm);
    error=zeros(size(lambda));
    errorIndex=1;
    for l=lambda
       errorSum=0;
       for k=0:(N-1)
           start=floor(m/N*k+1);
           finish=floor(m/N*(k+1));
           testX=X(start:finish,:);
           testY=Y(start:finish,:);
           trainX=[X(1:(start-1),:);X(finish+1:m,:)];
           trainY=[Y(1:(start-1),1);Y(finish+1:m,1)];
           theta=q5_train(trainX,trainY,l,mode);
           predictedValues=q5_predict(theta,testX,mode);
           errorSum=errorSum + q5_mse(predictedValues,testY);
       end
       error(errorIndex)=errorSum / N;
       errorIndex=errorIndex+1;
    end
end