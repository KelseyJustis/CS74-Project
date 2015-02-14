function [phi_y0, phi_y1, phi_prior] = q4_nb_train(Xtrain, Ytrain)
% Train a Naive Bayes model using Laplacian smoothing

% INPUT
%  Xtrain    : [m x n] matrix, where each row is an n-dimensional input *training* example
%  Ytrain    : [m x 1] vector, where the i-th element is the label for the i-th *training* example

% OUTPUT
%  phi_y0    : [n x 1] vector, class conditional probabilities for y=0,
%              where phi_y0(j) = p(x_j = 1 | y = 0)
%  phi_y1    : [n x 1] vector, class conditional probabilities for y=1, 
%              where phi_y0(j) = p(x_j = 1 | y = 1)
%  phi_prior : [1 x 1] scalar, prior probability of y being 1, i.e., phi_prior = p(y = 1)



end
