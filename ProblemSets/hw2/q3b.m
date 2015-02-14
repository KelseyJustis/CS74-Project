function q3b()
% This script requires to following functions to be implemented:
% q2_error
% q3_predict
% q3_cross_validation_error

assert(checking('q3b')==0);

S = load('parkinsons.mat');
X = S.trainsetX;
Y = S.trainsetY;

clear S;

k = 1:2:13;
err = q3_cross_validation_error(X, Y, k, 5);



close all;

plot(k, err, 'bo-');
ylabel('misclassification rate');
title('kNN cross validation error on parkinsons dataset');
xlabel('k');
grid on;

saveas(gcf, 'q3b.fig');