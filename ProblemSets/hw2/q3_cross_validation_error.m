function error = q3_cross_validation_error(Xtrain, Ytrain, k, N)
% Evaluate the cross validation error of kNN classifier with different 
% values of k

% INPUT
%  Xtrain      : [m x n] matrix, where each row is an n-dimensional input *training* example
%  Ytrain      : [m x 1] vector, where the i-th element is the label for the i-th *training* example
%  k           : [1 x L] vector, the different values of parameter k to be used by kNN
%  N           : [1 x 1] scalar, number of folds used for cross validation

% OUTPUT
%  error       : [1 x L] vector, the cross validation error of k-NN for the L different choices of neighborhood size (i.e., the
%                values in k)

% ** Implementation notes **
% - As discussed in class, you should first randomly permute the examples, before starting the
%   cross-validation stage. Here we do it for you: use the vector idxperm
%   to index the examples
% - In the cross-validation stage, the indexes of the examples for the j-th subset must be 
%   idxperm([floor(m / N * j + 1) : floor(m / N * (j + 1))])
%   where j \in {0, 1, ..., N-1}
% - Do not change/initialize/reset the Matlab pseudo-number generator.


% ********  DO NOT TOUCH THE FOLLOWING 3 LINES  ********************
rand('twister', 0);
[m,  n] = size(Xtrain);
idxperm = randperm(m);
% ******************************************************************



end
