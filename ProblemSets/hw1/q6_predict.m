function pred_y = q6_predict(X, Y, xtest, tau)
% Predicts the output value of the input example xtest, given the training
% set X, Y, parameter tau, and the test example

% 
% INPUT
%  X     : [m x d] matrix, where each row is a d-dimensional input example
%  Y     : [m x 1] vector, where the i-th element is the correct output value 
%                for the i-th input example. 
%  xtest : [d x 1] vector, the input vector of a *single* test example
%  tau   : scalar, value of the regularization hyperparameter
%
% OUTPUT
%  pred_y: scalar, the predicted output value.
%
    theta=q6_train(X,Y,xtest,tau);
    pred_y=theta'*[1; xtest];
end
