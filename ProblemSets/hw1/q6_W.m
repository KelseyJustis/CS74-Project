function W = q6_W(X, xtest, tau)
% Constructs the matrix W described in problem 5(a) of the homework
%
% INPUT
% X     : [m x d] matrix, containing the d-dimensional input vectors 
%         of the m training examples
% xtest : [d x 1] vector, the input vector of a *single* test example
% tau   : scalar, a *single* value for the regularization hyperparameter

% OUTPUT
% W: [m x m] matrix
tmp=ones(size(X, 1), 1)*[1; xtest]';
X=[ones(size(X, 1),1) X];
tmp=sum((tmp - X).^2, 2);
tmp=exp(-1*tmp ./ (2*tau^2));
tmp=tmp ./ sum(tmp);
W=diag(tmp + eps);
end