function [err] = sumSquaresError(Y)
mean = sum(Y)/Y.size();
err = 0;
for i=1:Y
    err = err + (mean-Y(i))^2;
end
end

