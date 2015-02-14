function theta = q6_train(X, Y, xtest, tau)
% Trains the locally weighted linear regression (LWLR) model using the 
% closed form solution given the training data X, Y, the test 
% input vector xtest and the parameter tau.
%
% INPUT:
%  X     : [m x d] matrix, where each row is a d-dimensional input example
%  Y     : [m x 1] vector, where the i-th element is the correct output value 
%                for the i-th input example. 
%  tau   : scalar value, regularization hyperparameter
%  xtest : [d x 1] vector, the input vector of a *single* test example
%
% OUTPUT:
%  theta : [n x 1] vector, containing the learned model parameters.
%
    B=q5_features(X,'linear');
    W=q6_W(X,xtest,tau);
    theta=(B'*W*B)\(B'*W*Y);
end
