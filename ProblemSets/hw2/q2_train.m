function [theta, n_iter, loglik] = q2_train(Xtrain, Ytrain, theta_init, alpha, tol)
% Train logistic regression using gradient ascent given the training set
% (Xtrain, Ytrain), the initial parameter vector theta, the fixed step alpha and a 
% tolerance value to judge convergence

% 
% INPUT
%  Xtrain  : [m x n] matrix, where each row is a n-dimensional input example (assume it 
%            already contains the constant feature set to 1)
%  Ytrain  : [m x 1] vector, where the i-th element is the correct label
%                    for the i-th example
%  theta_init   : [n x 1] vector, the initial parameter vector
%  alpha   : [1 x 1] scalar, the fixed step size used for gradient ascent
%  tol     : [1 x 1] scalar, tolerance value used in the stopping condition

% OUTPUT
%  theta   : [n x 1] vector, the learned parameters
%  n_iter  : [1 x 1] scalar, the number of gradient ascent iterations until convergence
%  loglik  : [1 x n_iter] vector containing the log likelihood value at each iteration

% HINT
%  your program should use the following stopping criterion:
%        while (norm(grad)>tol) && (n_iter < 100000)
%
% where grad is the gradient at the current iteration




end
