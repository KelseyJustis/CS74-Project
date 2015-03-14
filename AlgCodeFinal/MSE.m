function err = MSE(pred_Y, correct_Y)
% This function calculates the Mean Squared Error given two sets of output
% values, one set corresponding to the correct values, the other set
% representing the output values predicted by a regression model
% INPUT:
%  pred_Y: [m x 1] vector, containing the predicted values
%  correct_Y: [m x 1] vector, containing the correct values
%
% OUTPUT:
%  err: Mean Squared Error (scalar value)
%

[m,~] = size(pred_Y);
err = 0;
for i = 1:m
    err = err + (correct_Y(i)-pred_Y(i))^2;
end
err = (1/m) * err;
end