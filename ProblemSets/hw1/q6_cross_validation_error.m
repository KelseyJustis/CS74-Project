function error = q6_cross_validation_error(X, Y, tau, N) 
% Calculates the cross-validation errors for different values of tau, given the
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
%  X  : [m x d] matrix, where each row is a d-dimensional data example
%  Y  : [m x 1] vector, where the i-th element is the ground truth target value for the i-th example. 
%  tau: [1 x K] vector, containing the set of regularization hyperparameter values
%  N  : [1 x 1] scalar, number of subsets for the cross-validation stage
%
% OUTPUT
%  error: [1 x K] vector, containing the cross-validation error (i.e., the average of the mean 
%         squared errors over the N validation sets) for each tau.
%


% ********  DO NOT TOUCH THE FOLLOWING 3 LINES  ********************
rand('twister', 0);
[m,  d] = size(X);
idxperm = randperm(m);
% ******************************************************************

    m=size(X,1);
    error=zeros(1,size(tau,2));
    X=X(idxperm,:);
    Y=Y(idxperm);
  
    for i=1:size(tau,2)
       errorSum=0;
       for j=0:(N-1)
           start=floor(m/N*j+1);
           finish=floor(m/N*(j+1));
           testX=X(start:finish,:);
           testY=Y(start:finish,:);
           trainX=[X(1:(start-1),:);X(finish+1:m,:)];
           trainY=[Y(1:(start-1),1);Y(finish+1:m,1)];
           predictedValues=zeros(size(testY,1),1);
           for k=1:size(testY,1)
             predictedValues(k)=q6_predict(trainX,trainY,testX(k,:)',tau(i));
           end     
           errorSum=errorSum + q5_mse(predictedValues,testY);
       end
       error(i)=errorSum / N;
    end
end