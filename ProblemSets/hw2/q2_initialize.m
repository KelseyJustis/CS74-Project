function theta = q2_initialize(Xtrain, Ytrain, opt)
% Initializes the weights for training logistic regression

% INPUT
%  Xtrain  : [m x n] matrix, where each row is a n-dimensional input example (assume it 
%            already contains the constant feature set to 1)
%  Ytrain  : [m x 1] vector, where the i-th element is the correct label
%                    for the i-th example
%  opt     : string, can be either 'random' or 'heuristic' which allows to
%                    choose the initialization between randomly of heuristic

% OUTPUT
%  theta   : [n x 1] the initialized parameter vector

% HINTS
%  We provide the code for random initialization and ask you to implement
%  the case of 'heuristic’, which we have discussed in class.


n = size(Xtrain,2);
if strcmp(opt,'random')
    % random initialization
    rand('seed', 0);
    theta = rand(n,1); % generate initial value
else
    % "heuristic" initialization
    % FILL YOUR CODE HERE %




end



end
