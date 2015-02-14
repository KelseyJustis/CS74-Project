function B = q5_features(X, mode)
% Given the data matrix X (where each row X(i,:) is an example), the function
% computes the feature matrix B, where row B(i,:) represents the feature vector 
% associated to example X(i,:). The features should be either linear or quadratic
% functions of the inputs, depending on the value of the input argument 'mode'.
% Please make sure to implement the features according to the exact order
% specified in the text of the homework assignment.
%
% INPUT:
%  X: a matrix [m x d] where each row is a d-dimensional input example
%  mode: the type of features; it is a string that can be either 'linear' or 'quadratic'.
%
% OUTPUT:
%  B: a matrix [m x n], with each row containing the feature vector of an example
%

    if ~strcmp(mode, 'linear') && ~strcmp(mode, 'quadratic')
      disp('Error, only linear and quadratic features are supported');
    end
    m=size(X,1);
    d=size(X,2);
    if strcmp(mode, 'linear')
        B=ones(m,d+1);
        B((1:m),2:d+1)=X(1:m,1:d);
    elseif strcmp(mode, 'quadratic')
        B=ones(m,d+1);
        B((1:m),2:d+1)=X(1:m,1:d);
        BSqrd=zeros(m,(d*(d+1))/2);
        i=1;
        for j=1:d
            for k=j:d
                BSqrd(1:m,i)=X(1:m,j).*X(1:m,k);
                i=i+1;
            end
        end
        B=[B BSqrd];
    else
        disp('Error, only linear and quadratic features are supported');
    end
end