function q3c()
% This script requires the following functions to be implemented:
% q2_error
% q3_predict
% q3_leave_one_out_error

assert(checking('q3c')==0);

S = load('parkinsons.mat');
X = S.trainsetX;
Y = S.trainsetY;

clear S;

k = 1:2:13;
err = q3_leave_one_out_error(X, Y, k);



close all;

plot(k, err, 'bo-');
ylabel('misclassification rate');
title('kNN leave-one-out error on parkinsons dataset');
xlabel('k');
grid on;

saveas(gcf, 'q3c.fig');